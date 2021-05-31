public with sharing class SalonTriggerService implements Queueable, Database.AllowsCallouts{
    public final List<Salon__c> listToCreateRenovationCase;
    public static final string ENDPOINT = 'https://jsonplaceholder.typicode.com/posts';
    public static final string CONN_ERR = 'Bład połączenia'; 
    public static final string REQUEST_METHOD = 'POST';
    
    
    public static final String CASE_ORIGIN = 'Web';
    public static final String CASE_SUBJECT = 'Renovation required for: ';
    public static final String CASE_STATUS_CLOSED = 'Closed';
    public static final String CASE_STATUS_FAILD = 'Faild';//Add status to Case status picklist

    public SalonTriggerService(List<Salon__c> listToCreateRenovationCase) {
        this.listToCreateRenovationCase = listToCreateRenovationCase;
    }

    public void execute(QueueableContext ctx){
        List<Case> renovationCases = new List<Case>();
        for(Salon__c salon : listToCreateRenovationCase){
            renovationCases.add(new Case(Origin = CASE_ORIGIN, Salon__c = salon.Id, Subject = CASE_SUBJECT + salon.Name));
        }
        insert renovationCases;

        List<Id> caseIDs = new List<Id>();
        for(Case currentCase : renovationCases){
            caseIDs.add(currentCase.Id);
        }

    }
    
    @future(callout=true)
    public static void checkRepairCrewAvaliability(List<Id> listToCreateRenovationCaseIDs){
        List<Case> renovationCases = new List<Case>([SELECT Id FROM Case WHERE Id IN :listToCreateRenovationCaseIDs]);
        Http server = new Http();
        HttpRequest req = new HttpRequest();
        req.setEndpoint(ENDPOINT);
        req.setMethod(REQUEST_METHOD);
        req.setBody(JSON.serialize(renovationCases)); 
        HttpResponse resp = server.send(req);
        String status = CASE_STATUS_FAILD;
        If(resp.getStatusCode() == 201)
        {
            status = CASE_STATUS_CLOSED;
        }else{
            System.debug(LoggingLevel.ERROR, CONN_ERR);
        }

        for(Case currentCase : renovationCases){
            currentCase.Status = status;
        }
        update renovationCases;
    }

}
