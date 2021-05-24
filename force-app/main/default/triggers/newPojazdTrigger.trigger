trigger newPojazdTrigger on Pojazd__c (before insert) {
	newPojazdHandler.freeSlotsCheck(Trigger.new);
}