package com.prosoft.vhdl.ir;

import java.awt.Image;

import com.prosoft.glue.ComponentImplementation;
import com.prosoft.glue.GenDesc;
import com.prosoft.glue.HDLKind;
import com.prosoft.glue.HDLType;
import com.prosoft.glue.PortDesc;
import com.prosoft.vhdl.ir.util.IROperVisitor;
import com.prosoft.vhdl.lib.Library;

public class IRComponentInstance extends IRFullNamedElement implements ILocalResolver {

	IRNamedElement element;
	ComponentImplementation component;
	Library lib;
	IROper[] genericsAssociations = new IROper[0];
	IROper[] portAssociations = new IROper[0];
	String archName;

	public IRComponentInstance(IRElement parent, Library lib, String name, IRNamedElement libComponent, String archName) {
		super(parent, name);
		if( name.equalsIgnoreCase("omsp_timerA_inst") ) {
			int a = 0;
			a++;
		}
		this.lib = lib;
		this.element = libComponent;
		if( element instanceof IREntity ) {
			this.component = new ComponentImplementation(((IREntity)element));
		} else {
			if( libComponent != null ) {
				this.component = ((IRComponent)libComponent).getImplementation();
			}
		}
		this.archName = archName;
	}
	
	public IRComponentInstance dup() {
		IRComponentInstance res = new IRComponentInstance(getParent(), lib, getName(), element, archName);
		res.component = component;
		res.setPorts(IROper.dupIROperArray(portAssociations));
		res.setGenerics(IROper.dupIROperArray(genericsAssociations));
		return res;
	}
	
	public void setGenerics( IROper[] gens ) {
		this.genericsAssociations = gens;
		if( gens != null ) {
			for( IROper gen : gens ) {
				if( gen != null ) gen.setParent(this);
			}
		}
	}
	
	public void setPorts( IROper[] ports ) {
		this.portAssociations = ports;
		if( ports != null ) {
			for( IROper op : ports ) {
				if( op != null ) op.setParent(this);
			}
		}
	}

	public void visit(IROperVisitor visitor) {
//		if( component instanceof IREntity ) {
//			IREntity en = (IREntity) component;
//			en.arcs.get(0).visit(visitor);
//		} else {
//			throw new RuntimeException();
//		}
		for( int i = 0; i < portAssociations.length; i++ ) {
			portAssociations[i].visit(visitor);
		}
		for( int i = 0; i < genericsAssociations.length; i++ ) {
			genericsAssociations[i].visit(visitor);
		}
	}
	/*
	public void semanticCheck(IRErrorFactory err) throws CompilerError {
		if( genericsAssociations != null ) {
			boolean namedMet = false; // мы встретили уже встретили именовый элемент? 
			for( int i = 0; i < genericsAssociations.length; i++ ) {
				if( genericsAssociations[i] instanceof IROperAssoc ) {
					namedMet = true;
					IROperAssoc assoc = (IROperAssoc) genericsAssociations[i];
					assoc.setParent(this);
					IRName formal = (IRName) assoc.getChild(0);
					
					if( formal.name.equals("CKSEL") ) {
						int a = 0;
						a++;
					}
					
					IRNamedElement target = ((ILocalResolver)component).localResolve(formal.getName());
					IROper expr = assoc.getChild(1);
					if( expr.getType() == null ) {
						if( target instanceof IRConstant ) {
							expr.setType( ((IRConstant)target).type );
						} else
							throw new RuntimeException();
					}
					expr.semanticCheck(err);
					((IRConstant)target).value = expr;
				} else {
					if( namedMet ) {
						err.mixingNamedAndOrderPorts(genericsAssociations[i]);
					} else {
						IRGeneric gen = ((IREntity)component).gens.get(i);
						gen.setValue(genericsAssociations[i]);
					}
				}
			}
		}
		if( portAssociations != null ) {
			for( int i = 0; i < portAssociations.length; i++ ) {
				IROperAssoc assoc = (IROperAssoc) portAssociations[i];
				assoc.setParent(this);
				if( assoc.getChild(0) instanceof IRSignalOper ) continue; // значит замена на настоящий сигнал уже проведена
				IRName formal = (IRName) assoc.getChild(0);
				IRNamedElement target = ((ILocalResolver)component).localResolve(formal.getName());
				if( target == null ) {
					err.undefined(assoc.getBegin(), formal.getName());
				}
				IROper expr = assoc.getChild(1);
				if( expr.getType() == null ) {
					if( target instanceof IRPort ) {
						expr.setType( ((IRPort)target).type );
					} else
						throw new RuntimeException();
				}
				expr.semanticCheck(err);
				// заменяем на настоящий сигнал
//				assoc.setChild(0, new IRSignalOper((IRSignal) target) );
			}
		}
		if( component instanceof IREntity ) {
			IREntity en = (IREntity) component;
			en.semanticCheck(err);
		} else if( component instanceof IRComponent ) {
			IRComponent comp = (IRComponent) component;
			String name = comp.getName();
			IRNamedElement el = lib.getElement(name);
			if( el == null || !(el instanceof IREntity) ) {
				err.undefined(comp.getBegin(), name);
			} else {
				IREntity en = (IREntity) el;
				component = en;
				en.semanticCheck(err);
			}
			comp.semanticCheck(err);
		} else {
			throw new RuntimeException();
		}
	}
	*/

