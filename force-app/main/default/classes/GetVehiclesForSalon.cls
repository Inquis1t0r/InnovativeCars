/**
 *
 * @author  <piotr.kazimierski@accenture.com>
 * @date  14.06.2021
 * @description Pojazd__c REST Callout
 */

@RestResource(urlMapping='/v1/GetVehiclesForSalon/*')

global with sharing class GetVehiclesForSalon {

    @HttpGet
    global static List<Pojazd__c> getVehiclesForSalon(){
        RestRequest salonVehiclesRequest = RestContext.request;
        String SalonId = salonVehiclesRequest.params.get('Id');
        List<Pojazd__c> salonsList = new List<Pojazd__c>([SELECT Id, Name, Marka__c, Model__c, Numer_seryjny__c FROM Pojazd__c WHERE Salon__c = :SalonId]);
        return salonsList;
    }
}
