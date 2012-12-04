package com.prosoft.common;

public interface ICoordinatedElement {

	void setBegin( TextCoord coord );
	void setEnd( TextCoord coord );
	TextCoord getBegin();
	TextCoord getEnd();
	void setFull(FullCoord coord);
	FullCoord getFull();
}
