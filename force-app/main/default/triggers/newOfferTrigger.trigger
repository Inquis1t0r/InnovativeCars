trigger newOfferTrigger on Oferta__c (before insert) {
    ExistingOfferHandler.doesRecordExist(Trigger.new);
    emailNewOfferHandler.sendMail(Trigger.new);
}