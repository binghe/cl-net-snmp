clean:
	find . -name "*~" -exec rm {} \;
	find . -name "*.*fasl" -exec rm {} \;
	find . -name "*.*fsl" -exec rm {} \;
	find . -name "*.*f" -exec rm {} \;
	find . -name "*.old" -exec rm {} \;
	rm -f asn1/asn1-domain.* asn1/asn1.tab

build:
	lispworks -build deliver.lisp
