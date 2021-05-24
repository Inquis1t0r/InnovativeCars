public with sharing class newOfferTriggerTestDataFactory {
    public newOfferTriggerTestDataFactory() {
        Integer numberOfTestSalons = 5;
        Account account = new Account(Name = 'Car dealer for testing');

        List<Salon__c> newSalons = new List<Salon__c>();
        for(Integer i = numberOfTestSalons; i > 0; i--){
            newSalons.add(new Salon__c(Name = 'test ' + i, Account__c = account.Id));
        }
        insert newSalons;

    }
}
