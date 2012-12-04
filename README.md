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

