<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <rules>
        <fullName>Set Accenture Digital%3F to No</fullName>
        <active>true</active>
        <description>Set Accenture Digital? to No</description>
        <formula>NOT(ISPICKVAL(Attribute_Type__c, &quot;Accenture Digital&quot;))</formula>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Set Accenture Digital%3F to Yes</fullName>
        <active>true</active>
        <description>Set Accenture Digital? to Yes</description>
        <formula>ISPICKVAL(Attribute_Type__c, &quot;Accenture Digital&quot;)</formula>
        <triggerType>onCreateOnly</triggerType>
    </rules>
</Workflow>
