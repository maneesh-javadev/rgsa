package gov.in.rgsa.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.NamedNativeQueries;
import javax.persistence.NamedNativeQuery;

@Entity

@NamedNativeQueries({ 
	@NamedNativeQuery(query = "select * from rgsa.get_statewise_plan_status()",
	name = "STATEWISEPLANSTATUS", resultClass = StatewisePlanStatus.class)
	
})

public class StatewisePlanStatus {
	
	@Id
	@Column(name = "state_code", nullable = false)
	private Integer stateCode;
	
	@Column(name = "state_name_english")
	private String stateNameEnglish;
	
	@Column(name = "plan_status")
	private Character planStatus;
	
	@Column(name = "summary_details")
	private String summaryDetails;

	public Integer getStateCode() {
		return stateCode;
	}

	public void setStateCode(Integer stateCode) {
		this.stateCode = stateCode;
	}

	public String getStateNameEnglish() {
		return stateNameEnglish;
	}

	public void setStateNameEnglish(String stateNameEnglish) {
		this.stateNameEnglish = stateNameEnglish;
	}

	public Character getPlanStatus() {
		return planStatus;
	}

	public void setPlanStatus(Character planStatus) {
		this.planStatus = planStatus;
	}

	public String getSummaryDetails() {
		return summaryDetails;
	}

	public void setSummaryDetails(String summaryDetails) {
		this.summaryDetails = summaryDetails;
	}
	

	
	
	

}
