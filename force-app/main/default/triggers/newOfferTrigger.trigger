/**
 *
 * @author  <piotr.kazimierski@accenture.com>
 * @date  21.05.2021
 * @description Trigger for new Oferta__c, check Handlers jdoc for more details
 */
trigger newOfferTrigger on Oferta__c (before insert, after insert) {
    if(Trigger.isBefore){
        ExistingOfferHandler.doesRecordExist(Trigger.new);
    }
    if(Trigger.isAfter){
        emailNewOfferHandler.sendMail(Trigger.newMap.keySet());
    }
    
}