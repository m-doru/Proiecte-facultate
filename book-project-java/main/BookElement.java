package main;
import exceptions.EntityExistsException;

import java.io.PrintWriter;
import java.util.*;
abstract class BookElement {
	protected String title;
	ArrayList<BookElement> subElements;
	
	abstract void add(String element) throws EntityExistsException;
	abstract void add(String element, int position) throws EntityExistsException;
	abstract boolean remove(String element);
	public boolean equals (Object ob){
		if(this == ob)
			return true;
		if(this.title.equals(((BookElement)ob).title))
			return true;
		return false;
	}
//	abstract void print();
	abstract void print(PrintWriter out, int... cardinal);
}
