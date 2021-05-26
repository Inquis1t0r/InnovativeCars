/**
 *
 * @author  <piotr.kazimierski@accenture.com>
 * @date  24.05.2021
 * @description freeSlotsCheck method checks if there is enaught free slots for new Pojazd__c objects
 */
public class PojazdTriggerHandler {

    public static final string ERROR_MSG = 'Liczba miejsc w salonie przekroczona! Maksymalna pojemność salonu :';
    public static final string ARGUMENT_ERROR_MSG  = 'List cannot be empty!';

    public static void freeSlotsCheck(List<Pojazd__c> inListOfNewCars){
        
         List<Salon__c> salons = new list<Salon__c>([SELECT Id, Liczba_miejsc__c FROM Salon__c]);

        if(inListOfNewCars.isEmpty() || inListOfNewCars == null){
            throw new IllegalArgumentException(ARGUMENT_ERROR_MSG);
        }

         Map<Id, Decimal> maxSlots = new Map<Id, Decimal>();
         for (Salon__c salon : salons){
              maxSlots.put(salon.Id, salon.Liczba_miejsc__c);
          }

        For(Pojazd__c poj : inListOfNewCars)
        {             
            Decimal salonSlots = maxSlots.get(poj.Salon__c);
            if(salonSlots + 1 > salonSlots){ //TODO: Compare after adding inListOfNewCars size (- number of processed cars(?))
                poj.adderror(ERROR_MSG + salonSlots);
            }
        }
    }

    public static void moveTelemetryData(List<Pojazd__c> inListOfDeletedCars){
        List<Telemetria__c> telemetryDataForDeletedCars = new List<Telemetria__c>([select Id from Telemetria__c where Pojazd__c IN :Trigger.Old]);

    }
}
