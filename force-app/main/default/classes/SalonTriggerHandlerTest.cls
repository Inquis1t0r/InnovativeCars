@isTest
public class SalonTriggerHandlerTest {

    //WAREHOUSE_ID

    @isTest
    public static void shouldMoveAllVehiclesFromClosedSalonToWarehouse(){
        //given
        Integer numberOfTestVehicles = 2;
        Id warehouse = SalonTriggerHandler.WAREHOUSE_ID;

        List<Pojazd__c> vehiclesCurrentlyInWarehouse = new List<Pojazd__c>([select Id from Pojazd__c  where Salon__c = :warehouse]);
        Account account = OfferTriggerTestDataFactory.createTestAccount();

        Salon__c salon = OfferTriggerTestDataFactory.createTestSalon(account, numberOfTestVehicles);
        insert salon;

        Pojazd__c veh1 = OfferTriggerTestDataFactory.createSingleVehicle('test1', '6577', salon, account);
        insert veh1;

        Pojazd__c veh2 = OfferTriggerTestDataFactory.createSingleVehicle('test2', '76565', salon, account);
        insert veh2;

        



        //when
        Test.startTest();
        salon.Status_salonu__c = 'Zamknięty'; //Extract to const
        Database.SaveResult results = Database.update(salon, false);
        Test.stopTest();

        //then
        List<Pojazd__c> vehiclesInNewSalon = new List<Pojazd__c>([SELECT Id FROM Pojazd__c WHERE Salon__c = :salon.Id]);
        List<Pojazd__c> vehiclesInWarehouseAfterTest = new List<Pojazd__c>([select Id from Pojazd__c  where Salon__c = :warehouse]);
        System.assert(results.isSuccess());
        System.assertEquals(vehiclesCurrentlyInWarehouse.size() + numberOfTestVehicles, vehiclesInWarehouseAfterTest.size());



    }
}
