@isTest
public class AccountHelperTest {
    
    public static final Id PARTNER_RECORDTYPE = Schema.SObjectType.Account.getRecordTypeInfosByDeveloperName().get('Parceiro').getRecordTypeId();
    public static final Id FINAL_CUSTOMER_RECORDTYPE = Schema.SObjectType.Account.getRecordTypeInfosByDeveloperName().get('ConsumidorFinal').getRecordTypeId();

    static Account createAccountCNPJ() {
        return new Account(
            Name = 'Test',
            AccountNumber = '22349682000185',
            Type = 'CNPJ'
        );
    }

    static Account createAccountCPF() {
        return new Account(
            Name = 'Test',
            AccountNumber = '62370004029',
            Type = 'CPF'
        );
    }

    @isTest
    static void validateAccountNumberSuccess() {

        Account accCPF = createAccountCPF();
        Account accCNPJ = createAccountCNPJ();
        List<Database.SaveResult> resultList = Database.insert(new List<Account>{accCPF, accCNPJ});

        for(Database.SaveResult result : resultList) {

            System.assertEquals(result.isSuccess(), true);
        }

        accCPF.Type = null;
        Database.SaveResult result = Database.update(accCPF);

        System.assertEquals(result.isSuccess(), true);
    }

    @isTest
    static void validateAccountNumberError() {

        Account accCPF = createAccountCPF();
        accCPF.AccountNumber = null;
        Account accCNPJ = createAccountCNPJ();
        accCNPJ.AccountNumber = null;
        List<Database.SaveResult> resultList = Database.insert(new List<Account>{accCPF, accCNPJ}, false);

        for(Database.SaveResult result : resultList) {
            System.assertEquals(result.isSuccess(), false);
        }

        accCPF.Type = null;
        Database.SaveResult result = Database.insert(accCPF, false);
        System.assertEquals(result.isSuccess(), false);
    }

    @isTest
    static void createOpportunityToPartnersTest() {
        Account acc = createAccountCNPJ();
        acc.RecordTypeId = PARTNER_RECORDTYPE;
        insert acc;
        Opportunity opp = [
            SELECT Id,
                Name,
                CloseDate,
                StageName,
                AccountId
            FROM Opportunity 
            WHERE AccountId = :acc.Id
        ];

        System.assertEquals(opp.Name == (acc.Name + ' - opp Parceiro'), true);
        System.assertEquals(opp.CloseDate == System.today().addDays(30), true);
        System.assertEquals(opp.StageName == 'Qualification', true);
        System.assertEquals(opp.AccountId == acc.Id, true);
    }

    @isTest
    static void createTaskToFinalCustomersTest() {
        Account acc = createAccountCNPJ();
        acc.RecordTypeId = FINAL_CUSTOMER_RECORDTYPE;
        insert acc;
        Task task = [
            SELECT Id,
                Subject,
                WhatId,
                Status,
                Priority
            FROM Task 
            WHERE WhatId = :acc.Id
        ];

        System.assertEquals(task.Subject == 'Consumidor Final', true);
        System.assertEquals(task.WhatId == acc.Id, true);
        System.assertEquals(task.Status == 'Not Started', true);
        System.assertEquals(task.Priority == 'Normal', true);
    }
}