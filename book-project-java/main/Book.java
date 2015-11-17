package main;
/**
 * Book class. Objects of this class will manipulate books(add/remove chapters/subchapters/paragraphs; print the book, table of content)
 * @author M-Doru
 * @version 1.00	
 */
import interfaces.Indexable;

import java.io.PrintWriter;
import java.util.ArrayList;
import exceptions.EntityExistsException;
import exceptions.EntityNotExistsException;
public class Book extends BookElement implements Indexable{
	
	//private 
	ArrayList<String> authors;
	
	@Override
	public String index(){
		long index = this.title.hashCode();
		for(String author : authors)
			index += author.hashCode();
		index %= 9999999999L;
		return Long.toString(index);
	}
	
	/**
	 * The constructor gets the title and a variable number of authors
	 * @param title String variable, is the title of the book
	 * @param authors String array, holds the authors of the book
	 * 
	 */
	public Book(String title, String... authors){
		this.title = title;
		this.authors = new ArrayList<>();
		for(String author : authors)
			this.authors.add(author);
		this.subElements = new ArrayList<>();
	}
	public Book(){}
	@Override
	/**
	 * The method adds new chapter with title chapterTitle at the position "position"
	 * @param chapterTitle String variable representing the title of the chapter to be added
	 * @throws EntityExistsException Exception thrown when chapterTitle already exists 
	 */
	public void add(String chapterTitle) throws EntityExistsException{
		Chapter _chapter = new Chapter(chapterTitle);
		if(this.subElements.contains(_chapter) == false){
			this.subElements.add(_chapter);
		}
		else
			throw new EntityExistsException();
	}
	
	/**
	 * The method adds new chapter with title chapterTitle at the position "position"
	 * @param chapterTitle String variable representing the title of the chapter to be added
	 * @param position int variable representing the position where the chapter to be added
	 * @throws EntityExistsException Exception thrown when already exists a chapter with the chapterTitle
	 */
	@Override
	public void add(String chapterTitle, int position) throws EntityExistsException, IndexOutOfBoundsException{
		Chapter _chapter = new Chapter(chapterTitle);
		if(this.subElements.contains(_chapter) == false){
			this.subElements.add(position, _chapter);
		}
		else
			throw new EntityExistsException();
	}
	
	/**
	 * The method adds subChapterTitle to chapter chapterTitle
	 * @param chapterTitle String variable representing the chapter where the sub chapter is wanted to be added
	 * @param subChapterTitle String variable representing the sub chapter to be added
	 */
	
	public void addSubchapter(String chapterTitle, String subChapterTitle) throws EntityNotExistsException, EntityExistsException{
		Chapter _chapter = new Chapter(chapterTitle);
		if(this.subElements.contains(_chapter) == true){
			this.subElements.get(this.subElements.indexOf(_chapter)).add(subChapterTitle);
		}
		else{
			throw new EntityNotExistsException(chapterTitle);
		}
	}
	
	/**
	 * The method adds the sub chapter "subChapter" to chapter "chapterTitle" at the position "subChapterPosition" 
	 * If the chapter doesn't exists will thrown an !!!Make exception: EntityNotExistsException
	 * @param chapterTitle String variable - the title of the chapter where to be added the sub chapter "subChapter"
	 * @param subChapter String variable - the title of the sub chapter to be added
	 * @param subChapterPosition int variable - the position where the sub chapter to be added
	 * @throws EntityExistsException
	 */
	public void addSubchapter(String chapterTitle, String subChapter, int subChapterPosition) throws EntityNotExistsException, EntityExistsException{
		Chapter _chapter = new Chapter(chapterTitle);
		if(this.subElements.contains(_chapter) == true){
			this.subElements.get(this.subElements.indexOf(_chapter)).add(subChapter, subChapterPosition);
		}
		else{
			throw new EntityNotExistsException(chapterTitle);
		}
	}
	
	/**
	 * The method adds a variable number of paragraphs to the chapter "chapterTitle", sub chapter "subChapter"
	 * @param chapterTitle String variable - chapter where the paragraphs will be added
	 * @param subChapter String variable - sub chapter where the paragraphs will be added
	 * @param paragraphs String array - paragraphs to be added
	 * @throws EntityNotExistsException 
	 */
	public void addParagraph(String chapterTitle, String subChapterTitle, String... paragraphs) throws EntityNotExistsException{ 
		Chapter _chapter = new Chapter(chapterTitle);
		if(this.subElements.contains(_chapter) == true){
			((Chapter)(this.subElements.get(this.subElements.indexOf(_chapter)))).addParagraph(subChapterTitle, paragraphs);
		}
		else
			throw new EntityNotExistsException(chapterTitle);
	}
	