	public void semanticCheck(IRErrorFactory err) throws CompilerError {
		if( getName().equalsIgnoreCase("A_CIS") ) {
			int a = 0;
			a++;
		}
		if( component == null && element != null ) {
			IRComponent comp = resolveComponent(element.getName().toLowerCase());
			if( comp != null ) {
				IRNamedElement el = resolve(element.getName().toLowerCase());
				if( el == null ) {
				} else if( el instanceof IREntity ) {
					component = new ComponentImplementation((IREntity) el);
				}
			}
			if( component == null ) {
				component = lib.getComponentImplementation(element.getName());
				if( component == null ) {
					// if not component found in current environment, let's try to find it in implementations in library "work"
					Library work = lib.getLibEnvironment().getLibrary("work");
					component = work.getComponentImplementation(element.getName().toLowerCase());
				}
			}
		}
		if( component == null ) {
			if( element != null ) {
				err.undefined(getBegin(), element.getName());
			}
			return;
		}
		if( genericsAssociations != null ) {
			boolean namedMet = false; // мы встретили уже встретили именовый элемент? 
			for( int i = 0; i < genericsAssociations.length; i++ ) {
				if( genericsAssociations[i] instanceof IROperAssoc ) {
					namedMet = true;
					IROperAssoc assoc = (IROperAssoc) genericsAssociations[i];
					assoc.setParent(this);
					IRName formal = (IRName) assoc.getChild(0);
					
					if( formal.name.equals("M103C") ) {
						int a = 0;
						a++;
					}
					
					GenDesc target = component.getGeneric(formal.getName());
					if( target == null ) {
						err.undefined(assoc.getBegin(), formal.getName());
					}
					IROper expr = assoc.getChild(1);
					if( expr.getType() == null ) {
						expr.setType( target.getType().getVhdlType() );
					}
					expr.semanticCheck(err);
					if( target.getKind() == HDLKind.VHDL ) {
						target.getGeneric().value = expr;
					}
				} else {
					if( namedMet ) {
						err.mixingNamedAndOrderPorts(genericsAssociations[i]);
					} else {
						GenDesc target = component.getGeneric(i);
						IROper expr = genericsAssociations[i];
						expr.setType( target.getType().getVhdlType() );
						expr.semanticCheck(err);
						if( target.getKind() == HDLKind.VHDL ) {
							target.getGeneric().value = expr;
						}
					}
				}
			}
		}
		if( portAssociations != null ) {
			boolean namedMet = false; // мы встретили уже встретили именовый элемент? 
			for( int i = 0; i < portAssociations.length; i++ ) {
				if( portAssociations[i] instanceof IROperAssoc ) {
					namedMet = true;
					IROperAssoc assoc = (IROperAssoc) portAssociations[i];
					assoc.setParent(this);
					if( assoc.getChild(0) instanceof IRSignalOper ) continue; // значит замена на настоящий сигнал уже проведена
					if( assoc.getChild(0) instanceof IRName ) {
						IRName formal = (IRName) assoc.getChild(0);
						PortDesc target = component.getPort(formal.getName());
						if( target == null ) {
							err.undefined(assoc.getBegin(), formal.getName());
						}
						IROper expr = assoc.getChild(1);
						if( expr.getType() == null ) {
							if( component.getKind() == HDLKind.VHDL ) {
								expr.setType( target.getType().getVhdlType() );
							} else {
								IRPort p = (IRPort) ((IRComponent)element).resolve(target.getName());
								expr.setType(p.getType());
							}
						}
						expr.semanticCheck(err);
					} else {
						err.warn_cantCheckExpression(assoc.getChild(0));
					}
				} else {
					if( namedMet ) {
						err.mixingNamedAndOrderPorts(portAssociations[i]);
					} else {
						PortDesc target = component.getPort(i);
						IROper expr = portAssociations[i];
						if( expr.getType() == null ) {
							if( component.getKind() == HDLKind.VHDL ) {
								expr.setType( target.getType().getVhdlType() );
							} else {
								IRPort p = (IRPort) ((IRComponent)element).resolve(target.getName());
								expr.setType(p.getType());
							}
						}
						expr.semanticCheck(err);
//						IRGeneric gen = ((IREntity)element).gens.get(i);
//						gen.setValue(genericsAssociations[i]);
					}
				}
			}
		}
//		if( component.getKind() == HDLKind.VHDL ) {
//			IREntity en = component.getEntity();
//			en.semanticCheck(err);
//		} else if( component instanceof IRComponent ) {
//			IRComponent comp = (IRComponent) component;
//			String name = comp.getName();
//			IRNamedElement el = lib.getElement(name);
//			if( el == null || !(el instanceof IREntity) ) {
//				err.undefined(comp.getBegin(), name);
//			} else {
//				IREntity en = (IREntity) el;
//				component = en;
//				en.semanticCheck(err);
//			}
//			comp.semanticCheck(err);
//		} else {
//			throw new RuntimeException();
//		}
	}

	public String getArchName() {
		return archName;
	}

	public void setArchName(String archName) {
		this.archName = archName;
	}

	public IROper[] getGenericsAssociations() {
		return genericsAssociations;
	}

	public IROper[] getPortAssociations() {
		return portAssociations;
	}

	public ComponentImplementation getComponent() {
		return component;
	}
	
	public void setEntityImplementation(IREntity entity) {
		component = new ComponentImplementation(entity);
	}

	public String getComponentType() {
		return element.getName();
	}

	@Override
	public boolean contains(IRNamedElement el) {
//		if( component != null && component.getKind() == HDLKind.VHDL ) {
//			return component.getEntity().contains(el);
//		}
//		if( element != null && element instanceof ILocalResolver ) {
//			return ((ILocalResolver)element).contains(el);
//		}
		return false;
	}

	@Override
	public IRNamedElement localResolve(String name) {
//		if( element != null && element instanceof ILocalResolver ) {
//			return ((ILocalResolver)element).localResolve(name);
//		}
		return null;
	}

	@Override
	public void localResolve(IRSubprogramSearchContext context) {
//		if( element != null && element instanceof ILocalResolver ) {
//			((ILocalResolver)element).localResolve(context);
//		}
	}

}
