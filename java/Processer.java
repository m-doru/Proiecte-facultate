public class Processer{
  private long which = 0;
  private int[] current;
  private int maxCount = -1;
  private int[] mostPresent  = new int[4];
  private int[][] all;
  public Processer(int[] ext, int[][] extrageri){
    this.current = ext;
    this.all = extrageri;
  }

  public int[] getMostPresent(){
    return this.mostPresent;
  }

  public int getMaxCount(){
    return this.maxCount;
  }

  public void process(int []comb){

    int[] subset = new int[4];
    //for(int i = 0; i < 4; ++i)
      //subset[i] = current[comb[i]];

    subset[0] = current[comb[0]-1];
    subset[1] = current[comb[1]-1];
    subset[2] = current[comb[2]-1];
    subset[3] = current[comb[3]-1];

    int count = getCount(subset);

    if(count > maxCount){
      maxCount = count;
      mostPresent = subset;
    }
  }

  private int getCount(int []subset){
    int count = 0;

    int size = all.length;

    for(int i = 0; i < size; ++i)
      if(find(subset[0], all[i])
                  && find(subset[1], all[i])
                  && find(subset[2], all[i])
                  && find(subset[3], all[i]))
        count++;
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
