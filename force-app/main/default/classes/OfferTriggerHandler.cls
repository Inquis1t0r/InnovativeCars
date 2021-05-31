/**
 *
 * @author  <piotr.kazimierski@accenture.com>
 * @date  24.05.2021
 * @description Handler for OfferTrigger
 */

public class OfferTriggerHandler {
    public static final String ERR_MSG = 'Nie można utworzyć oferty ponieważ pojazd jest dostępny w ';
    public static final string ARGUMENT_ERROR_MSG_LIST  = 'List cannot be empty!';
    public static final string ERR_MSG_OFFER_ALREADY_PROCESSING  = 'Another physical offer is being processed for this vehicle';

    /**
     *
     * @author  <piotr.kazimierskis@accenture.com>
     * @date  24.05.2021
     * @description Prevents vehicles duplicates for phycisal offers, doesRecordExist compares new records with old to find duplicated vehicle assigment
     */
    public static void doesRecordExist(List<Oferta__c> inListOfNewOffers){
        
        if(inListOfNewOffers.isEmpty() || inListOfNewOffers == null){
            throw new IllegalArgumentException(ARGUMENT_ERROR_MSG_LIST);
        }

        List<Oferta__c> physicalOffers = new List<Oferta__c>();
        for(Oferta__c offer : inListOfNewOffers){
            if(offer.Oferta_fizyczna__c == true){
                physicalOffers.add(offer);
            }
        }

        Set<Id> vehicles = new Set<Id>();
        for(Oferta__c offer : physicalOffers){
            boolean success = vehicles.add(offer.Pojazd__c);
            if(!success){
                offer.addError(ERR_MSG_OFFER_ALREADY_PROCESSING);
            }else{
                vehicles.add(offer.Pojazd__c);
            }
        }

        Map<Id, String> vehiclesWithPhysicalOffer = new Map<Id, String>();
        List<Oferta__c> currOffersWithPhysicalOffers = new List<Oferta__c>([SELECT Pojazd__c, Oferta__c.Salon__r.Name FROM Oferta__c where Oferta_fizyczna__c = true and Pojazd__c in :vehicles]);
        for(Oferta__c offer : currOffersWithPhysicalOffers){
            vehiclesWithPhysicalOffer.put(offer.Pojazd__c, offer.Salon__r.Name);
        }


        for(Oferta__c offer : physicalOffers){
                if(vehiclesWithPhysicalOffer.containsKey(offer.Pojazd__c)){
                    String SalonName = vehiclesWithPhysicalOffer.get(offer.Pojazd__c);
                    offer.addError(ERR_MSG + SalonName);
                }
        }
    }


    public static final string SUBJECT = 'Nowe oferty';
    public static final string EMAIL_BODY = 'Pojawiły się nowe oferty. Liczba nowych ofert: ';
    public static final string POLICY = 'FILTER';
    public static final string RECIPIENT_EMAIL = 'vcp63826@cuoly.com';

    /**
     *
     * @author  <piotr.kazimierski@accenture.com>
     * @date  24.05.2021
     * @description Handles sending email after new offer cration (sends single mail after each new set of Oferta__c)
     * @usage Place your test mail, inside  of RECIPIENT_EMAIL to test output
     */
    @future
    public static void sendMail(Set<id> newOfferIDs){

        if(newOfferIDs == null || newOfferIDs.isEmpty()){
          throw new IllegalArgumentException(ARGUMENT_ERROR_MSG_LIST);
        }

        List<Oferta__c> newOffers = new List<Oferta__C>([SELECT Id, Name from Oferta__c where Id in :newOfferIDs]);

        Messaging.SingleEmailMessage message = new Messaging.SingleEmailMessage();
        message.toAddresses = new String[] {RECIPIENT_EMAIL}; 
        message.optOutPolicy = POLICY;
        message.subject = SUBJECT;
        message.plainTextBody = JSON.serialize(newOffers);
        Messaging.SingleEmailMessage[] messages =   new List<Messaging.SingleEmailMessage> {message};
        Messaging.SendEmailResult[] results = Messaging.sendEmail(messages);
        
        try{
            messaging.sendEmail(new Messaging.SingleEmailMessage[] { message });
        } catch(Exception e){
            System.debug(LoggingLevel.ERROR,'Error occured during email sending: ' + e.getMessage());
        }
        
        
    }

}
