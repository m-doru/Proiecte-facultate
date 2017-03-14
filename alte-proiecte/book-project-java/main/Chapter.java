package main;

import java.util.ArrayList;
import java.io.PrintWriter;
import java.lang.System;
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
	void add(String subChapter) throws EntityExistsException{
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
	void add(String subChapter, int position) throws EntityExistsException{
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
	void addParagraph(String subChapter, String... paragraphs) throws EntityNotExistsException{
		SubChapter _subChapter = new SubChapter(subChapter);
		if(this.subElements.contains(_subChapter) == true){
			((SubChapter)(this.subElements.get(this.subElements.indexOf(_subChapter)))).addParagraph(paragraphs);
		}
		else
			throw new EntityNotExistsException(subChapter);
	}
	
	void addParagraph(String subChapter, String paragraph, int position) throws EntityNotExistsException, IndexOutOfBoundsException{
		SubChapter _subChapter = new SubChapter(subChapter);
		if(this.subElements.contains(_subChapter) == true){
			((SubChapter)(this.subElements.get(this.subElements.indexOf(_subChapter)))).add(paragraph, position);
		}
		else
			throw new EntityNotExistsException();
	}
	
	@Override
	boolean remove(String subChapter){
		SubChapter _subChapter = new SubChapter(subChapter);
		if(this.subElements.contains(_subChapter) == true){
			return this.subElements.remove(_subChapter);
		}
		return false;
	}
	boolean remove(String subChapter, String paragraph){
		SubChapter _subChapter = new SubChapter(subChapter);
		if(this.subElements.contains(_subChapter) == true){
			return ((SubChapter)(this.subElements.get(this.subElements.indexOf(_subChapter)))).remove(paragraph);
		}
		return false;
	}
	boolean remove(String subChapter, int paragraph){
		SubChapter _subChapter = new SubChapter(subChapter);
		if(this.subElements.contains(_subChapter) == true){
			return ((SubChapter)(this.subElements.get(this.subElements.indexOf(_subChapter)))).remove(paragraph);
		}
		return false;
	}
	
	void printTitle(PrintWriter out,int... cardinal){
		out.print("Chapter ");
		for(int chapterCardinal = 0 ; chapterCardinal < cardinal.length - 1; ++chapterCardinal){
			out.print((cardinal[chapterCardinal]+1) + ".");
		}
		
		if(cardinal.length > 0){
			out.print((cardinal[cardinal.length-1]+1));
		}
		out.println( ": " + this.title);
	}
	
	void print(PrintWriter out,int... cardinal){
			printTitle(out, cardinal);
			int []ierarchy = new int[cardinal.length + 1];
			if(cardinal.length > 0)
				System.arraycopy(cardinal, 0, ierarchy, 0, cardinal.length);
			for(int subchapterCardinal = 0; subchapterCardinal < this.subElements.size(); ++subchapterCardinal){
				ierarchy[ierarchy.length-1] = subchapterCardinal;
				subElements.get(subchapterCardinal).print(out,ierarchy);
			}
	}
	void printNoParagraphs(PrintWriter out,int... cardinal){
		printTitle(out,cardinal);
		int []ierarchy = new int[cardinal.length + 1];
		if(cardinal.length > 0)
			System.arraycopy(cardinal, 0, ierarchy, 0, cardinal.length);
		for(int subchapterCardinal = 0; subchapterCardinal < this.subElements.size(); ++subchapterCardinal){
			ierarchy[ierarchy.length-1] = subchapterCardinal;
			((SubChapter)(subElements.get(subchapterCardinal))).printTitle(out,ierarchy);
		}
	}
}
