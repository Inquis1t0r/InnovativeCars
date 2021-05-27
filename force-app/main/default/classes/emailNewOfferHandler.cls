/**
 *
 * @author  <piotr.kazimierski@accenture.com>
 * @date  24.05.2021
 * @description Handles sending email after new offer cration
 */
public class emailNewOfferHandler {

    public static final string SUBJECT = 'Nowe oferty';
    public static final string EMAIL_BODY = 'Pojawiły się nowe oferty. Liczba nowych ofert: ';
    public static final string POLICY = 'FILTER';
    public static final string RECIPIENT_EMAIL = 'vtc57104@eoopy.com';
    public static final string ARGUMENT_ERROR_MSG = 'Set cennot be empty!';

    /**
     *
     * @author  <piotr.kazimierski@accenture.com>
     * @date  24.05.2021
     * @description sends single mail after each new set of Oferta__c
     * @usage Place your test mail, instead of 'vtc57104@eoopy.com' to test output
     */
    @future
    public static void sendMail(Set<Id> newOffersIDs){

        if(newOffersIDs == null || newOffersIDs.isEmpty()){
          throw new IllegalArgumentException(ARGUMENT_ERROR_MSG);
        }

        Integer newOffersCount = newOffersIDs.size();
        Messaging.SingleEmailMessage message = new Messaging.SingleEmailMessage();
        message.toAddresses = new String[] {RECIPIENT_EMAIL}; 
        message.optOutPolicy = POLICY;
        message.subject = SUBJECT;
        message.plainTextBody = EMAIL_BODY + newOffersCount;
        Messaging.SingleEmailMessage[] messages =   new List<Messaging.SingleEmailMessage> {message};
        Messaging.SendEmailResult[] results = Messaging.sendEmail(messages);
        
        messaging.sendEmail(new Messaging.SingleEmailMessage[] { message });
        
    }
}
