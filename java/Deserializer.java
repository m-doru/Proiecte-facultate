import java.util.*;
import java.util.ArrayList;
import java.io.*;

public class Deserializer{
    public ArrayList<Result> deserialize(String filename)
        throws IOException, ClassNotFoundException{
        ObjectInputStream ois = new ObjectInputStream(new FileInputStream(filename));
        
        ArrayList<Result> results = new ArrayList<>();

        while(ois.available() > 0){
            results.add((Result)ois.readObject());
        }

        return results;
    }
}
