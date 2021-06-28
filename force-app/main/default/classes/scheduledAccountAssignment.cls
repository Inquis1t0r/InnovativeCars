/**
 *
 * @author  <piotr.kazimierski@accenture.com>
 * @date  26.05.2021
 * @description Periodicly sets Vehicle.Account equal to Location.Account
 * @param accountNotConnected__c - formula - checkbox bypassing SOQL ignoring null values for Account__c
 */

global class scheduledAccountAssignment implements Schedulable {

  public static final string ARGUMENT_ERROR_MSG  = 'List cannot be empty!';

    global void execute(SchedulableContext SC) {
       List<Pojazd__c> vehiclesToUpdate = new List<Pojazd__c>([select id from Pojazd__c where accountNotConnected__c = true]);
      
      if(vehiclesToUpdate == null || vehiclesToUpdate.isEmpty()){
        throw new IllegalArgumentException(ARGUMENT_ERROR_MSG);
      }
      
       for(Pojazd__c vehicle : vehiclesToUpdate){
        vehicle.Account__c = vehicle.Salon__r.Account__c;
       }
     }
}
