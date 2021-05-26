/**
 *
 * @author  <piotr.kazimierski@accenture.com>
 * @date  26.05.2021
 * @description Periodicly sets Vehicle.Account equal to Location.Account
 * @param accountNotConnected__c - formula - checkbox bypassing SOQL ignoring null values for Account__c
 */
global class scheduledAccountAssignment implements Schedulable {
    global void execute(SchedulableContext SC) {
       List<Pojazd__c> vehiclesToUpdate = new List<Pojazd__c>([select id from Pojazd__c where accountNotConnected__c = true]);
       for(Pojazd__c vehicle : vehiclesToUpdate){
        vehicle.Account__c = salon__r.account__c;
       }
     }
}
