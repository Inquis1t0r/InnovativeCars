/**
 *
 * @author  <piotr.kazimierski@accenture.com>
 * @date  24.05.2021
 * @description generates data for testing purposes 
 */
public class OfferTriggerTestDataFactory {

    public static Account createTestAccount(){
        Account account = new Account(Name = 'Car dealer for testing');
        insert account;
        return account;
    }

    /*
    * @param account -> Account that will be associated with test Salon
    * @param numberOfGeneratedOffers -> Number of free slots inside test Salon
    * @return new Salon instance
    */
    public static Salon__c createTestSalon(Account account, Integer numberOfGeneratedOffers){
        Salon__c newSalon = new Salon__c(Name = 'test Salon', Account__c = account.id, Liczba_miejsc__c = numberOfGeneratedOffers, Strona_internetowa__c = 'https://www.google.com/', Salon_adres__c = 'test adress');
        return newSalon;
    }

    /*
    * @param account -> Account that will be associated with test Salon
    * @param numberOfGeneratedOffers -> Number of free slots inside test Salon
    * @param Status -> Status of created salon instance
    * @return new Salon instance
    */
    public static Salon__c createTestSalon(Account account, Integer numberOfGeneratedOffers, String Status){
        Salon__c newSalon = new Salon__c(Name = 'test Salon', Account__c = account.id, Liczba_miejsc__c = numberOfGeneratedOffers, Strona_internetowa__c = 'https://www.google.com/', Salon_adres__c = 'test adress', Status_salonu__c = status);
        return newSalon;
    }

    /*
    * @param vehicleName -> Name of single vehicle instance that will be created
    * @param serialNumber -> SN of single vehicle instance that will be created
    * @param testSalon -> Salon__c related to created vehicle instance
    * @param account -> Account that will be associated with created vehicle instance
    * @param Status -> Status of created salon instance
    * @return new Vehicle (Pojazd__c) instance
    */
    public static Pojazd__c createSingleVehicle(String vehicleName, String serialNumber, Salon__c testSalon, Account account){
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

    /*
    * @param name -> Name of offer instance
    * @param salon -> Salon related to offer instance
    * @param testSalon -> Salon__c related to created vehicle instance
    * @param vehicle -> Vehicle that will be associated with created offer instance
    * @param isPhysical -> Bollean value indicating if vehicle is physicaly avaliable inside related salon
    * @return new Offer__c instance
    */
    public static Oferta__c createSingleOffer(String name, Salon__c salon, Pojazd__c vehicle, Boolean isPhysical){
        Oferta__c offer = new Oferta__c(
            Name = name,
            Salon__c = salon.Id,
            Pojazd__c = vehicle.Id,
            Oferta_fizyczna__c = isPhysical
        );
        return offer;
    }

}
