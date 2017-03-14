package pb3;

import java.io.PrintWriter;
import java.util.Scanner;

public class Main {
	public static void main(String[] args){
		Solver solver = new Solver();
		Scanner input = new Scanner(System.in);
		solver.read(input);
		solver.solve();
		PrintWriter out = new PrintWriter(System.out);
		solver.printSolution(out);
		out.close();
	}
}
