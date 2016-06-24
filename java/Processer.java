public class Processer{

  private int[] current;
  private int maxCount = -1;
  private int[] mostPresent;
  private int[][] all;
  private int size;
  public Processer(int[] ext, int[][] extrageri, int size){
    this.current = ext;
    this.all = extrageri;
    this.mostPresent = new int[size];
    this.size = size;
  }

  public int[] getMostPresent(){
    return this.mostPresent;
  }

  public int getMaxCount(){
    return this.maxCount;
  }

  public void process(int []comb){

    int[] subset = new int[size];
    for(int i = 0; i < size; ++i)
      subset[i] = current[comb[i]-1];

    //subset[0] = current[comb[0]-1];
    //subset[1] = current[comb[1]-1];
    //subset[2] = current[comb[2]-1];
    //subset[3] = current[comb[3]-1];

    int count = getCount(subset);

    if(count > maxCount){
      maxCount = count;
      mostPresent = subset;
    }
  }

  private int getCount(int []subset){
    int count = 0;

    int sz = all.length;

    boolean ok = true;

    for(int i = 0; i < sz; ++i){
        for(int j = 0; j < size; ++j)
            ok = ok && find(subset[j], all[i]);
        if(ok == true)
            count++;
        ok = true;
    }
    return count;
  }

  public boolean find(int what, int[] where){    
    int lo = 0,
      hi = where.length-1;
    while(lo <= hi){ 
        int mid = lo + (hi-lo)/2;
     
        if(where[mid] == what)
            return true;
        if(where[mid] < what)
            lo = mid + 1;
        else
            hi = mid - 1;
    }
    return false;
  }
}
