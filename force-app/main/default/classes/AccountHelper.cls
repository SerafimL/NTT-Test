public with sharing class AccountHelper {

    public static void validateAccountNumber(Map<Id, Account> newMap) {
        validateAccountNumber(newMap.values());
    }

    public static void validateAccountNumber(List<Account> listNew) {
        
        for(Account acc : listNew) {
            if(acc.Type == 'CPF' && !Utils.validaCPF(acc.AccountNumber)){
                acc.addError(new AccountTriggerException(Label.InvalidAccountNumber));
            }

            if(acc.Type == 'CNPJ' && !Utils.validaCNPJ(acc.AccountNumber)){
                acc.addError(new AccountTriggerException(Label.InvalidAccountNumber));
            }

            if(!Utils.validaCPF(acc.AccountNumber) && !Utils.validaCNPJ(acc.AccountNumber)){
                acc.addError(new AccountTriggerException(Label.InvalidAccountNumber));
            }
        }
    }

    public class AccountTriggerException extends Exception {}
}