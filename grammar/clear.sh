#!/bin/sh

sed 's@\[§.*\]@@' vhdl-grammar > 2

sed 's@^[0-9]*$@@' 2 > 3

sed 's@^Std.*@@' 3 > 4

sed 's@^Copyright ©.*@@' 4 > 5

sed 's@^IEEE.*@@' 5 > 6
sed 's@^IIEEE.*@@' 6 > 7
