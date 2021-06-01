/**
 *
 * @author  <piotr.kazimierski@accenture.com>
 * @date  25.05.2021
 * @description Handler for Salon__c changes
 */

public class SalonTriggerHandler {


    public static final String salonStatusClosed = 'Zamknięty';
    public static final String WAREHOUSE_ID = 'a0009000008q5ApAAI';
    public static final string ARGUMENT_ERR_MSG = 'List cannot be empty!';

    /** 
    * @description Creates list of Salon__c with closed status
    **/
    public static void createRenovationCase(List<Salon__c> inSalonOld){
        List<Salon__c> listToCreateRenovationCase = new List <Salon__c>();
        for(Salon__c salon : inSalonOld){
            if(salon.Status_salonu__c == salonStatusClosed)
            listToCreateRenovationCase.add(salon);
        }
        if(listToCreateRenovationCase.size() > 0 && listToCreateRenovationCase != null){
            Id jobId = System.enqueueJob(new SalonTriggerService(listToCreateRenovationCase));
        }
        
    }

    /** 
    * @description Changes location of vehicles from deleted location, to designated warehouse
    **/
    public static void sendVehiclesToWarehouse(List<Salon__c> inClosedSalons){
        if(inClosedSalons == null || inClosedSalons.isEmpty()){
            throw new IllegalArgumentException(ARGUMENT_ERR_MSG);
        }

        List <Oferta__c> vehiclesToMove = new List<Oferta__c>([select Pojazd__c, Salon__c from Oferta__c where Oferta_fizyczna__c = true AND Salon__c IN :inDeletedSalons]);

        for(Salon__c deletedSalon : inClosedSalons){
            if(vehiclesToMove.size() > 0){
                for(Oferta__c vehicle : vehiclesToMove){
                    vehicle.Salon__c = WAREHOUSE_ID;
                }
                update vehiclesToMove;
            }

        }

    }
}
