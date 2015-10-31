package main;
import java.util.*;
public class SubChapter extends BookElement {
	ArrayList<String> paragraphs;
	/**
	 * The constructor take a String variable representing the title of the sub chapter
	 * @param title String variable representing the title of the subchapter
	 */
	SubChapter(String title){
		this.title = title;
		this.paragraphs = new ArrayList<>();
	}
	@Override
	/**
	 * The method adds the paragraph paragraph at position position
	 * @param paragraph String variable - the paragraph to be added
	 * @param position int variable - the position where the string will be added
	 */
	public void add(String paragraph, int position) throws IndexOutOfBoundsException{
		this.paragraphs.add(position, paragraph);
	}
	/**
	 * The method adds one or more paragraphs 
	 * @param paragraphs Variable String arguments variable - the pragraphs to be added
	 */
	public void addParagraph(String... paragraphs){
		for(String paragraph : paragraphs)
			this.paragraphs.add(paragraph);
	}
	public boolean remove(String paragraph){
		if(this.paragraphs.contains(paragraph) == true){
				this.paragraphs.remove(paragraph);
				return true;
			}
		return false;
	}
}
