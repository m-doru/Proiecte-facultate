package main;
/**
 * Book class. Objects of this class will manipulate books(add/remove chapters/subchapters/paragraphs; print the book, table of content)
 * @author M-Doru
 * @version 1.00	
 */
import interfaces.Indexable;
import java.util.ArrayList;
import exceptions.EntityExistsException;
public class Book extends BookElement implements Indexable{
	
	private ArrayList<String> authors;
	
	@Override
	public String index(){throw new UnsupportedOperationException(); }
	/**
	 * The constructor gets the title and a variable number of authors
	 * @param title String variable, is the title of the book
	 * @param authors String array, helds the authors of the book
	 * 
	 */
	Book(String title, String... authors){
		this.title = title;
		this.authors = new ArrayList<>();
		for(String author : authors)
			this.authors.add(author);
		this.subElements = new ArrayList<>();
	}
	
	@Override
	public void add(String chapterTitle, int position) throws EntityExistsException{
		Chapter _chapter = new Chapter(chapterTitle);
		if(subElements.contains(_chapter) == true)
			throw new EntityExistsException();
		else
			subElements.add(position, _chapter);
	}
	/**
	 * The method adds the sub chapter "subChapter" to chapter "chapterTitle" at the position "subChapterPosition" 
	 * If the chapter doesn't exists will thrown an !!!Make exception: EntityNotExistsException
	 * @param chapterTitle String variable - the title of the chapter where to be added the sub chapter "subChapter"
	 * @param subChapter String variable - the title of the sub chapter to be added
	 * @param subChapterPosition int variable - the position where the sub chapter to be added
	 * @throws EntityExistsException
	 */
	public void addSubchapter(String chapterTitle, String subChapter, int subChapterPosition) throws EntityExistsException{
		Chapter _chapter = new Chapter(chapterTitle);
		if(this.subElements.contains(_chapter) == true){
			int poz = this.subElements.indexOf(_chapter);
			this.subElements.get(poz).add(subChapter, subChapterPosition);
		}
	}
	/**
	 * The method adds a variable number of paragraphs to the chapter "chapterTitle", sub chapter "subChapter"
	 * @param chapterTitle String variable - chapter where the paragraphs will be added
	 * @param subChapter String variable - sub chapter where the paragraphs will be added
	 * @param paragraphs String array - paragraphs to be added
	 */
	public void addParagraphs(String chapterTitle, String subChapter, String... paragraphs){
		//if chapterTitle doesn't exist, create it
		//same with subChapter
	}

	
	
}
