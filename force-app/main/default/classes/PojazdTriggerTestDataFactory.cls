/**
 *
 * @author  <piotr.kazimierski@accenture.com>
 * @date  26.05.2021
 * @description Test data factory for PojazdTriggerTest
 */

public class PojazdTriggerTestDataFactory {

    //TODO: Extract somewhere
    public static final String testAccountName = 'Test Account'; 
    public static final String testSalonName = 'Test Salon';
    public static final String testSalonStatus = 'Otwarty';
    public static final String testSalonTyp = 'samochody osobowe';
    public static final Integer testSalonCapacity = 9999;
    public static final String testSalonStronaInternetowa = 'https://www.google.com';
    public static final String testSalonAddress = 'Ul. Testowa 14, 13-370 Testowice';
    public static final String testVehicleName = 'Test Vehicle';
    public static final Decimal testVehiclePrice = 99;
    public static final String testVehicleBrand = 'Ford';
    public static final String testVehicleModel = 'Mustang';
    public static final String testVehiclePower = '450';
    public static final String testVehicleCombustion = '11,5';
    public static final String testVehicleSN = '965212';
    public static final String testVehicleGenre = 'sportowe';
    public static final String testVehicleStatus = 'nowy';
    public static final Account testAccount = addTestAccount();
    public static final Salon__c testSalon = addTestSalon();
    public static final Boolean testTelemetryNormValue = true;

    public static List<Pojazd__c> addTestVehicles(Integer numberOfTestRecords){
        List<Pojazd__c> testVehicles = new List<Pojazd__c>();
        for(Integer i = 0; i < numberOfTestRecords; i++){
            testVehicles.add(new Pojazd__c(
                Name = testVehicleName + i,
                Account__c = testAccount.Id,
                Salon__c = testSalon.Id,
                Cena__c = testVehiclePrice,
                Marka__c = testVehicleBrand,
                moc__c = testVehiclePower,
                Model__c = testVehicleModel,
                Numer_seryjny__c = testVehicleSN + 1,
                Rodzaj__c = testVehicleGenre,
                Stan__c = testVehicleStatus
            ));
        }
        insert testVehicles;
        return testVehicles;
    }

    public static Account addTestAccount(){
        Account acc = new Account(Name = testAccountName);
        insert acc;
        return acc;
    }

    public static Salon__c addTestSalon(){
        Salon__c testSalon = new Salon__c(Name = testSalonName, Liczba_miejsc__c = testSalonCapacity, Salon_adres__c = testSalonAddress, Status_salonu__c = testSalonStatus, Typ__c = testSalonTyp, Strona_internetowa__c = testSalonStronaInternetowa, Account__c = testAccount.Id);
        insert testSalon;
        return testSalon;
    }

    public static void addTestPojazdEntitiesWithTelemetry(Integer numberOfTestRecords){

        List<Pojazd__c> testVehicles = addTestVehicles(numberOfTestRecords);
        List<EnvironmentalImpact__c> testTelemetryData = new List<EnvironmentalImpact__c>();
        for(Pojazd__c vehicle : testVehicles){
            testTelemetryData.add(new EnvironmentalImpact__c(
                Marka__c = vehicle.Marka__c,
                moc__c = vehicle.moc__c,
                Model__c = vehicle.Model__c,
                Numer_seryjny__c = vehicle.Numer_seryjny__c,
                spalanie__c = vehicle.spalanie__c,
                Norma__c = testTelemetryNormValue,
                warto__c = testVehiclePrice,
                wiek_pojazdu__c = String.valueOf(testVehicleBrand.length())
            ));
        }
    }
}
