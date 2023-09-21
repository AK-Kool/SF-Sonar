/*
	Username - aakakhilesh@yahoo.com.ein
	Password - Apple@1221
	Rest Service URL - https://testcompany-35b-dev-ed.my.salesforce.com/services/apexrest/v1/welcome/Hello
*/
@RestResource(urlMapping='/v1/Account/*')
global class AccountManager 
{
	@httpGet
    global static AccountWrapper accountInformation()
    {
        RestRequest request = RestContext.request;
        String requestURI = request.requestURI;
        String accountId = requestURI.substringAfterLast('/');
        List<Account> lstAccount = [
          	SELECT Id,Name,Rating,Industry
            FROM Account
            WHERE Id =: accountId
        ];
        List<Contact> lstContact = [
          	SELECT Id , Name
            FROM Contact
            WHERE AccountId =: accountId
        ];
        List<Case> lstCase = [
          	SELECT Id , CaseNumber , ContactId__c
            FROM Case
            WHERE ContactId__c =: lstContact.get(0).Id
        ];
        AccountWrapper wrapper = new AccountWrapper();
        if(!lstAccount.isEmpty())
        {
            wrapper.accountRecord = lstAccount.get(0);
            wrapper.contactList = lstContact;
            wrapper.caseList = lstCase;
        }   
        return wrapper;
    }
    
    global class AccountWrapper
    {
        global Account accountRecord;
        global List<Contact> contactList;
        global List<Case> caseList;
    }    
    
	@httpPost
    global static PostAccWrapper accountInformation1(PostAccWrapper postData)
    {
 		System.debug('## ' + postData);
        
        PostAccWrapper p = new PostAccWrapper();
        p.Name = postData.Name;
        p.Rating = postData.Rating;
        
        Account acc = new Account();
        acc.Name = postData.Name;
        acc.Rating = postData.Rating;
        insert acc;
        p.accId = acc.Id;
        return p;
		
    }
    global class PostAccWrapper
    {
        global String Name;
        global String Rating;
        global String accId;
    }    
}