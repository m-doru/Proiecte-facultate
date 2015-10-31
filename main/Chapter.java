package main;

import java.util.ArrayList;
import exceptions.EntityNotExistsException;
import exceptions.EntityExistsException;
class Chapter extends BookElement {
	
	/**
	 * The constructor takes a string which will be the title
	 * @param title String variable - the title of the chapter
	 */
	Chapter(String title){
		this.title = title;
		this.subElements = new ArrayList<>();
	}
	
	@Override
	/**
	 * The method takes a string representing the title of the sub chapter to be added and the position where to be added
	 * @param subChapter String variable - the title of the sub chapter
	 */
	public void add(String subChapter) throws EntityExistsException{
		SubChapter _subChapter = new SubChapter(subChapter);
		if(this.subElements.contains(_subChapter) == false){
			this.subElements.add(_subChapter);
		}
		else
			throw new EntityExistsException();
	}
	
	/**
	 * The method takes a string representing the title of the sub chapter to be added and the position where to be added
	 * @param subChapter String variable - the title of the sub chapter
	 * @param position Int variable - the position where the sub chapter to be added
	 * @throws EntityExistsException Exception thrown when the subChapter already exists
	 */
	@Override
	public void add(String subChapter, int position) throws EntityExistsException{
		SubChapter _subChapter = new SubChapter(subChapter);
		if(this.subElements.contains(_subChapter) == false){
			this.subElements.add(position, _subChapter);
		}
		else
			throw new EntityExistsException();
	}
	
	/**
	 * The method adds paragraphs to the sub chapter subChapter
	 * @param subChapter String variable representing the title of sub chapter to which the paragraphs will be added
	 * @param paragraphs String array representing the paragraphs to be added
	 * @throws EntityNotExistsException 
	 */
	public void addParagraph(String subChapter, String... paragraphs) throws EntityNotExistsException{
		SubChapter _subChapter = new SubChapter(subChapter);
		if(this.subElements.contains(_subChapter) == true){
			((SubChapter)(this.subElements.get(this.subElements.indexOf(_subChapter)))).addParagraph(paragraphs);
		}
		else
			throw new EntityNotExistsException(subChapter);
	}
	
	public void addParagraph(String subChapter, String paragraph, int position) throws EntityNotExistsException, IndexOutOfBoundsException{
		SubChapter _subChapter = new SubChapter(subChapter);
		if(this.subElements.contains(_subChapter) == true){
			((SubChapter)(this.subElements.get(this.subElements.indexOf(_subChapter)))).add(paragraph, position);
		}
		else
			throw new EntityNotExistsException();
	}
	
	@Override
	public boolean remove(String subChapter){
		SubChapter _subChapter = new SubChapter(subChapter);
		if(this.subElements.contains(_subChapter) == true){
			return this.subElements.remove(_subChapter);
		}
		return false;
	}
	
	public boolean remove(String subChapter, String paragraph){
		SubChapter _subChapter = new SubChapter(subChapter);
		if(this.subElements.contains(_subChapter) == true){
			return ((SubChapter)(this.subElements.get(this.subElements.indexOf(_subChapter)))).remove(paragraph);
		}
		return false;
	}
}
