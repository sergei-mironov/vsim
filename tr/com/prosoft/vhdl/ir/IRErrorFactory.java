package com.prosoft.vhdl.ir;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.Stack;

import com.prosoft.common.ICoordinatedElement;
import com.prosoft.common.TextCoord;
import com.prosoft.vhdl.parser.ParserBase;
import com.prosoft.vhdl.parser.ParserBase.ImplementationRule;

public class IRErrorFactory {
	
	public ParserBase parser;
	
	HashSet<Object> undefinedGenerics = new HashSet<Object>(); 
	HashSet<String> undefinedIdents = new HashSet<String>();
	
	IRErrorHandler dummy = new IRErrorHandler() {
		@Override
		public void handleError(String str) {
		}

		@Override
		public int getErrorCount() {
			return 0;
		}

		@Override
		public boolean isOkToThrowException() {
			return false;
		}
	};
	
	Stack<IRErrorHandler> handlers = new Stack<IRErrorHandler>();
	public IRErrorHandler handler() {
		return handlers.peek();
	}
	
	void pushDummyHandler() {
		handlers.push(dummy);
	}
	
	void popDummyHandler() {
		handlers.pop();
	}
	
	public int getErrorCount() {
		return handler().getErrorCount();
	}
	
	public IRErrorFactory() {
		handlers.add( new IRErrorHandler() {

			int errorCount;
			
			@Override
			public void handleError(String str) {
				System.err.println(str);
                System.err.flush();
                errorCount++;
			}
			
			public int getErrorCount() {
				return errorCount;
			}

			@Override
			public boolean isOkToThrowException() {
				return true;
			}
		});
	}
	
	protected String coord( Object op ) {
		if( op instanceof ICoordinatedElement && ((ICoordinatedElement) op).getBegin() != null ) {
			return ((ICoordinatedElement) op).getBegin().toString();
		} else if( op instanceof TextCoord ) {
			TextCoord coord = (TextCoord) op;
			if( coord.getFile() != null ) return coord.toString();
		}
		return "";
	}

    public void pushHandler(IRErrorHandler handler) {
        handlers.push(handler);
    }
    
    public IRErrorHandler popHandler() {
    	return handlers.pop();
    }
    
	public void cantAdd(IRElement el, Object obj) {
		handler().handleError(coord(obj) + "Can't add " + obj + " " + obj.getClass().getSimpleName() + " to " + el.getClass().getSimpleName() + " " + el );
		Thread.dumpStack();
	}

	public void cantAdd(TextCoord coord, IRElement el, Object obj) {
		handler().handleError(coord(coord) + "Can't add " + obj + " " + obj.getClass().getSimpleName() + " to " + el.getClass().getSimpleName() + " " + el );
		Thread.dumpStack();
	}

	public void undefined(TextCoord coord, String name) throws CompilerError {
		String lowName = name.toLowerCase();
		if( lowName.equals("prescaler") ) {
			int a = 0;
			a++;
		}
		if( !undefinedIdents.contains(lowName) ) {
			undefinedIdents.add(lowName);
			handler().handleError(coord(coord) + "Undefined " + name);
		}
		if( handler().isOkToThrowException() ) throw new CompilerError();
	}

	public void undefinedNoEx(TextCoord coord, String name) {
		String lowName = name.toLowerCase();
		if( lowName.equals("prescaler") ) {
			int a = 0;
			a++;
		}
		if( !undefinedIdents.contains(lowName) ) {
			undefinedIdents.add(lowName);
			handler().handleError(coord(coord) + "Undefined " + name);
		}
	}

	public void undefinedNoThrow(TextCoord coord, String name) {
		String lowName = name.toLowerCase();
		if( lowName.equals("natural") ) {
			int a = 0;
			a++;
		}
		if( !undefinedIdents.contains(lowName) ) {
			undefinedIdents.add(lowName);
			handler().handleError(coord(coord) + "Undefined " + name);
		}
	}

	public void undefined(TextCoord coord, String objectType, String name) throws CompilerError {
		String lowName = name.toLowerCase();
		if( lowName.equals("prescaler") ) {
			int a = 0;
			a++;
		}
		if( !undefinedIdents.contains(lowName) ) {
			undefinedIdents.add(lowName);
			handler().handleError(coord(coord) + "Undefined " + objectType + " " + name);
		}
		if( handler().isOkToThrowException() ) throw new CompilerError();
	}
	
	public void undefinedNoThrow(TextCoord coord, String objectType, String name) {
		String lowName = name.toLowerCase();
		if( lowName.equals("prescaler") ) {
			int a = 0;
			a++;
		}
		if( !undefinedIdents.contains(lowName) ) {
			undefinedIdents.add(lowName);
			handler().handleError(coord(coord) + "Undefined " + objectType + " " + name);
		}
	}

