/**
 *
 * @author  <piotr.kazimierski@accenture.com>
 * @date  24.05.2021
 * @description Handler for Pojazd__c Trigger
 */
public class PojazdTriggerHandler {

    public static final string ERROR_MSG = 'Liczba miejsc w salonie przekroczona! Maksymalna pojemność salonu :';
    public static final string ARGUMENT_ERROR_MSG  = 'List cannot be empty!';

    /*
    * @description method checks if there is enaught free slots for new Pojazd__c objects
    */
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
               // poj.adderror(ERROR_MSG + salonSlots);
            }
        }
    }

    /*
    * @description creates new EnvironmentalImpact__c records for deleted vehicles
    */
    public static void createEnvironmentalTelemetryData(List<Pojazd__c> inListOfDeletedCars){//Trigger.Old
        List<Telemetria__c> telemetryDataForDeletedCars = new List<Telemetria__c>([select Id from Telemetria__c where Pojazd__c IN :inListOfDeletedCars]);
        List<EnvironmentalImpact__c> newEnvironmentalImpactRecords = new List<EnvironmentalImpact__c>();

        for(Pojazd__c vehicle : inListOfDeletedCars){
            newEnvironmentalImpactRecords.add(new EnvironmentalImpact__c(
            Marka__c = vehicle.Marka__c,
            moc__c = vehicle.moc__c,
            Model__c = vehicle.Model__c,
            Numer_seryjny__c = vehicle.Numer_seryjny__c,
            spalanie__c = vehicle.spalanie__c,
            Norma__c = vehicle.Telemetria__r.Norma__c,
            warto__c = vehicle.Telemetria__r.warto__c,
            wiek_pojazdu__c = vehicle.Telemetria__r.wiek_pojazdu__c
            ));
        }
        insert newEnvironmentalImpactRecords;
    }
}
