# https://developer.salesforce.com/docs/atlas.en-us.api_tooling.meta/api_tooling/tooling_api_objects_metadatacomponentdependency_bulk2_usage.htm
 export AT='Authorization: OAuth 00D3h000007R1Lu!AR0AQE4YPu0mresERXyKlH4dljGHIj4qDSkT5eWfaU11NSmc43CzzghzwEe7i0JZEd7HVm72fNpejgRxWFctD.Rj0QPVkbEZ' 
curl --include --request POST  --header "${AT}"   --header "Accept: application/json " --header "Content-Type: application/json" --data '{ "operation": "query", "query": "select MetadataComponentType FROM MetadataComponentDependency" }' "https://mohansun-ea-02-dev-ed.my.salesforce.com/services/data/v49.0/tooling/jobs/query"
