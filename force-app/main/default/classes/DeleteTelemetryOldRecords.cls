public with sharing class DeleteTelemetryOldRecords implements Schedulable{
    public DeleteTelemetryOldRecords() {
        global void execute(SchedulableContext SC) {
            List<Telemetria__c> telemetryOldRecords = [select Id FROM Telemetria__c WHERE createddate = LAST_N_DAYS:30];
            if(!telemetryOldRecords.isEmpty()){
                delete telemetryOldRecords;
            }
        }

    }
}
