@isTest 
private class PositionPageTest {

	@testSetup
    static void createTestData() {

    	Account company = new Account(Name = 'Acme');
    	insert company;

    	Position__c positionOpen = new Position__c(
        	Name = 'Position 1', 	
        	Status__c = 'Open', 
        	Open_Date__c = Date.today(), 
        	Min_Pay__c = 1000, 
        	Max_Pay__c = 2000,
        	Location__c = 'Poltava', 
        	Company__c = company.Id, 
        	Title__c = 'Manager'
    	);
        
    	Position__c positionClosed = new Position__c(
            Name = 'Position 2',
            Status__c = 'Closed',
            Open_Date__c = Date.today().addDays(-25), 
            Closed_Date__c = Date.today().addDays(-25), 
            Min_Pay__c = 1500, Max_Pay__c = 3000, 
            Location__c = 'Kharkiv', 
            Company__c = company.Id, 
            Title__c = 'Manager'
        );
    
    	insert new List<Position__c>{positionOpen, positionClosed};	

	}

	@isTest
    static void testConstructor() {
        
        Test.startTest();
    	PositionPage page = new PositionPage();
        Test.stopTest();

        System.assertEquals(2, page.positions.size());

        Set<String> expectedPositionNames = new Set<String>{'Position 1', 'Position 2'};
        for (Position__c position : page.positions) {
            System.assert(expectedPositionNames.contains(position.Name));
        }
        
    	System.assertEquals(0, page.numFiltered);
	}

	@isTest
    static void testFilterPositions() {
    	Test.startTest();
        List<Position__c> positionsList = [SELECT Name, Status__c FROM Position__c WHERE Status__c = 'Open'];
        PositionPage page = new PositionPage();
        page.positions = positionsList;
		page.selectedStatus = 'Open';
    	page.filterPositions();
        Test.stopTest();
        
        Integer expectedSize = positionsList.size();
        System.assertEquals(expectedSize, page.positions.size());    
    }

    
	@isTest
   static void testSavePositions() {

		PositionPage page = new PositionPage();
        for (Position__c position : page.positions) {
            position.Status__c = 'Canceled';
        }

    	Test.startTest();
    	page.savePositions();
    	Test.stopTest();

    	List<Position__c> updatedPositions = [SELECT Status__c FROM Position__c];

        for (Position__c position: updatedPositions) {
        	System.assertEquals('Canceled', position.Status__c);
    	}
	}
}
