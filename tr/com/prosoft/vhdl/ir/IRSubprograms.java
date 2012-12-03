package com.prosoft.vhdl.ir;

import java.util.ArrayList;

public class IRSubprograms {

	ArrayList<IRSubProgram> subs = new ArrayList<IRSubProgram>();
	
	public boolean contains( IRSubProgram sub ) {
		return subs.contains(sub);
	}
	
	public void getMatchedByName( IRSubprogramSearchContext cnt ) {
		cnt.setupHandler();

		for( int i = 0; i < subs.size(); i++ ) {
			IRSubProgram sub = subs.get(i);
			if( sub.getName().equalsIgnoreCase(cnt.name) && !cnt.matchedByName.contains(sub) ) {
				cnt.matchedByName.add(sub);
			}
		}
		
		cnt.removeHandler();
	}
	
//	public void getMatched( IRSubprogramSearchContext cnt ) {
//		cnt.setupHandler();
//
//		for( int i = 0; i < cnt.matchedByName.size(); i++ ) {
//			IRSubProgram sub = cnt.matchedByName.get(i);
//			if( isMatched(sub, cnt) ) {
//				if( !cnt.matched.contains(sub) ) {
//					cnt.matched.add(sub);
////                     System.err.println("found matching " + cnt.name);
//				}
//			}
//		}
//		
//		cnt.removeHandler();
//	}
//	
//	protected boolean isMatched( IRSubProgram sub, IRSubprogramSearchContext cnt ) {
//		cnt.reset();
//		
//		if( !sub.getName().equalsIgnoreCase(cnt.name) ) return false;
///*		
//		if( cnt.returnType != null ) {
//			if( !sub.isFunction() ) return false;
//			IRType retType = ((IRFunction)sub).returnType;
////			if( !cnt.returnType.isAssignableFrom(retType) ) return false;
//			String name1 = cnt.returnType.getOriginalType().getBaseTypeName();
//			String name2 = retType.getOriginalType().getBaseTypeName();
////             System.err.println("cnt.name=" + cnt.name +
////                                "; name1=" + name1 + "; name2=" + name2);
//			if( !name1.equalsIgnoreCase(name2) ) return false;
//		}
//*/		
//		if( sub.getParameters().size() < cnt.args.length ) return false;
//		
//		System.out.println("Trying " + sub.toString());
//		
//		for( int i = 0; i < sub.parameters.size(); i++ ) {
//			
//			System.out.print("Params are: ");
//			
//			if( i < cnt.args.length ) {
//				try {
//					cnt.args[i].setType(sub.getParameters().get(i).getType());
//					cnt.args[i].semanticCheck(cnt.err);
//					System.out.print(cnt.args[i] + " " + cnt.args[i].getType() + " " + cnt.args[i].getBegin());
//					if( cnt.args[i].getBegin() != null && cnt.args[i].getBegin().getLine() == 2986 && cnt.args[i].getBegin().getFile().endsWith("numeric_std.vhdl") ) {
//						int a = 0;
//						a++;
//					}
//					IRType actual = sub.parameters.get(i).getType();
//					IRType formal = cnt.args[i].getType();
//					if( actual == null || formal == null ) return false;
//					String name1 = actual.getOriginalType().getBaseTypeName();
//					String name2 = formal.getOriginalType().getBaseTypeName();
////                     System.err.println("cnt.name=" + cnt.name + "; arg" + i +
////                                        "; name1=" + name1 + "; name2=" + name2);
//					if( !name1.equalsIgnoreCase(name2) ) {
//						System.out.println(" - failed");
//						return false;
//					}
//				} catch (CompilerError e) {
//				}
//				System.out.println(" - ok");
//			} else {
//				if( sub.getParameters().get(i).getDefaultValue() == null ) return false;
//			}
//		}
//
////         System.err.println("cnt.name=" + cnt.name + "; cnt.getErrorCount() == " +
////                            cnt.getErrorCount());
////         if ( cnt.getErrorCount() > 0 )
////             cnt.printErrors();
//		return cnt.getErrorCount() == 0;
//	}
	
	public void add( IRSubProgram sub ) {
		if( !subs.contains(sub) ) {
			subs.add(sub);
		}
	}
	
	public int size() {
		return subs.size();
	}
	
	public IRSubProgram get( int index ) {
		return subs.get(index);
	}
}
