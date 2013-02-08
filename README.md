Installing
==========

1. Install recent 'Haskell Platform' bundle

2. Unpack the sources into work dir

3. CD to work dir

4. Build java translator

	$ cd tr ; make clean all

5. Install compiler build tools

    $ cabal install happy alex

6. Generate lexer and parser

    $ alex src/Vir/VIR/Lexer.x

    $ happy src/Vir/VIR/AST.y

7. Build the sources

    $ cabal configure

    $ cabal build

Running
=======

To run an example (say, vhdl/assign4.vhd), one has to do the following:

1. Setup bash environment

    $ . simenv

2. Run the VHDL-to-VIR translator, combined with VIR-to-Haskell code generator

    $ vsim vhdl/assign4.vhd > src_r/Test/Autogen.hs

3. Build the model (run GHC interactive console)

    $ cd src_r ; ghci Test/Autogen.hs

4. Run the model from the console

    *Main> :main

Webserver
=========

	$ cygwin ~/proj/vsim $ cygrunsrv.exe -I websim \
		--path `pwd`/happstack/WebServer.exe -c `pwd` --args . -i 
	$ cygwin ~/proj/vsim $ cygrunsrv.exe -S websim                                                           

