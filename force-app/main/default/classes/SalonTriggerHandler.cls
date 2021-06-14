/**
 *
 * @author  <piotr.kazimierski@accenture.com>
 * @date  25.05.2021
 * @description Handler for Salon__c changes
 */

public class SalonTriggerHandler {


    public static final String salonStatusClosed = 'Zamknięty';
    public static final string ARGUMENT_ERR_MSG = 'List cannot be empty!';
    public static final string WAREHOUSE_ALREADY_EXIST_FOR_ACCOUNT = 'Warehouse already exist for this Account';

    /** 
    * @author  <piotr.kazimierski@accenture.com>
    * @date  25.05.2021
    * @params Trigger.New, Trigger.oldMap
    * @return void
    * @description Creates renovation cases for Salon__c that changes status to closed 
    **/
    public static void createRenovationCase(List<Salon__c> inSalonNew, Map<Id, Salon__c> inSalonOld){
        if(inSalonNew == null || inSalonNew.isEmpty() || inSalonOld == null || inSalonOld.isEmpty()){
            throw new IllegalArgumentException(ARGUMENT_ERR_MSG);
        }

        List<Salon__c> listToCreateRenovationCase = new List <Salon__c>();
        for (Salon__c newSalon: inSalonNew) {
            Salon__c oldSalon = inSalonOld.get(newSalon.id);
            if(newSalon.Status_salonu__c == salonStatusClosed && oldSalon.Status_salonu__c != salonStatusClosed) {
               listToCreateRenovationCase.add(newSalon);
            }
        }

        if(listToCreateRenovationCase.size() > 0 && listToCreateRenovationCase != null){
            Id jobId = System.enqueueJob(new SalonTriggerService(listToCreateRenovationCase));
        }
    }

    /** 
    * @description Changes location of vehicles from deleted location, to designated warehouse
    * @date  25.05.2021
    * @params Trigger.Old
    * @return void
    **/
    public static void sendVehiclesToWarehouse(List<Salon__c> inClosedSalons){
        if(inClosedSalons == null || inClosedSalons.isEmpty()){
            throw new IllegalArgumentException(ARGUMENT_ERR_MSG);
        }

        List <Pojazd__c> vehiclesToMove = new List<Pojazd__c>([SELECT Salon__c FROM Pojazd__c WHERE Salon__c IN :inClosedSalons]);
        List<Id> idAccountList = new List<Id>();
        for(Salon__c currentSalon : inClosedSalons){
            idAccountList.add(currentSalon.Account__c);
        }


        List<Salon__c> currentWarehouses = new List<Salon__c>([SELECT id, name, Account__c FROM salon__C WHERE isWarehouse__c = true AND Account__c IN :idAccountList]);
        Map<Id, Salon__c> existingWareHousesMap = new Map<Id, Salon__c>();

        for(Salon__c currentWarehouse : currentWarehouses){
            existingWareHousesMap.put(currentWarehouse.Account__c, currentWarehouse);
        }
        


        for(Salon__c deletedSalon : inClosedSalons){
            Salon__c existingWarehouse = existingWareHousesMap.get(deletedSalon.Account__c);
            if(vehiclesToMove.size() > 0){
                for(Pojazd__c vehicle : vehiclesToMove){
                    vehicle.Salon__c = existingWarehouse.id;
                }
                update vehiclesToMove;
            }

        }

    }

    /**
    * @description Prevents adding new warehouse if one already exist for selected Account
    * @date  25.05.2021
    * @params Trigger.New
    * @return void
    **/
    public static void preventMoreThenOneWarehousePerAccount(List<Salon__c> inNewSalonlist){
        if(inNewSalonlist == null || inNewSalonlist.isEmpty()){
            throw new IllegalArgumentException(ARGUMENT_ERR_MSG);
        }

        List<Id> idAccountList = new List<Id>();
        for(Salon__c currentSalon : inNewSalonlist){
            idAccountList.add(currentSalon.Account__c);
        }


        List<Salon__c> currentWarehouses = new List<Salon__c>([SELECT id, name, Account__c FROM salon__C WHERE isWarehouse__c = true AND Account__c IN :idAccountList]);
        Map<Id, Salon__c> existingWareHousesMap = new Map<Id, Salon__c>();

        for(Salon__c currentWarehouse : currentWarehouses){
            existingWareHousesMap.put(currentWarehouse.Account__c, currentWarehouse);
        }

        for(Salon__c iteratedSalon : inNewSalonlist){
            if(iteratedSalon.isWarehouse__c == true){
                Salon__c existingWarehouse = existingWareHousesMap.get(iteratedSalon.Account__c);
                if(existingWarehouse == null){
                    existingWareHousesMap.put(iteratedSalon.Account__c, iteratedSalon);
                }else{
                    iteratedSalon.addError(WAREHOUSE_ALREADY_EXIST_FOR_ACCOUNT);
                }
            }
        }

    }
}

