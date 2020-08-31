package gov.in.rgsa.dto;

import java.util.List;

import com.fasterxml.jackson.annotation.JsonPropertyOrder;

import gov.in.rgsa.entity.KpiWebService;



@JsonPropertyOrder({"mcode", "stateCode","deptCode","projectCode","secCode", "Record" })
public class KpiWebServiceRecord {
    private Integer mcode;
    private Integer state_code;
    private Integer dept_code;
    private Integer project_code;
    private Integer sec_code;
    private List<String> Record;

	public List<String> getRecord() {
		return Record;
	}
	public void setRecord(List<String> records) {
		Record = records;
	}
	public Integer getMcode() {
		return mcode;
	}
	public void setMcode(Integer mcode) {
		this.mcode = mcode;
	}
	public Integer getState_code() {
		return state_code;
	}
	public void setState_code(Integer state_code) {
		this.state_code = state_code;
	}
	public Integer getDept_code() {
		return dept_code;
	}
	public void setDept_code(Integer dept_code) {
		this.dept_code = dept_code;
	}
	public Integer getProject_code() {
		return project_code;
	}
	public void setProject_code(Integer project_code) {
		this.project_code = project_code;
	}
	public Integer getSec_code() {
		return sec_code;
	}
	public void setSec_code(Integer sec_code) {
		this.sec_code = sec_code;
	}
	
}