	/**
	 * The method adds a in chapter chapterTitle, sub chapter subChapter the paragraph paragraph ar position position
	 * @param chapterTitle String variable - the chapter containing the subChapter where the paragraph will be added
	 * @param subChapter String variable - the sub chapter where the paragraph will be added
	 * @param paragraph String variable - the paragraph to be added
	 * @param position int variable - the position where the paragraph to be added
	 * @throws EntityNotExistsException Exception thrown when the book doesn't contain the chapter with the title chapterTitle
	 * @throws IndexOutOfBoundsException Exception thrown when the position where the paragraph is wanted to be added is not within the bounds of the sub chapter already added paragraphs
	 */
	public void addParagraph(String chapterTitle, String subChapterTitle, String paragraph, int position) throws EntityNotExistsException, IndexOutOfBoundsException{
		Chapter _chapter = new Chapter(chapterTitle);
		if(this.subElements.contains(_chapter) == true){
			((Chapter)(this.subElements.get(this.subElements.indexOf(_chapter)))).addParagraph(subChapterTitle, paragraph, position);
		}
		else
			throw new EntityNotExistsException(chapterTitle);
	}

	/**
	 * The method removes the chapter chapterTitle
	 * @param chapterTitle String variable - the tile of the chapter to be removed
	 */
	@Override
	public boolean remove(String chapterTitle){
		Chapter _chapter = new Chapter(chapterTitle);
		if(this.subElements.contains(_chapter) == true){
			this.subElements.remove(_chapter);
			return true;
		}
		return false;
	}
	
	/**
	 * The method removes the sub chapter subChapterTitle from chapter chapterTitle
	 * @param chapterTitle String variable - the title of the chapter which contains the subChapter to be removed
	 * @param subChapterTitle String variable - the title of the sub chapter to be removed
	 */
	public boolean remove(String chapterTitle, String subChapterTitle){
		Chapter _chapter = new Chapter(chapterTitle);
		if(this.subElements.contains(_chapter) == true){
			return ((Chapter)(this.subElements.get(this.subElements.indexOf(_chapter)))).remove(subChapterTitle);
		}
		return false;
	}
	/**
	 * The method removes the paragraph paragraph from sub chapter subChapterTitle in chapter chapterTitle
	 * @param chapterTitle String variable - the chapter containing sub chapter containing the paragraph to be removed
	 * @param subChapterTitle String variable - the sub chapter containing the paragraph to be removed
	 * @param paragraph String variable - the paragraph to be removed
	 */
	public boolean remove(String chapterTitle, String subChapterTitle, String paragraph){
		Chapter _chapter = new Chapter(chapterTitle);
		if(this.subElements.contains(_chapter) == true){
			return ((Chapter)(this.subElements.get(this.subElements.indexOf(_chapter)))).remove(subChapterTitle, paragraph);
		}
		return false;
	}
	
	/**
	 * The method removes the paragraph situated at position paragraph in subChapterTitle from chapterTitle
	 * @param chapterTitle String variable representing the chapter from which the paragraph is to be removed
	 * @param subChapterTitle String variable representing the sub chapter from which is to be removed the paragraph at position paragraphPosition 
	 * @param paragraphPosition int variable representing the position of the paragraph that is to be removed
	 * @return
	 */
	public boolean remove(String chapterTitle, String subChapterTitle, int paragraphPosition){
		Chapter _chapter = new Chapter(chapterTitle);
		if(this.subElements.contains(_chapter) == true){
			return ((Chapter)(this.subElements.get(this.subElements.indexOf(_chapter)))).remove(subChapterTitle, paragraphPosition);
		}
		return false;
	}
	
	private void printTitleAndAuthors(PrintWriter out,boolean printAuthors){
		out.println(title);
		if(printAuthors == true){
			out.print("\tBy: ");
			for(String s : authors)
				out.print (s + " ");
		}
	}
	
	/**
	 * The method prints the book: title, authors, chapters, sub chapters and paragraphs with format
	 */
	public void print(PrintWriter out){
		printTitleAndAuthors(out,true);
		out.println();
		for(int chapterCardinal = 0; chapterCardinal < subElements.size(); ++chapterCardinal){
			subElements.get(chapterCardinal).print(out,chapterCardinal+1);
		}
			
	}
	@Override
	void print(PrintWriter out,int... cardinal){
		//void implementation of abstract method
	}
	
	/**
	 * The method prints the specified chapter with all the subchapters and paragraphs
	 * @param chapterTitle String variable representing the chapter to be printed
	 * @throws EntityNotExistsException Exception thrown when the chapter chapterTitle does not exist
	 */
	public void printChapter(PrintWriter out,String chapterTitle) throws EntityNotExistsException{
		Chapter _chapter = new Chapter(chapterTitle);
		if(this.subElements.contains(_chapter)){
			this.subElements.get(this.subElements.indexOf(_chapter)).print(out);
		}
		else
			throw new EntityNotExistsException();
	}
	public void printTableOfContents(PrintWriter out){
		printTitleAndAuthors(out,true);
		out.println();
		int cardinal = 0;
		for(BookElement chapter : subElements){
			((Chapter)chapter).printNoParagraphs(out,cardinal++);
		}
	}
}
