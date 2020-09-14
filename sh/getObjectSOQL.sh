export obj=$1
sfdx mohanc:ws:rest -f header_ea.json -r https://mohansun-ea-02-dev-ed.my.salesforce.com/services/data/v49.0/sobjects/$1/describe -m GET   > $1.json
sfdx mohanc:data:jq -i $1.json -f '.fields[] | .name + "," + .label + "," + .type + "," + (.length | tostring)' | sed -e 's/"//g' \
 |  cut -f1 -d','  | sed 's/^/,/g' | sed 's/^/    /g'   | sed 's/    ,Id/SELECT Id/' | sed '$ a\ 
FROM ' | sed "s/FROM /FROM $obj/" 