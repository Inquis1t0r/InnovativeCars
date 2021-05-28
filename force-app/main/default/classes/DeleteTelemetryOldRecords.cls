/**
 *
 * @author  <piotr.kazimierski@accenture.com>
 * @date  25.05.2021
 * @description Execute method removes Telemetria__c records with createddate >= 30 days ago //1 Day for testing purposes
 */
global with sharing class DeleteTelemetryOldRecords implements Database.Batchable<sObject>, Schedulable{

    private final String query = 'select Id FROM Telemetria__c WHERE createddate = ';
        //Schedulable
        //Scheduler code example:
        //public static String CRON_EXP = '0 0 0 28 5 ? 2022';
        //String jobId = System.schedule('DeleteTelemetryOldRecords',
        //CRON_EXP,
        //new DeleteTelemetryOldRecords());

        global void execute(SchedulableContext SC){
            String period = '';

            if(Test.isRunningTest()){
                period += 'LAST_N_DAYS:1 LIMIT 1';
            }else{
                period += 'LAST_N_DAYS:30 LIMIT 1';
            }

            List<Telemetria__c> telemetryOldRecords = Database.query(query + period);
            if(!telemetryOldRecords.isEmpty()){

                Database.executeBatch(this.DeleteTelemetryOldRecords(query + period));
            }
        }

        //Batchable
        public DeleteTelemetryOldRecords(String query){
            this.query = query;
        }

        public Database.QueryLocator start(Database.BatchableContext bc){
            return Database.getQueryLocator(query);
        }

        public void execute(Database.BatchableContext bc, List<sObject> scope){
            if(scope.size() == 0 || scope == null){
                finish();
            }
            delete scope;
        }

          public void finish(Database.BatchableContext bc){
            //system.debug('Cleanup finished or no records found');
        }
}
