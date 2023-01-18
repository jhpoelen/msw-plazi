#!/bin/bash
#
# takes first column from period separated file (like msw2-verbatim)
# parses the value
# then report non-matches against ITIS
#
grep -oP "^[^.]+" | sed 's/^/ \t/g' | nomer replace gbif-parse | nomer append itis | grep NONE | grep -v Family | grep -v Subfamily | grep -v Order | grep -v Suborder | cut -f2 | sed 's+$+,!,ITIS,"José Augusto Salim, & Jorrit Poelen. (2022). globalbioticinteractions/nomer: 0.4.7 (0.4.7). Zenodo. https://doi.org/10.5281/zenodo.7411758",2023-01-18,,,,,,,+g'
