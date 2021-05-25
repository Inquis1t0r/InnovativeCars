/**
 *
 * @author  <piotr.kazimierski@accenture.com>
 * @date  25.05.2021
 * @description Execute method removes Telemetria__c records with createddate >= 30 days ago //1 Day for testing purposes
 */
global with sharing class DeleteTelemetryOldRecords implements Schedulable{
        global void execute(SchedulableContext SC) {
            List<Telemetria__c> telemetryOldRecords = [select Id FROM Telemetria__c WHERE createddate = LAST_N_DAYS:1];
            if(!telemetryOldRecords.isEmpty()){
                delete telemetryOldRecords;
            }
    }
}
