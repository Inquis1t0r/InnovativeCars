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

        List<Id> vehicleIDs = new List<Id>();
        List<Id> salonIDs = new List<Id>();
        List<Oferta__c> physicalOffers = new List<Oferta__c>();
        
        for(Oferta__c offer : inListOfNewOffers){
            if(offer.Oferta_fizyczna__c = true){
                vehicleIDs.add(offer.Pojazd__c);
                salonIDs.add(offer.Salon__c);
                physicalOffers.add(offer);
            }
        }

        Map<Id, String> vehiclesExistingInOffers = new Map<Id, String>();
        for(Oferta__c offer: [SELECT Pojazd__c, Oferta__c.Salon__r.Name FROM Oferta__c WHERE Pojazd__c in :vehicleIDs]){
            vehiclesExistingInOffers.put(offer.Pojazd__c, offer.Salon__r.Name);
        }
        
        for(Oferta__c offer : physicalOffers){
            if(vehiclesExistingInOffers.containsKey(offer.Pojazd__c)){
                String salonWhereVehicleExistName = vehiclesExistingInOffers.get(offer.Pojazd__c);
                offer.addError(ERR_MSG + salonWhereVehicleExistName);
            }
        }


    }

    
}