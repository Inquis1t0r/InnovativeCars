trigger newOfferTrigger on Oferta__c (before insert, after insert) {
    if(Trigger.isBefore){
        ExistingOfferHandler.doesRecordExist(Trigger.new);
    }
    if(Trigger.isAfter){
        emailNewOfferHandler.sendMail(Trigger.newMap.keySet());
    }
    
}