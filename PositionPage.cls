public with sharing class PositionPage {

    public Boolean isFiltered {get; set;}
    public Integer numFiltered {get; set;}
    public String selectedStatus {get; set;}
    public List<Position__c> positions {get; set;}
    public List<SelectOption> statusOptions {get; set;}

    public PositionPage() {
        this.clearFilter();
        this.initFilterOptions();
    }
    
    public void filterPositions() {
        if (selectedStatus != null && selectedStatus != 'All') {
            this.applyFilter();
        } else {
            this.clearFilter();
        }
    }
    
    public void savePositions() {
        try {
            update this.positions;
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO, 'Position saved successfully.'));
        } catch(Exception e) {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Error saving position: ' + e.getMessage()));
        }
    }

    private void initFilterOptions() {
        List<SelectOption> options = new List<SelectOption>();
        options.add(new SelectOption('All', 'All'));
        Schema.DescribeFieldResult fieldResult = Position__c.Status__c.getDescribe();
        List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
        for (Schema.PicklistEntry picklistValues : ple) {
            options.add(new SelectOption(picklistValues.getValue(), picklistValues.getLabel()));
        }
        this.statusOptions = options;
    }

    private void clearFilter() {
        this.positions = this.getAllPositions();
        this.isFiltered = false;
        this.numFiltered = 0;
    }

    private void applyFilter() {
        this.positions = this.getPositionsByFilter();
        this.numFiltered = this.positions.size();
        this.isFiltered = true;
    }

    private List<Position__c> getAllPositions() {
        return [SELECT Name, 
                		Status__c, 
                		Open_Date__c,
                		Closed_Date__c, 
                		Min_Pay__c, 
                		Max_Pay__c, 
                		Location__c
                FROM Position__c
     	];
    }

    private List<Position__c> getPositionsByFilter() {
        return [SELECT Name, 
                		Status__c, 
                		Open_Date__c,
                		Closed_Date__c, 
                		Min_Pay__c, 
                		Max_Pay__c, 
                		Location__c
                FROM Position__c
                WHERE Status__c = :this.selectedStatus
     	];
    }
}