package com.prosoft.vhdl.ir;

import java.util.ArrayList;

public class IRSubprogramSearchContext {

	public String name;
	public IROper[] args;
	public IRType returnType;
	public IRErrorFactory err;
	public IROper relatedOper;
	public boolean proceduresOnly;
	
	public ILocalResolver localResolver;
	
	ArrayList<IRSubProgram> matchedByName = new ArrayList<IRSubProgram>();
	ArrayList<IRSubProgram> matchedFully = new ArrayList<IRSubProgram>();
	ArrayList<IRSubProgram> matchedPartially = new ArrayList<IRSubProgram>();
	
	class ErrorHandler implements IRErrorHandler {
		
		int errorCount;
        ArrayList<String> errors = new ArrayList<String>();

		@Override
		public void handleError(String str) {
            errors.add(str);
			errorCount++;
		}

		@Override
		public int getErrorCount() {
			return errorCount;
		}

		@Override
		public boolean isOkToThrowException() {
			return false;
		}
	}
	
	ErrorHandler handler = new ErrorHandler();
	
	public IRSubprogramSearchContext() {
	}
	
//	public IRSubprogramSearchContext(String name, IROper[] args,
//			IRType returnType, IRErrorFactory err) {
//		this.name = name;
//		this.args = args;
//		this.returnType = returnType;
//		this.err = err;
//	}
	
	void setupHandler() {
		if( err.handlers.peek() == handler ) throw new RuntimeException();
		err.handlers.push(handler);
	}
	
	void removeHandler() {
		if( err.handlers.peek() != handler ) throw new RuntimeException();
		err.handlers.pop();
	}
	
	int getErrorCount() {
		return handler.errorCount;
	}

    void printErrors() {
        for ( String e : handler.errors )
            System.out.println(e);
	}
	
	void reset() {
		handler.errorCount = 0;
        handler.errors.clear();
	}
	
	void init(String name, IROper[] args,
			IRType returnType, IRErrorFactory err, IROper relatedOper, ILocalResolver localResolver, boolean proceduresOnly) {
		this.name = name;
		this.args = args;
		this.returnType = returnType;
		this.err = err;
		this.relatedOper = relatedOper;
		this.localResolver = localResolver;
		this.proceduresOnly = proceduresOnly;
        matchedFully.clear();
        matchedPartially.clear();
	}
	
	public ArrayList<IRSubProgram> getMatchedFully() {
		return matchedFully;
	}

	public ArrayList<IRSubProgram> getMatchedPartially() {
		return matchedPartially;
	}
	
	public ArrayList<IRSubProgram> getMatched() {
		return matchedFully;
	}

	public ArrayList<IRSubProgram> getMatchedByName() {
		return matchedByName;
	}
	
	
	public void checkMatched() throws CompilerError {
		
		MATCH res;
		
		if( matchedByName.size() == 1 ) {
			IRType retType = returnType;
			returnType = null;
			IRSubProgram sub = matchedByName.get(0);
			if( (res = isMatched(sub, this)) != MATCH.NONE ) {
				if( sub.isFunction() ) {
					IRType realRetType = ((IRFunction)sub).getReturnType();
					if( retType != null && !retType.getBaseTypeName().equalsIgnoreCase(realRetType.getBaseTypeName()) ) {
						try {
							err.incompatibleTypes(retType, realRetType, relatedOper);
						} catch (CompilerError e) {
							e.printStackTrace();
						}
					} else {
						if( res == MATCH.FULL ) {
							matchedFully.add(sub);
						} else {
							matchedPartially.add(sub);
						}
					}
				} else {
					if( res == MATCH.FULL ) {
						matchedFully.add(sub);
					} else {
						matchedPartially.add(sub);
					}
				}
			}
		} else {
		
			setupHandler();
	
			for( int i = 0; i < matchedByName.size(); i++ ) {
				IRSubProgram sub = matchedByName.get(i);
				if( sub.isFunction() && proceduresOnly ) continue;
				if( sub.toString().equals("\"<=\"( std_logic_vector, std_logic )") ) {
					int a = 0;
					a++;
				}
				if( (res = isMatched(sub, this)) != MATCH.NONE ) {
					if( res == MATCH.FULL ) {
						if( !matchedFully.contains(sub) ) {
							matchedFully.add(sub);
						}
					} else {
						if( !matchedPartially.contains(sub) ) {
							matchedPartially.add(sub);
						}
					}
				}
			}
			
			removeHandler();
		
		}
		
		if( matchedFully.size() == 0 ) {
//			matchedFully.addAll(matchedPartially);
			if( matchedPartially.size() > 0 ) {
				matchedFully.add(matchedPartially.get(0));
			}
		}
	}
	
