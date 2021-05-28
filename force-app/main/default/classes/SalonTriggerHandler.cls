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
    public static final String salonStatusClosed = 'Zamknięty';

    @InvocableMethod
    public static void checkRepairCrewAvaliability(){
        Http server = new Http();
        HttpRequest req = new HttpRequest();
        //String requestBody = '';
        //RequestBody requestBody = new RequestBody();
        req.setEndpoint(ENDPOINT);
        req.setMethod(REQUEST_METHOD);
        req.setBody(JSON.serialize('')); 
        HttpResponse resp = server.send(req);

        If(resp.getStatusCode() == 201)
        {
            System.debug(resp.getBody());
            //System.debug('success');
        }else{
            System.debug(LoggingLevel.ERROR, CONN_ERR);
        }
    }

    /** 
    * @description Creates list of Salon__c with closed status
    **/
    public static void createRenovationCase(List<Salon__c> inSalonOld){
        List<Salon__c> listToCreateRenovationCase = new List <Salon__c>();
        for(Salon__c salon : inSalonOld){
            if(salon.Status_salonu__c == salonStatusClosed)
            listToCreateRenovationCase.add(salon);
        }
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
