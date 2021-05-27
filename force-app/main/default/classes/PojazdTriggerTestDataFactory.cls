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
    public static final String testVehicleSN = '965212';
    public static final String testVehicleGenre = 'sportowe';
    public static final String testVehicleStatus = 'nowy';
    public static final Account testAccount = addTestAccount();
    public static final Salon__c testSalon = addTestSalon();

    public static void addTestVehicles(Integer numberOfTestRecords){
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


        //TODO EnvironmentalImpact__c factory
    }
}
