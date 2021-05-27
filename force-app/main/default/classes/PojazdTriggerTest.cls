/**
 *
 * @author  <piotr.kazimierski@accenture.com>
 * @date  26.05.2021
 * @description Test class for PojazdTrigger
 */

@isTest
public class PojazdTriggerTest {

    @isTest
    public static void shouldAddEnvironmentalImpactRecordsWhenVehicleWithTelemetryDataDeleted(){
        //given
        Integer numberOfTestRecords = 200;
        PojazdTriggerTestDataFactory.addTestPojazdEntitiesWithTelemetry(numberOfTestRecords);
        List<Pojazd__c> currentVehicles = new List<Pojazd__c>([Select Id from Pojazd__c]);
        //when
        Test.startTest();
        List<Database.DeleteResult> result = Database.delete(currentVehicles, false);
        Test.stopTest();
        //then
        List<EnvironmentalImpact__c> envImpactRecords = new List<EnvironmentalImpact__c>([Select Id from EnvironmentalImpact__c]);
        System.assertEquals(envImpactRecords.size(), numberOfTestRecords);
    }

}
