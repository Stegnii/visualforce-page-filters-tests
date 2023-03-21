# VisualForce Page with Filters for Position Custom Object

## Overview
The purpose of this project is to create a VisualForce page with filters for a Position Custom Object in Salesforce. This project includes a VisualForce page, an Apex class, and a test class. The VisualForce page allows users to filter Position records by Name, Department, and Status fields. The Apex class handles the logic for the dynamic SOQL queries, while the test class is used to test the functionality of the Apex class.

## Prerequisites
To use this project, you must have the following:
- A Salesforce org with the Position custom object
- Access to create VisualForce pages, Apex classes, and test classes in Salesforce

## Installation
To install and use this project, follow these steps:
1. Clone the repository to your local machine using the command: `git clone https://github.com/Stegnii/visualforce-page-filters-tests.git`
2. Open the Salesforce Developer Console in your org and create a new VisualForce page with the code from the `Positions.page` file in the repository.
3. Create a new Apex class in Salesforce with the code from the `PositionPage.cls` file in the repository.
4. Add the Apex class to the VisualForce page by updating the `controller` attribute in the VisualForce page code to the name of the Apex class.
5. Create a new test class in Salesforce with the code from the `PositionPageTest.cls` file in the repository.
6. Run the test class to ensure that the functionality of the Apex class is working as expected.
7. You need to have the 'Position' custom object in your Salesforce org. Additionally, the 'Position' custom object must contain the 'Status' custom field with the following picklist values: 'Open', 'Closed', 'Scheduled', and 'Canceled'.

## Usage
To use the VisualForce page with filters, follow these steps:
1. Navigate to the VisualForce page in your Salesforce org.
2. Select the filter values for the Status field.
3. Click the Apply Filters button to display the matching Position records.
4. To clear the filters, click the Clear Filters button.

## License
This project is licensed under the MIT License - see the `LICENSE` file for details.

## Acknowledgments
- Thanks to Salesforce! 
