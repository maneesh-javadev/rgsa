package gov.in.rgsa.model;

import gov.in.rgsa.entity.QprPlanFunds;

import java.util.List;
import java.util.Map;

public class QprReportConsModel {
    Map<Integer, String> yearMap;
    Map <Integer, String> stateMap;
    Integer yearId = 0;
    Integer stateCode = 0;
    List<QprPlanFunds> qprPlanFundsList;

    public Map<Integer, String> getYearMap() {
        return yearMap;
    }

    public void setYearMap(Map<Integer, String> yearMap) {
        this.yearMap = yearMap;
    }

    public Map<Integer, String> getStateMap() {
        return stateMap;
    }

    public void setStateMap(Map<Integer, String> stateMap) {
        this.stateMap = stateMap;
    }

    public Integer getYearId() {
        return yearId;
    }

    public void setYearId(Integer yearId) {
        this.yearId = yearId;
    }

    public Integer getStateCode() {
        return stateCode;
    }

    public void setStateCode(Integer stateCode) {
        this.stateCode = stateCode;
    }

    public List<QprPlanFunds> getQprPlanFundsList() {
        return qprPlanFundsList;
    }

    public void setQprPlanFundsList(List<QprPlanFunds> qprPlanFundsList) {
        this.qprPlanFundsList = qprPlanFundsList;
    }
}
