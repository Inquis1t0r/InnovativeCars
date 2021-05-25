public with sharing class emailNewOfferHandler {

    @future
    public static void sendMail(List <Oferta__c> newOffers){
        Integer newOffersCount = newOffers.size();
        Messaging.SingleEmailMessage message = new Messaging.SingleEmailMessage();
        message.toAddresses = 'xyz@gmail.com'; //TODO
        message.optOutPolicy = 'FILTER';
        message.subject = 'Nowe oferty';
        message.plainTextBody = 'Pojawiły się nowe oferty. Liczba nowych ofer: ' + newOffersCount;
        Messaging.SingleEmailMessage[] messages =   new List<Messaging.SingleEmailMessage> {message};
        Messaging.SendEmailResult[] results = Messaging.sendEmail(messages);
        
        if(newOffersCount > 0){
            messaging.sendEmail(message);
        }
    }
}
