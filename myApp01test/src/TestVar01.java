public class TestVar01 {
    //主方法
    public static void main(String[] args) {
        //宣告變數
        byte b1 = 127; 
        byte b2 = -128;
        int  price = 2147483647;
        System.out.println(Byte.MIN_VALUE);
        System.out.println(Byte.MAX_VALUE);
        System.out.println(Integer.MIN_VALUE); //int 最小值
        System.out.println(Integer.MAX_VALUE); //int 最大值
        double d1 = 0.01;
        float  f1 = 0.01F;
        float  f2 = (float)d1;   //d1 assign to f2 , 必須轉型
        char ch1 = 'A';
        char ch2 = '好'; 
        char ch3 = 65;
        System.out.println("ch1=" + ch1);
        System.out.println("ch2=" + ch2);
        System.out.println("ch3=" + ch3);
        boolean isRainy = false; //布林
    }
}   

