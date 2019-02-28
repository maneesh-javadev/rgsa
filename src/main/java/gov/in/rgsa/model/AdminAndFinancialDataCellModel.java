package gov.in.rgsa.model;

import java.util.List;

import gov.in.rgsa.entity.AdminFinancialDataCellActivityDetails;

public class AdminAndFinancialDataCellModel {

	List<AdminFinancialDataCellActivityDetails> adminFinancialDataCellActivityDetails;
	
	private Integer additionalRequirement;
	
	private Integer adminFinancialDataActivityId;
	
	private Boolean isFreeze;

	private String userType;
	
	public List<AdminFinancialDataCellActivityDetails> getAdminFinancialDataCellActivityDetails() {
		return adminFinancialDataCellActivityDetails;
	}

	public void setAdminFinancialDataCellActivityDetails(
			List<AdminFinancialDataCellActivityDetails> adminFinancialDataCellActivityDetails) {
		this.adminFinancialDataCellActivityDetails = adminFinancialDataCellActivityDetails;
	}

	public Integer getAdditionalRequirement() {
		return additionalRequirement;
	}

	public void setAdditionalRequirement(Integer additionalRequirement) {
		this.additionalRequirement = additionalRequirement;
	}

	public Integer getAdminFinancialDataActivityId() {
		return adminFinancialDataActivityId;
	}

	public void setAdminFinancialDataActivityId(Integer adminFinancialDataActivityId) {
		this.adminFinancialDataActivityId = adminFinancialDataActivityId;
	}

	public Boolean getIsFreeze() {
		return isFreeze;
	}

	public void setIsFreeze(Boolean isFreeze) {
		this.isFreeze = isFreeze;
	}

	public String getUserType() {
		return userType;
	}

	public void setUserType(String userType) {
		this.userType = userType;
	}

}
