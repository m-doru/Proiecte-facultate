package main;
import exceptions.EntityExistsException;
import java.util.*;
public abstract class BookElement {
	protected String title;
	ArrayList<BookElement> subElements;
	/**
	 * The method adds a new BookElement with the title "title" at the position "position"
	 * @param title String variable representing the title of the subElement to be added
	 * @param position Integer variable representing the position where to be added the subElement
	 * @throws EntityExistsException Exception thrown when the subElement to be added already exists
	 */
	public abstract void add(String title, int position) throws EntityExistsException;
	public boolean equals (Object ob){
		if(this == ob)
			return true;
		if(this.title.equals(((BookElement)ob).title))
			return true;
		return false;
	}
}
