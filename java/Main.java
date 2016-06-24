import java.util.ArrayList;
import java.io.*;

public class Main{
    public static void main(String[] args)
        throws IOException, ClassNotFoundException{
        Deserializer des = new Deserializer();
    
        ArrayList<Result> results;

        results = des.deserialize("serializedResults.ser");

        for(int i = results.size() - 1; i > results.size() - 300 && i >= 0; --i)
            System.out.println(results.get(i));
    }
}
