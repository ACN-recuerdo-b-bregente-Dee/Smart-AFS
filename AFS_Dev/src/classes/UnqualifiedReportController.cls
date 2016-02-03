public class UnqualifiedReportController {

    public List<Attribute__c> digitalPipeline {get; set;}
    public List<Attribute__c> nonDigitalPipeline {get; set;}
    public List<Attribute__c> noAttributePipeline {get; set;}
    public List<Attribute__c> grandTotal {get; set;}
    public Map<Id, Opportunity> allOpportunities {get; set;}
    public Integer digitalSize {get; set;}
    public Integer nonDigitalSize {get; set;}
    public Integer noAttributeSize {get; set;}
    public Integer grandTotalSize {get; set;}
    public String digitalSum {get; set;}
    public String nonDigitalSum {get; set;}
    public String noAttributeSum {get; set;}
    public String digitalOppSum {get; set;}
    public String nonDigitalOppSum {get; set;}
    public String noAttributeOppSum {get; set;}
    public String grandSum {get; set;}
    public String grandOppSum {get; set;}
    
  
    public PageReference getReport() {
        allOpportunities = new Map<Id, Opportunity>([
        SELECT Id, Total_Current_Revenue__c FROM Opportunity WHERE  Reporting_Status__c = 'Unqualified'  
        ]);
        
        
        digitalPipeline = new List<Attribute__c>();
        nonDigitalPipeline = new List<Attribute__c>();
        noAttributePipeline = new List<Attribute__c>();
        grandTotal = new List<Attribute__c>();
        Set<Id> oppWithAttribute = new Set<Id>();
        Decimal dSum = 0;
        Decimal ndSum = 0;
        Decimal noAttSum = 0;
        Decimal dOppSum = 0;
        Decimal ndOppSum = 0;
        Decimal noAttOppSum = 0;
        Decimal grandTotalOppTCR = 0;
        
        Set<Id> digitalOpp = new Set<Id>();
        Set<Id> nonDigitalOpp = new Set<Id>();
        Set<Id> allOpp = new Set<Id>();
        for(Attribute__c attribute : [SELECT Opportunity_Name__c, Attribute_Type__c, Attribute_Value__c, Attribute_TCR__c, AttributePercent__c
                                        FROM Attribute__c WHERE Opportunity_Name__c IN :allOpportunities.keySet()]){
            oppWithAttribute.add(attribute.Opportunity_Name__c);
            Decimal tcr = 0;
            if(attribute.Attribute_TCR__c != null){
                tcr = attribute.Attribute_TCR__c;
            }
            
            Decimal oppTcr = 0;
            if(allOpportunities.get(attribute.Opportunity_Name__c).Total_Current_Revenue__c != null){
                oppTcr = allOpportunities.get(attribute.Opportunity_Name__c).Total_Current_Revenue__c;
            }
            
            if(attribute.Attribute_Type__c.equals('Accenture Digital')){
                digitalPipeline.add(attribute);
                dSum += tcr;
                if(!digitalOpp.contains(attribute.Opportunity_Name__c)){
                    dOppSum += oppTcr;
                    digitalOpp.add(attribute.Opportunity_Name__c);
                }
            }
            else{
                nonDigitalPipeline.add(attribute);
                ndSum += tcr;
                if(!nonDigitalOpp.contains(attribute.Opportunity_Name__c)){
                    ndOppSum += oppTcr;
                    nonDigitalOpp.add(attribute.Opportunity_Name__c);
                }
            }
            
            if(!allOpp.contains(attribute.Opportunity_Name__c)){
                grandTotalOppTCR += oppTcr;
                allOpp.add(attribute.Opportunity_Name__c);
            }
        }
        
        for(Id oppId : allOpportunities.keySet()){
            if(!oppWithAttribute.contains(oppId)){
                noAttributePipeline.add(new Attribute__c(
                    Opportunity_Name__c = oppId,
                    Attribute_Type__c = '-',
                    Attribute_Value__c = '-',
                    AttributePercent__c = null
                    ));
                noAttOppSum += allOpportunities.get(oppId).Total_Current_Revenue__c;
                grandTotalOppTCR += allOpportunities.get(oppId).Total_Current_Revenue__c;
            }
        }
        
        digitalSize = digitalPipeline.size();
        nonDigitalSize = nonDigitalPipeline.size();
        noAttributeSize = noAttributePipeline.size();
        grandTotalSize = digitalSize + nonDigitalSize + noAttributeSize;
        
        digitalSum = dSum.format();
        nonDigitalSum = ndSum.format();
        noAttributeSum = noAttSum.format();
        digitalOppSum = dOppSum.format();
        nonDigitalOppSum = ndOppSum.format();
        noAttributeOppSum = noAttOppSum.format();
        grandSum = (dSum + ndSum + noAttSum).format();
        grandOppSum = grandTotalOppTCR.format();
        
        
        return null;
    }
    
    public PageReference getReports() {
        allOpportunities = new Map<Id, Opportunity>([
        SELECT Id, Total_Current_Revenue__c FROM Opportunity WHERE  Reporting_Status__c = 'Unqualified'  
        ]);
        
        
        digitalPipeline = new List<Attribute__c>();
        nonDigitalPipeline = new List<Attribute__c>();
        noAttributePipeline = new List<Attribute__c>();
        grandTotal = new List<Attribute__c>();
        Set<Id> oppWithAttribute = new Set<Id>();
        Decimal dSum = 0;
        Decimal ndSum = 0;
        Decimal noAttSum = 0;
        Decimal dOppSum = 0;
        Decimal ndOppSum = 0;
        Decimal noAttOppSum = 0;
        Decimal grandTotalOppTCR = 0;
        
        Set<Id> digitalOpp = new Set<Id>();
        Set<Id> nonDigitalOpp = new Set<Id>();
        Set<Id> allOpp = new Set<Id>();
        for(Attribute__c attribute : [SELECT Opportunity_Name__c, Attribute_Type__c, Attribute_Value__c, Attribute_TCR__c, AttributePercent__c
                                        FROM Attribute__c WHERE Opportunity_Name__c IN :allOpportunities.keySet()]){
            oppWithAttribute.add(attribute.Opportunity_Name__c);
            Decimal tcr = 0;
            if(attribute.Attribute_TCR__c != null){
                tcr = attribute.Attribute_TCR__c;
            }
            
            Decimal oppTcr = 0;
            if(allOpportunities.get(attribute.Opportunity_Name__c).Total_Current_Revenue__c != null){
                oppTcr = allOpportunities.get(attribute.Opportunity_Name__c).Total_Current_Revenue__c;
            }
            
            if(attribute.Attribute_Type__c.equals('Accenture Digital')){
                digitalPipeline.add(attribute);
                dSum += tcr;
                if(!digitalOpp.contains(attribute.Opportunity_Name__c)){
                    dOppSum += oppTcr;
                    digitalOpp.add(attribute.Opportunity_Name__c);
                }
            }
            else{
                nonDigitalPipeline.add(attribute);
                ndSum += tcr;
                if(!nonDigitalOpp.contains(attribute.Opportunity_Name__c)){
                    ndOppSum += oppTcr;
                    nonDigitalOpp.add(attribute.Opportunity_Name__c);
                }
            }
            
            if(!allOpp.contains(attribute.Opportunity_Name__c)){
                grandTotalOppTCR += oppTcr;
                allOpp.add(attribute.Opportunity_Name__c);
            }
        }
        
        for(Id oppId : allOpportunities.keySet()){
            if(!oppWithAttribute.contains(oppId)){
                nonDigitalPipeline.add(new Attribute__c(
                    Opportunity_Name__c = oppId,
                    Attribute_Type__c = null,
                    Attribute_Value__c = null,
                    AttributePercent__c = null
                    ));
                ndOppSum += allOpportunities.get(oppId).Total_Current_Revenue__c;
                grandTotalOppTCR += allOpportunities.get(oppId).Total_Current_Revenue__c;
            }
        }
        
        digitalSize = digitalPipeline.size();
        nonDigitalSize = nonDigitalPipeline.size();
        grandTotalSize = digitalSize + nonDigitalSize;
        
        digitalSum = dSum.format();
        nonDigitalSum = ndSum.format();
        digitalOppSum = dOppSum.format();
        nonDigitalOppSum = ndOppSum.format();
        grandSum = (dSum + ndSum).format();
        grandOppSum = grandTotalOppTCR.format();
        
        
        return null;
    }
    

}