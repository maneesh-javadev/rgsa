package gov.in.rgsa.dto;

import com.fasterxml.jackson.annotation.JsonProperty;

public class KpiWebServiceParam {

	@JsonProperty("yr")
    Integer yr;
    private Integer mCode;
    private Integer stateCode;
    private Integer deptCode;
    private Integer projectCode;
    private Integer secCode;
    
	public Integer getYr() {
		return yr;
	}
	public void setYr(Integer yr) {
		this.yr = yr;
	}
	public Integer getmCode() {
		return mCode;
	}
	public void setmCode(Integer mCode) {
		this.mCode = mCode;
	}
	
		public Integer getStateCode() {
		return stateCode;
	}
	public void setStateCode(Integer stateCode) {
		this.stateCode = stateCode;
	}
		public Integer getDeptCode() {
		return deptCode;
	}
	public void setDeptCode(Integer deptCode) {
		this.deptCode = deptCode;
	}
	public Integer getProjectCode() {
		return projectCode;
	}
	public void setProjectCode(Integer projectCode) {
		this.projectCode = projectCode;
	}
	public Integer getSecCode() {
		return secCode;
	}
	public void setSecCode(Integer secCode) {
		this.secCode = secCode;
	}
	
	
	
}
