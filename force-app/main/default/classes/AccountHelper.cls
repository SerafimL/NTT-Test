public with sharing class AccountHelper {

    public static final Id PARTNER_RECORDTYPE = Schema.SObjectType.Account.getRecordTypeInfosByDeveloperName().get('Parceiro').getRecordTypeId();
    public static final Id FINAL_CUSTOMER_RECORDTYPE = Schema.SObjectType.Account.getRecordTypeInfosByDeveloperName().get('ConsumidorFinal').getRecordTypeId();

    public static void validateAccountNumber(Map<Id, Account> newMap) {
        validateAccountNumber(newMap.values());
    }

    public static void validateAccountNumber(List<Account> listNew) {
        
        for(Account acc : listNew) {
            if(acc.Type == 'CPF' && !Utils.validaCPF(acc.AccountNumber)) {
                acc.addError(new AccountTriggerException(Label.InvalidAccountNumber));
            }
            else if(acc.Type == 'CNPJ' && !Utils.validaCNPJ(acc.AccountNumber)) {
                acc.addError(new AccountTriggerException(Label.InvalidAccountNumber));
            }
            else if(!Utils.validaCPF(acc.AccountNumber) && !Utils.validaCNPJ(acc.AccountNumber)) {
                acc.addError(new AccountTriggerException(Label.InvalidAccountNumber));
            }
        }
    }

    public static void createOpportunityToPartners(Map<Id, Account> mapNew, Map<Id, Account> mapOld) {
        List<Account> accList = new List<Account>();
        for(String id : mapNew.keySet()) {
            Account accOld = mapOld.get(id);
            Account accNew = mapNew.get(id);

            if(accNew.RecordTypeId == PARTNER_RECORDTYPE && accOld.RecordTypeId != PARTNER_RECORDTYPE) {
                accList.add(accNew);
            }
        }
        if(!accList.isEmpty()) createOpportunityToPartners(accList);
    }

    public static void createOpportunityToPartners(List<Account> listNew) {
        
        List<Opportunity> oppList = new List<Opportunity>();

        for(Account acc : listNew) {
            if(acc.RecordTypeId != PARTNER_RECORDTYPE) {
                continue;
            }

            oppList.add(new Opportunity(
                Name = (acc.Name + ' - opp Parceiro'),
                CloseDate = System.today().addDays(30),
                StageName = 'Qualification',
                AccountId = acc.Id
            ));
        }
        insert oppList;
    }

    public static void createTaskToFinalCustomers(Map<Id, Account> mapNew, Map<Id, Account> mapOld) {
        List<Account> accList = new List<Account>();
        for(String id : mapNew.keySet()) {
            Account accOld = mapOld.get(id);
            Account accNew = mapNew.get(id);

            if(accNew.RecordTypeId == FINAL_CUSTOMER_RECORDTYPE && accOld.RecordTypeId != FINAL_CUSTOMER_RECORDTYPE) {
                accList.add(accNew);
            }
        }
        if(!accList.isEmpty()) createTaskToFinalCustomers(accList);
    }

    public static void createTaskToFinalCustomers(List<Account> listNew) {
        
        List<Task> taskList = new List<Task>();

        for(Account acc : listNew) {
            if(acc.RecordTypeId != FINAL_CUSTOMER_RECORDTYPE) {
                continue;
            }

            taskList.add(new Task(
                Subject = 'Consumidor Final',
                WhatId = acc.Id,
                Status = 'Not Started',
                Priority = 'Normal'
            ));
        }
        insert taskList;
    }

    public class AccountTriggerException extends Exception {}
}