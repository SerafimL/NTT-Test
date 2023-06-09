public with sharing class AccountHandler extends TriggerHandler {
    
    public AccountHandler(System.TriggerOperation operation, List<Account> newRecordList, List<Account> oldRecordList, Map<Id, Account> newMap, Map<Id, Account> oldMap) {
        super(operation, newRecordList, oldRecordList, newMap, oldMap);
    }

    // @TRIGGER METHODS
    private static Boolean runTrigger;

    static {
        runTrigger = true;
    }

    public static Boolean isTriggerEnabled() {
        return runTrigger;
    }

    public static Boolean enableTrigger() {
        return runTrigger = true;
    }

    public static Boolean disableTrigger() {
        return runTrigger = false;
    }

    public override void beforeInsert() {
        AccountHelper.validateAccountNumber((List<Account>)newRecordList);
    }

    public override void afterInsert() {
        AccountHelper.createOpportunityToPartners((List<Account>)newRecordList);
        AccountHelper.createTaskToFinalCustomers((List<Account>)newRecordList);
    }

    public override void beforeUpdate() {
        AccountHelper.validateAccountNumber((Map<Id, Account>)newMap);
    }

    public override void afterUpdate() {
        AccountHelper.createOpportunityToPartners((Map<Id, Account>)newMap, (Map<Id, Account>)oldMap);
        AccountHelper.createTaskToFinalCustomers((Map<Id, Account>)newMap, (Map<Id, Account>)oldMap);
    }

    public override void beforeDelete() {}

    public override void afterDelete() {}
}