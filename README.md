[![License: CC BY-SA 4.0](https://img.shields.io/badge/License-CC_BY--SA_4.0-lightgrey.svg)](https://creativecommons.org/licenses/by-sa/4.0/)

TempO - Temporal Ontology
=========================

TempO is a lightweight ontology for describing temporal validity and efficacy according to a tritemporal data model.


Motivation
----------

In a typical (uni)temporal data model every resource's appearance (and disappearance) is being tracked.
Numerous systems accomplish unitemporal tracking, either externally by e.g. using git to record the insertion or deletion of a resource, or internally by e.g. using `prov:generatedAtTime` and `prov:invalidatedAtTime`.
This axis of time is known as *system time*, and none of TempO's concern because for one there is readily available support, and moreover because unitemporal tracking is used for principally true statements, i.e. those that have always been (considered) true or will always be (considered) true.

TempO addresses bitemporal and tritemporal setups: Resources which are (known or believed to be) valid and efficacious for some time.
A second time axis orthogonal to system time is introduced, that is a resource can be valid even though it is currently not in the system, or, conversely, can be already or still invalid by the time it enters the system.

Efficacy, sometimes called decision time, is yet another concept orthogonal to validity, i.e. a resource that is no longer or not yet valid can be efficacious.
The converse, a valid but inefficacious resource in the system, is *usually* not encountered but TempO does not impose restrictions on the shape of the time area.

In general the necessity for tracking both validity and efficacy arises in areas where concepts are assigned a code or label that is subject to reuse following invalidation.
Tracking efficacy and validity concurrently then allows for fine-grained control over how much future knowledge or how much past knowledge we tolerate in a datset.


Example
-------

Czechoslovakia was founded in 1918 but became part of Germany, Hungary and Poland in 1938.
It was reestablished in 1945 but split into two sovereign states in 1993.
The ISO 3166 country code for Czechoslovakia used to be `CS`, assigned in 1974, published in February 1978, and invalidated with the country's split.
In 2003 ISO 3166 reassigned the country code `CS` to Serbia and Montenegro.
The facts were assembled in 2018 and written down as follows:

    cc:CSHH
        a cc:ISO3166-CountryCode ;
        rdfs:label "CS" ;
        cc:refersTo "Czechoslovakia" ;
        prov:generatedAtTime "2018-02-29T04:00:00Z"^^xsd:dateTime .
        tempo:validFrom "1978-02"^^xsd:gYearMonth ;
        tempo:validTill "1993-01-01"^^xsd:date ;
        tempo:efficaciousFrom "1918"^^xsd:gYear , "1945"^^xsd:gYear ;
        tempo:efficaciousTill "1938"^^xsd:gYear , "2003"^^xsd:gYear .

The use of the country code `CS` in a statement from 1988 can be resolved to `cc:CSHH`, as of today, free from ambiguity; it was valid back then after all and we know that today.
The same query in 2017 (point-in-time query) would have yielded no results because the information hadn't been in the system back then.
Point-in-time queries, however, are not TempO's major concern so only as-of-today queries are assumed from now on.

Following the country's split it is highly likely that news reports from, say, 1994 highlighting the then-recent past would still have used `CS` to refer to `cc:CSHH`.
According to the resource this is possible, a query for `CS` in 1994 would bring up `cc:CSHH` as it is efficacious but marked as invalidated.

On the other end of history, the use of the code `CS` in, say, 1976 is plausible.  The code was decided on but not yet formally published.
A query for `CS` as used in 1976 would bring up `cc:CSHH`, marked as anachronistic.
Going back further, a statement from, say 1942, using the code `CS` must clearly refer to something else.
A query for `CS` as used in 1976 would yield not yield any results.
