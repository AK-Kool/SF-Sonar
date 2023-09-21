public class CaseStatusTimeCal // run as System context
{
	public static void caseStatusTimeCalFunc(List<Case> lstCase)
    {
        Set<Id> caseIds = new Set<Id>();
        if(!lstCase.isEmpty())
        {
            // get caseIds for getting all CaseHistories
            for(Case c: lstCase)
            {
                caseIds.add(c.Id);
            }
            List<CaseHistory> lstCaseHis = [SELECT Id,OldValue,NewValue
                                            FROM CaseHistory
                                            WHERE CaseId IN :caseIds];
            List<Case> newCaseLst = [SELECT Id,(SELECT OldValue,NewValue,CreatedDate FROM Histories)
                                     FROM Case
                                     WHERE Id IN :caseIds];
       		
            if(!newCaseLst.isEmpty())
                calculateTime(newCaseLst);
        }
    }
	
	private static void calculateTime(List<Case> lstCase)
    {
        // map case id , field and total time
        // Map<Id,Map<String,Decimal>>
        Map<Id,Map<String,Decimal>> caseMapWithHistory = new Map<Id,Map<String,Decimal>>();
        Map<Id,List<CaseHistory>> allCaseHistoryMap = new Map<Id,List<CaseHistory>>();
     	for(Case c: lstCase)
        {
            if(!caseMapWithHistory.containsKey(c.Id) && !c.Histories.isEmpty())
            {
             	caseMapWithHistory.put(c.Id,new Map<String,Decimal>());
                allCaseHistoryMap.put(c.Id,c.Histories);
            }
        }
        
        for(Id caseId: allCaseHistoryMap.keySet())
        {
            // need status start time and end time
            
            for(CaseHistory ch: allCaseHistoryMap.get(caseId))
            {
                System.debug('Case Id:' + caseId + ' Created Date : ' + ch.CreatedDate + ' OldValue: ' + ch.OldValue + ' NewValue: ' + ch.OldValue);
            }    
        }
    }
}
// List<Case> lstCase = [SELECT Id FROM Case WHERE Id = '5005g00000DdsQCAAZ'];
// CaseStatusTimeCal.caseStatusTimeCalFunc(lstCase);