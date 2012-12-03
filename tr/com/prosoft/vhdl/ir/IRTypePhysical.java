package com.prosoft.vhdl.ir;

import java.util.ArrayList;

import com.prosoft.vhdl.lib.LibEnvironment;
import com.prosoft.vhdl.sim.IntValue;
import com.prosoft.vhdl.sim.PhysicalValue;

public class IRTypePhysical extends IRType implements IRangedElement {
	
	public static PhysicalValue createConstant( IRType type, IROper value, String units, IRErrorFactory err ) {
		if( type == null ) return null;
		if( !type.isPhysical() ) {
			err.valueOutOfRange(value.getBegin(), value.toString());
			return null;
		}
		IRTypePhysical rtype = (IRTypePhysical) type.dup();
		IRConst cnst = (IRConst) value;
		long v;
		if( cnst.getConstant() instanceof IntValue ) {
			v = cnst.getConstant().getIntValue();
		}
		else {
			v = (long) cnst.getConstant().getDoubleValue();
			double vf = cnst.getConstant().getDoubleValue();
			if( v != vf ) {
				while( true ) {
					IRPhysicalUnits u = rtype.getLowerUnits(units);
					if( u == null ) {
						err.valueOutOfRange(value.getBegin(), value.toString());
						return new PhysicalValue(rtype, 1, rtype.getUnits());
					}
					PhysicalValue phyValue = (PhysicalValue) ((IRConst)u.getValue()).getConstant();
					vf *= phyValue.getValue();
					v = (long) vf;
					units = phyValue.getUnits();
					if( v == vf ) {
						break;
					}
				}
			}
		}
		if( type != null ) {
			PhysicalValue res = new PhysicalValue(type, v, units);
			IRConst cres = new IRConst(res);
			cres.setType( rtype );
			rtype.getRange().setRangeHigh(cres);
			rtype.getRange().setRangeLow(cres);
			return res;
		} else {
			return new PhysicalValue(null, v, units);
		}
	}
	
//	public IROper integerToPhysical( IROper value ) {
//		if( value == null ) return null;
//		if( value.getType().isPhysical() ) return value;
//		if( value instanceof IRConst && value.getType().isInt() ) {
//			IntValue v = (IntValue) ((IRConst)value).getConstant();
//			PhysicalValue vres = createConstant(this, value, units, null);
//			return new IRConst(vres);
//		} else {
//			throw new RuntimeException(value.getType().toString());
//		}
//	}
	
	String units;
//    IROper rangeHigh, rangeLow, isDownTo;
    final IROperRange range = new IROperRange();
	
	public ArrayList<IRPhysicalUnits> secondaryUnits = new ArrayList<IRPhysicalUnits>();
	private boolean isLeftRight;
	
	public IRTypePhysical( IRPackage pack, String name ) {
		super(pack, name);
	}
	
	public void add( IRPhysicalUnits units, IRErrorFactory err ) {
		if( getUnits(units.getPhysValue().getUnits()) == null && !this.units.equalsIgnoreCase(units.getPhysValue().getUnits()) ) {
			err.invalidPhysicalUnits(getBegin(), units.getPhysValue().getUnits());
		}
		secondaryUnits.add(units);
	}

	@Override
	public IRTypePhysical dup() {
		IRTypePhysical res = new IRTypePhysical(pack, getName());
		res.setUnits(units);
		res.getRange().setDownTo(getRange().isDownTo());
		res.getRange().setRangeHigh(getRange().getRangeHigh());
		res.getRange().setRangeLow(getRange().getRangeLow());
 //       res.setLeftRight(isLeftRight);
        res.secondaryUnits = secondaryUnits;
        subDup(res);
		return res;
	}

	public void registerUnits(LibEnvironment env, IRElement currentOwner) {
		IPhysicalUnitsHolder holder = (IPhysicalUnitsHolder) currentOwner;
		PhysicalValue v = new PhysicalValue(this, 1, null);
		IRConst cnst = new IRConst(v);
		IRPhysicalUnits base = new IRPhysicalUnits(this, units, cnst);
		env.add( base );
		holder.add(base);
		for( int i = 0; i < secondaryUnits.size(); i++ ) {
			IRPhysicalUnits units = secondaryUnits.get(i);
			env.add(units);
			holder.add(units);
		}
	}
	
	@Override
	public boolean isPhysical() {
		return true;
	}

	@Override
	public boolean isAssignableFrom(IRType type) {
//		if( type.isInt() ) return true;
		if( !(type instanceof IRTypePhysical) && !type.isInt() ) return false;
//		IRTypePhysical other = (IRTypePhysical) type;
		// TODO сделать проверку с учетом диапазона
		return true;
	}

	@Override
	public boolean isEqualTo(IRType type) {
		if( !(type instanceof IRTypePhysical) ) return false;
		IRTypePhysical other = (IRTypePhysical) type;
		// TODO сделать нормальную проверку
		return true;
	}

	public String getUnits() {
		return units;
	}

	public void setUnits(String units) {
		this.units = units;
	}

	/*
	public IROper getRangeHigh() {
		return rangeHigh;
	}

	public void setRangeHigh(IROper rangeHigh) {
		this.rangeHigh = integerToPhysical(rangeHigh);
	}

	public IROper getRangeLow() {
		return rangeLow;
	}

	public void setRangeLow(IROper rangeLow) {
		this.rangeLow = integerToPhysical(rangeLow);
	}

	@Override
	public boolean isConst() {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public IROper isDownTo() {
		return isDownTo;
	}

	@Override
	public void setDownTo(IROper downTo) {
        isDownTo = downTo;
	}

	public boolean isLeftRight() {
		return this.isLeftRight;
	}
	public IROper isRight() {
		return isDownTo();
	}
	public void setLeftRight(boolean leftRight) {
		this.isLeftRight = leftRight;
	}
	
    */
    public IRType getRangeType() { return this; }
    
    public IRPhysicalUnits getUnits(String units) {
    	for( IRPhysicalUnits cur : secondaryUnits ) {
    		if( cur.getName().equalsIgnoreCase(units) ) {
    			return cur;
    		}
    	}
    	return null;
    }
    
    public IRPhysicalUnits getLowerUnits(String units) {
    	for( IRPhysicalUnits cur : secondaryUnits ) {
    		PhysicalValue value = (PhysicalValue) ((IRConst)cur.getValue()).constant;
    		if( value.getUnits().equalsIgnoreCase(units) ) {
    			return cur;
    		}
    	}
    	return null;
    }

	@Override
	public IROperRange getRange() {
		return range;
	}
	
}
