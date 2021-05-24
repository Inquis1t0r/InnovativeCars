public with sharing class newOfferTriggerTestDataFactory {
    public static List<Oferta__c> generateTestOffers(Integer numberOfGeneratedOffers, Boolean exceedLimits) {
        Integer numberOfTestEntities = numberOfGeneratedOffers;
        
        Account account = new Account(Name = 'Car dealer for testing');
        insert account;

        List<Salon__c> newSalons = new List<Salon__c>();
        for(Integer i = numberOfTestEntities; i > 0; i--){
            newSalons.add(new Salon__c(Name = 'test ' + i, Account__c = account.Id, Liczba_miejsc__c = numberOfTestEntities));
        }
        insert newSalons;

        List<Pojazd__c> newVehicles = new List<Pojazd__c>();
        for(Integer i = numberOfTestEntities; i > 0; i--){
            newVehicles.add(Name = 'Test ' + i, Numer_seryjny__c = 'testSN' +i, Account__c = account.Id);
        }
        insert newVehicles;

        List<Oferta__c> newOffers = new List<Oferta__c>();
        for(Integer i = numberOfTestEntities; i > 0; i--){
            newOffers.add(Pojazd__c = newVehicles[i], Salon__c = newSalons[0], Oferta_fizyczna__c = true);
        }
        insert newOffers;

        return newOffers;
    }
}
