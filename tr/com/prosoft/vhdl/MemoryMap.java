// -*- coding: cp866 -*-
package com.prosoft.vhdl;

import java.math.BigInteger;
import java.util.*;
import java.util.regex.Pattern;
import java.util.regex.Matcher;
import java.io.*;
import java.nio.charset.Charset;

import com.prosoft.vhdl.ir.CompilerError;
import com.prosoft.vhdl.MemoryMapRecord;

// The memory map class.
public class MemoryMap {
	// Shared token patterns.

	// space and space-alike patterns.
	static Pattern space = Pattern.compile ("^[ \t\n\r]+");
	static Pattern comment = Pattern.compile ("^//[^\n]*");

	// braces.
	static Pattern openBrace = Pattern.compile ("^[{]");
	static Pattern closeBrace = Pattern.compile ("^[}]");

	// Delimiters.
	static Pattern colon = Pattern.compile ("^[:]");
	static Pattern semiColon = Pattern.compile ("^[;]");
	static Pattern dot = Pattern.compile("^[.]");

	// Identifiers.
	static Pattern identifier = Pattern.compile("^[a-zA-Z_][a-zA-Z_0-9]*");

	// Range keyword.
	static Pattern rangeKeyword = Pattern.compile ("^range");

	// Range delimiter. Just two dots.
	static Pattern rangeDelimiter = Pattern.compile ("^[.][.]");

	// Integer.
	// Supported: decimal, octal (0o777), hexadecimal (0xbadf00d).
	static Pattern integer10 = Pattern.compile ("^([1-9][0-9]*|0+)");
	static Pattern integer8  = Pattern.compile ("^(0[oO][0-7]+)");
	static Pattern integer16 = Pattern.compile ("^(0[xX][0-9a-fA-F]+)");

	// Filename and text are object-local.
	String filename, text;

	// Constructor. Does not parse text.
	public MemoryMap (String filename, String text) {
		this.filename = filename;
		this.text = text;
	}

	// Parse text and throw error when failed.
	public void parse(List<MemoryMapRecord> records) throws CompilerError {
		startParse(records);
		parseProcess();
	}

	// --------------------------------------------------------------------
	// Parsing.
	//
	// The grammar:
	// memory_map ::=
	//          | def defs
	//
	// def ::= range | registers
	//
	// range ::= "range" path "{" path_ranges "}"
	//
	// path_ranges ::= path_range
	//               | path_range path_ranges
	//
	// path_range :: path ":" integer ".." integer ";"
	//
	// path ::= "." identifier
	//        | "." identifier path
	//
	// registers ::= "registers" path 
	//
	// This is basically regular grammar. So we employ a recursive descent
	// but without a fallback. And the recursion depth is fixed.

	CharSequence currentText;

	List<MemoryMapRecord> mapRecords;

	int line, col;
	void startParse(List<MemoryMapRecord> records) {
		mapRecords = records;
		currentText = text;
		line = 1;
		col = 0;
	}

	boolean EOS() {
		return currentText.length() == 0;
	}

	void compilerError(String msg) throws CompilerError {
		throw new CompilerError(filename + ":" + line + ":" + col + ": " + msg);
	}

	void parseProcess() throws CompilerError {
		while (!EOS()) {
			parseRange();
		}
	}

	String matchPattern(Pattern p) {
		Matcher m = p.matcher(currentText);
		if (m.find()) {
			String result = m.group();
			int i, l = m.end(0);
			for (i=0; i < result.length(); i++) {
				switch (result.charAt(i)) {
					// carriage return does not advance.
					case '\r':
						break;
					// tab advances to least bigger column
					// that is multiply of 8.
					case '\t':
						col = ((col / 8) + 1) * 8;
						break;
					// new line.
					case '\n':
						line = line + 1;
						col = 0;
						break;
					// any other char.
					default:
						col = col + 1;
						break;
				}
			}
			currentText = currentText.subSequence(result.length(),currentText.length());
			return result;
		} else
			return null;
	}
	boolean skipPattern(Pattern p) {
		return matchPattern(p) != null;
	}

	void skipSpace() throws CompilerError {
		while (!EOS()) {
			if (skipPattern(space))
				continue ;
			if (!skipPattern(comment))
				return ;
		}
	}

	void skipExpected(Pattern p, String what) throws CompilerError {
		skipSpace();
		if (!skipPattern(p))
			compilerError(what + " expected.");
	}

	String pathElement(boolean must) throws CompilerError {
		if (must)
			skipExpected(dot,"'.'");
		else {
			skipSpace();
			if (!skipPattern(dot))
				return null;
		}
		// if we had a dot, we have to have an identifier.
		String id = matchPattern(identifier);
		if (id == null)
			compilerError("identifier expected.");
		return id;
	}

	String[] parsePath() throws CompilerError {
		List<String> path = new ArrayList<String>();
		String pathEl = pathElement(true);
		while (pathEl != null) {
			path.add(pathEl);
			pathEl = pathElement(false);
		}
		return path.toArray(new String[path.size()]);
	}

	BigInteger parseInteger() throws CompilerError {
		skipSpace();
		String i = matchPattern(integer8);
		if (i != null)
			return new BigInteger(i.substring(2),8);
		i = matchPattern(integer16);
		if (i != null)
			return new BigInteger(i.substring(2),16);
		i = matchPattern(integer10);
		if (i != null)
			return new BigInteger(i);
		compilerError("integer expected.");
		return new BigInteger("0");
	}

	void parseRanges(String[] path) throws CompilerError {
		skipSpace();
		do {
			int line = this.line;
			int col = this.col;
			String[] signalPath = parsePath();
			skipExpected(colon,"':'");
			BigInteger start = parseInteger();
			skipExpected(rangeDelimiter,"'..'");
			BigInteger end = parseInteger();
			if (start.compareTo(end) > 0)
				compilerError("Second range value should be bigger that first.");
			skipExpected(semiColon,"';'");
			mapRecords.add(new MemoryMapRecord(filename, line, col, path, signalPath, start, end));
			skipSpace();
		} while(!skipPattern(closeBrace));
	}

	void parseRange () throws CompilerError {
		skipSpace();
		if (EOS())
			return ;
		skipExpected(rangeKeyword, "'range'");
		String[] path = parsePath();
		skipExpected(openBrace, "'{'");
		parseRanges(path);	// Closes brace.
	}

}
