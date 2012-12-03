package com.prosoft.verilog.ir;

import java.util.ArrayList;

import com.prosoft.common.FullCoord;
import com.prosoft.common.ICoordinatedElement;
import com.prosoft.common.TextCoord;

public abstract class VOper implements ICoordinatedElement {

	ArrayList<VOper> children = new ArrayList<VOper>(2);
	VOper parent;
	private VType type;
	
	public VOper() {}
	public VOper( VOper child ) { 
		setChildAt(0, child); 
	}
	
	public VOper( VOper child1, VOper child2 ) {
		setChildAt(0, child1); setChildAt(1, child2); 
	}
	
	public abstract VOperKind getKind();
	
	void setChildAt( int i, VOper child ) {
		while( children.size() < i + 1 ) {
			children.add(null);
		}
		if( child == null ) {
			VOper oldChild = children.get(i);
			if( oldChild != null ) {
				oldChild.parent = null;
			}
			children.set(i, null);
		} else {
//			if( child.parent != null ) {
//				throw new RuntimeException();
//			}
			children.set(i, child);
			child.parent = this;
		}
	}
	
	public VOper getChild( int index ) {
		return children.get(index);
	}
	
	public int getChildIndex(VOper child) {
		return children.indexOf(child);
	}
	
	public VOper getParent() {
		return parent;
	}
	public VType getType() {
		return type;
	}
	
	protected void setType( VType type ) {
		this.type = type;
	}
	
	protected abstract VType inferTypeInternal(VEnvironment env);
	
//	protected abstract void getAccessedObjects(  ArrayList<VOper> write, ArrayList<VOper> read, boolean isWriteTarget );
	protected void getAccessedObjects(  ArrayList<VOper> write, ArrayList<VOper> read, boolean isWriteTarget ) {
		if( this instanceof IElementOper ) {
			IElementOper el = (IElementOper) this;
			if( el.isTop() ) {
				ArrayList<VOper> list = isWriteTarget?write:read;
				list.add(this);
			}
		}
		for( int i = 0; i < getChildNum(); i++ ) {
			getChild(i).getAccessedObjects(write, read, isWriteTarget);
		}
	}
	
	public VType inferType(VEnvironment env) {
		type = inferTypeInternal(env);
		return type;
	}
	
	public String toString() {
		StringBuffer res = new StringBuffer();
		res.append(getKind());
		res.append("( ");
		for( int i = 0; i < children.size(); i++ ) {
			res.append(children.get(i));
			if( i + 1 < children.size() ) {
				res.append(", ");
			}
		}
		res.append(" )");
		return res.toString();
	}
	public int getChildNum() {
		return children.size();
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
	

}
