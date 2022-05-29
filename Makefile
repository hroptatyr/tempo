PYTHON = ~/usr/intel/intelpython/python3.9/bin/python

all: .canonical tempo.rdf index.html

.canonical: tempo.owl.ttl
	rapper -i turtle $< >/dev/null
	ttl2ttl --sortable $< \
	| tr '@' '\001' \
	| sort \
	| tr '\001' '@' \
	| ttl2ttl \
	> $<.t && mv $<.t $< && touch $@

tempo.rdf: tempo.owl.ttl .canonical
	rapper -i turtle -o rdfxml-abbrev $< \
	| mawk 'NR==2{print "<?xml-stylesheet type=\"text/xsl\" href=\"owl2html.xslt.xml\"?>"}1' \
	> $@.t && mv $@.t $@

index.html: tempo.owl.ttl .canonical
	$(PYTHON) -m pylode -c true -o $@ $< \
	|| $(RM) $@
	sed -i 's/ns1:0000/orcid:0000/' $@
