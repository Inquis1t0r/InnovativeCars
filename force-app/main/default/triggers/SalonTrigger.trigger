/**
 *
 * @author  <piotr.kazimierski@accenture.com>
 * @date  25.05.2021
 * @description Check Handlers for more docs
 */
trigger SalonTrigger on Salon__c (after update) {
    SalonTriggerHandler.createRenovationCase(Trigger.Old);
}