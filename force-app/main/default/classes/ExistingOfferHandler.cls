public with sharing class ExistingOfferHandler {
    public ExistingOfferHandler() {
        List<Oferta__c> existingRecords = [select Pojazd__c, Salon__c, Salon__r.Name from Oferta__c where Oferta_fizyczna__c = true];
    }
}
