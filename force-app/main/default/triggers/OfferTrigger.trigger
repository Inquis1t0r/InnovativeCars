/**
 *
 * @author  <piotr.kazimierski@accenture.com>
 * @date  21.05.2021
 * @description Trigger for new Oferta__c, check Handlers jdoc for more details
 */
trigger newOfferTrigger on Oferta__c (before insert, after insert) {
    if(Trigger.isBefore){
        OfferTriggerHandler.doesRecordExist(Trigger.new);
    }
    if(Trigger.isAfter){
        OfferTriggerHandler.sendMail(Trigger.newMap.keySet());
    }
    
}