	public void incompatibleTypes(IRType t1, IRType t2, IROper relatedOper) throws CompilerError {
		handler().handleError(coord(relatedOper) + "Incompatible Types at \"" + relatedOper.getKind() + "\": " + t1 + " and " + t2 + (t1!=null&&t2!=null?"(" + t1.getBaseTypeName() + " and " + t2.getBaseTypeName() + ")":""));
		if( handler().isOkToThrowException() ) throw new CompilerError();
//         try { throw new RuntimeException(); } catch (RuntimeException e)
//             { e.printStackTrace(); }
	}

	public void incompatibleTypesNoEx(IRType t1, IRType t2, IROper relatedOper) {
		handler().handleError(coord(relatedOper) + "Incompatible Types at \"" + relatedOper.getKind() + "\": " + t1 + " and " + t2 + (t1!=null&&t2!=null?"(" + t1.getBaseTypeName() + " and " + t2.getBaseTypeName() + ")":""));
//         try { throw new RuntimeException(); } catch (RuntimeException e)
//             { e.printStackTrace(); }
	}

	public void incorrectRange(IROper operRange, IRangedElement r) {
		String range = r.getRange().isDownTo().getBooleanValue() ? r.getRange().getRangeHigh() + " downto " + r.getRange().getRangeLow() : r.getRange().getRangeLow() + " to " + r.getRange().getRangeHigh();
		handler().handleError(coord(operRange) + "Incorrect range: " + operRange + " in range " + range);
	}

	public void othersShouldBeLast(IROperOthers others) throws CompilerError {
		handler().handleError(coord(others)+"\"others\" should be last in association list");
		if( handler().isOkToThrowException() ) throw new CompilerError();
	}

	public void mixingNamedAndOrderAggreg(IRAggreg agg) throws CompilerError {
		handler().handleError(coord(agg) + "Mixing named and ordered elements in aggregate");
		if( handler().isOkToThrowException() ) throw new CompilerError();
	}

	public void mixingNamedAndOrderArgs(IROper arg) {
		handler().handleError(coord(arg) + "Mixing named and ordered arguments in call");
	}

	public void mixingNamedAndOrderPorts(IROper op) throws CompilerError {
		handler().handleError(coord(op) + "Mixing named and ordered elements in map");
		if( handler().isOkToThrowException() ) throw new CompilerError();
	}

	public void indexOutOfRange(IROper op) throws CompilerError {
		handler().handleError(coord(op) + "Index out of range: " + op);
		if( handler().isOkToThrowException() ) throw new CompilerError();
	}

	public void multipleAssociationInAggregate(IROperAssoc assoc) throws CompilerError {
		handler().handleError(coord(assoc) + "Multiple associations for an aggregate element: " + assoc);
		if( handler().isOkToThrowException() ) throw new CompilerError();
	}

	public void constantExpressionRequired(IROper oper) {
		handler().handleError(coord(oper) + "Constant expression required: " + oper);
	}

	public void invalidAggregateLength(IRAggreg aggreg, int expectedSize) throws CompilerError {
		handler().handleError("Improper aggregate length. Expected length is " + expectedSize);
		if( handler().isOkToThrowException() ) throw new CompilerError();
	}

	public void fieldNameExpected(IROper oper) throws CompilerError {
		handler().handleError(coord(oper) + "Field name expected " + oper);
		if( handler().isOkToThrowException() ) throw new CompilerError();
	}
	
	public void cantGetField(IROper field, IROper parent) throws CompilerError {
		handler().handleError(coord(field) + "Can't get field " + field + " from " + parent);
		if( handler().isOkToThrowException() ) throw new CompilerError();
	}
	
	public void notRecord(IROper op) throws CompilerError {
		handler().handleError(coord(op) + op + " is not a record");
		if( handler().isOkToThrowException() ) throw new CompilerError();
	}

	public void othersShouldBeAtLeastOne(IRAggreg aggreg) throws CompilerError {
		handler().handleError(coord(aggreg) + "The choice others in a record aggregate should represent at least one element: " + aggreg);
		if( handler().isOkToThrowException() ) throw new CompilerError();
	}

	public void redeclaration(IRNamedElement prevElem, IRNamedElement cur) /*throws CompilerError*/ {
		handler().handleError(coord(cur) + "Redeclaration of " + cur.getName() + ": " + cur + " previous is " + prevElem + " at " + coord(prevElem));
//		if( handler().isOkToThrowException() ) throw new CompilerError();
	}

	public void subProgramHasNoBody(IRSubProgram sub) {
		handler().handleError(coord(sub) + "Subprogram has no corresponding body: " + sub);
	}

