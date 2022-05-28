all: .canonical tempo.rdf

.canonical: tempo.owl.ttl
	rapper -i turtle $< >/dev/null
	ttl2ttl --sortable $< \
	| tr '@' '\001' \
	| sort \
	| tr '\001' '@' \
	| ttl2ttl \
	> $<.t && mv $<.t $< && touch $@

tempo.rdf: .canonical
	rapper -i turtle -o rdfxml $< \
	> $@.t && mv $@.t $@
