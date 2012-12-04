package com.prosoft.vhdl.gen;

import java.io.ByteArrayOutputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.util.ArrayList;

public class OutputEnvironment {
	
	ArrayList<TextOut> outs[];
	OutputStream os;

//	@SuppressWarnings("unchecked")
	public TextOut getTextOut( OutputStage stage, String typename ) {
		TextOut res = lookupTextOut(stage, typename);
		if( res != null ) return res;
		res = new TextOut(typename, new ByteArrayOutputStream());
		outs[stage.ordinal()].add(res);
		return res;
	}
	
	@SuppressWarnings("unchecked")
	public OutputEnvironment( OutputStream os ) {
		this.os = os;
		outs = new ArrayList[OutputStage.values().length];
		for( int i = 0; i < outs.length; i++ ) {
			outs[i] = new ArrayList<TextOut>();
		}
	}
	
	TextOut lookupTextOut( OutputStage stage, String typename ) {
		ArrayList<TextOut> out = outs[stage.ordinal()];
		for( int i = 0; i < out.size(); i++ ) {
			TextOut cur = out.get(i);
			if( cur.name.equals(typename) ) {
				return cur;
			}
		}
		return null;
	}
	
	public void generate() throws IOException {
		for( int si = 0; si < outs.length; si++ ) {
			ArrayList<TextOut> out = outs[si];
			for( int ti = 0; ti < out.size(); ti++ ) {
				TextOut cur = out.get(ti);
				ByteArrayOutputStream curOs = (ByteArrayOutputStream) cur.out;
				String st = ";; -*- mode: lisp; coding: cp1251 -*-";//"\r\n// " + cur.name + " " + OutputStage.values()[si] + "\r\n";
				os.write( st.getBytes() );
				os.write( curOs.toByteArray() );
			}
		}
	}
	
	public void addString( String str ) throws IOException {
		os.write( str.getBytes() );
	}
}
