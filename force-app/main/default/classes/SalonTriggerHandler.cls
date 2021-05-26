/**
 *
 * @author  <piotr.kazimierski@accenture.com>
 * @date  25.05.2021
 * @description Handler for Salon__c changes
 */

public class SalonTriggerHandler {

    public static final string ENDPOINT = 'https://jsonplaceholder.typicode.com/posts';
    public static final string CONN_ERR = 'Bład połączenia'; 
    public static final string REQUEST_METHOD = 'POST';
    public static final string ARGUMENT_ERR_MSG = 'List cannot be empty!';
    public static final String WAREHOUSE_ID = 'a0009000008q5ApAAI';

    @InvocableMethod
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

    /** 
    * @description Changes localisation of vehicles from deleted location, to designated warehouse
    **/
    public static void sendVehiclesToWarehouse(List<Salon__c> inDeletedSalons){
        if(inDeletedSalons == null || inDeletedSalons.isEmpty()){
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
