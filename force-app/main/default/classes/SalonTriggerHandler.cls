public with sharing class SalonTriggerHandler {

    private static final string ENDPOINT = 'https://jsonplaceholder.typicode.com/posts';
    private static final string CONN_ERR = 'Bład połączenia'; 
    private static final string REQUEST_METHOD = 'POST';
    private static final string ARGUMENT_ERR_MSG = 'List cannot be empty!';
    private static final Id WAREHOUSE_ID = a0009000008q5ApAAI;

    public static void checkRepairCrewAvaliability(){
        Http server = new Http();
        HttpRequest req = new HttpRequest();
        String requestBody = '';
        req.setEndpoint(ENDPOINT);
        req.setMethod(REQUEST_METHOD);
        req.setBody(JSON.serialize(requestBody)); 
        HttpResponse resp = server.send(req);

        If(resp.getStatusCode() == 201)
        {
            //TODO
        }else{
            System.debug(LoggingLevel.ERROR, CONN_ERR);
        }
    }

    public static void createRenovationEvent(){
        //TODO: New Renovation case 
    }

    public static void sendVehiclesToWarehouse(List<Salon__c> inDeletedSalons){
        if(inDeletedSalons = null || inDeletedSalons.isEmpty()){
            throw new IllegalArgumentException(ARGUMENT_ERR_MSG);
        }

        for(Salon__c deletedSalon : inDeletedSalons){
            List <Oferta__c> vehiclesToMove = new List<Oferta__c>([select Pojazd__c, Salon__c from Oferta__c where Oferta_fizyczna__c = true AND Salon__c IN :inDeletedSalons ]);

            if(vehiclesToMove.size() > 0){
                for(Oferta__c vehicle : vehiclesToMove){
                    vehicle.Salon__c = WAREHOUSE_ID;
                }
            }

        }

    }
}
