/**
 *
 * @author  <piotr.kazimierski@accenture.com>
 * @date  14.06.2021
 * @description Pojazd__c REST Callout
 */

global with sharing class VehicleWrapper {
    public String Id;
    public String Name;
    public String Marka__c;
    public String Model__c;
    public String Numer_seryjny__c;

    global static VehicleWrapper parse(String json) {
        return (VehicleWrapper) System.JSON.deserialize(json, VehicleWrapper.class);
    }
}
