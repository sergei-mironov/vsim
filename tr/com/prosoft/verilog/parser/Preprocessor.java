package com.prosoft.verilog.parser;

import java.io.ByteArrayInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.util.HashSet;
import java.util.Hashtable;
import java.util.Stack;

import com.prosoft.vhdl.parser.VhdlParserTokenManager;

public class Preprocessor extends VerilogParserTokenManager {
	
	class SourceFile {
		VerilogParserTokenManager source;
		String filename;
		File fullName;
		public SourceFile(VerilogParserTokenManager source, String filename, File fullName) {
			this.source = source;
			this.filename = filename;
			this.fullName = fullName;
		}
		
	}
	
	Hashtable<String, String> macroses = new Hashtable<String, String>();
	
	VerilogParser parser;
	Stack<SourceFile> files = new Stack<SourceFile>();

	public Preprocessor(VerilogParserTokenManager sourceFile, VerilogParser parser) {
		// этим token manager'ом мы пользоваться не будем, это просто для обмана javacc
		super(new JavaCharStream(new ByteArrayInputStream(new byte[]{})));
		this.parser = parser;
		push(sourceFile, parser.fileName, parser.fullName);
	}
	
	protected void push( VerilogParserTokenManager source, String filename, File fullName ) {
		files.push(new SourceFile(source, filename, fullName));
	}
	
	public String getTopFilename() {
		return files.peek().filename;
	}
	
	protected Token getNextTokenInternal() {
		Token t = files.peek().source.getNextToken();
		if( t.kind == EOF ) {
			if( ifs.size() > 0 ) {
				System.err.println("No endif for ifdef/ifndef " + ifs.peek().token + " at line " + ifs.peek().token.beginLine);
			}
			while( files.size() > 1 ) {
				files.pop();
				t = files.peek().source.getNextToken();
				if( t.kind != EOF ) return t;
			}
		}
		return t;
	}
	
	class Ifdef {
		Token token;
		boolean met;
		boolean elseMet;
		public Ifdef(Token token, boolean met) {
			this.token = token;
			this.met = met;
		}
	}
	
	Stack<Ifdef> ifs = new Stack<Ifdef>();

	@Override
	public Token getNextToken() {
		while( true ) {
		Token t = getNextTokenInternal();
			if( t.kind == INCLUDE ) {
				Token incFile = getNextTokenInternal();
				String cleanName = incFile.image.substring(1, incFile.image.length()-1);
				File f = new File(files.peek().fullName.getParent(), cleanName);
				if( !f.exists() ) {
					System.err.println("File " + incFile.image + " not found");
					continue;
				}
				FileInputStream is;
				try {
					is = new FileInputStream(f);
				} catch (FileNotFoundException e) {
					System.err.println("File " + incFile.image + " is not accessible");
					continue;
				}
				System.out.println("  Including " + incFile.image + " ...");
				VerilogParserTokenManager man = new VerilogParserTokenManager(new JavaCharStream(is));
				push(man, cleanName, f);
				return getNextToken();
			} else if( t.kind == TIMESCALE ) {
				int i = 5;
				while( i-- > 0 ) getNextTokenInternal();
				continue;
			} else if( t.kind == IFDEF ) {
				Token macro = getNextToken();
				if( macro.image.equalsIgnoreCase("DBG_UART") ) {
					int a = 0;
					a++;
				}
				String value = macroses.get(macro.image);
				ifs.push(new Ifdef(macro, value != null));
				if( value == null ) {
					return skipTokens();
				}
				continue;
			} else if( t.kind == IFNDEF ) {
				Token macro = getNextToken();
				String value = macroses.get(macro.image);
				ifs.push(new Ifdef(macro, value == null));
				if( value != null ) {
					return skipTokens();
				}
				continue;
			} else if( t.kind == ENDIF ) {
				ifs.pop();
				continue;
			} else if( t.kind == UNDEF ) {
				Token name = getNextTokenInternal();
				macroses.remove(name.image);
				continue;
			} else if( t.kind == PREP_ELSE ) {
				checkElse();
				if( ifs.peek().met ) {
					return skipTokens();
				} else {
					continue;
				}
			} else if( t.kind == DEFINE ) {
//				Token macro = getNextToken();
				// строка без 'define и оконечного \r или \n
				String clean = t.image.substring(7, t.image.length()-1).trim();
				int ind = clean.indexOf(' ');
				String name;
				String value;
				if( ind < 0 ) {
					name = clean;
					value = "";
				} else {
					name = clean.substring(0, ind).trim();
					value = clean.substring(ind+1).trim();
				}
				macroses.put(name, value);
				continue;
//				boolean backslashMet = false;
//				int line = macro.beginLine;
//				while( true ) {
//					Token cur = getNextTokenInternal();
//					if( cur.kind == BACKSLASH ) {
//						backslashMet = true;
//						value.append(" " + cur.image);
//						continue;
//					}
//					if( cur.beginLine != line ) {
//						if( backslashMet ) {
//							line = cur.beginLine;
//						} else {
//							macroses.put(macro.image, value.toString());
//							return cur;
//						}
//					} else if( backslashMet ) {
//						System.err.println(cur.image + " met after backslash");
//					} else {
//						value.append(" " + cur.image);
//					}
//				}
			} else if( t.kind == MACRO_NAME ) {
				String name = t.image.substring(1, t.image.length());
				String macroValue = macroses.get(name);
				if( macroValue == null ) {
					System.err.println("Undefined macro " + name);
				} else if( macroValue.length() == 0 ) {
					System.err.println("Empty macro " + name);
				} else {
					ByteArrayInputStream is = new ByteArrayInputStream(macroValue.getBytes());
					push(new VerilogParserTokenManager(new JavaCharStream(is)), t.image, null);
					return getNextToken();
				}
				continue;
			}
			return t;
		}
	}
	
	Token skipTokens() {
		Token macro;
		int ifsMet = 0;
		while( true ) {
			macro = getNextTokenInternal();
			if( macro.kind == EOF ) break;
			if( macro.kind == IFNDEF || macro.kind == IFDEF ) {
				ifsMet++; continue;
			}
			if( macro.kind == ENDIF || macro.kind == ELSEIF || macro.kind == PREP_ELSE ) {
				if( ifsMet == 0 ) break;
			} 
			if( macro.kind == ENDIF ) {
				ifsMet--;
			}
				//(macro = getNextToken()).kind != ENDIF && macro.kind != ELSEIF && macro.kind != PREP_ELSE && macro.kind != EOF ) {
//			System.out.println("Skipping " + macro);
		}
		if( macro.kind == ENDIF ) {
			ifs.pop();
			return getNextToken();
		} else if( macro.kind == ELSEIF ) {
			Token name = getNextTokenInternal();
			String value = macroses.get(name.image);
			if( value != null ) {
				ifs.peek().met = true;
				return getNextTokenInternal();
			} else {
				return skipTokens();
			}
		} else if( macro.kind == PREP_ELSE ) {
			checkElse();
			if( ifs.peek().met ) {
				return skipTokens();
			} else {
				return getNextTokenInternal();
			}
		}
		return macro;
	}

	void checkElse() {
		if( ifs.peek().elseMet ) {
			System.err.println("Dublicate \"`else\"");
		}
		ifs.peek().elseMet = true;
	}
}
