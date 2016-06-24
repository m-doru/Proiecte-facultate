import java.io.*;
import java.util.ArrayList;
import java.util.Collections;

public class Main{
  public static void main(String[] args)
    throws FileNotFoundException, IOException{

    int [][]all = computeData("processedData.out"); 

    ArrayList<Result> results = new ArrayList<>();

    for(int i = 0; i < all.length; ++i){ 
        System.out.println("Processing " + i);
        Processer p = new Processer(all[i], all);

        Combinari c = new Combinari(20, 4, p);

        c.rulareBacktracking();

       results.add(new Result(p.getMostPresent(), p.getMaxCount()));
    }
    
    Collections.sort(results);
    
    serialize(results);

    print(results);

  }

  private static void serialize(ArrayList<Result> results)
    throws IOException{
    ObjectOutputStream oos = new ObjectOutputStream(new FileOutputStream("serializedResults.ser"));

    for(Result res : results)
        oos.writeObject(res);

    oos.close();

  }

  private static void print(ArrayList<Result> results){
    for(int i = 0; i < 10; ++i){
        System.out.println(results.get(i));
    }
  }

  private static int[][] computeData(String filename)
    throws FileNotFoundException, IOException{
    FileInputStream fis = new FileInputStream(filename);

    int lines = 0;

    ArrayList<int[]> ans = new ArrayList<>();

    while(fis.available() > 0){
        int [] values = new int[20];
        int i = 0;
        int a,b;
        while( (a = fis.read()) != 10){
            b = fis.read();
            if(b == 32)
                values[i++] = a-48;
            else{
                values[i++] = (a-48)*10 + (b - 48);
                fis.read();   
            }
        }
        ans.add(values);
    }
    fis.close();
    return ans.toArray(new int[ans.size()][]);
  }
}
