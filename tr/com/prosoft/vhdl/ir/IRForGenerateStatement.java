package com.prosoft.vhdl.ir;

import java.util.ArrayList;

import com.prosoft.common.FullCoord;
import com.prosoft.common.TextCoord;
import com.prosoft.vhdl.ir.util.IROperVisitor;
import com.prosoft.vhdl.sim.IntValue;

public class IRForGenerateStatement extends IRGenerateStatement implements ILocalResolver {
	
	IRLoopVariable loopVariable;
	
	protected IRForGenerateStatement(IRLoopVariable var) {
		this.loopVariable = var;
	}
	
	public IRForGenerateStatement() {
		loopVariable = new IRLoopVariable(this, null);
	}

	public IRLoopVariable getLoopVariable() {
		return loopVariable;
	}

	@Override
	public void getAccessedObjects(ArrayList<IROper> write,
			ArrayList<IROper> read) {
		this.processed.getAccessedObjects(write, read);
	}

	@Override
	public IROper dup() {
		IRForGenerateStatement res = new IRForGenerateStatement((IRLoopVariable) loopVariable.dup());
		res.loopVariable.setParent(this);
		res.dupChildrenAndCoordAndType(this);
		res.label = label;
		res.processed.statements = dupIRStatementArray(processed.statements);
		res.statements.statements = dupIRStatementArray(statements.statements);
		return res;
	}

	@Override
	public IROperKind getKind() {
		return IROperKind.GEN_FOR;
	}
	
	class Visitor implements IROperVisitor {
		
		IRConst varValue;

		public Visitor(IRConst varValue) {
			this.varValue = varValue;
		}

		@Override
		public void visit(IROper parent, int childIndex, IROper child) {
			if( child instanceof IRConstRead && ((IRConstRead)child).getConstant() == loopVariable ) {
				parent.setChild(childIndex, varValue);
			}
		}
		
	}
	
	protected void processStatements( Visitor vis ) {
		IRStatements cur = statements.dup();
		cur.visitStatement(vis);
		processed.add(cur);
		cur = concurent.dup();
		cur.visitStatement(vis);
		processedConcurent.add(cur);
	}

	@Override
	protected void semanticCheckInternal(IRErrorFactory err) throws CompilerError {
		if( "g1".equalsIgnoreCase(label) ) {
			int a = 0;
			a++;
		}
		loopVariable.setParent(this);
		loopVariable.semanticCheck(err);
		super.semanticCheckInternal(err);
	}

	@Override
	public void generate(IRErrorFactory err) {
		processed.clear();
		processedConcurent.clear();
		processedComponents.clear();
		IROperRange range;
		if( loopVariable.getRange().isRangeOf() ) {
			IRType type = loopVariable.getRange().getRangeOf().getType();
			if( type.isArray() ) {
				range = IRTypeArray.getArray(type, err, loopVariable.getRange()).getFirstIndex().getRange();
			} else {
				reportError();
				return;
			}
		} else {
			range = loopVariable.getRange();
		}
		IRConst low = IRConst.getConstantValue(range.getRangeLow(), err);
		IRConst high = IRConst.getConstantValue(range.getRangeHigh(), err);
		if( low == null || low.getConstant() == null ) {
			err.constantExpressionRequired(range.getRangeLow());
		} else if( high == null || high.getConstant() == null ) {
			err.constantExpressionRequired(range.getRangeHigh());
		} else if( loopVariable.getType().isInt() ) {
			int l = ((IntValue)low.getConstant()).getIntValue();
			int r = ((IntValue)high.getConstant()).getIntValue();
			for( int li = l; li <= r; li++ ) {
				IRConst cnst = IRTypeInteger.createConstant(li);
				Visitor vis = new Visitor(cnst);
				processStatements(vis);
				for( int ci = 0; ci < components.size(); ci++ ) {
					IRComponentInstance inst = components.get(ci);
//					String compName = inst.getName() + "_" + li;
					String compName = getLabel() + "__" + li + "." + inst.getName();
					inst = inst.dup();
					// TODO ensure that the name is unique
					inst.setName(compName);
					inst.visit(vis);
					try {
						inst.semanticCheck(err);
					} catch (CompilerError e) {
						e.printStackTrace();
					}
					processedComponents.add(inst);
				}
			}
		} else {
			throw new RuntimeException();
		}
	}

	@Override
	public IRNamedElement localResolve(String name) {
		return name.equalsIgnoreCase(loopVariable.getName()) ? loopVariable : null;
	}

	@Override
	public void setBegin(TextCoord coord) {
		super.setBegin(coord);
		loopVariable.setBegin(coord);
	}

	@Override
	public void setEnd(TextCoord coord) {
		super.setEnd(coord);
		loopVariable.setEnd(coord);
	}

	@Override
	public void setFull(FullCoord coord) {
		super.setFull(coord);
		loopVariable.setFull(coord);
	}

	@Override
	public void visitStatement(IROperVisitor visitor) {
		super.visitStatement(visitor);
		loopVariable.visit(visitor);
	}
	
	@Override
	public boolean contains(IRNamedElement el) {
		return el == loopVariable;
	}

	@Override
	public void localResolve(IRSubprogramSearchContext context) {
	}

}
