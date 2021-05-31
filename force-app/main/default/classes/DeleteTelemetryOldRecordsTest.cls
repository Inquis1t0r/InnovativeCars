/**
 *
 * @author  <piotr.kazimierski@accenture.com>
 * @date  25.05.2021
 * @description Test class for DeleteTelemetryOldRecords
 */

@isTest
public with sharing class DeleteTelemetryOldRecordsTest {

    private static String cronExpr = '0 0 0 15 3 ? 2022';

    public static void shouldRemoveTelemetriesOlderThenToday(){

        //given
        Integer numberofTestRecords = 200;
        String query = 'SELECT Id, CreatedDate FROM Telemetria__c where CreatedDate < TODAY';
        //PojazdTriggerTestDataFactory.addTestPojazdEntitiesWithTelemetry(numberofTestRecords); 


        //when
        Test.startTest();
        Id jobId = System.schedule('DeleteTelemetryOldRecordsTest', cronExpr, new DeleteTelemetryOldRecords(query));
        Test.stopTest();

        //then
        List<Telemetria__c> telemetries = new List<Telemetria__c>([SELECT Id, CreatedDate FROM Telemetria__c where CreatedDate < TODAY]);
        System.assertEquals(0, telemetries.size());
    }
}
