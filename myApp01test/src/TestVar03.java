public class TestVar03 {
    public static void main(String[] args) {
        int a=10,b=7;
        System.out.println("a+b=" + a+b);
        System.out.println("a+b=" + (a+b));
        System.out.println("a-b=" + (a-b));
        System.out.println("a*b=" + a*b);
        System.out.println("a/b=" + a/b);
        
        System.out.printf("%d %% %d = %d\n",a,b,a%b);
        //---------------
        int c=100;
        c = c + 1; // c += 1 
        c++;
    }
    
}
