package com.prosoft.vhdl.gen;

import java.io.IOException;
import java.io.OutputStream;
import java.util.Stack;

public class TextOut {

	Stack<Scope> scopes = new Stack<Scope>();
	OutputStream out;
    public int writesCount = 0;
    public static OutputStream out2 = null; //System.out;
	String name;
	boolean forceLowerCase;
	
	String commentString = "// ";
	
	int labelIndex;
	
	public String generateExitLabel() {
		return "exit_label" + labelIndex++;
	}
	
	public TextOut( String name ) {
		this.name = name;
	}
	
	public TextOut( String name, OutputStream os ) {
		this.name = name;
		this.out = os;
	}
	
	public void setCommentString( String commentString ) {
		this.commentString = commentString;
	}
	
	public void pushScope( Scope scope ) {
		Scope parent = null;
		if( !scopes.empty() ) parent = scopes.lastElement();
		scopes.push(scope);
		if( parent != null ) {
			scope.setParent(parent);
			parent.addChild(scope);
		}
	}
	
	public boolean isForceLowerCase() {
		return forceLowerCase;
	}

	public Scope peekScope() {
		return scopes.peek();
	}
	
	public Scope popScope() {
		return scopes.pop();
	}
	
	public void add( String data ) {
		if( forceLowerCase ) 
		{   //Debugging information shouldn't be changed to low register
			if (!data.contains("(# "))
				data = data.toLowerCase();
		}
		try {
			if( out!= null ) out.write( data.getBytes() );
			if( out2!= null ) out2.write( data.getBytes() );
            writesCount++;
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	public void nl() {
		add( "\r\n" );
	}
	
	public void nlAdd( String str ) {
		nl();
		add(str);
	}
	
	public void tab() {
		int count = scopes.size();
		while( count-- != 0 ) {
			add("\t");
		}
	}
	
	public void comment( String str ) {
		add(commentString);
		add(str);
	}
	
	public void nlComment( String str ) {
		nl();
		comment(str);
	}
	
	public void nlTabComment( String str ) {
		nl();
		tab();
		comment(str);
	}
	
	public void nlTab() {
		nl();
		tab();
	}
	
	public void nlTabAdd( String data ) {
		nl();
		tab();
		add(data);
	}
	
	public void forceLowerCase( boolean force ) {
		this.forceLowerCase = force;
	}
}
