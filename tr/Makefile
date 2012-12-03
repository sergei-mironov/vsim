# use "make clean all".

JAR = bin/hdltranslator.jar
TESTJAR = bin/translatortest.jar

all: jars

clean:
	rm -rf bin/com/* $(JAR) $(TESTJAR)
	mkdir -p bin

jars: jar $(TESTJAR)
jar: $(JAR)

$(JAR): com/prosoft/vhdl/HDLTranslator.java
	javac -g -Xlint:none -d bin -sourcepath . com/prosoft/vhdl/HDLTranslator.java
	cd bin;	jar cfe hdltranslator.jar com.prosoft.vhdl.HDLTranslator com/*

$(TESTJAR): com/prosoft/vhdl/test/Test.java
	javac -g -Xlint:none -d bin -sourcepath . com/prosoft/vhdl/test/Test.java
	cd bin;	jar cfe translatortest.jar com.prosoft.vhdl.test.Test com/*

run:
	java -jar $(JAR)

trans:
	java -jar $(TESTJAR) $(CFGS) $(ENTITY)

compress:
	rm -f eide-java.tar*
	tar cf eide-java.tar *
	bzip2 -9 eide-java.tar
