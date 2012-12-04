package com.prosoft.common;

public class FullCoord {

	TextCoord begin, end;

	public FullCoord(TextCoord begin, TextCoord end) {
		super();
		this.begin = begin;
		this.end = end;
	}

	public TextCoord getBegin() {
		return begin;
	}

	public void setBegin(TextCoord begin) {
		this.begin = begin;
	}

	public TextCoord getEnd() {
		return end;
	}

	public void setEnd(TextCoord end) {
		this.end = end;
	}
	
	public String toString() {
		return begin + " - " + end;
	}
}
