/**
*
* @author Piotr Kazimierski <piotr.kazimierski@accenture.com>
* @date	21.05.2021
* @description	Trigger for Pojazd__c, for more info check Handler doc
**/

trigger newPojazdTrigger on Pojazd__c (before insert) {
	newPojazdHandler.freeSlotsCheck(Trigger.new);
}