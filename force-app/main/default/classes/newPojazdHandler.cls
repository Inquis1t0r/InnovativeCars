public with sharing class newPojazdHandler {
    public newPojazdHandler() {

    }

    public static void freeSlotsCheck(List<Pojazd__c> listOfNewCars){

         List<Salon__c> salony = new list<Salon__c>([SELECT Id, Liczba_miejsc__c FROM Salon__c]);

         Map<Id, Decimal> maxSlots = new Map<Id, Decimal>();
         for (Salon__c s : salony){
              maxSlots.put(s.Id, s.Liczba_miejsc__c);
          }

        For(Pojazd__c poj : listOfNewCars)
        {             
            Decimal salonSlots = maxSlots.get(poj.Salon__c);
            if(salonSlots + 1 > salonSlots){
                poj.adderror('Liczba miejsc w salonie przekroczona! Maksymalna pojemność salonu :' + salonSlots);
            }
        }
    }
}
