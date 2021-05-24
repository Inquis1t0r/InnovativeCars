public with sharing class newOfferTriggerTestDataFactory {
    public static List<Oferta__c> generateTestOffers(Integer numberOfGeneratedOffers, Boolean exceedLimits) {
        Integer numberOfTestEntities = numberOfGeneratedOffers;

        Account account = new Account(Name = 'Car dealer for testing');
        insert account;

        List<Salon__c> newSalons = new List<Salon__c>();
        for(Integer i = numberOfTestEntities; i > 0; i--){
            newSalons.add(new Salon__c(Name = 'test ' + i, Account__c = account.Id, Liczba_miejsc__c = numberOfTestEntities, Strona_internetowa__c = 'https://www.google.com/', Salon_adres__c = 'test adress'));
        }
        insert newSalons;

        List<Pojazd__c> newVehicles = new List<Pojazd__c>();
        for(Integer i = numberOfTestEntities; i > 0; i--){
            newVehicles.add(new Pojazd__c (Name = 'Test ' + i, Numer_seryjny__c = 'testSN' +i, Account__c = account.Id, Cena__c = 100, Marka__c = 'test', Model__c = 'asdf', Salon__c = newSalons[0].Id));
        }
        insert newVehicles;

        List<Oferta__c> newOffers = new List<Oferta__c>();
        for(Integer i = numberOfTestEntities; i > 0; i--){
            newOffers.add(new Oferta__c(Pojazd__c = newVehicles[i].Id, Salon__c = newSalons[0].Id, Oferta_fizyczna__c = true));
        }
        insert newOffers;

        return newOffers;
    }
}
