package pb1;

public class Interval implements Comparable<Interval>{
	int inceput, sfarsit;
	Interval(){}
	Interval(int inceput, int sfarsit){
		this.inceput = inceput;
		this.sfarsit = sfarsit;
	}
	public String toString(){
		return new String(inceput + " " + sfarsit);
	}
	void setValues(int a, int b){
		inceput = a;
		sfarsit = b;
	}
	boolean contains(Interval i){
		if(i.inceput >= this.inceput && i.sfarsit <= this.sfarsit)
			return true;
		return false;
	}
	boolean contains(int punct){
		if(punct >= this.inceput && punct <= this.sfarsit)
			return true;
		return false;
	}
	boolean isAfter(int punct){
		if(punct < this.inceput)
			return true;
		return false;
	}
	boolean isBefore(int punct){
		if(punct > this.sfarsit)
			return true;
		return false;
	}
	@Override
	public int compareTo(Interval ob) {
		if(this.inceput < ob.inceput)
			return -1;
		else if(this.inceput == ob.inceput && this.sfarsit < ob.sfarsit)
				return -1;
		if(this.inceput == ob.inceput && this.sfarsit == ob.sfarsit)
			return 0;
		return 1;
	}
}
