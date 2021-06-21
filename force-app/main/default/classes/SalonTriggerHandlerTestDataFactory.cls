/**
 *
 * @author  <piotr.kazimierski@accenture.com>
 * @date  01.06.2021
 * @description Data factory SalonTriggerHandler
 */
public with sharing class SalonTriggerHandlerTestDataFactory {

    /*
    * @return new Account instance
    */
    public static Account createTestAccount(){
        Account account = new Account(Name = 'Car dealer for testing');
        insert account;
        return account;
    }


    /*
    * @param account -> Account that will be associated with test Salon
    * @param numberOfGeneratedOffers -> Number of free slots inside test Salon
    * @return new Salon instance
    */
    public static Salon__c createTestWarehouseSalon(Account account, Integer numberOfGeneratedOffers){
        Salon__c newSalon = new Salon__c(Name = 'test Warehouse', Account__c = account.id, Liczba_miejsc__c = numberOfGeneratedOffers, Strona_internetowa__c = 'https://www.google.com/', Salon_adres__c = 'test adress', isWarehouse__c = true);
        return newSalon;
    }
}
