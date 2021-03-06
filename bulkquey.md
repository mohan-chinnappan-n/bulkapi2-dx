## How to Query using BulkAPI 2.0?

- Requires plugin 0.0.137 or above
- [How to install plugin?](https://mohan-chinnappan-n.github.io/dx/plugins.html#/1)

### Usage

```
$ sfdx mohanc:data:bulkapi:query -h
Data Query using BulkAPI 2  

USAGE
  $ sfdx mohanc:data:bulkapi:query

OPTIONS
  -q, --queryfile=queryfile                       SOQL query file
  -u, --targetusername=targetusername             username or alias for the target org; overrides default target org
  --apiversion=apiversion                         override the api version used for api requests made by this command
  --json                                          format output as json
  --loglevel=(trace|debug|info|warn|error|fatal)  logging level for this command invocation

EXAMPLE

              sfdx mohanc:data:bulkapi:query  -u <username>  -q queryFile [input.soql]

              Executes the given SOQL query in the given queryFile (example: input.soql) and writes the CSV output to  
  queryFile.csv (example: input.soql.csv)
```


### Demo

![Demo-1](img/bq-1.gif)

#### Query file
```
$ cat ~/tmp/acr.soql
SELECT Id, AccountId, ContactId 
FROM 
AccountContactRelation

```
#### Executing query command
```
## Make sure that you have logged in

$ sfdx force:auth:web:login

## Run the query command
$ sfdx mohanc:data:bulkapi:query -u mchinnappan@fsc-gs0.com -q ~/tmp/acr.soql
SELECT Id, AccountId, ContactId 
FROM 
AccountContactRelation

{
  id: '750B000000BqgfeIAB',
  operation: 'query',
  object: 'AccountContactRelation',
  createdById: '005B0000006pysJIAQ',
  createdDate: '2021-02-22T15:47:48.000+0000',
  systemModstamp: '2021-02-22T15:47:48.000+0000',
  state: 'UploadComplete',
  concurrencyMode: 'Parallel',
  contentType: 'CSV',
  apiVersion: 51,
  lineEnding: 'LF',
  columnDelimiter: 'COMMA'
}
=== JOB STATUS === 
=== JOB STATUS for job: 750B000000BqgfeIAB ===
{
  id: '750B000000BqgfeIAB',
  operation: 'query',
  object: 'AccountContactRelation',
  createdById: '005B0000006pysJIAQ',
  createdDate: '2021-02-22T15:47:48.000+0000',
  systemModstamp: '2021-02-22T15:47:48.000+0000',
  state: 'InProgress',
  concurrencyMode: 'Parallel',
  contentType: 'CSV',
  apiVersion: 51,
  jobType: 'V2Query',
  lineEnding: 'LF',
  columnDelimiter: 'COMMA',
  numberRecordsProcessed: 0,
  retries: 0,
  totalProcessingTime: 0
}
WAITING...
{
  id: '750B000000BqgfeIAB',
  operation: 'query',
  object: 'AccountContactRelation',
  createdById: '005B0000006pysJIAQ',
  createdDate: '2021-02-22T15:47:48.000+0000',
  systemModstamp: '2021-02-22T15:47:49.000+0000',
  state: 'JobComplete',
  concurrencyMode: 'Parallel',
  contentType: 'CSV',
  apiVersion: 51,
  jobType: 'V2Query',
  lineEnding: 'LF',
  columnDelimiter: 'COMMA',
  numberRecordsProcessed: 110,
  retries: 0,
  totalProcessingTime: 436
}
=== JOB Failure STATUS === 
statusCode: 200
==== Output CSV file written into : /Users/mchinnappan/tmp/acr.soql.csv ===
==== View the output file : /Users/mchinnappan/tmp/acr.soql.csv using:
 cat /Users/mchinnappan/tmp/acr.soql.csv ===
=== JOB Failure STATUS for job: 750B000000BqgfeIAB ===
"sf__Id","sf__Error","Id","AccountId","ContactId"

```

### Results
```
$ head ~/tmp/acr.soql.csv 
"Id","AccountId","ContactId"
"07kB00000039SYHIA2","001B000001KYA8VIAX","003B000000HbTrZIAV"
"07kB00000039SYIIA2","001B000001KYA8gIAH","003B000000HbTrZIAV"
"07kB00000039SYJIA2","001B000001KYA8gIAH","003B000000HbTrbIAF"
"07kB00000039SYLIA2","001B000001KYA8XIAX","003B000000HbTrZIAV"
"07kB00000039SYNIA2","001B000001KYA8XIAX","003B000000HbTraIAF"
"07kB00000039SYOIA2","001B000001KYA8fIAH","003B000000HbTrcIAF"
"07kB00000039SYSIA2","001B000001KYA8fIAH","003B000000HbTrfIAF"
"07kB00000039SYTIA2","001B000001KYA8WIAX","003B000000HbTraIAF"
"07kB00000039aAVIAY","001B000001KYvQzIAL","003B000000HcGJhIAN"

```

### Listing bulk query jobs
```
$ sfdx mohanc:data:bulkapi:listJobs -u mchinnappan@fsc-gs0.com -o query

```
```
$ sfdx mohanc:data:bulkapi:listJobs -u mchinnappan@fsc-gs0.com -o query
{
  done: true,
  records: [
    {
      id: '750B000000BqgfeIAB',
      operation: 'query',
      object: 'AccountContactRelation',
      createdById: '005B0000006pysJIAQ',
      createdDate: '2021-02-22T15:47:48.000+0000',
      systemModstamp: '2021-02-22T15:47:49.000+0000',
      state: 'JobComplete',
      concurrencyMode: 'Parallel',
      contentType: 'CSV',
      apiVersion: 51,
      jobType: 'V2Query',
      lineEnding: 'LF',
      columnDelimiter: 'COMMA'
    },
    {
      id: '750B000000Br2OSIAZ',
      operation: 'query',
      object: 'AccountContactRelation',
      createdById: '005B0000006pysJIAQ',
      createdDate: '2021-02-24T16:30:31.000+0000',
      systemModstamp: '2021-02-24T16:30:31.000+0000',
      state: 'JobComplete',
      concurrencyMode: 'Parallel',
      contentType: 'CSV',
      apiVersion: 51,
      jobType: 'V2Query',
      lineEnding: 'LF',
      columnDelimiter: 'COMMA'
    }...
]
}
```
