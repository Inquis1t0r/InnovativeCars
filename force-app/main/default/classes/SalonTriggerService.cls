public with sharing class SalonTriggerService {
    public static final string ENDPOINT = 'https://jsonplaceholder.typicode.com/posts';
    public static final string CONN_ERR = 'Bład połączenia'; 
    public static final string REQUEST_METHOD = 'POST';
    public static final string ARGUMENT_ERR_MSG = 'List cannot be empty!';
    public static final String WAREHOUSE_ID = 'a0009000008q5ApAAI';

    public SalonTriggerService() {

    }

    //@InvocableMethod
    @future(callout=true)
    public static void checkRepairCrewAvaliability(){
        Http server = new Http();
        HttpRequest req = new HttpRequest();
        //String requestBody = '';
        //RequestBody requestBody = new RequestBody();
        req.setEndpoint(ENDPOINT);
        req.setMethod(REQUEST_METHOD);
        req.setBody(JSON.serialize('')); //casesList
        HttpResponse resp = server.send(req);

        If(resp.getStatusCode() == 201)
        {
            //System.debug(resp.getBody());
            //System.debug('success');
        }else{
            System.debug(LoggingLevel.ERROR, CONN_ERR);
        }
    }

}
