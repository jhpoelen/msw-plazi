#!/bin/bash
#
# takes first column from period separated file (like msw2.json)
# parses the value
# then report non-matches against ITIS
#
# example usage:
#  cat msw2.json | ./annotate-using-nomer-itis.sh

jq --raw-output '[.["docId"], .["verbatimText"]] | @tsv'\
 | grep -oP "^[^.]+"\
 | nomer append gbif-parse\
 | cut -f1,5\
 | nomer append itis\
 | grep NONE\
 | grep -v Family\
 | grep -v Subfamily\
 | grep -v Order\
 | grep -v Suborder\
 | cut -f1,2\
 | awk -v FS='\t' '{ print($2 ",!,ITIS,\"Salim JA, Poelen JH (2022). globalbioticinteractions/nomer: 0.4.7 (0.4.7). Zenodo. https://doi.org/10.5281/zenodo.7411758\",2023-01-18,https://tb.plazi.org/GgServer/html/" $1 ",,,,,,") }'
