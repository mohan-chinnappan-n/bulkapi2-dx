# How to use Google as OpenID Connect provider for Salesforce?

## Topics

- [Demo](#demo)
- [Auth. Provider Settings](#ap)
- [Open ID Provider client secret](#cs)
- [Auth.RegistrationHandler](#rh)
- [References](#ref)

<a name='demo'></a>

## Demo
![Demo oid](img/openIdconnect-SF-Google-1.gif)


<a name='ap'></a>

## Auth. Provider settings
![auth provide settings](img/auth-provide-google-1.png)
<a name='cs'></a>

## OID provider client secret details
- Note: Content is mangled here to protect the idenity
```json

{
  "web": {
    "project_id": "oidtest-310720",
    
    "client_id": "113225562349-fqktafcJUNK.apps.googleusercontent.com",
    "client_secret": "6VIgVAz8NlJUNKIk4INu4",

    "auth_uri": "https://accounts.google.com/o/oauth2/auth",
    "token_uri": "https://oauth2.googleapis.com/token",
   
     "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",


    "redirect_uris": [
      "https://mohansun-ea-02-dev-ed.my.salesforce.com/services/authcallback/Google"
    ]
  }
}

```
<a name='rh'></a>
## Sample AutocreatedRegHandler class

```java 
// TODO:This autogenerated class includes the basics for a Registration

// Handler class. You will need to customize it to ensure it meets your needs and
// the data provided by the third party.

global class AutocreatedRegHandler1618428423355 implements Auth.RegistrationHandler {
   
 global boolean canCreateUser(Auth.UserData data) {
        //TODO: Check whether we want to allow creation of a user with this data
        //Set<String> s = new Set<String>{'usernamea', 'usernameb', 'usernamec'};
        //if(s.contains(data.username)) {
            //return true;
        //}
        return false;
    }

    global User createUser(Id portalId, Auth.UserData data){
        
        User u = [Select Id From User WHERE federationidentifier = :data.email LIMIT 1];
        return u;
    }

    global void updateUser(Id userId, Id portalId, Auth.UserData data){
         
    }


}
```

<a name='ref'></a>
## Resources

- [RegistrationHandler Interface](https://developer.salesforce.com/docs/atlas.en-us.apexcode.meta/apexcode/apex_auth_plugin.htm)
- [Configure an OpenID Connect Authentication Provider](https://developer.salesforce.com/docs/atlas.en-us.mobile_sdk.meta/mobile_sdk/sso_provider_openid_connect.htm)

- [OpenID Connect](https://openid.net/connect/)

## About OpenID connect
- Simple Identity layer on top of the OAuth 2.0 protocol
- Allows Clients (like service providers) to verify the identity of the End-User based on the authentication performed by an Authorization Server
- ![oid-1](img/oid-1.png)  