	public void arrayExpected(IROper child) {
		handler().handleError(coord(child) + "Array expected: " + child);
	}

	public void integerExpected(IROper expr) {
		handler().handleError(coord(expr) + "Integer expected: " + expr);
	}

	public void typeExpected(IROper expr) {
		handler().handleError(coord(expr) + "Type expected: " + expr);
	}

	public void typeExpected(TextCoord coord) {
		handler().handleError(coord(coord) + "Type expected");
	}

	public void typeExpected(TextCoord coord, String id) {
		handler().handleError(coord(coord) + "Type expected: " + id);
	}

	public void timeExpected(IROper expr) {
		handler().handleError(coord(expr) + "Time expression expected: " + expr);
	}

	public void typeOrArrayExpected(IROper expr) {
		handler().handleError(coord(expr) + "Type or array expected: " + expr);
	}

	public void undefinedAttribute(IROper prefix, String attributeName) throws CompilerError {
		handler().handleError(coord(prefix) + "Undefined attribute \"" + attributeName + "\" at " + prefix);
		if( handler().isOkToThrowException() ) throw new CompilerError();
	}

	public void discreteConstantExpected(IROper op) {
		handler().handleError(coord(op) + "Discrete constant expected: " + op);
	}

	public void discreteExpected(IROper child) {
		handler().handleError(coord(child) + "Disctere type expected: " + child);
	}

	public void discreteOrPhysicalExpected(IROper child) {
		handler().handleError(coord(child) + "Disctere or physical type expected: " + child);
	}

	public void undefinedGeneric(IRGeneric gen) {
		if( undefinedGenerics.contains(gen.getName().toLowerCase()) ) return;
		handler().handleError(coord(gen) + "Undefined generic: " + gen);
		undefinedGenerics.add(gen.getName().toLowerCase());
	}

	public void noSubprogram(String name, IROper[] parameters, IROper related) throws CompilerError {
		handler().handleError(coord(related) + "No subprogram \"" + name + "\" for parameters");
		if( handler().isOkToThrowException() ) throw new CompilerError();
//         try { throw new RuntimeException(); } catch (RuntimeException e)
//             { e.printStackTrace(); }
	}

	public void incorrectConcat(IROper a1, IROper a2) throws CompilerError {
		handler().handleError(coord(a1) + "Incorrect concatenation between " + a1 + " and " + a2 + 
				" (" + a1.getType().getBaseTypeName() + " and " + a2.getType().getBaseTypeName() + ")");
		if( handler().isOkToThrowException() ) throw new CompilerError();
//         try { throw new RuntimeException(); } catch (RuntimeException e)
//             { e.printStackTrace(); }
	}

	public void booleanExpected(IROper op) {
		handler().handleError(coord(op) + "Boolean expression expected " + op);
	}

	public void signalExpected(IROper sig) {
		handler().handleError(coord(sig) + "Signal expected " + sig);
	}

	public void resolutionFunctionUndefined(IRType type) {
		handler().handleError(coord(type) + "Resolution function should be defined for type " + type);
	}

	public void functionNameExpected(IRType type, String found) {
		handler().handleError(coord(type) + "Function name expected, but " + found + " found ");
	}

	public void invalidBitString(String str, IROper relatedOper) {
		handler().handleError(coord(relatedOper) + "Invalid bitstring " + str);
	}

	public void cantInferType(IROper oper) throws CompilerError {
		handler().handleError(coord(oper) + "Can't infer type from expression: " + oper);
//		if( handler().isOkToThrowException() ) throw new CompilerError();
	}

	public void incorrectTypeCast(IRTypeCast oper) throws CompilerError {
		handler().handleError(coord(oper) + "Incorrect type cast: " + oper);
		if( handler().isOkToThrowException() ) throw new CompilerError();
	}

	public void ambiguousCall(IRFunctionCall call, ArrayList<IRSubProgram> matched) throws CompilerError {
		handler().handleError(coord(call) + "Ambiguous call to " + call.functionName + ". See " + 
				coord(matched.get(0)) + " and " + coord(matched.get(1)));
		if( handler().isOkToThrowException() ) throw new CompilerError();
	}

	public void ambiguousBinaryOper(IRBinaryOper oper, ArrayList<IRSubProgram> matched) throws CompilerError {
		handler().handleError(coord(oper) + "Ambiguous binary oper " + oper.getChild(0).getType().getOriginalType().getFullName()
				+ "'" + oper.image + "'" + oper.getChild(1).getType().getOriginalType().getFullName()
				+ ". See " + coord(matched.get(0)) + " and " + coord(matched.get(1))  + " => " + oper.getChild(0) + " _'"+oper.image+"'_ " + oper.getChild(1));
		if( handler().isOkToThrowException() ) throw new CompilerError();
	}

