@isTest
public class SalonTriggerHandlerTest {

    @isTest
    public static void shouldMoveAllVehiclesFromClosedSalonToWarehouse(){
        //given
        Integer numberOfTestVehicles = 2;
        Id warehouse = SalonTriggerHandler.WAREHOUSE_ID;

        List<Pojazd__c> vehiclesCurrentlyInWarehouse = new List<Pojazd__c>([select Id from Pojazd__c  where Salon__c = :warehouse]);
        Account account = OfferTriggerTestDataFactory.createTestAccount();

        Salon__c salon = OfferTriggerTestDataFactory.createTestSalon(account, numberOfTestVehicles);
        insert salon;

        Pojazd__c veh1 = OfferTriggerTestDataFactory.createSingleVehicle(Constants.testVehicleForSalon1Name, Constants.testVehicleForSalon1SN, salon, account);
        insert veh1;

        Pojazd__c veh2 = OfferTriggerTestDataFactory.createSingleVehicle(Constants.testVehicleForSalon2Name, Constants.testVehicleForSalon2SN, salon, account);
        insert veh2;

        //when
        Test.startTest();
        salon.Status_salonu__c = Constants.testSalonStatusClosed;
        Database.SaveResult results = Database.update(salon, false);
        Test.stopTest();

        //then
        List<Pojazd__c> vehiclesInNewSalon = new List<Pojazd__c>([SELECT Id FROM Pojazd__c WHERE Salon__c = :salon.Id]);
        List<Pojazd__c> vehiclesInWarehouseAfterTest = new List<Pojazd__c>([select Id from Pojazd__c  where Salon__c = :warehouse]);
        System.assert(results.isSuccess());
        System.assertEquals(vehiclesCurrentlyInWarehouse.size() + numberOfTestVehicles, vehiclesInWarehouseAfterTest.size());
    }


    @isTest
    public static void shouldCreateNewRenovationCase(){
        //given
        Integer numberOfTestVehicles = 1;
        Account account = OfferTriggerTestDataFactory.createTestAccount();

        Salon__c salon = OfferTriggerTestDataFactory.createTestSalon(account, numberOfTestVehicles, Constants.testSalonStatus);
        insert salon;

        //when
        Test.startTest();
        salon.Status_salonu__c = Constants.testSalonStatusClosed;
        update salon;
        Test.stopTest();

        //then
        List<Case> newCases = new List<Case>([SELECT id FROM Case where Salon__c = :salon.id]);
        System.assertEquals(1, newCases.size());

    }
}
