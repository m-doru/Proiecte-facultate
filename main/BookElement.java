package main;
import exceptions.EntityExistsException;

import java.util.*;
abstract class BookElement {
	protected String title;
	ArrayList<BookElement> subElements;
	
	protected abstract void add(String element) throws EntityExistsException;
	protected abstract void add(String element, int position) throws EntityExistsException;
	protected abstract boolean remove(String element);
	public boolean equals (Object ob){
		if(this == ob)
			return true;
		if(this.title.equals(((BookElement)ob).title))
			return true;
		return false;
	}
}
