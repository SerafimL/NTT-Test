public class BatchAccountInactive implements Database.Batchable<SObject> {
    public Database.QueryLocator start(Database.BatchableContext BC) {
        //poderia ser feito por meio de rollup em opportunidade e por campo auxiliar, como que um rollup, para tasks, 
        //assim não precisaria fazer uma query em todas as accounts ativas.
        return Database.getQueryLocator([
            SELECT
                Id,
                (
                    SELECT Id FROM Tasks 
                    WHERE ActivityDate > :System.today().addDays(-90) 
                    LIMIT 1
                ),
                (
                    SELECT Id FROM Opportunities 
                    WHERE (CloseDate > :System.today().addDays(-120) AND Probability = 100) 
                    OR (CloseDate > :System.today() AND Probability != 100 AND Probability != 0)
                    LIMIT 1
                )
            FROM Account
            WHERE Inativa__c != true
        ]);
    }

    public void execute(Database.BatchableContext BC, List<Account> scope) {
        for(Account acc : scope) {
            if(acc.Tasks?.isEmpty() == true && acc.Opportunities?.isEmpty() == true) {
                acc.Inativa__c = true;
            }
        }
        update scope;
    }

    public void finish(Database.BatchableContext BC) {}
}