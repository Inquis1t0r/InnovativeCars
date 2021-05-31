/**
 *
 * @author  <piotr.kazimierski@accenture.com>
 * @date  24.05.2021
 * @description Handler for OfferTrigger
 */

public class OfferTriggerHandler {
    public static final String ERR_MSG = 'Nie można utworzyć oferty ponieważ pojazd jest dostępny w ';
    public static final string ARGUMENT_ERROR_MSG_LIST  = 'List cannot be empty!';

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


    public static final string SUBJECT = 'Nowe oferty';
    public static final string EMAIL_BODY = 'Pojawiły się nowe oferty. Liczba nowych ofert: ';
    public static final string POLICY = 'FILTER';
    public static final string RECIPIENT_EMAIL = 'vtc57104@eoopy.com';
    public static final string ARGUMENT_ERROR_MSG_SET = 'Set cennot be empty!';

    /**
     *
     * @author  <piotr.kazimierski@accenture.com>
     * @date  24.05.2021
     * @description Handles sending email after new offer cration (sends single mail after each new set of Oferta__c)
     * @usage Place your test mail, instead of 'vtc57104@eoopy.com' to test output
     */
    @future
    public static void sendMail(Set<Id> newOffersIDs){

        if(newOffersIDs == null || newOffersIDs.isEmpty()){
          throw new IllegalArgumentException(ARGUMENT_ERROR_MSG_SET);
        }

        Integer newOffersCount = newOffersIDs.size();
        Messaging.SingleEmailMessage message = new Messaging.SingleEmailMessage();
        message.toAddresses = new String[] {RECIPIENT_EMAIL}; 
        message.optOutPolicy = POLICY;
        message.subject = SUBJECT;
        message.plainTextBody = EMAIL_BODY + newOffersCount;
        Messaging.SingleEmailMessage[] messages =   new List<Messaging.SingleEmailMessage> {message};
        Messaging.SendEmailResult[] results = Messaging.sendEmail(messages);
        
        try{
            messaging.sendEmail(new Messaging.SingleEmailMessage[] { message });
        } catch(Exception e){
            System.debug(LoggingLevel.ERROR,'Error occured during email sending: ' + e.getMessage());
        }
        
        
    }

}
