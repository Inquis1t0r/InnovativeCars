/**
 *
 * @author  <piotr.kazimierski@accenture.com>
 * @date  24.05.2021
 * @description Perform tests for Offer
 */



@isTest
public with sharing class newOfferTriggerTest {

     /**
     *
     * @description Test adding new offers
     */
    @isTest
    public static void shouldAddNewOffer(){
        //given
        List<Oferta__c> newOffers = newOfferTriggerTestDataFactory.generateTestOffers(200, false);
        //when
        Test.startTest();
        List<Database.SaveResult> resuts = Database.insert(newOffers, true);
        Test.stopTest();
        //then
        System.assertEquals(200, resuts.size());
    }

     /**
     *
     * @description Test prevention of creating duplicate offers
     */
    @isTest
    public static void shouldNotAllowNewOfferWhenAlreadyExist(){
        //given
        List<Oferta__c> newOffers = newOfferTriggerTestDataFactory.generateTestOffers(200, true);
        //when
        Test.startTest();
        List<Database.SaveResult> resuts = Database.insert(newOffers, false);
        Test.stopTest();
        //then
        System.assertEquals(0, resuts.size());
    }

}
