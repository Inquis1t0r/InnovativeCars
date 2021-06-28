/**
 *
 * @author  <piotr.kazimierski@accenture.com>
 * @date  24.05.2021
 * @description Perform tests for Offer
 */

@isTest
public class OfferTriggerTest {

     /**
     *
     * @description Test adding single new offer
     */
    @isTest
    public static void shouldAddNewOffer(){
        Account account = OfferTriggerTestDataFactory.createTestAccount();
        Salon__C salon = OfferTriggerTestDataFactory.createTestSalon(account, 1);
        insert salon;
        Pojazd__c vehicle = OfferTriggerTestDataFactory.createSingleVehicle(Constants.testVehicleName, Constants.testVehicleSN, salon, account);
        insert vehicle;

        Oferta__c testOffert = OfferTriggerTestDataFactory.createSingleOffer(Constants.OFF1, salon, vehicle, true);

        Test.startTest();
        Database.SaveResult result = Database.insert(testOffert, false);
        Test.stopTest();

        System.assert(result.isSuccess());
    }

     /**
     *
     * @description Test prevention of creating duplicate offers
     */
    @isTest
    public static void shouldAddNewOfferWhenItsTheFirstOneForVehicle(){
        Account account = OfferTriggerTestDataFactory.createTestAccount();
        Salon__C salon = OfferTriggerTestDataFactory.createTestSalon(account, 1);
        insert salon;
        Pojazd__c vehicle = OfferTriggerTestDataFactory.createSingleVehicle(Constants.testVehicleName, Constants.testVehicleSN, salon, account);
        insert vehicle;

        Oferta__c testOffert = OfferTriggerTestDataFactory.createSingleOffer(Constants.OFF1, salon, vehicle, true);

        Test.startTest();
        Database.SaveResult result = Database.insert(testOffert, false);
        Test.stopTest();

        System.assert(result.isSuccess());
    }

    @isTest
    public static void shouldNotAllowNewOfferWhenVehicleAlreadyAssigned(){
        //given
        Account account = OfferTriggerTestDataFactory.createTestAccount();
        Salon__C salon = OfferTriggerTestDataFactory.createTestSalon(account, 1);
        insert salon;
        Pojazd__c vehicle = OfferTriggerTestDataFactory.createSingleVehicle(Constants.testVehicleName, Constants.testVehicleSN, salon, account);
        insert vehicle;

        Oferta__c offer = OfferTriggerTestDataFactory.createSingleOffer(Constants.OFF1, salon, vehicle, true);
        insert offer;

        Oferta__c testOffert = OfferTriggerTestDataFactory.createSingleOffer(Constants.OFF2, salon, vehicle, true);

        //when
        Test.startTest();
        Database.SaveResult result = Database.insert(testOffert, false);
        Test.stopTest();

        //then
        System.assert(!result.isSuccess());
        System.assert(result.getErrors().size() > 0);
        System.assertEquals('Nie można utworzyć oferty ponieważ pojazd jest dostępny w ' + salon.Name,
        result.getErrors()[0].getMessage());
    }
    
    @isTest
    public static void shouldSendEmailForNewOffers(){
        //given
        Integer expectedLimits = 0;
        Integer actualLimits = 0;
        Account account = OfferTriggerTestDataFactory.createTestAccount();
        Salon__C salon = OfferTriggerTestDataFactory.createTestSalon(account, 1);
        insert salon;
        Pojazd__c vehicle = OfferTriggerTestDataFactory.createSingleVehicle(Constants.testVehicleName, Constants.testVehicleSN, salon, account);
        insert vehicle;

        Oferta__c offer = OfferTriggerTestDataFactory.createSingleOffer(Constants.OFF1, salon, vehicle, true);
        insert offer;

        //when
        Test.startTest();
        List<Id> offerIDs = new list<Id>();
        offerIDs.add(offer.id);
        Test.stopTest();

        //then
        expectedLimits = 1;
        actualLimits = Limits.getEmailInvocations();
        System.assertEquals(expectedLimits, actualLimits, 'Limits don\'t match');
    }

}