	protected IROper[] getProcessedArgs( IRSubProgram sub, IRSubprogramSearchContext cnt ) throws CompilerError {
		boolean error = false;
		if( cnt.args.length > 1 && cnt.args[0] instanceof IROperAssoc ) {
			IROper[] res = new IROper[sub.getParameters().size()];
			for( IROper arg : cnt.args ) {
				if( !(arg instanceof IROperAssoc) ) {
					cnt.err.mixingNamedAndOrderArgs(arg);
					error = true;
					continue;
				}
				IROperAssoc assoc = (IROperAssoc) arg;
				if( !(assoc.getChild(0) instanceof IRName) ) {
					int a = 0;
					a++;
				}
				if( !(assoc.getChild(0) instanceof IRName) ) {
					err.directAssociationRequired(assoc);
				}
				IRName name = (IRName) assoc.getChild(0);
				IRParameter param = sub.getParameter(name.getName());
				if( param == null ) {
					cnt.err.undefinedNoThrow(name.getBegin(), "parameter", name.getName());
					error = true;
					continue;
				}
				res[sub.getParameters().indexOf(param)] = assoc.getChild(1);
			}
			for( int i = 0; i < res.length; i++ ) {
				if( res[i] == null ) {
					error = true;
					cnt.err.missingActualParameter(sub.getParameters().get(i));
				}
			}
			if( error ) return null;
			return res;
		} else {
			for( IROper op : cnt.args ) {
				if( op instanceof IROperAssoc ) {
					error = true;
					cnt.err.mixingNamedAndOrderArgs(op);
				}
			}
			if( error ) return null;
			return cnt.args;
		}
	}
	
	public enum MATCH { NONE, PARTIAL, FULL };
	
	protected MATCH isMatched( IRSubProgram sub, IRSubprogramSearchContext cnt ) throws CompilerError {
		cnt.reset();
		
		if( sub.toString().equals("\"and\"( BOOLEAN, BOOLEAN )") ) {
			int a = 0;
			a++;
		}
		
		MATCH res = MATCH.FULL;
		
		if( !sub.getName().equalsIgnoreCase(cnt.name) ) return MATCH.NONE;
		
		if( cnt.returnType != null ) {
			if( !sub.isFunction() ) return MATCH.NONE;
			IRType retType = ((IRFunction)sub).returnType;
			String name1 = cnt.returnType.getOriginalType().getBaseTypeName();
			String name2 = retType.getOriginalType().getBaseTypeName();
//             System.err.println("cnt.name=" + cnt.name +
//                                "; name1=" + name1 + "; name2=" + name2);
			if( !name1.equalsIgnoreCase(name2) ) {
				res = MATCH.NONE;//MATCH.PARTIAL;
			}
			if( !cnt.returnType.isAssignableFrom(retType) ) return MATCH.NONE;
		}
		
		if( sub.getParameters().size() < cnt.args.length ) return MATCH.NONE;
		
//		System.out.println("Trying " + sub.toString());
		
		IROper[] args = getProcessedArgs(sub, cnt);
		if( args == null ) return MATCH.NONE;
		
		for( int i = 0; i < sub.parameters.size(); i++ ) {
			
//			System.out.print("Params are: ");
			
			if( i < cnt.args.length ) {
				try {
					if( cnt.args[i].getBegin() != null && cnt.args[i].getBegin().getLine() == 150 && cnt.args[i].getBegin().getFile().endsWith("rstctrl.vhd") && cnt.args[i].getBegin().getColumn() > 41 ) {
						int a = 0;
						a++;
					}
					args[i].setType(sub.getParameters().get(i).getType());
					args[i].semanticCheck(cnt.err);
//					System.out.print(cnt.args[i] + " " + cnt.args[i].getType() + " " + cnt.args[i].getBegin());
					IRType actual = sub.parameters.get(i).getType();
					IRType formal = args[i].getType();
					if( actual == null || formal == null ) return MATCH.NONE;
					String name1 = actual.getOriginalType().getBaseTypeName();
					String name2 = formal.getOriginalType().getBaseTypeName();
//                     System.err.println("cnt.name=" + cnt.name + "; arg" + i +
//                                        "; name1=" + name1 + "; name2=" + name2);
					if( !name1.equalsIgnoreCase(name2) ) {
//						System.out.println(" - failed");
						return MATCH.NONE;
					}
					cnt.args[i].setType(actual);
				} catch (CompilerError e) {
				}
//				System.out.println(" - ok");
			} else {
				if( sub.getParameters().get(i).getDefaultValue() == null ) return MATCH.NONE;
			}
		}

//         System.err.println("cnt.name=" + cnt.name + "; cnt.getErrorCount() == " +
//                            cnt.getErrorCount());
//         if ( cnt.getErrorCount() > 0 )
//             cnt.printErrors();
		return (cnt.getErrorCount() == 0) ? res : MATCH.NONE;
	}
}
