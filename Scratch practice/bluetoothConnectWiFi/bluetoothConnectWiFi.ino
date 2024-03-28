#include <ESP8266WiFi.h>
#include <PubSubClient.h>
#include <EEPROM.h>
#include <DHT.h>
#include <Adafruit_NeoPixel.h>


const char* mqtt_server = "test.mosquitto.org";
WiFiClient espClient;
PubSubClient client(espClient);
unsigned long lastMsg = 0;
#define MSG_BUFFER_SIZE	(100)
char msg[MSG_BUFFER_SIZE];
#define mqttChannel_BUFFER_SIZE	(128)
char mqttChannel[mqttChannel_BUFFER_SIZE];
int value = 0;
unsigned long lastBlueToothMsg = 0;

#include <string.h>

char val;  // 接收資料的變數

int mode = 0;
/*
0: 讀取SSID長度
1: 接收SSID
2: 讀取密碼長度
3: 接收密碼
*/

int inputIndex = 0;
int length = 0;
bool connected2Wifi = false;
char* ssid = "";
char* password = "";
char* deviceName = "";
char tempInput[64] = "";
char tempPwdInput[64] = "";
char tempUserId[65] = "";
#define SSID_ADDR 0
#define PASSWORD_ADDR 34
#define USER_ID_ADDR 100

//溫濕度感測
#define DHTTYPE DHT11 // DHT 11
uint8_t DHTPIN = D7;
DHT dht(DHTPIN, DHTTYPE);
float temperature = 20.0;

//燈條
#define LED_PIN D6
#define NUM_PIXELS 4
Adafruit_NeoPixel pixels = Adafruit_NeoPixel(NUM_PIXELS, LED_PIN, NEO_GRB + NEO_KHZ800);

//SERVO
#include <Servo.h>
#define SERVO_PIN D5
Servo myservo;  // create servo object to control a servo
int pos = 0;    // 設定 Servo 位置的變數


void clearArr(char* arr, int len){
  for(int i = 0 ; i < len; i++){
    *(arr+i) = '\0';
  }
}

char* readFromEEPROM(int Addr){
  static char arr[64];
  for(int i = Addr ; i < EEPROM.read(Addr)+Addr ; i++){
    arr[i-Addr] = EEPROM.read(i+1);
  }
  return arr;
}

char* readFromEEPROM2(int Addr){
  static char arr[64];
  for(int i = Addr ; i < EEPROM.read(Addr)+Addr ; i++){
    arr[i-Addr] = EEPROM.read(i+1);
  }
  return arr;
}

char* readFromEEPROM3(int Addr){
  static char arr[64];
  for(int i = Addr ; i < EEPROM.read(Addr)+Addr ; i++){
    arr[i-Addr] = EEPROM.read(i+1);
  }
  return arr;
}

char* readFromEEPROM4(int Addr){
  static char arr[65];
  for(int i = Addr ; i < EEPROM.read(Addr)+Addr ; i++){
    arr[i-Addr] = EEPROM.read(i+1);
  }
  return arr;
}

void setup_wifi(int mode) {
  connected2Wifi = false;
  delay(10);
  // We start by connecting to a WiFi network
  Serial.println();
  Serial.println(readFromEEPROM(SSID_ADDR));
  delay(100);
  Serial.println(readFromEEPROM2(PASSWORD_ADDR));

  ssid = readFromEEPROM(SSID_ADDR);
  delay(100);
  password = readFromEEPROM2(PASSWORD_ADDR);
  // Serial.println(readFromEEPROM(SSID_ADDR));
  // Serial.println(readFromEEPROM(PASSWORD_ADDR));

  delay(100);
  Serial.print("Connecting to ");
  Serial.println(ssid);
  Serial.println(password);
  Serial.println("----------");

  WiFi.mode(WIFI_STA);
  if(mode == 0)
    WiFi.begin(ssid, password);
  else
    WiFi.begin(tempInput, tempPwdInput);

  int count = 0;
  while (WiFi.status() != WL_CONNECTED) {
    delay(500);
    Serial.print(".");
    count++;
    if(count>20){
      Serial.println("Connect Error");
      break;
    }
  }

  if(WiFi.status() == WL_CONNECTED)
    connected2Wifi = true;


  randomSeed(micros());

  Serial.println("");
  Serial.println("WiFi connected");
  Serial.println("IP address: ");
  Serial.println(WiFi.localIP());
}

