package main;
import java.io.PrintWriter;
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
	 * The method adds paragraph to the sub chapter
	 * @param paragraph String variable representing the paragraph to be added
	 */
	void add(String paragraph){
		paragraphs.add(paragraph);
	}
	@Override
	/**
	 * The method adds the paragraph paragraph at position position
	 * @param paragraph String variable - the paragraph to be added
	 * @param position int variable - the position where the string will be added
	 */
	void add(String paragraph, int position) throws IndexOutOfBoundsException{
		this.paragraphs.add(position, paragraph);
	}
	/**
	 * The method adds one or more paragraphs 
	 * @param paragraphs Variable String arguments variable - the pragraphs to be added
	 */
	void addParagraph(String... paragraphs){
		for(String paragraph : paragraphs)
			this.paragraphs.add(paragraph);
	}
	boolean remove(String paragraph){
		if(this.paragraphs.contains(paragraph) == true){
				this.paragraphs.remove(paragraph);
				return true;
			}
		return false;
	}
	boolean remove(int paragraph){
		if(paragraph < paragraphs.size()){
			paragraphs.remove(paragraph);
			return true;
		}
		else
			return false;
	}

	void printTitle(PrintWriter out,int... cardinal){
		out.print("\tSubchapter ");
		for(int subchapterIerachy = 0; subchapterIerachy < cardinal.length - 1; ++subchapterIerachy)
			out.print((cardinal[subchapterIerachy]+1) + ".");
		if(cardinal.length > 0)
			out.println(cardinal[cardinal.length-1]+1 + ": " + title);
	}
	
	@Override
	void print(PrintWriter out,int... cardinal){
			printTitle(out,cardinal);
			for(int paragraph = 0; paragraph < paragraphs.size(); ++paragraph){
				out.print("\t\tParagraph ");
				for(int ierarchy = 0; ierarchy < cardinal.length-1; ++ierarchy)
					out.print((cardinal[ierarchy]+1)+".");
				out.println((paragraph+1)+ ": " + paragraphs.get(paragraph));
			}
	}
}
