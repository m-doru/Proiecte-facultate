package pb3;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Scanner;
public class Solver {
	ArrayList<Sir> siruriDescrescatoare;
	ArrayList<Integer> sirInitial;
	void log(Object... e){
		for(Object el : e)
			System.out.print(el + " ");
		System.out.println();
	}
	Solver(){
		siruriDescrescatoare = new ArrayList<>();
		sirInitial = new ArrayList<>();
	}
	void read(Scanner input){
		for(int size = input.nextInt(), i = 0; i < size; sirInitial.add(input.nextInt()), ++i);
	}
	int binarySearch(int element){
		int lo = 0, hi = siruriDescrescatoare.size()-1;
		if(hi <= 0)return -1;
		while(lo < hi){
			int mid = lo + (hi - lo)>>1;
			if(element <= siruriDescrescatoare.get(mid).lastElement)
				hi = mid;
			else
				lo = mid + 1;
		}
		if(!(element <= siruriDescrescatoare.get(lo).lastElement))
			return -1;
		return lo;
	}
	void solve(){
		for(int element : sirInitial){
			int poz = binarySearch(element);
			if(poz == -1){
				siruriDescrescatoare.add(new Sir(element));
			}
			else{
				siruriDescrescatoare.get(poz).add(element);
			}
		}
	}
	void printSolution(PrintWriter out){
		for(Sir sir : siruriDescrescatoare)
			out.println(sir);
	}
}
