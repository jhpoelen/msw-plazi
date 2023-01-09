#!/bin/bash 
#
# script to facilitate reporting of annotations 
# according to Plazi community feedback protocols
#

BODIES=$(mktemp)
TITLES=$(mktemp)
GH_CMDS=$(mktemp)

#  | grep -v "gihub.com/plazi/community/issues"

cat annotations.csv\
 | mlr --icsv --ojson cat\
 | jq -c .[]\
 | jq --raw-output '["on", .claimDate, ", ", .claimBy, "claimed that [", .subject, "] should be replace with [", .object, "] in [", .subjectReferenceId, "]" ] | @tsv'\
 | tr '\t' ' '\
 | tee ${BODIES}\
 | tee ${TITLES}\
 > /dev/null


 cat ${TITLES}\
 | sed 's/^/gh issue create --title "/g'\
 | sed 's/$/" --body "/g'\
 > ${GH_CMDS}

 paste -d " " ${GH_CMDS} ${BODIES}\
 | sed 's/$/"/g'\
 > create-issues.sh

rm ${GH_CMDS} ${BODIES} ${TITLES}

echo Found [$(cat create-issues.sh | wc -l)] unreported annotation\(s\).
echo 
echo Please inspect and run generated script, [create-issues.sh], to report issues via the gh, the github commandline tool.
