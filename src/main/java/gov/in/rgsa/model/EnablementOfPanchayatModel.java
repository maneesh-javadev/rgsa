package gov.in.rgsa.model;

import java.util.List;

import gov.in.rgsa.entity.EEnablementDetails;

public class EnablementOfPanchayatModel {
	
	private Integer eEnablementId;
	
	private String status;
	
	private List<EEnablementDetails> eEnablementDetails;
	
	private List<EEnablementDetails> enablementDetailsForState;
	
	private List<EEnablementDetails> enablementDetailsForMOPR;
	
	private Integer additionalRequirement; 
	
	private Integer additionalRequirementForState; 
	
	private Integer additionalRequirementForMopr; 

	
	public Integer getAdditionalRequirement() {
		return additionalRequirement;
	}

	public void setAdditionalRequirement(Integer additionalRequirement) {
		this.additionalRequirement = additionalRequirement;
	}

	public Integer geteEnablementId() {
		return eEnablementId;
	}

	public void seteEnablementId(Integer eEnablementId) {
		this.eEnablementId = eEnablementId;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public List<EEnablementDetails> geteEnablementDetails() {
		return eEnablementDetails;
	}

	public void seteEnablementDetails(List<EEnablementDetails> eEnablementDetails) {
		this.eEnablementDetails = eEnablementDetails;
	}

	public List<EEnablementDetails> getEnablementDetailsForState() {
		return enablementDetailsForState;
	}

	public void setEnablementDetailsForState(List<EEnablementDetails> enablementDetailsForState) {
		this.enablementDetailsForState = enablementDetailsForState;
	}

	public List<EEnablementDetails> getEnablementDetailsForMOPR() {
		return enablementDetailsForMOPR;
	}

	public void setEnablementDetailsForMOPR(List<EEnablementDetails> enablementDetailsForMOPR) {
		this.enablementDetailsForMOPR = enablementDetailsForMOPR;
	}

	public Integer getAdditionalRequirementForState() {
		return additionalRequirementForState;
	}

	public void setAdditionalRequirementForState(Integer additionalRequirementForState) {
		this.additionalRequirementForState = additionalRequirementForState;
	}

	public Integer getAdditionalRequirementForMopr() {
		return additionalRequirementForMopr;
	}

	public void setAdditionalRequirementForMopr(Integer additionalRequirementForMopr) {
		this.additionalRequirementForMopr = additionalRequirementForMopr;
	}
	
}
