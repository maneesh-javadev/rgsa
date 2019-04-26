package gov.in.rgsa.utils;

public class PlanUtil {

    public static enum STATUS {
        NO_BASIC_INFO(0),
        NOT_SUBMITTED(1),
        PENDING_AT_MOPR(2),
        REVERTED_BY_MOPR(3),
        PENDING_AT_CEC(4),
        APPROVED_BY_CEC(5);

        private final int value;

        STATUS (final int newValue) {
            this.value = newValue;
        }

        public Integer getValue() { return value==0 ? null: value; }

        public static STATUS valueOf(Integer value) {
            if(value==null)
                return NO_BASIC_INFO;
            for(STATUS status: values()) {
                if(status.value == value)
                    return status;
            }
            return NOT_SUBMITTED;
        }
    }
    private STATUS currentStatus;

    public PlanUtil(Integer statusCode){
        currentStatus = getStatus(statusCode);
    }

    PlanUtil(STATUS status){
        currentStatus = status;
    }

    public STATUS getStatus(Integer statusCode) {
        return STATUS.valueOf(statusCode);
    }

    public boolean hasStatus(Integer statusCode){
        return hasStatus(getStatus(statusCode));
    }

    public boolean hasStatus(STATUS status){
        return currentStatus==status;
    }

    public boolean isNotSubmitted(){
        return hasStatus(STATUS.NOT_SUBMITTED);
    }

    // Every state other than NOT_SUBMITTED.
    public boolean isSubmittedByState() {
        return !hasStatus(STATUS.NOT_SUBMITTED);
    }

    public boolean pendingAtMOPR(){
        return hasStatus(STATUS.PENDING_AT_MOPR);
    }

    public boolean pendingAtCEC(){
        return hasStatus(STATUS.PENDING_AT_CEC);
    }

    public boolean revertedByMOPR(){
        return hasStatus(STATUS.REVERTED_BY_MOPR);
    }

    public boolean isApprovedByCEC(){
        return hasStatus(STATUS.APPROVED_BY_CEC);
    }
}
