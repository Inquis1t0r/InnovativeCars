@RestResource(urlMapping='/v1/PostExternalVehicle/*')

public with sharing class PostExternalVehicle {

    public static final String externalSalonId = '';
    @HttpPost
    global static List<Pojazd__c> postExternalVehicle(){
        RestRequest postExternalVehicleRequest = RestContext.request;
        String inputJSON = postExternalVehicleRequest.requestBody.toString();
        List<Pojazd__c> vehiclesToCreate = new List<Pojazd__c>();
        Account externalSalonAccount = ([SELECT Id, Name FROM Account Where Id = :externalSalonId]);

    }
}
