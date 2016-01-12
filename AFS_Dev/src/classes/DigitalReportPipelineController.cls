public class DigitalReportPipelineController {

    public static Decimal opportunityTotalCurrency {get;set;}
    public static Decimal accentureTotalCurrency = 0;  
    public static Decimal accentureTotalPercentage {get;set;}
    public static Decimal otherTotalPercentage = 0;       
    public List<chartData> getData() 
    {
        return getChartData();
    } 
    
    public List<Attribute__c> digitalPipeline {get; set;}
    public List<Attribute__c> nonDigitalPipeline {get; set;}
    public Integer digitalSize {get; set;}
    public Integer nonDigitalSize {get; set;}
    public String digitalSum {get; set;}
    public String nonDigitalSum {get; set;}
    
    List<chartData> chartSource {get;set;}
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
        SELECT Id FROM Opportunity WHERE  Reporting_Status__c = 'Qualified'  
        ]);
        
        //try{
        totalOppTCR =[SELECT SUM(Total_Current_Revenue__c) totalOppTCR FROM Opportunity WHERE Id IN: allOpportunities];
        totalAccentureTCR = [SELECT SUM(Accenture_Digital_TCR__c) totalAccentureTCR FROM Attribute__c WHERE Opportunity_Name__c IN:
                            allOpportunities AND Attribute_Type__c = 'Accenture Digital'];
        totalInteractiveTCR = [SELECT SUM(Accenture_Digital_TCR__c) totalInteractiveTCR FROM Attribute__c WHERE Opportunity_Name__c IN:
                                allOpportunities AND Attribute_Type__c = 'Accenture Digital' AND Attribute_Value__c = 'Interactive' ];
                                
        totalAnalyticsTCR = [SELECT SUM(Accenture_Digital_TCR__c) totalAnalyticsTCR FROM Attribute__c WHERE Opportunity_Name__c IN:
                                allOpportunities AND Attribute_Type__c = 'Accenture Digital' AND Attribute_Value__c = 'Analytics' ];
        totalMobilityTCR = [SELECT SUM(Accenture_Digital_TCR__c) totalMobilityTCR FROM Attribute__c WHERE Opportunity_Name__c IN:
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
    
    public PageReference getReport() {
        Opportunity[] allOpportunities = new List<Opportunity>([
        SELECT Id FROM Opportunity WHERE  Reporting_Status__c = 'Qualified'  
        ]);
        
        
        digitalPipeline = new List<Attribute__c>();
        nonDigitalPipeline = new List<Attribute__c>();
        Decimal dSum = 0;
        Decimal ndSum = 0;
        for(Attribute__c attribute : [SELECT Opportunity_Name__c, Attribute_Type__c, Attribute_Value__c, Attribute_TCR__c, AttributePercent__c FROM Attribute__c WHERE Opportunity_Name__c IN :allOpportunities]){
            
            Decimal tcr = 0;
            if(attribute.Attribute_TCR__c != null){
                tcr = attribute.Attribute_TCR__c;
            }
            
            if(attribute.Attribute_Type__c.equals('Accenture Digital')){
                digitalPipeline.add(attribute);
                dSum += tcr;
            }
            else{
                nonDigitalPipeline.add(attribute);
                ndSum += tcr;
            }
        }
        
        digitalSize = digitalPipeline.size();
        nonDigitalSize = nonDigitalPipeline.size();
        return null;
    }
    
    public pagereference goToReport(){
        PageReference pageRef = new PageReference('/00OJ0000000POAa');
        pageRef.setRedirect(true);
        return null;
    }
    
    public pagereference goToReportLink(){
        PageReference pageRef = new PageReference('/00OJ0000000POAa');
        pageRef.setRedirect(false);
        return pageRef;
    }
    

}