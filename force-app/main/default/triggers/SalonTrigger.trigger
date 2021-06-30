/**
 *
 * @author  <piotr.kazimierski@accenture.com>
 * @date  25.05.2021
 * @description Check Handlers for more docs
 */
trigger SalonTrigger on Salon__c (after update, before insert) {
    if(Trigger.isUpdate){
        SalonTriggerHandler.sendVehiclesToWarehouse(Trigger.Old);
        SalonTriggerHandler.createRenovationCase(Trigger.New, Trigger.oldMap);
    }
    
    if(Trigger.isUpdate || Trigger.isInsert){
        SalonTriggerHandler.preventMoreThenOneWarehousePerAccount(Trigger.New);
    }

}