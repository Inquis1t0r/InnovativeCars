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
        return newSalon;
    }

    public static Pojazd__c createVehicle(String vehicleName, String serialNumber, Salon__c testSalon, Account account){
        Pojazd__c vehicle = new Pojazd__c(
            Name = vehicleName, 
            Numer_seryjny__c = serialNumber, 
            Salon__c = testSalon.Id, 
            Cena__c = Constants.testVehiclePrice,
            Account__c = account.Id,
            Marka__c = Constants.testVehicleBrand,
            Model__c = Constants.testVehicleModel
            );
        return vehicle;
    }

    public static Oferta__c createOffer(String name, Salon__c salon, Pojazd__c vehicle, Boolean isPhysical){
        Oferta__c offer = new Oferta__c(
            Name = name,
            Salon__c = salon.Id,
            Pojazd__c = vehicle.Id,
            Oferta_fizyczna__c = isPhysical
        );
        return offer;
    }

}