    public void ambiguousUnaryOper(IRUnaryOper oper, ArrayList<IRSubProgram> matched) throws CompilerError {
		handler().handleError(coord(oper) + "Ambiguous unary oper "
                              + "'" + oper.getImage() + "'"
                              + oper.getChild(0).getType().getOriginalType().getFullName()
                              + ". See " + coord(matched.get(0))
                              + " and " + coord(matched.get(1)));
		if( handler().isOkToThrowException() ) throw new CompilerError();
	}

	public void allDoesntAllowedHere(IROper oper) {
		handler().handleError(coord(oper) + "\"ALL\" doesn't allowed here: " + oper);
	}

	public void invalidPhysicalUnits(TextCoord coord, String units) {
		handler().handleError(coord(coord) + "Invalid physical units: " + units);
	}

	public void entityExpected(TextCoord coord, String name) {
		handler().handleError(coord(coord) + "Entity expected: " + name);
	}

	public void packageOrLibraryExpected(TextCoord coord, IRName name) {
		handler().handleError(coord(coord) + "Package or library expected: " + name);
	}

	public void unexpected(IROper oper) {
		handler().handleError(coord(oper) + "Unexpected: " + oper);
	}

	public void incorrentComponent(IRComponentInstance comp,  String expected) throws CompilerError {
		handler().handleError(coord(comp) + "Incorrect component: " + comp.getName() + "(" + comp.getComponentType() + "), expected " + expected);
		if( handler().isOkToThrowException() ) throw new CompilerError();
	}

	public void directAssociationRequired(IROperAssoc assoc) throws CompilerError {
		handler().handleError(coord(assoc) + "Direct association required: " + assoc);
		if( handler().isOkToThrowException() ) throw new CompilerError();
	}

	public void ambiguousImplementation(IRComponentInstance comp, ImplementationRule rule1, ImplementationRule rule2) {
		handler().handleError(coord(comp) + "Ambiguous implementation for " + comp + ": " + rule1.getCompType() + " and " + rule2.getCompType());
	}

	public void incorrectProcedureName(IRSubProgram subProgram) {
		handler().handleError(coord(subProgram) + "Incorrect procedure name " + subProgram);
	}

	public void invalidOverloadedFunction(IRSubProgram subProgram) {
		handler().handleError(coord(subProgram) + "Invalid overloaded function " + subProgram);
	}

	public void cantAccessAttribFromSubprogram(IRAttrib attrib) {
		handler().handleError("Can't access attribute \"" + attrib.getAttributeName() + "\" from subprogram context");
	}

	public void variableExpected(IROper child) {
		handler().handleError(coord(child) + "Variable expected " + child);
	}

	public void valueOutOfRange(TextCoord coord, String value) {
		handler().handleError(coord(coord) + "Value " + value + " is out of range");
	}

	public void cantWrite(IROper oper) {
		handler().handleError(coord(oper) + "Can't write to " + oper);
	}

	public void cantRead(IROper oper) {
		handler().handleError(coord(oper) + "Can't read from " + oper);
	}
	
	public void incorrectObjectClass(IRNamedElement el, IRObjectClass objectClass, IRObjectClass[] allowed) {
		String cl = "";
		for( IRObjectClass cur : allowed ) {
			cl += cur.toString() + ", ";
		}
		cl = cl.substring(0, cl.length() - 2);
		handler().handleError(coord(el) + "Incorrect object class \"" + objectClass + "\" of " + el + ", following classes expected: " + cl );
	}

	public void incorrectObjectClass(IROper el, IRObjectClass allowed) {
		handler().handleError(coord(el) + "Incorrect object class of " + el + ", expected: " + allowed );
	}

	public void ensureObjectClass(IRNamedElement el, IRObjectClass actual, IRObjectClass[] allowed) {
		for( IRObjectClass cur : allowed ) {
			if( actual == cur ) return;
		}
		incorrectObjectClass(el, actual, allowed);
	}

	public void onlyInParamsInFunction(IRParameter parameter) {
		handler().handleError(coord(parameter) + "Only input parameters are allowed in function: " + parameter );
	}

	public void missingActualParameter(IRParameter parameter) {
		handler().handleError(coord(parameter) + "Missing actual parameter for " + parameter );
	}

	public void identifiersDontMatch(TextCoord begin, String name, String image) {
		handler().handleError(coord(begin) + "Identifiers don't match: " + name + " and " + image );
	}

	public void warn_cantCheckExpression(IROper op) {
		System.out.println(coord(op) + "Warning: Can't check expression " + op);
	}

}
