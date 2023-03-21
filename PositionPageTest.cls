@isTest 
private class PositionPageTest {

@testSetup
    static void createTestData() {
        if ([SELECT COUNT() FROM Position__c] == 0) {

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
}
   
@isTest
    static void testConstructor() {
    PositionPage page = new PositionPage();

    Integer expectedPositionsCount = 2;
        System.assertEquals(expectedPositionsCount, page.positions.size());
        Set<String> expectedPositionNames = new Set<String>{'Position 1', 'Position 2'};
        for (Position__c positions : page.positions) {
            System.assert(expectedPositionNames.contains(positions.Name));
        }
    System.assertEquals(0, page.numFiltered);
}

@isTest
    static void testFilterPositions() {
    PositionPage page = new PositionPage();

    page.selectedStatus = 'Open';
    page.filterPositions();
    page.selectedStatus = 'Closed';
    page.filterPositions();
    page.selectedStatus = null;
    page.filterPositions();
    }
    
@isTest
    static void testSavePositions() {

PositionPage page = new PositionPage();
page.selectedStatus = 'New Status';
    
    Test.startTest();
    page.savePositions();
    Test.stopTest();

    List<Position__c> updatedPositions = [
        SELECT Name, Status__c
        FROM Position__c
        ];

        for (Position__c position: updatedPositions) {
        System.assertEquals('New Status', position.Status__c);
    }

    List<ApexPages.Message> messages = ApexPages.getMessages();
    System.assertEquals(1, messages.size());
    ApexPages.Message message = messages[0];
    System.assertEquals(ApexPages.Severity.INFO, message.getSeverity());
    System.assertEquals('Position saved successfully.', message.getDetail());
}
    }