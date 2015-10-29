package main;
import exceptions.EntityExistsException;
import java.util.*;
public abstract class BookElement {
	protected String title;
	ArrayList<BookElement> subElements;
	public abstract void add(String element, int position) throws EntityExistsException;
	public boolean equals (Object ob){
		if(this == ob)
			return true;
		if(this.title.equals(((BookElement)ob).title))
			return true;
		return false;
	}
}
