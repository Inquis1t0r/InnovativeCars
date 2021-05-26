/**
 *
 * @author  <piotr.kazimierski@accenture.com>
 * @date  24.05.2021
 * @description freeSlotsCheck method checks if there is enaught free slots for new Pojazd__c objects
 */
public with sharing class PojazdHandler {

    public static void freeSlotsCheck(List<Pojazd__c> inListOfNewCars){
        string errorMsg = 'Liczba miejsc w salonie przekroczona! Maksymalna pojemność salonu :';
         List<Salon__c> salons = new list<Salon__c>([SELECT Id, Liczba_miejsc__c FROM Salon__c]);

         Map<Id, Decimal> maxSlots = new Map<Id, Decimal>();
         for (Salon__c salon : salons){
              maxSlots.put(salon.Id, salon.Liczba_miejsc__c);
          }

        For(Pojazd__c poj : inListOfNewCars)
        {             
            Decimal salonSlots = maxSlots.get(poj.Salon__c);
            if(salonSlots + 1 > salonSlots){ //TODO: Compare after adding inListOfNewCars size (- number of processed cars(?))
                poj.adderror(errorMsg + salonSlots);
            }
        }
    }
}
