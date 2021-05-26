/**
*
* @author Piotr Kazimierski <piotr.kazimierski@accenture.com>
* @date	21.05.2021
* @description	Trigger for Pojazd__c, for more info check Handler doc
**/

trigger PojazdTrigger on Pojazd__c (before insert, after delete) {

	if(Trigger.isInsert){
		PojazdHandler.freeSlotsCheck(Trigger.new);
	}
	if(Trigger.isDelete){
		//TODO
	}
	
}