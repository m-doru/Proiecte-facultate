package pb2;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.Scanner;
public class Main {
	/*
	 * a)Sortam dupa deadline si asta e ordinea corespunzatoare
	 * b)Daca am sorta dupa ti-li ar fi gresit pentru ca:
	 * Contraexemplu: l1 = 1, t1 = 4/ l2 = 6, d2 = 8
	 * sortate ar fi: activitatea2 activitatea1
	 * 0|---a2---|6|-a1-|7 - intarzierea planificarii e intarzierea activitatii 1 = 3
	 * solutie optima: 0|-a1-|1|-----a2----|7 - intarziere 0
	 */
	public static void read(ArrayList<Activity> activitati){
		Scanner input = new Scanner(System.in);
		int nr = input.nextInt();
		for(int i = 0; i < nr; ++i)
			activitati.add(new Activity(input.nextInt(), input.nextInt()));
		input.close();
	}
	static class DelayComparator implements Comparator<Activity>{
		@Override
		public int compare(Activity a, Activity b){
			return a.getDelay() < b.getDelay() ? -1 : a.getDelay() == b.getDelay() ? 0 : 1;
		}
	}
	public static void main(String[] args){
		ArrayList<Activity> activitati = new ArrayList<>();
		read(activitati);
		Collections.sort(activitati);
		int freeFrom = 0;
		for(Activity activitate : activitati){
			activitate.plannedTime = freeFrom;
			freeFrom += activitate.lenght;
		}
		Activity maxDelay = Collections.max(activitati, new DelayComparator());
		System.out.println(maxDelay);
	}
}
