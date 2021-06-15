/**
 *
 * @author  <piotr.kazimierski@accenture.com>
 * @date  07.06.2021
 * @description Accounts REST Callout
 */

@RestResource(urlMapping='/v1/GetAccountSalons/*')

/**
 *
 * @author  <piotr.kazimierski@accenture.com>
 * @date  07.06.2021
 * @description Returns list of all Accounts in response to GET request
 * @return List<Account>
 */
global with sharing class GetAccountSalons {
    
    @HttpGet
    global static List<Salon__c> getAccounts(){
        RestRequest accountSalonsRequest = RestContext.request;
        String AccountId = accountSalonsRequest.params.get('Id');
        List<Salon__c> salonsList = new List<Salon__c>([SELECT Id, Name FROM Salon__c WHERE Account__c = :AccountId]);
        return salonsList;
    }

}
