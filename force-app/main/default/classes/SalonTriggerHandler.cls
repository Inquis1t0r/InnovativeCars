/**
 *
 * @author  <piotr.kazimierski@accenture.com>
 * @date  25.05.2021
 * @description Handler for Salon__c changes
 */

public class SalonTriggerHandler {


    public static final String salonStatusClosed = 'Zamknięty';
    public static final String WAREHOUSE_ID = 'a0009000008q5ApAAI'; //query ID for current
    public static final string ARGUMENT_ERR_MSG = 'List cannot be empty!';
    public static final string WAREHOUSE_ALREADY_EXIST_FOR_ACCOUNT = 'Warehouse already exist for this Account';

    /** 
    * @description Creates renovation cases for Salon__c that changes status to closed 
    **/
    public static void createRenovationCase(List<Salon__c> inSalonNew, Map<Id, Salon__c> inSalonOld){
        if(inSalonNew == null || inSalonNew.isEmpty() || inSalonOld == null || inSalonOld.isEmpty()){
            throw new IllegalArgumentException(ARGUMENT_ERR_MSG);
        }

        List<Salon__c> listToCreateRenovationCase = new List <Salon__c>();
        for (Salon__c newSalon: inSalonNew) {
            Salon__c oldSalon = inSalonOld.get(Status_salonu__c);
            if(newSalon.Status_salonu__c == salonStatusClosed && oldSalon.Status_salonu__c != salonStatusClosed) {
               listToCreateRenovationCase.add(salon);
            }
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

        List <Pojazd__c> vehiclesToMove = new List<Pojazd__c>([select Salon__c from Pojazd__c where Salon__c IN :inClosedSalons]);
        List<Id> idAccountList = new List<Id>();
        for(Salon__c currentSalon : inNewSalonlist){
            idAccountList.add(currentSalon.Account__c);
        }


        List<Salon__c> currentWarehouses = new List<Salon__c>([select id, name, Account__c from salon__C where isWarehouse__c = true AND Account__c in :idAccountList]);
        Map<Id, Salon__c> existingWareHousesMap = new Map<Id, Salon__c>();

        for(Salon__c currentWarehouse : currentWarehouses){
            existingWareHousesMap.put(currentWarehouse.Account__c, currentWarehouse);
        }
        


        for(Salon__c deletedSalon : inClosedSalons){
            Salon__c existingWarehouse = existingWareHousesMap.get(deletedSalon.Account__c);
            if(vehiclesToMove.size() > 0){
                for(Pojazd__c vehicle : vehiclesToMove){
                    vehicle.Salon__c = existingWarehouse;
                }
                update vehiclesToMove;
            }

        }

    }

    /**/
    *
    **/
    public static void preventMoreThenOneWarehousePerAccount(List<Salon__c> inNewSalonlist){
        if(inNewSalonlist == null || inNewSalonlist.isEmpty()){
            throw new IllegalArgumentException(ARGUMENT_ERR_MSG);
        }

        List<Id> idAccountList = new List<Id>();
        for(Salon__c currentSalon : inNewSalonlist){
            idAccountList.add(currentSalon.Account__c);
        }


        List<Salon__c> currentWarehouses = new List<Salon__c>([select id, name, Account__c from salon__C where isWarehouse__c = true AND Account__c in :idAccountList]);
        Map<Id, Salon__c> existingWareHousesMap = new Map<Id, Salon__c>();

        for(Salon__c currentWarehouse : currentWarehouses){
            existingWareHousesMap.put(currentWarehouse.Account__c, currentWarehouse);
        }

        for(Salon__c iteratedSalon : inNewSalonlist){
            if(iteratedSalon.isWarehouse__c == true){
                Salon__c existingWarehouse = existingWareHousesMap.get(iteratedSalon.Account__c);
                if(existingWarehouse == null){
                    existingWareHousesMap.put(iteratedSalon.Account__c);
                }else{
                    iteratedSalon.addError(WAREHOUSE_ALREADY_EXIST_FOR_ACCOUNT);
                }
            }
        }

    }
}

