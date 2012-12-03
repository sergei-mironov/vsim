parser test:
	javacc vhdl.jj
# переводим в виндовые cr/lf чтобы diff-ы были меньше и ^M не было
# из-за смешанной unix/win кодировки
	./towin.sh VhdlParser.java VhdlParserTokenManager.java VhdlParserConstants.java

