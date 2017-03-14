package pb2;


public class Activity implements Comparable<Activity>{
	int deadline,
		lenght,
		plannedTime;
	Activity(){}
	Activity(int lenght, int deadline){
		this.deadline = deadline;
		this.lenght = lenght;
	}
	@Override
	public int compareTo(Activity b){
		if(this.deadline < b.deadline) return -1;
		if(this.deadline == b.deadline) return 0;
		return 1;
	}
	
	public String toString(){
		String durata = this.plannedTime + " -> " + (this.plannedTime + this.lenght);
		String intarziere = this.getDelay() + "";
		return durata + " : " + intarziere;
	}
	
	public int getDelay(){
		int delay = plannedTime + lenght - deadline;
		if(delay > 0)
			return delay;
		return 0;
	}
}
