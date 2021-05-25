public with sharing class salonStatusChangeHandler {
    public static void checkRepairCrewAvaliability(){
        Http server = new Http();
        HttpRequest req = new HttpRequest();
        String request = '';
        req.setEndpoint('https://jsonplaceholder.typicode.com/posts');
        req.setMethod('POST');
        req.setBody(JSON.serialize(request)); 
        HttpResponse resp = server.send(req);

        If(resp.getStatusCode() =201)
        {
            //TODO
        }else{
            System.debug(LoggingLevel.ERROR,'Bład połączenia');
        }

    }
}
