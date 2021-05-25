/**
 *
 * @author  <piotr.kazimierski@accenture.com>
 * @date  24.05.2021
 * @description sendMail method sends single mail after each new set of Oferta__c 
 * @usage Place your test mail, instead of 'vtc57104@eoopy.com' for testing
 */
public with sharing class emailNewOfferHandler {

    @future
    public static void sendMail(Set<Id> newOffersIDs){
        Integer newOffersCount = newOffersIDs.size();
        Messaging.SingleEmailMessage message = new Messaging.SingleEmailMessage();
        message.toAddresses = new String[] {'vtc57104@eoopy.com'}; 
        message.optOutPolicy = 'FILTER';
        message.subject = 'Nowe oferty';
        message.plainTextBody = 'Pojawiły się nowe oferty. Liczba nowych ofer: ' + newOffersCount;
        Messaging.SingleEmailMessage[] messages =   new List<Messaging.SingleEmailMessage> {message};
        Messaging.SendEmailResult[] results = Messaging.sendEmail(messages);
        
        if(newOffersCount > 0){
            messaging.sendEmail(new Messaging.SingleEmailMessage[] { message });
        }
    }
}
