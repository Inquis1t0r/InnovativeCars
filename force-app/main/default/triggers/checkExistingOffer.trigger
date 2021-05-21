trigger checkExistingOffer on Oferta__c (before insert) {
    ExistingOfferHandler.doesRecordExist(Trigger.new);
}