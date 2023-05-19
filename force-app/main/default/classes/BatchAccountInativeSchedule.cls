public class BatchAccountInativeSchedule implements Schedulable {

public void execute(SchedulableContext sc) {

    Database.executeBatch(new BatchAccountInactive());
}

public static void scheduleBatch() {
    BatchAccountInativeSchedule s = new BatchAccountInativeSchedule();
    System.schedule(Test.isRunningTest() ? 'batchAccountInactiveTest' : 'batchAccountInactive', '0 0 0,6,12,18 ? * MON-FRI', s);
}

}