void callback(char* topic, byte* payload, unsigned int length) {
  Serial.print("Message arrived [");
  Serial.print(topic);
  Serial.print("] ");
  for (int i = 0; i < length; i++) {
    Serial.print((char)payload[i]);
  }
  Serial.println();

  // Switch on the LED if an 1 was received as first character
  if ((char)payload[0] == '1') {
    digitalWrite(BUILTIN_LED, LOW);   // Turn the LED on (Note that LOW is the voltage level
    // but actually the LED is on; this is because
    // it is active low on the ESP-01)
  } else {
    digitalWrite(BUILTIN_LED, HIGH);  // Turn the LED off by making the voltage HIGH
  }

}

void reconnect() {
  // Loop until we're reconnected
  while (!client.connected()) {
    Serial.print("Attempting MQTT connection...");
    // Create a random client ID
    String clientId = "ESP8266Client-";
    clientId += String(random(0xffff), HEX);
    // Attempt to connect
    if (client.connect(clientId.c_str())) {
      Serial.println("connected");
      // Once connected, publish an announcement...
      client.publish("outTopic", "hello world");
      // ... and resubscribe
      client.subscribe("inTopic");
    } else {
      Serial.print("failed, rc=");
      Serial.print(client.state());
      Serial.println(" try again in 5 seconds");
      // Wait 5 seconds before retrying
      delay(5000);
    }
  }
}


void setup() {
  Serial.begin(9600);   // 與電腦序列埠連線速率
  // Serial.print("SSID: ");
  // Serial.println(readFromEEPROM(SSID_ADDR));
  // Serial.print("PWD: ");
  // Serial.println(readFromEEPROM(PASSWORD_ADDR));
  pixels.begin();           // INITIALIZE NeoPixel strip object (REQUIRED)
  pixels.show();            // Turn OFF all pixels ASAP
  pixels.setBrightness(50); // Set BRIGHTNESS to about 1/5 (max = 255)

  myservo.attach(SERVO_PIN, 500, 2500);

  EEPROM.begin(512);

  // ssid = readFromEEPROM(SSID_ADDR);
  // password = readFromEEPROM(PASSWORD_ADDR);

  delay(1000);

  deviceName = readFromEEPROM4(USER_ID_ADDR);
  Serial.println(deviceName);

  setup_wifi(0);

  client.setServer(mqtt_server, 1883);
  client.setCallback(callback);

  dht.begin();



  // pinMode(LED, OUTPUT);
  // 設定藍牙模組的連線速率
  // HC-05，用38400
  // BT.begin(38400);
}

