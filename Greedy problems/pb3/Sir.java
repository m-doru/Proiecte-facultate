package pb3;

import java.util.ArrayList;

public class Sir implements Comparable<Sir>{
	ArrayList<Integer> storage;
	int lastElement;
	public Sir(){
		storage = new ArrayList<>();
		lastElement = -1;
	}
	public Sir(int val){
		storage = new ArrayList<>();
		storage.add(val);
		lastElement = val;
	}
	public void add(int element){
		storage.add(element);
		lastElement = element;
	}
	public int compareTo(Sir b){
		return this.lastElement < b.lastElement ? -1 : this.lastElement == b.lastElement? 0 : 1;
	}
	public String toString(){
		String ret = new String();
		for(int i : storage)
			ret += i + " ";
		return ret;
	}
}
