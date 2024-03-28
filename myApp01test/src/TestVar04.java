//三元運算子
public class TestVar04 {
    public static void main(String[] args) {
        double n1=10.89,n2=10.925,n3=10.92,max;
        max = n1 > n2 ? n1:n2;
        max = max> n3 ? max:n3;
        System.out.println("三個數中最大數為:" + max);
        
    }
    
}
