/**
 *
 * @author  <piotr.kazimierski@accenture.com>
 * @date  24.05.2021
 * @description generates data for testing purposes 
 */
public with sharing class newOfferTriggerTestDataFactory {
    public static List<Oferta__c> generateTestOffers(Integer numberOfGeneratedOffers, Boolean exceedLimits) {
        Integer numberOfTestEntities = numberOfGeneratedOffers;

        if(exceedLimits = False){
            numberOfTestEntities = numberOfGeneratedOffers/2;
        }

        Account account = new Account(Name = 'Car dealer for testing');
        insert account;

        Salon__c newSalon = new Salon__c(Name = 'test Salon', Account__c = account.Id, Liczba_miejsc__c = numberOfGeneratedOffers, Strona_internetowa__c = 'https://www.google.com/', Salon_adres__c = 'test adress');
        insert newSalon;

        List<Pojazd__c> newVehicles = new List<Pojazd__c>();
        for(Integer i = numberOfTestEntities; i >= 0; i--){
            newVehicles.add(new Pojazd__c (Name = 'Test ' + i, Numer_seryjny__c = 'testSN' +i, Account__c = account.Id, Cena__c = 100, Marka__c = 'test', Model__c = 'asdf', Salon__c = newSalon.Id));
        }
        insert newVehicles;

        List<Oferta__c> newOffers = new List<Oferta__c>();
        for(Pojazd__c vehicle : newVehicles){
            newOffers.add(new Oferta__c(Pojazd__c = vehicle.Id, Salon__c = newSalon.Id, Oferta_fizyczna__c = true));
        }
        insert newOffers;

        return newOffers;
    }
}
