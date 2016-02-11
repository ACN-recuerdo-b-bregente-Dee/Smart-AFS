/**
   @Author Lhea Valencia
   @name DigitalReportPipelineController
   @CreateDate 11/26/2015
   @Description This class will be utilized as controller for the the DigitalReportPipeline  Visualforce Chart 
   @Version <1.0>
   @reference <Referenced program names>
  */
public class DigitalReportPipelineController {

    public static Decimal opportunityTotalCurrency {get;set;}
    public static Decimal accentureTotalCurrency = 0;  
    public static Decimal accentureTotalPercentage {get;set;}
    public static Decimal otherTotalPercentage = 0; 
    
          
    public List<chartData> getData() 
    {
        return getChartData();
    }
    
    public static String reportUrl {get;set;}
    
    List<chartData> chartSource {get;set;}
    
    //This will return the actual data for the chart
    public List<chartData> getChartData(){
        
        chartSource = new List<chartData>();
  

        Decimal opportunityTotalPercentage = 0;
        Decimal otherTotalCurrency = 0;
        //Decimal otherTotalPercentage = 0;
        Decimal interactiveTotalCurrency = 0;
        Decimal analyticsTotalCurrency = 0;
        Decimal mobilityTotalCurrency = 0;
        Decimal interactiveTotalPercentage = 0;
        Decimal analyticsTotalPercentage = 0;
        Decimal mobilityTotalPercentage = 0;
        
        AggregateResult[] totalOppTCR;
        AggregateResult[] totalAccentureTCR;
        AggregateResult[] totalInteractiveTCR;
        AggregateResult[] totalAnalyticsTCR;
        AggregateResult[] totalMobilityTCR;
        
        Opportunity[] allOpportunities = new List<Opportunity>([
        SELECT Id FROM Opportunity WHERE  Reporting_Status__c = 'Qualified' AND Portfolio__c != 'Defense - ASM'  
        ]);
        
        //try{
        totalOppTCR =[SELECT SUM(Total_Current_Revenue__c) totalOppTCR FROM Opportunity WHERE Id IN: allOpportunities];
        totalAccentureTCR = [SELECT SUM(Attribute_TCR__c) totalAccentureTCR FROM Attribute__c WHERE Opportunity_Name__c IN:
                            allOpportunities AND Attribute_Type__c = 'Accenture Digital'];
        totalInteractiveTCR = [SELECT SUM(Attribute_TCR__c) totalInteractiveTCR FROM Attribute__c WHERE Opportunity_Name__c IN:
                                allOpportunities AND Attribute_Type__c = 'Accenture Digital' AND Attribute_Value__c = 'Interactive' ];
                                
        totalAnalyticsTCR = [SELECT SUM(Attribute_TCR__c) totalAnalyticsTCR FROM Attribute__c WHERE Opportunity_Name__c IN:
                                allOpportunities AND Attribute_Type__c = 'Accenture Digital' AND Attribute_Value__c = 'Analytics' ];
        totalMobilityTCR = [SELECT SUM(Attribute_TCR__c) totalMobilityTCR FROM Attribute__c WHERE Opportunity_Name__c IN:
                                allOpportunities AND Attribute_Type__c = 'Accenture Digital' AND Attribute_Value__c = 'Mobility' ];                         
        //} catch(Exception e){
        
        
        if(totalOppTCR[0].get('totalOppTCR') != NULL){
            opportunityTotalCurrency = (decimal) totalOppTCR[0].get('totalOppTCR');
        }
        if(totalAccentureTCR[0].get('totalAccentureTCR') != NULL){
            accentureTotalCurrency = (decimal) totalAccentureTCR[0].get('totalAccentureTCR');
            accentureTotalPercentage = (accentureTotalCurrency / opportunityTotalCurrency) * 100;
            otherTotalCurrency = (decimal) opportunityTotalCurrency - accentureTotalCurrency;
            otherTotalPercentage = 100 - accentureTotalPercentage;

        }
        if(totalInteractiveTCR[0].get('totalInteractiveTCR') != NULL){
            interactiveTotalCurrency = (decimal) totalInteractiveTCR[0].get('totalInteractiveTCR'); 
            interactiveTotalPercentage = (interactiveTotalCurrency / accentureTotalCurrency) * accentureTotalPercentage ;  
        }
        if(totalAnalyticsTCR[0].get('totalAnalyticsTCR') != NULL){
            analyticsTotalCurrency = (decimal) totalAnalyticsTCR[0].get('totalAnalyticsTCR');
            analyticsTotalPercentage = (analyticsTotalCurrency / accentureTotalCurrency) * accentureTotalPercentage ;
        }
        if(totalMobilityTCR[0].get('totalMobilityTCR') != NULL ){
            mobilityTotalCurrency = (decimal) totalMobilityTCR[0].get('totalMobilityTCR');
            mobilityTotalPercentage =  (mobilityTotalCurrency / accentureTotalCurrency ) * accentureTotalPercentage ;
        }
        
        
        
        
        //chartSource.add(new chartData('Accenture Digital : '+ accentureTotalPercentage.setScale(2) +'%\n$' + accentureTotalCurrency.format(), accentureTotalCurrency, accentureTotalPercentage.setScale(2)));
        chartSource.add(new chartData('Non-Digital Opp TCR: ' + otherTotalPercentage.setScale(2) +'%\n$' + otherTotalCurrency.format(), otherTotalCurrency, otherTotalPercentage.setScale(2)));
        chartSource.add(new chartData('Interactive: ' + interactiveTotalPercentage.setScale(2) +'%\n$' + interactiveTotalCurrency.format(), interactiveTotalCurrency,interactiveTotalPercentage.setScale(2)));
        chartSource.add(new chartData('Analytics:  ' + analyticsTotalPercentage.setScale(2) +'%\n$' + analyticsTotalCurrency.format(), analyticsTotalCurrency,analyticsTotalPercentage.setScale(2)));
        chartSource.add(new chartData('Mobility:  ' + mobilityTotalPercentage.setScale(2) +'%\n$' + mobilityTotalCurrency.format(), mobilityTotalCurrency,mobilityTotalPercentage.setScale(2)));      
        //}
        
        return chartSource;
    }
    //wrapper class
    public class chartData{
        public string name {get;set;}
        public decimal data {get;set;}
        public decimal dataPercentage {get;set;}
        public Decimal overalTotalCurrency  {get;set;}
        public Decimal accDigitalTotalCurrency {get;set;}
        public Decimal overallTotalPercent {get;set;}
        public decimal accDigitalTotalPercent {get;set;}
        public string formattedOveralTotalCurrency {get;set;}
        public string formatteAccDigitalTotalCurrency {get;set;}
        
