/**
 *
 * @author  <piotr.kazimierski@accenture.com>
 * @date  25.05.2021
 * @description Execute method removes Telemetria__c records with createddate >= 30 days ago //1 Day for testing purposes
 */
global with sharing class DeleteTelemetryOldRecords implements Database.Batchable<sObject>, Schedulable{
        


        private final String query = 'select Id FROM Telemetria__c WHERE createddate = LAST_N_DAYS:1';
        //Schedulable
        global void execute(SchedulableContext SC) {
            List<Telemetria__c> telemetryOldRecords = Database.query(query);
            if(!telemetryOldRecords.isEmpty()){
                //delete telemetryOldRecords;
                Database.executeBatch(new DeleteTelemetryOldRecords(query));
            }
        }

        //Batchable
        public DeleteTelemetryOldRecords(String query) {
            this.query = query;
        }

        public Database.QueryLocator start(Database.BatchableContext bc) {
            return Database.getQueryLocator(query);
        }

        public void execute(Database.BatchableContext bc, List<sObject> scope) {
            delete scope;
        }

          public void finish(Database.BatchableContext bc) {
        }

}
