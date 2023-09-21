public class CaseRoot_Apex 
{
    @AuraEnabled(cacheable=true)
	public static List<Case> getCaseRecords()
    {
        return [SELECT Id,CaseNumber,Status,(SELECT Id FROM Histories WHERE CaseId != null) FROM Case];
    }    
}