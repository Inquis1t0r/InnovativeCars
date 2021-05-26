public with sharing class SalonTriggerHandler {

    private final string endpoint = 'https://jsonplaceholder.typicode.com/posts';

    public static void checkRepairCrewAvaliability(){
        Http server = new Http();
        HttpRequest req = new HttpRequest();
        String requestBody = '';
        req.setEndpoint('https://jsonplaceholder.typicode.com/posts');
        req.setMethod('POST');
        req.setBody(JSON.serialize(requestBody)); 
        HttpResponse resp = server.send(req);

        If(resp.getStatusCode() == 201)
        {
            //TODO
        }else{
            System.debug(LoggingLevel.ERROR,'Bład połączenia');
        }
    }

    public static void createRenovationEvent(){
        //TODO: New Renovation case 
    }
}
