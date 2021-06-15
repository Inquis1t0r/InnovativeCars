@RestResource(urlMapping='/v1/PostExternalVehicle/*')

global with sharing class PostExternalVehicle {

    global static final String externalSalonId = '';

    @HttpPost
    global static List<Pojazd__c> postExternalVehicle(){
        RestRequest postExternalVehicleRequest = RestContext.request;
        String inputJSON = postExternalVehicleRequest.requestBody.toString();
        List<Pojazd__c> vehiclesToCreate = new List<Pojazd__c>();
        Account externalSalonAccount = ([SELECT Id, Name FROM Account Where Id = :externalSalonId]);
        
        insert vehiclesToCreate;
        return vehiclesToCreate;
    }
}
