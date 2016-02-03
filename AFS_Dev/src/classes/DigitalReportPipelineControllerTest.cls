/**
 * Class Name: DigitalReportPipelineControllerTest
 * @author: Lhea Valencia
 * Date: 04/17/2015
 * Test Class for DigitalReportPipelineController
 */
@isTest(SeeAllData=false)
public class DigitalReportPipelineControllerTest {

static testMethod void testReportPipeline() {

    //Id opportunityId = null;
    //Id accountId = null;
    //list<Opportunity> opp = new list<Opportunity>();
    //list<Opportunity> oppError = new list<Opportunity>();
    //final String accountName = 'Sample Test Account';

    //List<PriceBookEntry> priceBookEntries = new List<PriceBookEntry>{};
    //Map<String, Id> priceBookEntryMap = new Map<String, Id>{};
  
        Profile p = [select id from profile where name='System Administrator' limit 1];
        User u = new User();
        u.alias = 'userTest';
        u.email='user1@sample.com';
        u.emailencodingkey='UTF-8';
        u.lastname='Test';
        u.languagelocalekey='en_US';   
        u.localesidkey='en_US';
        u.profileid = p.Id;
        u.timezonesidkey='America/Los_Angeles';
        u.username='user1@sample.com.dev';
        database.insert(u,true);
        System.assertNotEquals(null, u.Id);
        
        //for (PriceBookEntry entry :[SELECT Id, Name FROM PriceBookEntry WHERE Name IN :priceBookEntryNames AND Pricebook2.IsStandard = true]) {
        //    priceBookEntryMap.put(entry.Name, entry.Id);
       // }
        
        RecordType clientRecType = [Select Id FROM RecordType WHERE Name = 'Client' LIMIT 1];
      
        Account testAcc  = new Account();
        testAcc.RecordTypeId = clientRecType.Id;
        testAcc.name = 'Test data Account';
        testAcc.Status__c = 'Active';
        testAcc.Type = 'Client';
        testAcc.Client_Account_Lead__c = u.id; 
        testAcc.Client_Classification__c = 'Diamond'; 
        database.insert(testAcc,true);
        //accountid = testAcc.id;

        //List<Pricebook2> standardPb = [select id, name, isActive from Pricebook2 where IsStandard = true limit 1];
        //List<Pricebook2> standardPb = new List<Pricebook2>();        
        //standardPb = [select id, name, isActive from Pricebook2 where IsStandard = true limit 1];
        /*
        * - Test PriceBook
        */  
        
        Pricebook2 testPricebook = new Pricebook2();
        testPricebook.Name = 'SI - CostPlus';
        testPricebook.Description = 'Test Pricebook Entry 1';
        testPricebook.isActive = true;
        
        database.insert(testPricebook, True);
        
        
        /*
        * - Test Products
        */  
        
        Product2 testProduct = new Product2();
        testProduct.Name = 'SI - CostPlus';
        testProduct.IsActive = true;
        testProduct.Target_OI__c = 10.4;
        testProduct.Type_of_Work__c = 'Consulting';
        testProduct.Type__c = 'SI';
        
        database.insert(testProduct, True);
        
        Product2 testProduct2 = new Product2();
        testProduct2.Name = 'SI - CostPlus';
        testProduct2.IsActive = true;
        testProduct2.Target_OI__c = 10.4;
        testProduct2.Type_of_Work__c = 'Consulting';
        testProduct2.Type__c = 'SI';
        
        database.insert(testProduct2, True);
        //recordProd = testProduct2;
        
        /*
        * - Test PriceBook Entry
        */
        
        PricebookEntry testPricebookEntry = new PricebookEntry();
        testPricebookEntry.Product2ID = testProduct.id;
        testPricebookEntry.Pricebook2ID = Test.getStandardPricebookId();
        testPricebookEntry.UnitPrice = 100;
        testPricebookEntry.isActive = true;
        
        database.insert(testPricebookEntry, True);      
        
        Person__c testPerson = new Person__c(
            Name='Test name',
            email__c='test@email.com',
            user_type__c='AFS'
        ); 
        database.insert(testPerson,true);

        //Test.startTest();
    
        Opportunity testOpp = new Opportunity();
        testOpp.Name = 'Opportunity Test Class Zero';
        testOpp.AccountId = testAcc.Id; //'001q0000006jVaf';
        testOpp.Source__c = 'Salesforce';
        testOpp.STATUS_STAGE_REQUESTED__C = '0';
        testOpp.Proposal_Submission_Date__c=System.today() + 4;
        testOpp.Draft_RFP_Release_Date__c=System.today() + 2;
        testOpp.Actual_Contract_Sign_Date__c=System.today() + 20;
        testOpp.RFP_RELEASE_DATE__C = System.today() + 3;
        testOpp.CLOSEDATE = System.today() + 115; 
        testOpp.REPORTING_STATUS_SINCE__C = System.today() - 30; 
        testOpp.TYPE = 'Competitive';
        testOpp.STAGENAME = '0';
        testOpp.APPROVED_STATUS_STAGE__C = '0';
        testOpp.REPORTING_STATUS__C = 'Unqualified';
        testOpp.Consulting_Start__c  = System.today() + 120; 
        testOpp.Consulting_End__c = System.today() + 210;   
        testOpp.Outsourcing_Start__c = System.today() + 150; 
        testOpp.Outsourcing_End__c  = System.today() + 240; 
        testOpp.Hierarchy_Level__c = 'Standalone';
        testOpp.Probability = 0.1;
        testOpp.PoC_Responsible__c = testPerson.id;
        testOpp.Sales_Committed_for_First_Year__c = 2344;
        database.insert(testOpp,true);
        
        testOpp.STATUS_STAGE_REQUESTED__C = '1A';
        testOpp.Best_Probable_Worst__c = 'Probable Win';
        testOpp.Client_Industry_Area_of_Service__c = 'None Apply';
        testOpp.Complexity_Category__c = 'CB: Cross border client contract';
        testOpp.Export_Transfer_of_Products_Software__c  = 'No';
        testOpp.Hierarchy_Level__c = 'Contract Vehicle';
        testOpp.Industry_Sub_Segment__c  = 'D&PS OTHER';
        testOpp.ONCONUS_Work_Required__c  = 'Yes';
        testOpp.Primary_Function__c  = 'Business Process Outsourcing';
        testOpp.Is_AFS_Prime_or_Subcontractor__c = 'Prime';
        testOpp.Proposal_Submission_Date__c = System.today() + 10;
        testOpp.RFP_Release_Date__c = System.today() + 5;
        testOpp.The_Opportunity_involves_activities_now__c = 'No';
        testOpp.Subject_countries_client_operates__c = 'None Apply';
        testOpp.Win_Probability__c = '50';
    	
    	database.update(testOpp, true);
    
        Opportunity_Team_Roles__c testOppTR = new Opportunity_Team_Roles__c();
        testOppTR.Opportunity_Name__c = testOpp.Id;
        testOppTR.Name__c = testPerson.id;
        testOppTR.Role__c = 'Opportunity Director';
        testOppTR.Opportunity_Access__c = 'Read Only';
        testOppTR.Sales_Credit__c= 2;
        database.insert(testOppTR,True);
        
        Opportunity_Team_Roles__c testOppTR2 = new Opportunity_Team_Roles__c();
        testOppTR2.Opportunity_Name__c = testOpp.Id;
        testOppTR2.Name__c = testPerson.id;
        testOppTR2.Role__c = 'Opportunity QA Director';
        testOppTR2.Opportunity_Access__c = 'Read Only';
        testOppTR.Sales_Credit__c= 0;
        database.insert(testOppTR2,True);        
        
        Opportunity testOpp1 = new Opportunity();
        testOpp1.id = testOpp.Id;
        testOpp.Source__c = 'Salesforce';
        testOpp1.STATUS_STAGE_REQUESTED__C = '1A';
        testOpp1.Best_Probable_Worst__c = 'Probable Win';
        testOpp1.Client_Industry_Area_of_Service__c = 'None Apply';
        testOpp1.Complexity_Category__c = 'CB: Cross border client contract';
        testOpp1.Export_Transfer_of_Products_Software__c  = 'No';
        testOpp1.Hierarchy_Level__c = 'Contract Vehicle';
        testOpp1.Industry_Sub_Segment__c  = 'D&PS OTHER';
        testOpp1.ONCONUS_Work_Required__c  = 'Yes';
        testOpp1.Primary_Function__c  = 'Business Process Outsourcing';
        testOpp1.Is_AFS_Prime_or_Subcontractor__c = 'Prime';
        testOpp1.Proposal_Submission_Date__c = System.today() + 10;
        testOpp1.RFP_Release_Date__c = System.today() + 5;
        testOpp1.The_Opportunity_involves_activities_now__c = 'No';
        testOpp1.Subject_countries_client_operates__c = 'None Apply';
        testOpp1.Win_Probability__c = '50';
        
        database.update(testOpp1,false);
        
        List<OpportunityLineItem> listOppItem = new List<OpportunityLineItem>();
        
        OpportunityLineItem testOppLI1 = new OpportunityLineItem();
        testOppLI1.OpportunityId = testOpp.id;
        //testOppLI1.PriceBookEntryId = priceBookEntryMap.get('AO - CostPlus');
        testOppLI1.PriceBookEntryId = testPricebookEntry.Id;
        testOppLI1.Revenue__c = 1000000;
        testOppLI1.Total_Costs__c = 100;
        testOppLI1.Type__c ='01 - AO';
        database.insert(testOppLI1,True);
        
        OpportunityLineItem testOppLI2 = new OpportunityLineItem();
        testOppLI2.OpportunityId = testOpp.id;
        //testOppLI2.PriceBookEntryId = priceBookEntryMap.get('MC - CostPlus');
        testOppLI2.PriceBookEntryId = testPricebookEntry.Id;
        testOppLI2.Revenue__c = 1000000;
        testOppLI2.Total_Costs__c = 100;
        testOppLI2.HW_SW_Costs__c = 0;
        testOppLI2.Type__c ='04 - MC';
        database.insert(testOppLI2,True);

        List<Attribute__c> testAtts = new List<Attribute__c>();
    
        Attribute__c testAtt1 = new Attribute__c (Opportunity_Name__c = testOpp.Id,    
        Attribute_Type__c = 'Accenture Digital',
        Attribute_Value__c = 'Analytics',
        AttributePercent__c = 20);
        
        testAtts.add(testAtt1);

        Attribute__c testAtt2 = new Attribute__c (Opportunity_Name__c = testOpp.Id,    
        Attribute_Type__c = 'Accenture Digital',
        Attribute_Value__c = 'Interactive',
        AttributePercent__c = 20);   
    
        testAtts.add(testAtt2);

        Attribute__c testAtt3 = new Attribute__c (Opportunity_Name__c = testOpp.Id,    
        Attribute_Type__c = 'Accenture Digital',
        Attribute_Value__c = 'Mobility',
        AttributePercent__c = 20);      
    
        testAtts.add(testAtt3);
        Database.insert(testAtts,false);
        System.debug('<<<<<<<<<value of attribute>>>>' + testAtt3);
        
        Test.startTest();
    
        PageReference pageRef = Page.DigitalReportPipeline;
        Test.setCurrentPage(pageRef);
        
        DigitalReportPipelineController controller = new DigitalReportPipelineController();
        //List <chartData> testMyChartData = controller.getChartData();
        //List <chartData> testMyChartData = controller.getData();
        //Data[] testMyChartData = controller.getChartData();       
        pageReference VFPageData = controller.prepareVFPageData();
        pageReference proceedToReportLink = controller.goToReportLink();
        controller.getData();
        controller.getChartData();
    
        Test.stopTest();
        

        
}
}