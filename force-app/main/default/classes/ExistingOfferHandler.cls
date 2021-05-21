public with sharing class ExistingOfferHandler {
    public ExistingOfferHandler() {
        List<Oferta__c> existingRecords = [select Pojazd__c, Salon__c, Salon__r.Name from Oferta__c where Oferta_fizyczna__c = true];
        for(Oferta__c newOff:listOfNewOffers)
        {
            for(Oferta__c oldOff:existingRecords)
            {
                if(oldOff.Pojazd__c == newOff.Pojazd__c)
                {
                    newOff.adderror('Nie można utworzyć oferty ponieważ pojazd jest dostępny w ' + oldOff.Salon__r.Name);
                }
            }
        }
    }
}
