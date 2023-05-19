public with sharing class AccountHelper {

    public static void validateAccountNumber(Map<Id, Account> newMap) {
        validateAccountNumber(newMap.values());
    }

    public static void validateAccountNumber(List<Account> listNew) {
        
        for(Account acc : listNew) {
            if(acc.Type == 'CPF' && !Utils.validaCPF(acc.AccountNumber)){
                acc.addError(new AccountTriggerException('Número do cliente é inválido'));
            }

            if(acc.Type == 'CNPJ' && !Utils.validaCNPJ(acc.AccountNumber)){
                acc.addError(new AccountTriggerException('Número do cliente é inválido'));
            }

            if(!Utils.validaCPF(acc.AccountNumber) && !Utils.validaCNPJ(acc.AccountNumber)){
                acc.addError(new AccountTriggerException('Número do cliente é inválido'));
            }
        }
    }

    public class AccountTriggerException extends Exception {}
}