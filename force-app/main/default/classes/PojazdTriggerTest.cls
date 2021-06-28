/**
 *
 * @author  <piotr.kazimierski@accenture.com>
 * @date  26.05.2021
 * @description Test class for PojazdTrigger
 */

@isTest
public class PojazdTriggerTest {

    /*
    * @author  <piotr.kazimierski@accenture.com>
    * @date  26.05.2021
    * @description Verifies that deleted vehicles leads to EnvironmentalImpact__c record creation
    */
    @isTest
    public static void shouldAddEnvironmentalImpactRecordsWhenVehicleWithTelemetryDataDeleted(){
        //given
        Integer numberOfTestRecords = 200;
        //List<Pojazd__c> currentVehicles = PojazdTriggerTestDataFactory.addTestPojazdEntitiesWithTelemetry(numberOfTestRecords);
        List<Pojazd__c> currentVehicles = new List<Pojazd__c>([Select Id from Pojazd__c]);
        //when
        Test.startTest();
        List<Database.DeleteResult> result = Database.delete(currentVehicles, false);
        Test.stopTest();
        //then
        List<EnvironmentalImpact__c> envImpactRecords = new List<EnvironmentalImpact__c>([Select Id from EnvironmentalImpact__c]);
        System.assertEquals(envImpactRecords.size(), numberOfTestRecords);
    }

    /*
    * @author  <piotr.kazimierski@accenture.com>
    * @date  26.05.2021
    * @description Verifies that vehicle cannot be added then there are no free slots in salon
    */
    @isTest
    public static void shouldPreventAddingVehicleWhenThereIsNoFreeSlots(){ 
        
        //given
        Account account = OfferTriggerTestDataFactory.createTestAccount();
        Salon__C salon = OfferTriggerTestDataFactory.createTestSalon(account, 1);
        insert salon;
        Pojazd__c vehicle = OfferTriggerTestDataFactory.createSingleVehicle(Constants.testVehicleName, Constants.testVehicleSN, salon, account);
        Pojazd__c vehicle2 = OfferTriggerTestDataFactory.createSingleVehicle(Constants.testVehicleName2, Constants.testVehicleSN2, salon, account);

        List<Pojazd__c> vehicles = new List<Pojazd__c>{vehicle, vehicle2};
        //when
        try{
            Test.startTest();
            List<Database.SaveResult> results = Database.insert(vehicles, true);
            Test.stopTest();

            //then
            List<Id> listOfIds = new List<Id>();
            for(Database.SaveResult result : results){
                if(result.isSuccess()){
                    listOfIds.add(result.getId());
                }
            }
            System.assertEquals(1, listOfIds.size());

        }catch(Exception e){

            Boolean expectedExceptionThrown =  e.getMessage().contains(PojazdTriggerHandler.ERROR_MSG) ? true : false;
            System.AssertEquals(expectedExceptionThrown, true);
     }
    }

    /*
    * @author  <piotr.kazimierski@accenture.com>
    * @date  26.05.2021
    * @description Verifies that vehicle can be added then there are free slots in salon
    */
    @isTest
    public static void shouldAllowAddingVehicleWhereThereAreFreeSlots(){
        
        //given
        Account account = OfferTriggerTestDataFactory.createTestAccount();
        Salon__C salon = OfferTriggerTestDataFactory.createTestSalon(account, 2);
        insert salon;
        Pojazd__c vehicle = OfferTriggerTestDataFactory.createSingleVehicle(Constants.testVehicleName, Constants.testVehicleSN, salon, account);
        //when
        Test.startTest();
        Database.SaveResult result = Database.insert(vehicle, true);
        Test.stopTest();
        //then
        System.assert(result.isSuccess());


    }

}