        public chartData(string name, decimal data, decimal dataPercentage){
        this.name = name;
        this.data = data;
        this.dataPercentage = dataPercentage;
        this.overalTotalCurrency = opportunityTotalCurrency; 
        this.accDigitalTotalCurrency = accentureTotalCurrency; 
        this.overallTotalPercent = otherTotalPercentage;
        //this.accDigitalTotalPercent = accentureTotalPercentage.setScale(3); 
        this.accDigitalTotalPercent =  Math.round(accentureTotalPercentage* 100) / 100.00;
        this.formattedOveralTotalCurrency = '$' + String.valueOf(overalTotalCurrency.format());
        this.formatteAccDigitalTotalCurrency = '$' + String.valueOf(accentureTotalCurrency.format());
        //this.overalTotalCurrency = String.valueOf(Math.random() * 1000);
        
    }
    }
    
    /*******************************************************************************************************
    * @name prepareVFPageData
    * @description Prepares the data to be used in the VF page
    * @return a null PageReference object
    */
    public PageReference prepareVFPageData() {
        reportUrl = Label.Qualified_Report_Url;
        return null;
    }
    
    
    public pagereference goToReportLink(){
        PageReference pageRef = new PageReference('/00OJ0000000POAa');
        pageRef.setRedirect(false);
        return pageRef;
    }
    

}