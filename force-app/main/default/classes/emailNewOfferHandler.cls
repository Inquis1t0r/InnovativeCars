public with sharing class emailNewOfferHandler {

    @future
    public static void sendMail(Set<Id> newOffersIDs){
        Integer newOffersCount = newOffersIDs.size();
        Messaging.SingleEmailMessage message = new Messaging.SingleEmailMessage();
        message.toAddresses = new String[] {'vtc57104@eoopy.com'}; //TODO
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
