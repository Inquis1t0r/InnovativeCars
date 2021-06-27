/**
 *
 * @author  <piotr.kazimierski@accenture.com>
 * @date  26.05.2021
 * @description Test data factory for PojazdTriggerTest
 */

@isTest
public class PojazdTriggerTestDataFactory {

    /*
    * @param inNumberOfTestRecords -> number of test Pojazd__c records
    * @return new List<Pojazd__c>
    */
    public static List<Pojazd__c> addTestVehicles(Integer inNumberOfTestRecords){
        
        Account acc = addTestAccount();
        Salon__c salon = addTestSalon();
        List<Pojazd__c> testVehicles = new List<Pojazd__c>();
        for(Integer i = 0; i < inNumberOfTestRecords; i++){
            testVehicles.add(new Pojazd__c(
                Name = Constants.testVehicleName + i,
                Account__c = acc.Id,
                Salon__c = salon.Id,
                Cena__c = Constants.testVehiclePrice,
                Marka__c = Constants.testVehicleBrand,
                moc__c = Constants.testVehiclePower,
                Model__c = Constants.testVehicleModel,
                Numer_seryjny__c = Constants.testVehicleSN + 1,
                Rodzaj__c = Constants.testVehicleGenre,
                Stan__c = Constants.testVehicleStatus,
                spalanie__c = Constants.testVehicleCombustion
            ));
        }

        return testVehicles;
    }

    /*
    * @return new Account instance
    */
    public static Account addTestAccount(){
        Account acc = new Account(Name = Constants.testAccountName);
        insert acc;
        return acc;
    }

    /*
    * @return new Salon instance
    */
    public static Salon__c addTestSalon(){
        Account acc = PojazdTriggerTestDataFactory.addTestAccount();

        Salon__c testSalon = new Salon__c(Name = Constants.testSalonName, Liczba_miejsc__c = Constants.testSalonCapacity, Salon_adres__c = Constants.testSalonAddress, Status_salonu__c = Constants.testSalonStatus, Typ__c = Constants.testSalonTyp, Strona_internetowa__c = Constants.testSalonStronaInternetowa, Account__c = acc.Id);
        insert testSalon;
        return testSalon;
    }

    /*
    * @description Creates List<Pojazd__c> testVehicles with associated List<EnvironmentalImpact__c> testTelemetryData
    * @param account -> Account that will be associated with test Salon
    * @param inNumberOfTestRecords -> Number of testVehicles created 
    * @return void
    */
    public static void addTestPojazdEntitiesWithTelemetry(Integer inNumberOfTestRecords){

        List<Pojazd__c> testVehicles = addTestVehicles(inNumberOfTestRecords);
        insert testVehicles;
        List<EnvironmentalImpact__c> testTelemetryData = new List<EnvironmentalImpact__c>();
        for(Pojazd__c vehicle : testVehicles){
            testTelemetryData.add(new EnvironmentalImpact__c(
                Marka__c = vehicle.Marka__c,
                moc__c = vehicle.moc__c,
                Model__c = vehicle.Model__c,
                Numer_seryjny__c = vehicle.Numer_seryjny__c,
                spalanie__c = vehicle.spalanie__c,
                Norma__c = Constants.testTelemetryNormValue,
                warto__c = Constants.testVehiclePrice,
                wiek_pojazdu__c = String.valueOf(Constants.testVehicleBrand.length())
            ));
        }
        insert testTelemetryData;
    }
}
