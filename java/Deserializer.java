import java.util.*;
import java.util.ArrayList;
import java.io.*;

public class Deserializer{
    public ArrayList<Result> deserialize(String filename)
        throws IOException, ClassNotFoundException{
        ObjectInputStream ois = new ObjectInputStream(new FileInputStream(filename));
        
        ArrayList<Result> results = new ArrayList<>();


        Result res;
        try{
            while((res = (Result)ois.readObject()) != null)
                results.add(res);
        }
        catch(EOFException e){} 

        return results;
    }
}
