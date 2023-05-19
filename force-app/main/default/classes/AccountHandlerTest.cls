@isTest
public class AccountHandlerTest {

    public static final Id PARTNER_RECORDTYPE = Schema.SObjectType.Account.getRecordTypeInfosByDeveloperName().get('Parceiro').getRecordTypeId();
    public static final Id FINAL_CUSTOMER_RECORDTYPE = Schema.SObjectType.Account.getRecordTypeInfosByDeveloperName().get('ConsumidorFinal').getRecordTypeId();


    static Account createAccount() {
        return new Account(
            Name = 'Test',
            AccountNumber = '22349682000185'
        );
    }

    @isTest
    static void AccountHandlerStaticTest() {
        AccountHandler.enableTrigger();
        System.AssertEquals(AccountHandler.isTriggerEnabled(), true);
        AccountHandler.disableTrigger();
        System.AssertEquals(AccountHandler.isTriggerEnabled(), false);
    }

    @isTest
    static void insertTest() {
        Account acc = createAccount();
        insert acc;
        System.AssertEquals(acc.Id != null, true);
    }

    @isTest
    static void updateTest() {
        Account acc = createAccount();
        insert acc;
        acc.Type = 'CNPJ';
        update acc;
    }

    @isTest
    static void deleteTest() {
        Account acc = createAccount();
        insert acc;
        delete acc;
    }

    @isTest
    static void massInsertAndUpdate() {
        List<Account> accList = new List<Account>();
        for(Integer i=0; i<500; i++) {
            Account acc = createAccount();
            acc.RecordTypeId = FINAL_CUSTOMER_RECORDTYPE;
            accList.add(acc);
        }
        insert accList;

        for(Account acc : accList) {
            acc.Type = 'CNPJ';
            acc.RecordTypeId = PARTNER_RECORDTYPE;
        }
        update accList;

        for(Account acc : accList) {
            acc.Type = 'CNPJ';
            acc.RecordTypeId = FINAL_CUSTOMER_RECORDTYPE;
        }
        update accList;
    }
}