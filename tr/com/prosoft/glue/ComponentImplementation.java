package com.prosoft.glue;

import java.util.ArrayList;
import java.util.HashMap;

import com.prosoft.verilog.ir.VModule;
import com.prosoft.verilog.ir.VParameter;
import com.prosoft.verilog.ir.VPort;
import com.prosoft.vhdl.ir.IREntity;
import com.prosoft.vhdl.ir.IRGeneric;
import com.prosoft.vhdl.ir.IRPort;

public class ComponentImplementation {

	private HashMap<String, PortDesc> ports = new HashMap<String, PortDesc>();
	private ArrayList<PortDesc> portList = new ArrayList<PortDesc>();
	
	private HashMap<String, GenDesc> gens = new HashMap<String, GenDesc>();
	private ArrayList<GenDesc> genList = new ArrayList<GenDesc>();
	
	private boolean isInterfaceRead = false;
	
	IREntity entity;
	VModule module;
	HDLKind kind;
	
	public ComponentImplementation( IREntity entity ) {
		this.entity = entity;
		kind = HDLKind.VHDL;
		if( entity.getName().equalsIgnoreCase("fmctl2_analogPart") ) {
			int a = 0;
			a++;
		}
	}
	
	public ComponentImplementation( VModule module ) {
		this.module = module;
		kind = HDLKind.VERILOG;
	}
	
	protected void readInterfaceFromEntity() {
		for( int i = 0; i < entity.getPorts().size(); i++ ) {
			IRPort p = entity.getPorts().get(i);
			put( new PortDesc(p) );
		}
		for( int i = 0; i < entity.getGenerics().size(); i++ ) {
			IRGeneric g = entity.getGenerics().get(i);
			put( new GenDesc(g) );
		}
	}
	
	protected void readInterfaceFromModule() {
		ArrayList<VPort> ports = module.getEnvironment().getPorts();
		for( int i = 0; i < ports.size(); i++ ) {
			VPort p = ports.get(i);
			put( new PortDesc(p) );
		}
		ArrayList<VParameter> params = module.getEnvironment().getParameters();
		for( int i = 0; i < params.size(); i++ ) {
			VParameter p = params.get(i);
			put( new GenDesc(p) );
		}
	}
	
	protected void ensureInterfaceRead() {
		if( !isInterfaceRead ) {
			switch( kind ) {
			case VHDL:
				readInterfaceFromEntity();
				break;
			case VERILOG:
				readInterfaceFromModule();
				break;
			default:
				throw new RuntimeException();
			}
		}
		isInterfaceRead = true;
	}
	
	public String getComponentName() {
		switch( kind ) {
		case VHDL:
			return entity.getName();
		case VERILOG:
			return module.getName();
		default:
			throw new RuntimeException();
		}
	}
	
	void put( PortDesc port ) {
		ports.put(port.name.toLowerCase(), port);
		portList.add(port);
	}
	
	public PortDesc getPort( String name ) {
		ensureInterfaceRead();
		return ports.get(name.toLowerCase());
	}
	
	public PortDesc getPort( int index ) {
		ensureInterfaceRead();
		return portList.get(index);
	}
	
	void put( GenDesc gen ) {
		gens.put(gen.name.toLowerCase(), gen);
		genList.add(gen);
	}
	
	public GenDesc getGeneric( String name ) {
		ensureInterfaceRead();
		return gens.get(name.toLowerCase());
	}
	
	public GenDesc getGeneric( int index ) {
		ensureInterfaceRead();
		return genList.get(index);
	}

	public IREntity getEntity() {
		if( entity == null ) throw new RuntimeException();
		return entity;
	}

	public VModule getModule() {
		if( module == null ) throw new RuntimeException();
		return module;
	}

	public HDLKind getKind() {
		return kind;
	}

	public ArrayList<PortDesc> getPortList() {
		ensureInterfaceRead();
		return portList;
	}

	public ArrayList<GenDesc> getGenList() {
		ensureInterfaceRead();
		return genList;
	}
	
	
}
