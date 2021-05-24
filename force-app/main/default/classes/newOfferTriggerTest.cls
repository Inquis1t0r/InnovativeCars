@isTest
public with sharing class newOfferTriggerTest {
    @isTest
    public static void shouldAddNewOffer(){
        //given
        List<Oferta__c> newOffers = newOfferTriggerTestDataFactory.generateTestOffers(200, false);
        //when
        Test.startTest();
        List<Database.SaveResult> resuts = Database.insert(newOffers, true);
        Test.stopTest();
        //then
        System.assertEquals(201, resuts.size());
    }

    @isTest
    public static void shouldNotAllowNewOfferWhenAlreadyExist(){
        //given
        List<Oferta__c> newOffers = newOfferTriggerTestDataFactory.generateTestOffers(200, true);
        //when
        Test.startTest();
        List<Database.SaveResult> resuts = Database.insert(newOffers, false);
        Test.stopTest();
        //then
        System.assertEquals(201, resuts.size());
    }

}
