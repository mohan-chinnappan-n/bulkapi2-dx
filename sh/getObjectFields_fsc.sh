sfdx mohanc:ws:rest -f header_fsc.json -r https://mohansun-fsc-201.my.salesforce.com/services/data/v49.0/sobjects/$1/describe -m GET   > $1.json
sfdx mohanc:data:jq -i $1.json -f '.fields[] | .name + "," + .label + "," + .type + "," + (.length | tostring)' | sed -e 's/"//g'
