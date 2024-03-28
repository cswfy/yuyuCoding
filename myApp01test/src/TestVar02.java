public class TestVar02 {
    public static void main(String[] args) {
        int age=18;
        String name = "Anna";   //宣告字串物件變數
        final double PI = 3.14159; //宣告常數
        System.out.printf("姓名:%s  年齡:%d\n", name,age);
        //PI = 3.14159;  //常數不可重新指定
        double n1 = 1.23e-3;  //科學記號
        double n2 = 1.23e3;
        System.out.println("n1=" + n1);
        System.out.println("n2=" + n2);
        System.out.println(0b1001); //2進位
        System.out.println(0xff);   //16進位
    }
    
}
