clean:
	find . -name "*~" -exec rm {} \;
	find . -name "*.64ufasl" -exec rm {} \;
	find . -name "*.old" -exec rm {} \;

build:
	lispworks -build deliver.lisp
