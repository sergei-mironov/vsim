package com.prosoft.verilog.ir;

import java.util.ArrayList;
import java.util.Iterator;

import com.prosoft.vhdl.ir.CompilerError;

public class VEnvironment implements IVNamedSpace {
	
	public final VErrorFactory err;
	
	ArrayList<VEnvironment> children = new ArrayList<VEnvironment>();
	VEnvironment parent;
	
	public VEnvironment(VEnvironment parent, VErrorFactory err) {
		this.err = err;
		this.parent = parent;
		if( parent != null ) {
			parent.children.add(this);
		}
	}

	VNameSpace namespace = new VNameSpace(VNameSpaceKind.DEFINITIONS);
	
	public VNamedElement resolve( String name, boolean generateError ) {
		if( name.equalsIgnoreCase("TACTL_D") ) {
			int a = 0;
			a++;
		}
		VNamedElement el = get(name);
		if( el == null && parent != null ) {
			el = parent.resolve(name, false);
		}
		if( el == null && generateError ) {
			err.undefined(name);
		}
		return el;
	}
	
	@Override
	public VNamedElement get(String name) {
		return namespace.get(name);
	}

	@Override
	public VNameSpaceKind getKind() {
		return namespace.getKind();
	}

	@Override
	public void put(VNamedElement el) {
		namespace.put(el);
	}
	
	public ArrayList<VPort> getPorts() {
		ArrayList<VPort> res = new ArrayList<VPort>();
		Iterator<VNamedElement> it = namespace.els.values().iterator();
		while( it.hasNext() ) {
			VNamedElement el = it.next();
			if( el.getName().equalsIgnoreCase("irq_ta0") ) {
				int a = 0;
				a++;
			}
			if( el.getElementKind() == VNamedElementKind.PORT ) res.add((VPort) el);
		}
		return res;
	}

	public ArrayList<VParameter> getParameters() {
		ArrayList<VParameter> res = new ArrayList<VParameter>();
		Iterator<VNamedElement> it = namespace.els.values().iterator();
		while( it.hasNext() ) {
			VNamedElement el = it.next();
			if( el.getElementKind() == VNamedElementKind.PARAMETER ) res.add((VParameter) el);
		}
		return res;
	}
	
	public ArrayList<VNet> getNets() {
		ArrayList<VNet> res = new ArrayList<VNet>();
		Iterator<VNamedElement> it = namespace.els.values().iterator();
		while( it.hasNext() ) {
			VNamedElement el = it.next();
			if( el.getElementKind() == VNamedElementKind.NET ) res.add((VNet) el);
		}
		return res;
	}
	
	public ArrayList<VVariable> getVariables() {
		ArrayList<VVariable> res = new ArrayList<VVariable>();
		Iterator<VNamedElement> it = namespace.els.values().iterator();
		while( it.hasNext() ) {
			VNamedElement el = it.next();
			if( el.getElementKind() == VNamedElementKind.VARIABLE ) res.add((VVariable) el);
		}
		return res;
	}
	
	
	
	// utility methods
	public boolean ensureType( VTypeKind[] allowedTypes, VOper op, boolean constantRequired ) {
		VType type = op.inferType(this);
		if( type == null ) {
			err.typesExpected(allowedTypes, op, constantRequired); return false;
		}
		boolean found = false;
		for( int i = 0; i < allowedTypes.length; i++ ) {
			if( type.getKind() == allowedTypes[i] ) { found = true; break; }
		}
		if( !found ) {
			err.typesExpected(allowedTypes, op, constantRequired); return false;
		}
		if( constantRequired && VConst.getConst(op) == null ) {
			err.typesExpected(allowedTypes, op, constantRequired); return false;
		}
		return true;
	}
	
	public VType inferBiggestTypeAndMakeCast( VOper[] ops ) {
		long size = 0;
		VType biggestType = null;
		for( int i = 0; i < ops.length; i++ ) {
			long curSize = ops[i].getType().getSize();
			if( curSize > size ) {
				size = curSize;
				biggestType = ops[i].getType();
			}
		}
		if( biggestType != null ) {
			for( int i = 0; i < ops.length; i++ ) {
				VOper child = ops[i];
				VOper parent = child.getParent();
				int index = parent.getChildIndex(child);
				parent.setChildAt(index, null);
				child = VOperCast.cast(this, biggestType, child);
				parent.setChildAt(index, child);
			}
			return biggestType;
		} else {
			throw new RuntimeException();
		}
	}
	
	public boolean ensureNet( VOper op ) {
		op.inferType(this);
		if( op instanceof IElementOper ) {
			IElementOper el = (IElementOper) op;
			if( el.getElement() instanceof VNet || el.getElement() instanceof VPort ) return true;
		}
		err.netOrPortExpected(op);
		return false;
	}

	public boolean ensureNetOrVarOrPort(VOper op) {
		op.inferType(this);
		if( op instanceof IElementOper ) {
			IElementOper el = (IElementOper) op;
			if( el.getElement() instanceof VNet || el.getElement() instanceof VVariable || el.getElement() instanceof VPort ) return true;
		}
		err.netExpected(op);
		return false;
	}
	
	public boolean ensureType( VType requiredType, VOper oper, boolean constantRequired ) {
		return ensureType(new VTypeKind[]{requiredType.getKind()}, oper, constantRequired );
	}

	public void semanticCheck() {
		for( VNamedElement el : namespace.els.values() ) {
			if( el instanceof VModule ) {
				VModule module = (VModule) el;
				try {
					module.check();
				} catch (CompilerError e) {
					e.printStackTrace();
				}
			} else if( el instanceof VVariable ) {
				VVariable var = (VVariable) el;
				if( var.getInit() != null ) {
					ensureType(var.type, var.getInit(), false);
				}
			} else if( el instanceof VNet ) {
				VNet net = (VNet) el;
				if( net.getInit() != null ) {
					ensureType(net.getType(), net.getInit(), false);
				}
			} else if( el instanceof VPort ) {
				
			} else if( el instanceof VParameter ) {
				VParameter p = (VParameter) el;
				if( p.getExpression() != null ) {
					ensureType(p.getType(), p.getExpression(), false);
				}
			} else {
				throw new RuntimeException(el.getClass().getCanonicalName());
			}
		}
	}

}
