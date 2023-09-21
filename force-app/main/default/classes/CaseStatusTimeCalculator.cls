public class CaseStatusTimeCalculator
{
	public static void calculateCaseHistory(Map<Id,Case> newCaseMap , Map<Id,Case> oldCaseMap)
    {
        Set<Id> caseIds = new Set<Id>();
        Map<Case,List<CaseHistory>> mapCaseWithHistory = new Map<Case,List<CaseHistory>>();
        for(Case c: newCaseMap.values())
        {
            caseIds.add(c?.Id);
            if(!mapCaseWithHistory.containsKey(c))
            	mapCaseWithHistory.put(c,new List<CaseHistory>());
        }
        List<Case> lstCases;
        if(!caseIds.isEmpty())
        {
            lstCases = [SELECT Id,Status,(SELECT NewValue,OldValue FROM Histories)
                        FROM Case
                        WHERE Id IN :caseIds];
        }//if
        for(Case c: lstCases)
        {
            if(mapCaseWithHistory.containsKey(c) && !c.Histories.isEmpty())
            {
                mapCaseWithHistory.get(c).addAll(c.Histories);
            }// if
        }// for
        
    }//func
}//root