void loop() {
  // Serial.print("PPP");
  // Serial.println(readFromEEPROM(0));
  // Serial.println(readFromEEPROM(PASSWORD_ADDR));
  // delay(500);
  // 若收到「序列埠監控視窗」的資料，則送到藍牙模組
  if (Serial.available()) {
    lastBlueToothMsg = millis(); // 紀錄藍牙訊號的輸入時間
    val = Serial.read();
    // Serial.println(val);
    switch(mode){
      case 0:
        // mode = (int)val-48;
        mode = 1;
        length = (int)val;
        EEPROM.write(0, length);
        Serial.println(length);
        inputIndex = 0;
        connected2Wifi = false;
        clearArr(tempInput, 64);
        clearArr(tempPwdInput, 64);
        clearArr(ssid, 64);
        clearArr(password, 64);
        Serial.write("RECEIVED");
        Serial.println(mode);
        break;

      case 1:
        // Serial.println(val);
        tempInput[inputIndex] = val;
        EEPROM.write(inputIndex+1, (int)val);
        inputIndex++;
        if(inputIndex+1 > length){
          mode = 2;
          EEPROM.write(inputIndex+2, '\0');
          // strcat(ssid, tempInput);
          Serial.println(tempInput);
          // EEPROM.commit();
        }
        break;

      case 2:
        mode = 3;
        length = (int)val;
        Serial.println(length);

        EEPROM.write(PASSWORD_ADDR, length);
        inputIndex = 0;
        break;

      case 3:
        Serial.println(inputIndex);
        tempPwdInput[inputIndex] = val;
        EEPROM.write(PASSWORD_ADDR + inputIndex+1, (int)val);
        inputIndex++;
        if(inputIndex+1 > length){
          // mode = 0;
          mode = 4;
          Serial.println(tempPwdInput);
          // EEPROM.commit();

          // ssid = readFromEEPROM(SSID_ADDR);
          // password = readFromEEPROM(PASSWORD_ADDR);
          // Serial.println(readFromEEPROM(SSID_ADDR));
          // Serial.println(readFromEEPROM(PASSWORD_ADDR));
          // strcat(password, tempPwdInput);
          // setup_wifi(1);
          // Serial.println(password);
        }
        break;

      case 4:
        mode = 5;
        length = (int)val;
        Serial.println(length);

        EEPROM.write(USER_ID_ADDR, length);
        inputIndex = 0;
        break;

      case 5:
        Serial.println(inputIndex);
        tempUserId[inputIndex] = val;
        EEPROM.write(USER_ID_ADDR + inputIndex+1, (int)val);
        inputIndex++;
        if(inputIndex+1 > length){
          mode = 0;
          // Serial.println(tempPwdInput);
          EEPROM.commit();

          // ssid = readFromEEPROM(SSID_ADDR);
          // password = readFromEEPROM(PASSWORD_ADDR);
          Serial.println(readFromEEPROM(SSID_ADDR));
          Serial.println(readFromEEPROM(PASSWORD_ADDR));
          Serial.println(readFromEEPROM(USER_ID_ADDR));
          // strcat(password, tempPwdInput);
          setup_wifi(1);
          // Serial.println(password);
        }
        break;

    }
    // Serial.println(mode);
    // Serial.println(ssid);
    // Serial.println(password);
    // Serial.write("RECEIVED");
  }

  // 5秒未接收到藍牙訊號就終止輸入模式
  if(millis() - lastBlueToothMsg > 5000){
    mode = 0;
    if(WiFi.status() == WL_CONNECTED)
      connected2Wifi = true;
  }

  // Serial.println(connected2Wifi);
  //連上WiFi後呼叫MQTT
  if(connected2Wifi) {
    breath();
    // Serial.println("asdagrsgfhnghnghgfdrg");
    if(!client.connected())
      reconnect();

    client.loop();
    unsigned long now = millis();

    //每5秒呼叫一次
    if (now - lastMsg > 5000) {
      float h = dht.readHumidity();
      float t = dht.readTemperature();
      temperature = t;

      pos = getRotate(t, 35, 15, 0, 35);
      Serial.println(pos);
      myservo.write(pos);

      lastMsg = now;
      ++value;
      snprintf (msg, MSG_BUFFER_SIZE, "{\"t\":\"%f\", \"h\":\"%f\", \"name\":\"%s\"}", t, h, "deviceName");
      snprintf (mqttChannel, mqttChannel_BUFFER_SIZE, "steamedShrimp/%s", deviceName);
      // Serial.print("Publish message: ");
      Serial.println(deviceName);
      Serial.println(mqttChannel);
      // client.publish("steamedShrimp/ttest", msg);
      client.publish(mqttChannel, msg);
    }

  }

}

void breath(){
  Serial.println(temperature);
  // if(isnan(temperature)) {
  //   pixels.setBrightness(0); // 熄滅燈條
  //   pixels.show();
  //   delay(1000);
  //   return;
  // }

  int redValue = 0;
  int greenValue = 0;
  int blueValue = 0;

  if(temperature >= 35) {
    redValue = 255;
  } else if(temperature <= 15) {
    blueValue = 255;
  } else {
    float range = 35 - 15;
    float temperatureInRange = temperature - 15;
    float percentage = temperatureInRange / range;

    if(percentage < 0) {
      percentage = 0;
    } else if(percentage > 1) {
      percentage = 1;
    }

    redValue = 255 * percentage;
    blueValue = 255 * (1 - percentage);
  }

  // 呼吸燈效果
  for(int brightness=0; brightness<=255; brightness++) {
    for(int i=0; i<NUM_PIXELS; i++) {
      pixels.setPixelColor(i, pixels.Color(redValue, greenValue, blueValue));
    }
    pixels.setBrightness(brightness);
    pixels.show();
    delay(5);
  }

  for(int brightness=255; brightness>=0; brightness--) {
    for(int i=0; i<NUM_PIXELS; i++) {
      pixels.setPixelColor(i, pixels.Color(redValue, greenValue, blueValue));
    }
    pixels.setBrightness(brightness);
    pixels.show();
    delay(5);
  }
}

int getRotate(int t, int maxT, int minT, int maxR, int minR){
  if(t >= maxT)
    return maxR;
  
  if(t <= minT)
    return minR;

  // (minR - s) = ((minT - t)/(minT-maxT) * (maxR-minR);
  return ((float)(minT - t)/(float)(minT-maxT) * (float)(maxR-minR) + minR);;
}