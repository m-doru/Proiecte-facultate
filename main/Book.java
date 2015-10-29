package main;
import interfaces.Indexable;
import java.util.ArrayList;
import exceptions.EntityExistsException;
public class Book extends BookElement implements Indexable{
	private ArrayList<String> authors;
	
	@Override
	public String index(){throw new UnsupportedOperationException(); }
	
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
	public void addSubchapter(String chapterTitle, String subChapter, int subChapterPosition) throws EntityExistsException{
		Chapter _chapter = new Chapter(chapterTitle);
		if(this.subElements.contains(_chapter) == true){
			int poz = this.subElements.indexOf(_chapter);
			this.subElements.get(poz).add(subChapter, subChapterPosition);
		}
	}
	public void addParagraphs(String chapterTitle, String subChapter, String... paragraphs){
		//if chapterTitle doesn't exist, create it
		//same with subChapter
	}

	
	
}
