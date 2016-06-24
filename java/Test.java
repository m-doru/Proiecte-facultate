public class Test{
    public static void main(String[] args){
        Processer p = new Processer(null, null);
 

        assert test1(p) == true;

        assert test2(p) == true;

        assert test3(p) == true;
    }

    private static boolean test1(Processer p){
        int [] a = new int[]{1, 2, 3, 4, 5, 6, 7, 8};
        
        return p.find(1,a) && p.find(8, a) && !p.find(9, a); 
    }
    private static boolean test2(Processer p){
        int [] a = new int[]{1, 2};

        return p.find(1, a) && p.find(2, a);
    }

    private static boolean test3(Processer p){
        int []a = new int[]{1,1,1,1,1,1};

        return p.find(1, a) && !p.find(2, a);
    }
}
