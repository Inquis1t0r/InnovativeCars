/**
 *
 * @author  <piotr.kazimierski@accenture.com>
 * @date  24.05.2021
 * @description doesRecordExist compares new records with old to find duplicated vehicle assigment
 */
public with sharing class ExistingOfferHandler {

    public static void doesRecordExist(List<Oferta__c> inListOfNewOffers){
        String errMsg = 'Nie można utworzyć oferty ponieważ pojazd jest dostępny w ';
        List<Oferta__c> existingRecords = [select Pojazd__c, Salon__c, Salon__r.Name from Oferta__c where Oferta_fizyczna__c = true];
        
        for(Oferta__c newOff:inListOfNewOffers)
        {
            for(Oferta__c oldOff:existingRecords)
            {
                if(oldOff.Pojazd__c == newOff.Pojazd__c)
                {
                    newOff.adderror(errMsg + oldOff.Salon__r.Name);
                }
            }
        }
    }

    
}