package main;

import java.io.FileNotFoundException;
import java.io.PrintWriter;
import exceptions.EntityExistsException;
import exceptions.EntityNotExistsException;

public class Test {
	public static void print(Book b1){
		System.out.println(b1.title);
		System.out.println(b1.subElements.get(0).title);
		System.out.println(b1.subElements.get(0).subElements.get(0).title);
		System.out.println(((SubChapter)b1.subElements.get(0).subElements.get(0)).paragraphs.get(0));
	}
	public static void main(String [] args){
		String title = "The adventures of a mighty hero",
				authors[] = {"Author1", "Author2", "Author3"},
				chapter = "To Bucharest",
				chapter2 = "In Bucharest",
				subChapter = "The train",
				subChapter2 = "The subway",
				paragraph = "He left thinking will get the 9:30 am train, having time to grab something to eat. But little did he know he will get the 8:44 am train",
				paragraph2 = "Alone, he started thinking about life",
				paragraph3 = "Not alone anymore";
		PrintWriter out;
		try {
			out = new PrintWriter("./src/main/out.txt");
		} catch (FileNotFoundException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
			return;
		}
		Book b1 = new Book(title, authors);
		try{
			b1.add(chapter);
			b1.add(chapter2);
			b1.addSubchapter(chapter, subChapter);
			b1.addSubchapter(chapter2, subChapter2);
			b1.addParagraph(chapter, subChapter, paragraph, paragraph2);
			b1.addParagraph(chapter2, subChapter2, paragraph3);
		}
		catch(EntityExistsException | EntityNotExistsException e){
			e.printStackTrace();
		}
		
		b1.print(out);
		
		out.flush();
		out.close();
	}
	}

