package com.prosoft.verilog.ir;

import com.prosoft.common.FullCoord;
import com.prosoft.common.ICoordinatedElement;
import com.prosoft.common.TextCoord;

public abstract class VNamedElement implements ICoordinatedElement {
	
	String name;
	
	public VNamedElement(String name) {
		this.name = name;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public abstract VType getType();
	public abstract VEnvironment getEnvironment();
	public abstract VNamedElementKind getElementKind();
	
	public String toString() {
		return name;
	}

	public String getFullName() {
		return "work." + name;
	}
	
	
	
	
	
	private FullCoord coord = new FullCoord(null, null);
	
	@Override
	public TextCoord getBegin() {
		return coord.getBegin();
	}

	@Override
	public TextCoord getEnd() {
		return coord.getEnd();
	}

	@Override
	public FullCoord getFull() {
		return coord;
	}

	@Override
	public void setBegin(TextCoord coord) {
		this.coord = new FullCoord(coord, getEnd());
	}

	@Override
	public void setEnd(TextCoord coord) {
		this.coord = new FullCoord(getBegin(), coord);
	}

	@Override
	public void setFull(FullCoord coord) {
		this.coord = coord;
	}

	public static boolean isLocalElement(VNamedElement type) {
		return false;
	}
	
	
}
