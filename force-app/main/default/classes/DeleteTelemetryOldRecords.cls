/**
 *
 * @author  <piotr.kazimierski@accenture.com>
 * @date  25.05.2021
 * @description Execute method removes Telemetria__c records with createddate >= 30 days ago
 */
global with sharing class DeleteTelemetryOldRecords implements Schedulable{
        global void execute(SchedulableContext SC) {
            List<Telemetria__c> telemetryOldRecords = [select Id FROM Telemetria__c WHERE createddate = LAST_N_DAYS:30];
            if(!telemetryOldRecords.isEmpty()){
                delete telemetryOldRecords;
            }
    }
}
