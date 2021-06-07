/**
 *
 * @author  <piotr.kazimierski@accenture.com>
 * @date  07.06.2021
 * @description Returns list of all Accounts in response to GET request
 * @return List<Account>
 */

 @RestResource(urlMapping='/v1/getAccounts/')

public with sharing class GetAccounts {

    @HttpGet
    global static List<Account> getAccounts(){
        RestRequest accountRequest = RestContext.request;
        List<Account> accountList = [SELECT Id, Name FROM Account];
        return accountList;
    }

}
