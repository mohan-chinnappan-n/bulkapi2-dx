# JWT flow in java

## Topics
- [Steps](#steps)
- [Sample Code](#code)
- [Demo](#demo)
- [Connected App](#capp)



### Steps
<a name="steps"></a>

#### Prepare or create JKS file
- You have server.key (private key) and server.cer (Cert file)? 
    - Then you can convert into jks as explained here: [Prepare JKS](https://github.com/mohan-chinnappan-n/bulkapi2-dx/tree/master/jwt/java/jks)
    - NOTE: Cert file should be same as the one you have provided in your Salesforce connected App

- If you do not have server.key and server.cer?
 -  How to create java keystore (jks)?
 -  **Example** - how to create jks file:   *mohansun4.jks*

```
$ keytool -genkeypair -alias certalias  -keyalg RSA -keysize 2048 -sigalg SHA256withRSA -validity 365 -keystore ~/.jks/mohansun4.jks 
```
```
Enter keystore password:  
Re-enter new password: 
What is your first and last name?
  [Unknown]:  mohan chinnappan
What is the name of your organizational unit?
  [Unknown]:  dev
What is the name of your organization?
  [Unknown]:  mohansun
What is the name of your City or Locality?
  [Unknown]:  nashua
What is the name of your State or Province?
  [Unknown]:  nh
What is the two-letter country code for this unit?
  [Unknown]:  us
Is CN=mohan chinnappan, OU=dev, O=mohansun, L=nashua, ST=nh, C=us correct?
  [no]:  yes
```  

- How to  List JKS  file:
```  
$ keytool -list -v -keystore ~/.jks/mohansun4.jks 
```

```
Enter keystore password:  
Keystore type: PKCS12
Keystore provider: SUN

Your keystore contains 1 entry

Alias name: certalias
Creation date: Sep 14, 2020
Entry type: PrivateKeyEntry
Certificate chain length: 1
Certificate[1]:
Owner: CN=mohan chinnappan, OU=dev, O=mohansun, L=nashua, ST=nh, C=us
Issuer: CN=mohan chinnappan, OU=dev, O=mohansun, L=nashua, ST=nh, C=us
Serial number: 50950c42
Valid from: Mon Sep 14 23:04:52 EDT 2020 until: Tue Sep 14 23:04:52 EDT 2021
Certificate fingerprints:
	 SHA1: 2A:E8:E0:57:E3:2B:47:F2:62:98:DE:77:F4:64:11:A2:22:F7:5E:F2
	 SHA256: 9E:04:AA:77:45:3B:5C:9D:A7:C4:CA:EC:3F:16:5A:AB:35:5A:04:DE:4E:C8:DA:71:44:FC:65:BB:18:16:F5:09
Signature algorithm name: SHA256withRSA
Subject Public Key Algorithm: 2048-bit RSA key
Version: 3

Extensions: 

#1: ObjectId: 2.5.29.14 Criticality=false
SubjectKeyIdentifier [
KeyIdentifier [
0000: 10 80 9E BC B0 0A 5D 4A   6F DC 47 5F D2 A9 5E E7  ......]Jo.G_..^.
0010: 06 74 C8 3A                                        .t.:
]
]



*******************************************
*******************************************

-  How to create cert file out jks
$ keytool -exportcert -alias certalias -keystore ~/.jks/mohansun4.jks -file mohansun4.cer

Note: use this file mohansun4.cer in creating the connected app

- Different format?
    Ref:
    Generate a salesforce compatible JKS from PFX or P12
    https://help.salesforce.com/articleView?id=000313672&language=en_US&type=1&mode=1

```

#### 3 steps
- STEP-1: Get JWT Assertion
- STEP-2:  POST the assertion(token) to get the access token
- STEP 3: use the access token to access Salesforce protected resource
- Refer the [code below](#code) for the details of how to do these steps 1-3

<a name="code"></a>
### Sample Code  
- [App.java](https://github.com/mohan-chinnappan-n/bulkapi2-dx/blob/master/jwt/java/prj/jwt/src/main/java/org/mohansun/jwt/App.java)

<a name="demo"></a>

### Demo

- Command to run
```
java -jar target/jwt-1.0-SNAPSHOT-jar-with-dependencies.jar -p ~/.props/jwt.properties

```

- Sample jwt.properties file
    - [jwt.properties](https://github.com/mohan-chinnappan-n/bulkapi2-dx/blob/master/jwt/java/prj/jwt/jwt-SAMPLE.properties)

- Output
```json
{
  "access_token": "00D3h000007R1Lu!JUNKnxtF_FrKKfJLOx6glLwSaH6LI8UgoedOIgW0embYBrKXoX1a4lQIjGGpOpo04oc7ZX6eUFrdkeJS0vyvn23rQ2K9Es",
  "scope": "web api id",
  "instance_url": "https://mohansun-ea-02-dev-ed.my.salesforce.com",
  "id": "https://login.salesforce.com/id/00D3h000007R1LuEAK/0053h000002xQ5sAAE",
  "token_type": "Bearer"
}
{
  "datasets": [
    {
      "clientShardsUrl": "/services/data/v49.0/wave/datasets/0Fb3h0000005Yz0CAE/shards",
      "createdBy": {
        "id": "0053h000002xQ5sAAE",
        "name": "Mohan Chinnappan",
        "profilePhotoUrl": "https://mohansun-ea-02-dev-ed--c.documentforce.com/profilephoto/005/T"
      },
      "createdDate": "2020-08-27T22:02:56.000Z",
      "currentVersionId": "0Fc3h000002umTfCAI",
      "currentVersionUrl": "/services/data/v49.0/wave/datasets/0Fb3h0000005Yz0CAE/versions/0Fc3h000002umTfCAI",
      "dataRefreshDate": "2020-08-27T22:03:18.000Z",
      "datasetType": "default",
      "description": "Created from the ea-s3-r recipe.",
      "folder": {
        "id": "0053h000002xQ5sAAE",
        "label": "Mohan Chinnappan"
      },
      "id": "0Fb3h0000005Yz0CAE",
      "label": "ea-s3-r",
      "lastAccessedDate": "2020-09-04T11:45:12.000Z",
      "lastModifiedBy": {
        "id": "0053h000003de6bAAA",
        "name": "Integration User",
        "profilePhotoUrl": "https://mohansun-ea-02-dev-ed--c.documentforce.com/profilephoto/005/T"
      },
      "lastModifiedDate": "2020-08-27T22:03:19.000Z",
      "lastQueriedDate": "2020-08-28T00:02:59.000Z",
      "name": "ea_s3_r",
      "permissions": {
        "create": true,
        "manage": true,
        "modify": true,
        "view": true
      },
      "type": "dataset",
      "url": "/services/data/v49.0/wave/datasets/0Fb3h0000005Yz0CAE",
      "versionsUrl": "/services/data/v49.0/wave/datasets/0Fb3h0000005Yz0CAE/versions"
    },
    {
      "clientShardsUrl": "/services/data/v49.0/wave/datasets/0Fb3h0000008sAECAY/shards",
      "createdBy": {
        "id": "0053h000002xQ5sAAE",
        "name": "Mohan Chinnappan",
        "profilePhotoUrl": "https://mohansun-ea-02-dev-ed--c.documentforce.com/profilephoto/005/T"
      },
      "createdDate": "2020-07-14T11:30:41.000Z",
      "currentVersionId": "0Fc3h0000026QMACA2",
      "currentVersionUrl": "/services/data/v49.0/wave/datasets/0Fb3h0000008sAECAY/versions/0Fc3h0000026QMACA2",
      "dataRefreshDate": "2020-07-14T11:31:03.000Z",
      "datasetType": "default",
      "folder": {
        "id": "0053h000002xQ5sAAE",
        "label": "Mohan Chinnappan"
      },
      "id": "0Fb3h0000008sAECAY",
      "label": "fruit-yield-acct",
      "lastAccessedDate": "2020-09-04T11:21:06.000Z",
      "lastModifiedBy": {
        "id": "0053h000003de6bAAA",
        "name": "Integration User",
        "profilePhotoUrl": "https://mohansun-ea-02-dev-ed--c.documentforce.com/profilephoto/005/T"
      },
      "lastModifiedDate": "2020-07-14T11:31:04.000Z",
      "lastQueriedDate": "2020-09-04T11:20:31.000Z",
      "name": "fruit_yield_acct",
      "permissions": {
        "create": true,
        "manage": true,
        "modify": true,
        "view": true
      },
      "type": "dataset",
      "url": "/services/data/v49.0/wave/datasets/0Fb3h0000008sAECAY",
      "versionsUrl": "/services/data/v49.0/wave/datasets/0Fb3h0000008sAECAY/versions"
    },
    {
      "clientShardsUrl": "/services/data/v49.0/wave/datasets/0Fb3h0000008spECAQ/shards",
      "createdBy": {
        "id": "0053h000002xQ5sAAE",
        "name": "Mohan Chinnappan",
        "profilePhotoUrl": "https://mohansun-ea-02-dev-ed--c.documentforce.com/profilephoto/005/T"
      },
      "createdDate": "2020-07-15T18:10:09.000Z",
      "currentVersionId": "0Fc3h0000026e3aCAA",
      "currentVersionUrl": "/services/data/v49.0/wave/datasets/0Fb3h0000008spECAQ/versions/0Fc3h0000026e3aCAA",
      "dataRefreshDate": "2020-07-15T18:10:31.000Z",
      "datasetType": "default",
      "folder": {
        "id": "0053h000002xQ5sAAE",
        "label": "Mohan Chinnappan"
      },
      "id": "0Fb3h0000008spECAQ",
      "label": "mycustomers",
      "lastAccessedDate": "2020-08-23T18:53:47.000Z",
      "lastModifiedBy": {
        "id": "0053h000003de6bAAA",
        "name": "Integration User",
        "profilePhotoUrl": "https://mohansun-ea-02-dev-ed--c.documentforce.com/profilephoto/005/T"
      },
      "lastModifiedDate": "2020-09-15T15:30:18.000Z",
      "lastQueriedDate": "2020-08-23T18:53:48.000Z",
      "name": "mycustomers",
      "permissions": {
        "create": true,
        "manage": true,
        "modify": true,
        "view": true
      },
      "type": "dataset",
      "url": "/services/data/v49.0/wave/datasets/0Fb3h0000008spECAQ",
      "versionsUrl": "/services/data/v49.0/wave/datasets/0Fb3h0000008spECAQ/versions"
    },
    {
      "clientShardsUrl": "/services/data/v49.0/wave/datasets/0Fb3h0000008ryVCAQ/shards",
      "createdBy": {
        "id": "0053h000002xQ5sAAE",
        "name": "Mohan Chinnappan",
        "profilePhotoUrl": "https://mohansun-ea-02-dev-ed--c.documentforce.com/profilephoto/005/T"
      },
      "createdDate": "2020-07-13T19:30:57.000Z",
      "currentVersionId": "0Fc3h0000026KlGCAU",
      "currentVersionUrl": "/services/data/v49.0/wave/datasets/0Fb3h0000008ryVCAQ/versions/0Fc3h0000026KlGCAU",
      "dataRefreshDate": "2020-07-15T16:56:26.000Z",
      "datasetType": "default",
      "folder": {
        "id": "00l3h000001NosUAAS",
        "label": "My DTC Sales",
        "name": "My_DTC_Sales",
        "url": "/services/data/v49.0/wave/folders/00l3h000001NosUAAS"
      },
      "id": "0Fb3h0000008ryVCAQ",
      "label": "DTC Opportunity",
      "lastAccessedDate": "2020-07-15T18:10:38.000Z",
      "lastModifiedBy": {
        "id": "0053h000003de6dAAA",
        "name": "Security User",
        "profilePhotoUrl": "https://mohansun-ea-02-dev-ed--c.documentforce.com/profilephoto/005/T"
      },
      "lastModifiedDate": "2020-07-15T16:56:26.000Z",
      "lastQueriedDate": "2020-07-15T16:56:26.000Z",
      "name": "DTC_Opportunity_SAMPLE",
      "permissions": {
        "create": true,
        "manage": true,
        "modify": true,
        "view": true
      },
      "type": "dataset",
      "url": "/services/data/v49.0/wave/datasets/0Fb3h0000008ryVCAQ",
      "versionsUrl": "/services/data/v49.0/wave/datasets/0Fb3h0000008ryVCAQ/versions"
    },
    {
      "clientShardsUrl": "/services/data/v49.0/wave/datasets/0Fb3h0000008ryTCAQ/shards",
      "createdBy": {
        "id": "0053h000002xQ5sAAE",
        "name": "Mohan Chinnappan",
        "profilePhotoUrl": "https://mohansun-ea-02-dev-ed--c.documentforce.com/profilephoto/005/T"
      },
      "createdDate": "2020-07-13T19:30:57.000Z",
      "currentVersionId": "0Fc3h0000026KlECAU",
      "currentVersionUrl": "/services/data/v49.0/wave/datasets/0Fb3h0000008ryTCAQ/versions/0Fc3h0000026KlECAU",
      "dataRefreshDate": "2020-02-26T21:15:34.000Z",
      "datasetType": "default",
      "folder": {
        "id": "00l3h000001NosRAAS",
        "label": "The Motivator",
        "name": "The_Motivator",
        "url": "/services/data/v49.0/wave/folders/00l3h000001NosRAAS"
      },
      "id": "0Fb3h0000008ryTCAQ",
      "label": "Activities",
      "lastAccessedDate": "2020-07-15T16:55:53.000Z",
      "lastModifiedBy": {
        "id": "0053h000003de6bAAA",
        "name": "Integration User",
        "profilePhotoUrl": "https://mohansun-ea-02-dev-ed--c.documentforce.com/profilephoto/005/T"
      },
      "lastModifiedDate": "2020-02-26T21:15:35.000Z",
      "lastQueriedDate": "2020-07-15T16:55:54.000Z",
      "name": "activity",
      "permissions": {
        "create": true,
        "manage": true,
        "modify": true,
        "view": true
      },
      "type": "dataset",
      "url": "/services/data/v49.0/wave/datasets/0Fb3h0000008ryTCAQ",
      "versionsUrl": "/services/data/v49.0/wave/datasets/0Fb3h0000008ryTCAQ/versions"
    },
    {
      "clientShardsUrl": "/services/data/v49.0/wave/datasets/0Fb3h0000008sotCAA/shards",
      "createdBy": {
        "id": "0053h000002xQ5sAAE",
        "name": "Mohan Chinnappan",
        "profilePhotoUrl": "https://mohansun-ea-02-dev-ed--c.documentforce.com/profilephoto/005/T"
      },
      "createdDate": "2020-07-15T15:18:17.000Z",
      "currentVersionId": "0Fc3h0000026d2LCAQ",
      "currentVersionUrl": "/services/data/v49.0/wave/datasets/0Fb3h0000008sotCAA/versions/0Fc3h0000026d2LCAQ",
      "dataRefreshDate": "2020-07-15T15:18:39.000Z",
      "datasetType": "default",
      "folder": {
        "id": "0053h000002xQ5sAAE",
        "label": "Mohan Chinnappan"
      },
      "id": "0Fb3h0000008sotCAA",
      "label": "myfruits",
      "lastAccessedDate": "2020-07-15T16:46:59.000Z",
      "lastModifiedBy": {
        "id": "0053h000003de6bAAA",
        "name": "Integration User",
        "profilePhotoUrl": "https://mohansun-ea-02-dev-ed--c.documentforce.com/profilephoto/005/T"
      },
      "lastModifiedDate": "2020-07-15T15:18:40.000Z",
      "lastQueriedDate": "2020-07-15T16:47:00.000Z",
      "name": "myfruits",
      "permissions": {
        "create": true,
        "manage": true,
        "modify": true,
        "view": true
      },
      "type": "dataset",
      "url": "/services/data/v49.0/wave/datasets/0Fb3h0000008sotCAA",
      "versionsUrl": "/services/data/v49.0/wave/datasets/0Fb3h0000008sotCAA/versions"
    },
    {
      "clientShardsUrl": "/services/data/v49.0/wave/datasets/0Fb3h0000008s9kCAA/shards",
      "createdBy": {
        "id": "0053h000002xQ5sAAE",
        "name": "Mohan Chinnappan",
        "profilePhotoUrl": "https://mohansun-ea-02-dev-ed--c.documentforce.com/profilephoto/005/T"
      },
      "createdDate": "2020-07-14T10:51:37.000Z",
      "currentVersionId": "0Fc3h0000026QBWCA2",
      "currentVersionUrl": "/services/data/v49.0/wave/datasets/0Fb3h0000008s9kCAA/versions/0Fc3h0000026QBWCA2",
      "dataRefreshDate": "2020-07-14T10:52:00.000Z",
      "datasetType": "default",
      "folder": {
        "id": "0053h000002xQ5sAAE",
        "label": "Mohan Chinnappan"
      },
      "id": "0Fb3h0000008s9kCAA",
      "label": "fruit-yield",
      "lastAccessedDate": "2020-07-14T11:14:38.000Z",
      "lastModifiedBy": {
        "id": "0053h000003de6bAAA",
        "name": "Integration User",
        "profilePhotoUrl": "https://mohansun-ea-02-dev-ed--c.documentforce.com/profilephoto/005/T"
      },
      "lastModifiedDate": "2020-07-14T10:52:00.000Z",
      "lastQueriedDate": "2020-07-14T11:06:45.000Z",
      "name": "fruit_yield",
      "permissions": {
        "create": true,
        "manage": true,
        "modify": true,
        "view": true
      },
      "type": "dataset",
      "url": "/services/data/v49.0/wave/datasets/0Fb3h0000008s9kCAA",
      "versionsUrl": "/services/data/v49.0/wave/datasets/0Fb3h0000008s9kCAA/versions"
    },
    {
      "clientShardsUrl": "/services/data/v49.0/wave/datasets/0Fb3h0000008s9uCAA/shards",
      "createdBy": {
        "id": "0053h000002xQ5sAAE",
        "name": "Mohan Chinnappan",
        "profilePhotoUrl": "https://mohansun-ea-02-dev-ed--c.documentforce.com/profilephoto/005/T"
      },
      "createdDate": "2020-07-14T10:57:37.000Z",
      "dataRefreshDate": "2020-07-14T10:57:37.000Z",
      "datasetType": "default",
      "folder": {
        "id": "00l3h000001NosSAAS",
        "label": "Shared App",
        "name": "SharedApp",
        "url": "/services/data/v49.0/wave/folders/00l3h000001NosSAAS"
      },
      "id": "0Fb3h0000008s9uCAA",
      "label": "regFruitYield",
      "lastAccessedDate": "2020-07-14T11:00:13.000Z",
      "lastModifiedBy": {
        "id": "0053h000002xQ5sAAE",
        "name": "Mohan Chinnappan",
        "profilePhotoUrl": "https://mohansun-ea-02-dev-ed--c.documentforce.com/profilephoto/005/T"
      },
      "lastModifiedDate": "2020-07-14T10:57:37.000Z",
      "name": "regFruitYield",
      "permissions": {
        "create": true,
        "manage": true,
        "modify": true,
        "view": true
      },
      "type": "dataset",
      "url": "/services/data/v49.0/wave/datasets/0Fb3h0000008s9uCAA",
      "versionsUrl": "/services/data/v49.0/wave/datasets/0Fb3h0000008s9uCAA/versions"
    },
    {
      "clientShardsUrl": "/services/data/v49.0/wave/datasets/0Fb3h0000008ryhCAA/shards",
      "createdBy": {
        "id": "0053h000002xQ5sAAE",
        "name": "Mohan Chinnappan",
        "profilePhotoUrl": "https://mohansun-ea-02-dev-ed--c.documentforce.com/profilephoto/005/T"
      },
      "createdDate": "2020-07-13T19:30:57.000Z",
      "currentVersionId": "0Fc3h0000026KlSCAU",
      "currentVersionUrl": "/services/data/v49.0/wave/datasets/0Fb3h0000008ryhCAA/versions/0Fc3h0000026KlSCAU",
      "dataRefreshDate": "2018-12-05T15:56:00.000Z",
      "datasetType": "default",
      "folder": {
        "id": "00l3h000001NosQAAS",
        "label": "ABC Seed",
        "name": "ABC_Seed",
        "url": "/services/data/v49.0/wave/folders/00l3h000001NosQAAS"
      },
      "id": "0Fb3h0000008ryhCAA",
      "label": "Fundraising Opportunities",
      "lastModifiedBy": {
        "id": "0053h000003de6dAAA",
        "name": "Security User",
        "profilePhotoUrl": "https://mohansun-ea-02-dev-ed--c.documentforce.com/profilephoto/005/T"
      },
      "lastModifiedDate": "2018-12-05T16:29:31.000Z",
      "lastQueriedDate": "2020-02-26T20:57:46.000Z",
      "name": "ABC_Seed_Opportunities",
      "permissions": {
        "create": true,
        "manage": true,
        "modify": true,
        "view": true
      },
      "type": "dataset",
      "url": "/services/data/v49.0/wave/datasets/0Fb3h0000008ryhCAA",
      "versionsUrl": "/services/data/v49.0/wave/datasets/0Fb3h0000008ryhCAA/versions"
    },
    {
      "clientShardsUrl": "/services/data/v49.0/wave/datasets/0Fb3h0000008ryUCAQ/shards",
      "createdBy": {
        "id": "0053h000002xQ5sAAE",
        "name": "Mohan Chinnappan",
        "profilePhotoUrl": "https://mohansun-ea-02-dev-ed--c.documentforce.com/profilephoto/005/T"
      },
      "createdDate": "2020-07-13T19:30:57.000Z",
      "currentVersionId": "0Fc3h0000026KlFCAU",
      "currentVersionUrl": "/services/data/v49.0/wave/datasets/0Fb3h0000008ryUCAQ/versions/0Fc3h0000026KlFCAU",
      "dataRefreshDate": "2020-02-26T21:15:34.000Z",
      "datasetType": "default",
      "folder": {
        "id": "00l3h000001NosRAAS",
        "label": "The Motivator",
        "name": "The_Motivator",
        "url": "/services/data/v49.0/wave/folders/00l3h000001NosRAAS"
      },
      "id": "0Fb3h0000008ryUCAQ",
      "label": "Users",
      "lastModifiedBy": {
        "id": "0053h000003de6bAAA",
        "name": "Integration User",
        "profilePhotoUrl": "https://mohansun-ea-02-dev-ed--c.documentforce.com/profilephoto/005/T"
      },
      "lastModifiedDate": "2020-02-26T21:15:35.000Z",
      "lastQueriedDate": "2020-02-26T21:18:34.000Z",
      "name": "user",
      "permissions": {
        "create": true,
        "manage": true,
        "modify": true,
        "view": true
      },
      "type": "dataset",
      "url": "/services/data/v49.0/wave/datasets/0Fb3h0000008ryUCAQ",
      "versionsUrl": "/services/data/v49.0/wave/datasets/0Fb3h0000008ryUCAQ/versions"
    }
  ],
  "nextPageUrl": null,
  "totalSize": 10,
  "url": "/services/data/v49.0/wave/datasets"
}

{"id":"e00xx0000000001AAA","success":true,"errors":[{"statusCode":"OPERATION_ENQUEUED","message":"3a77f372-8e80-4fac-a687-ff2852be5876","fields":[]}]}

```
<img src='https://github.com/mohan-chinnappan-n/bulkapi2-dx/blob/master/img/pe-pwr-down.png' alt ='PE subscribe process builder email-alert' width='400'/>

<a name='capp'></a>
### Connected App
![connected app](img/jwt-flow-app-2.png)
![connected app manage](img/jwt-flow-app-3.png)
#### OAuth Connected App Usage count
![usage count](img/jwt-use-count-1.png)
