Installing
==========

1. Install recent Haskell Platform

2. Unpack the sources into work dir

3. CD to work dir

4. Install compiler build tools

    $ cabal install happy alex

5. Generate lexer and parser

    $ alex src/Vir/VIR/Lexer.x

    $ happy src/Vir/VIR/AST.y

6. Build the sources

    $ cabal configure

    $ cabal build

