/**
 *
 * @author  <piotr.kazimierski@accenture.com>
 * @date  24.05.2021
 * @description Prevents vehicles duplicates for phycisal offers
 */
public class ExistingOfferHandler {

    public static final String ERR_MSG = 'Nie można utworzyć oferty ponieważ pojazd jest dostępny w ';
    public static final string ARGUMENT_ERROR_MSG  = 'List cannot be empty!';

    /**
     *
     * @author  <piotr.kazimierski@accenture.com>
     * @date  24.05.2021
     * @description doesRecordExist compares new records with old to find duplicated vehicle assigment
     */
    public static void doesRecordExist(List<Oferta__c> inListOfNewOffers){
        
        if(inListOfNewOffers.isEmpty() || inListOfNewOffers == null){
            throw new IllegalArgumentException(ARGUMENT_ERROR_MSG);
        }
        
        List<Oferta__c> existingRecords = [select Pojazd__c, Salon__c, Salon__r.Name from Oferta__c where Oferta_fizyczna__c = true and Pojazd__c IN :inListOfNewOffers];
        
        for(Oferta__c newOff:inListOfNewOffers)
        {
            for(Oferta__c oldOff:existingRecords)
            {
                if(oldOff.Pojazd__c == newOff.Pojazd__c)
                {
                    newOff.adderror(ERR_MSG + oldOff.Salon__r.Name);
                }
            }
        }
    }

    
}