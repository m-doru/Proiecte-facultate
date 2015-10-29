package main;
import java.util.ArrayList;
public class Chapter extends BookElement {
	Chapter(String title){
		this.title = title;
		this.subElements = new ArrayList<>();
	}
	@Override
	public void add(String subChapter, int position){
		throw new UnsupportedOperationException();
	}
}
