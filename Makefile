all: tempo.rdf

.PHONY: tempo.owl.ttl
tempo.owl.ttl:
	rapper -i turtle $@ >/dev/null
	ttl2ttl --sortable $@ \
	| tr '@' '\001' \
	| sort \
	| tr '\001' '@' \
	| ttl2ttl \
	> $@.t && mv $@.t $@

tempo.rdf: tempo.owl.ttl
	rapper -i turtle -o rdfxml $< \
	> $@.t && mv $@.t $@
