import java.io.Serializable;

public class Result implements Comparable<Result>, Serializable{
    private static final long serialVersionUID = 1L;
    private int[] result;
    private int frecv;

    public Result(int[] result, int frecv){
        this.result = result;
        this.frecv = frecv;
    }

    public int getFrecv(){
        return frecv;
    }

    public int compareTo(Result o){
        return this.frecv - o.getFrecv();
    }

    public String toString(){
        StringBuilder ans = new StringBuilder();

        for(int r : result)
            ans.append(r + " ");
        ans.append(" - " + frecv);

        return ans.toString();
    }
}
