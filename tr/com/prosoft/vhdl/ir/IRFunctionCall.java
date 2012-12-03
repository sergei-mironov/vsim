package com.prosoft.vhdl.ir;

public class IRFunctionCall extends IROper {
	
	IRSubProgram function;
	ILocalResolver context;
	String functionName;
	IROper[] parameters = new IROper[0];
	boolean proceduresOnly;
	
	IROper[] processedParameters;
	
	IRSubprogramSearchContext cnt = new IRSubprogramSearchContext();
	
	public IROper[] getParameters() {
		return parameters;
	}

	public void setParameters(IROper[] parameters) {
		this.parameters = parameters;
		for( int i = 0; i < parameters.length; i++ ) {
			setChild(i, parameters[i]);
		}
	}
	
	public IRFunctionCall dup() {
		IRFunctionCall res = new IRFunctionCall(context, functionName);
		res.dupChildrenAndCoordAndType(this);
		res.function = function;
		res.parameters = dupIROperArray(parameters);
		res.processedParameters = dupIROperArray(processedParameters);
		return res;
	}

	public String getFunctionName() {
		return functionName;
	}

	public IRSubProgram getFunction() {
		return function;
	}

	public IRFunctionCall(ILocalResolver context, String functionName) {
		this.context = context;
		this.functionName = functionName;
	}

//	public IRFunctionCall( IRFunction function ) {
//		this.function = function;
//	}

	@Override
	public IROperKind getKind() {
		return IROperKind.FCALL;
	}

	@Override
	protected boolean requiresValuesAtChildren() {
		return true;
	}
	
	protected IRType[] inferParametersTypes(IRErrorFactory err) throws CompilerError {
		IRType[] res = new IRType[parameters.length];
		for( int i = 0; i < parameters.length; i++ ) {
			if( (parameters[i] instanceof IROperAssoc) ) {
				throw new RuntimeException("Not supported");
			}
			parameters[i].semanticCheck(err);
			res[i] = parameters[i].getType();
		}
		return res;
	}
	
	protected void processParameters(IRErrorFactory err) throws CompilerError {
		/*if( function == null )*/ {
//			IRSubprogramSearchContext cnt = new IRSubprogramSearchContext(functionName, parameters, getType(), err);
			cnt.init(functionName, parameters, getType(), err, this, context, proceduresOnly);
			
			if( getBegin() != null && getBegin().getFile().endsWith("ct00279.vhd") && getBegin().getLine() == 129 ) {
				int a = 0;
				a++;
			}
			
			if( functionName != null && functionName.equalsIgnoreCase("Proc1") ) {
				int a = 0;
				a++;
			}
			
			resolve(cnt);
//			resolve(cnt);
			
			if( cnt.getMatched().size() == 0 ) {
				err.noSubprogram(functionName, parameters, this);
				resolve(cnt);
				setType(null);
				return;
			} else if( cnt.getMatched().size() > 1 ) {
				err.ambiguousCall(this, cnt.getMatched());
			}
			
			function = cnt.getMatched().get(0);
			if( function instanceof IRFunction ) {
				setType(((IRFunction)function).returnType);
			}
			/*
			IRType[] types = inferParametersTypes(err);
//			if( types.length == 0 ) return;
			String canName = IRSubProgram.getCanonicalName(getBegin(), functionName, types);
			function = (IRSubProgram) resolve(canName);//err.parser.localResolve(canName);
			if( function == null ) {
				err.noSubprogram(canName, parameters, this);
				canName = IRSubProgram.getCanonicalName(getBegin(), functionName, types);
				resolve(canName);
				return;
			}
			*/
		}
		
		processedParameters = new IROper[function.getParameters().size()];
		for( int i = 0; i < processedParameters.length; i++ ) {
			IROper param;
			if( i < parameters.length ) {
				param = parameters[i];
			} else {
				param = function.getParameters().get(i).getDefaultValue();
			}
			IRParameter formal = function.getParameters().get(i);
			IRType formalType = formal.getType();
			if( param instanceof IROperAssoc ) {
				IROperAssoc assoc = (IROperAssoc) param;
				IRName trg = (IRName) assoc.getChild(0);
				formal = function.getParameter(trg.getName());
				if( formal == null ) {
					err.undefined(trg.getBegin(), "parameter", trg.getName());
					continue;
				} else {
					formalType = formal.getType();
				}
			}
			if( param instanceof IROperAssoc ) {
				param = param.getChild(1);
				param.setType( formalType );
			} else {
				param.setType( formalType );
			}
			param.semanticCheck(err);
			if( !formalType.getOriginalType().isAssignableFrom(param.getType().getOriginalType()) ) {
				err.incompatibleTypes( formalType, param.getType(), this );
			}
			processedParameters[i] =  param;
			
			if( formal.getObjectClass() == IRObjectClass.FILE ) {
				if( !(param instanceof IObjectElement) || ((IObjectElement)param).getObjectClass() != IRObjectClass.FILE ) {
					err.incorrectObjectClass(param, IRObjectClass.FILE);
				}
				
			} else if( formal.direction == IRDirection.INPUT && (formal.getObjectClass() == IRObjectClass.CONSTANT 
																	|| formal.getObjectClass() == IRObjectClass.VARIABLE) ) {
				
			} else {
				if( param instanceof IObjectElement ) {
					IObjectElement el = (IObjectElement) param;
					if( el.getObjectClass() != formal.getObjectClass() && formal.getObjectClass() != IRObjectClass.VARIABLE ) {
						err.incorrectObjectClass(formalType, el.getObjectClass(), new IRObjectClass[] {formal.getObjectClass()});
					}
				} else {
					switch(formal.getObjectClass()) {
					case SIGNAL:
						err.signalExpected(param); break;
					case VARIABLE:
						err.variableExpected(param); break;
					default:
						err.unexpected(param);
					}
				}
			}
		}
	}

	@Override
	public void semanticCheck(IRErrorFactory err) throws CompilerError {
		processParameters(err);
		if( function != null && function.isFunction() ) {
			setType( ((IRFunction)function).returnType );
		} 
	}

	public IROper[] getProcessedParameters() {
		return processedParameters;
	}

	public boolean isProceduresOnly() {
		return proceduresOnly;
	}

	public void setProceduresOnly(boolean proceduresOnly) {
		this.proceduresOnly = proceduresOnly;
	}

	@Override
	public boolean isEqualTo(IROper other) {
		if( !defaultIsEqualTo(other) ) return false;
		return function == ((IRFunctionCall)other).getFunction();
	}

	public String toString() {
		StringBuffer res = new StringBuffer();
		res.append( functionName + "( " );
		if( processedParameters != null ) {
			for( int i = 0; i < processedParameters.length; i++ ) {
				res.append( processedParameters[i].toString() );
				if( i + 1 < processedParameters.length ) {
					res.append(", ");
				}
			}
		}
		res.append(" )" );
		return res.toString();
	}
}
