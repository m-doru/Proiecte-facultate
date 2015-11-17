package pb1;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Scanner;
public class Main {
	static void read(Interval intervalDeAcoperit, ArrayList<Interval>intervalCurent){
		Scanner input = new Scanner(System.in);
		intervalDeAcoperit.setValues(input.nextInt(), input.nextInt());
		int nr = input.nextInt();
		
		for(int i = 0; i < nr; ++i)
			intervalCurent.add(new Interval(input.nextInt(), input.nextInt()));
		input.close();
	}
	static void log(Interval i){
		System.out.println(i);
	}
	public static void main(String []args){
		Interval intervalDeAcoperit = new Interval();
		ArrayList<Interval> intervalCurent = new ArrayList<>();
		ArrayList<Interval> solutie = new ArrayList<>();
		read(intervalDeAcoperit,  intervalCurent);
		Collections.sort(intervalCurent);
	
		//@param critial = intervalul dintre inceputul intervalului care mi-a ramas de acoperi si sfarsitul intervalului care este acoperit pana in momentul curent
		//intervalul care mi-a ramas de acoperit se modifica dinamic de fiecare data cand ajung in situatia in care nu se mai poate inlocui un interval cu alt interval
		
		Interval critical = new Interval(0, intervalDeAcoperit.inceput);
		int size = intervalCurent.size();
		for(int i = 0; i < size && critical.sfarsit < intervalDeAcoperit.sfarsit; ++i){
			if(intervalCurent.get(i).contains(critical)){
				//daca intervalul curent are capatul intre capatul intervalului ales anterior(conditie asigurata de sortare)
                //si inceputul intervalului care mi-a ramas de acoperit(prima conditie din contains) si este suficient de lung(a doua conditie din contains)
                // atunci il poate inlocui pe candidatul anterior pentru ca:
                //1.se mentine continuitatea intervalului acoperit
                //2.este un cadidat mai bun pentru ca se termina mai tarziu astfel se ajunge la minimizarea numarului de intevale necesare
				critical.sfarsit = intervalCurent.get(i).sfarsit;
				solutie.remove(solutie.size() - 1);
				solutie.add(intervalCurent.get(i));
			}
			else if(critical.contains(intervalCurent.get(i).inceput) && critical.isBefore(intervalCurent.get(i).sfarsit)){
				//daca intervalul curent nu il mai poate inlocui pe candidatul anterior
                //pentru ca nu s-ar mentine continuitatea intervalului acoperit pana in momentul actual(prima conditie din contains)
                //verific daca acesta concatenat la intervalul anterior mentine continuitatea intervalului acoperit(a doua conditie din contains)
                //si daca imi mareste intervalul acoperit(a doua conditie din if) adica daca este util
                //il adaug la solutie
				critical.inceput = critical.sfarsit;
				critical.sfarsit = intervalCurent.get(i).sfarsit;
				solutie.add(intervalCurent.get(i));
			}
		}
		if(critical.isBefore(intervalDeAcoperit.sfarsit)){
			System.out.println("-1");
			return;
		}
		System.out.println(solutie.size());
		for(Interval e : solutie)
			System.out.println(e);
	}
}
