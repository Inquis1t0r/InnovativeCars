@isTest
public class SalonTriggerHandlerTest {

    //WAREHOUSE_ID

    @isTest
    public static void shouldMoveAllVehiclesFromClosedSalonToWarehouse(){
        //given
        Account account = OfferTriggerTestDataFactory.createTestAccount();

        Salon__c salon = OfferTriggerTestDataFactory.createTestSalon(account, 2);
        insert salon;

        Pojazd__c veh1 = OfferTriggerTestDataFactory.createSingleVehicle();
        insert veh1;

        Pojazd__c veh2 = OfferTriggerTestDataFactory.createSingleVehicle();
        insert veh2;

        id warehouse = WAREHOUSE_ID;

        //when

        //then



    }
}
