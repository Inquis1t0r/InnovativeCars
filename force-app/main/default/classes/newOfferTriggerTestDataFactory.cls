/**
 *
 * @author  <piotr.kazimierski@accenture.com>
 * @date  24.05.2021
 * @description generates data for testing purposes 
 */
public class newOfferTriggerTestDataFactory {

    public static Account createTestAccount(){
        Account account = new Account(Name = 'Car dealer for testing');
        insert account;
        return account;
    }

    public static Salon__c createTestSalon(Account account, Integer numberOfGeneratedOffers){
        Salon__c newSalon = new Salon__c(Name = 'test Salon', Account__c = account.id, Liczba_miejsc__c = numberOfGeneratedOffers, Strona_internetowa__c = 'https://www.google.com/', Salon_adres__c = 'test adress');
        insert newSalon;
        return newSalon;
    }

    public static List<Oferta__c> generateTestOffers(Integer numberOfGeneratedOffers, Boolean exceedLimits) {
        Integer numberOfTestEntities = numberOfGeneratedOffers;
        Account account = createTestAccount();
        Salon__c newSalon = createTestSalon(account, numberOfGeneratedOffers);

        if(exceedLimits = False){
            numberOfTestEntities = numberOfGeneratedOffers/2;
        }else{
            numberOfTestEntities = numberOfGeneratedOffers + 20;
        }

        List<Pojazd__c> newVehicles = new List<Pojazd__c>();
        for(Integer i = numberOfTestEntities; i >= 0; i--){
            newVehicles.add(new Pojazd__c (Name = 'Test ' + i, Numer_seryjny__c = 'testSN' + i, Account__c = account.id, Cena__c = 100, Marka__c = 'test', Model__c = 'asdf', Salon__c = newSalon.id));
        }
        insert newVehicles;

        List<Oferta__c> newOffers = new List<Oferta__c>();
        for(Pojazd__c vehicle : newVehicles){
            newOffers.add(new Oferta__c(Pojazd__c = vehicle.id, Salon__c = newSalon.id, Oferta_fizyczna__c = true));
        }
        insert newOffers;

        return newOffers;
    }

    public static List<Oferta__c> generateDuplicateVehicleOffers(Integer numberOfGeneratedOffers ){
        Integer numberOfTestEntities = numberOfGeneratedOffers;
        Account account = createTestAccount();
        Salon__c newSalon = createTestSalon(account, numberOfGeneratedOffers);

        List<Pojazd__c> newVehicles = new List<Pojazd__c>();
        for(Integer i = numberOfTestEntities; i >= 0; i--){
            newVehicles.add(new Pojazd__c (Name = 'Test ' + i, Numer_seryjny__c = 'testSN' + i, Account__c = account.id, Cena__c = 100, Marka__c = 'test', Model__c = 'asdf', Salon__c = newSalon.id));
        }
        insert newVehicles;

        List<Oferta__c> newOffers = new List<Oferta__c>();
        for(Pojazd__c vehicle : newVehicles){
            newOffers.add(new Oferta__c(Pojazd__c = vehicle.id, Salon__c = newSalon.id, Oferta_fizyczna__c = true));
        }
        insert newOffers;
        return newOffers;

        

    }
}
