package gov.in.rgsa.model;

import java.util.List;

import gov.in.rgsa.entity.EGovSupportActivityDetails;

public class EGovernanceSupportModel {
	private String dbFileName;
	
	private Integer eGovSupportActivityId;
	
	private Integer eGovPostId;
	
	private List<EGovSupportActivityDetails> eGovSupportActivityDetails;
	
	private String level;
	
	private String designation;
	
	private Integer noOfPost;
	
	private Integer month;
	
	private Integer unitCost;
	
	private Integer fund;
	
	private String remarks;
	
	private Integer additionalRequirement;

	public Integer getAdditionalRequirement() {
		return additionalRequirement;
	}

	public void setAdditionalRequirement(Integer additionalRequirement) {
		this.additionalRequirement = additionalRequirement;
	}

	public String getDbFileName() {
		return dbFileName;
	}

	public void setDbFileName(String dbFileName) {
		this.dbFileName = dbFileName;
	}

	public Integer geteGovSupportActivityId() {
		return eGovSupportActivityId;
	}

	public void seteGovSupportActivityId(Integer eGovSupportActivityId) {
		this.eGovSupportActivityId = eGovSupportActivityId;
	}

	public Integer geteGovPostId() {
		return eGovPostId;
	}

	public void seteGovPostId(Integer eGovPostId) {
		this.eGovPostId = eGovPostId;
	}

	

	public String getLevel() {
		return level;
	}

	public void setLevel(String level) {
		this.level = level;
	}

	public String getDesignation() {
		return designation;
	}

	public void setDesignation(String designation) {
		this.designation = designation;
	}

	public Integer getNoOfPost() {
		return noOfPost;
	}

	public void setNoOfPost(Integer noOfPost) {
		this.noOfPost = noOfPost;
	}

	public Integer getMonth() {
		return month;
	}

	public void setMonth(Integer month) {
		this.month = month;
	}

	public Integer getUnitCost() {
		return unitCost;
	}

	public void setUnitCost(Integer unitCost) {
		this.unitCost = unitCost;
	}

	public Integer getFund() {
		return fund;
	}

	public void setFund(Integer fund) {
		this.fund = fund;
	}

	public String getRemarks() {
		return remarks;
	}

	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}

	public List<EGovSupportActivityDetails> geteGovSupportActivityDetails() {
		return eGovSupportActivityDetails;
	}

	public void seteGovSupportActivityDetails(List<EGovSupportActivityDetails> eGovSupportActivityDetails) {
		this.eGovSupportActivityDetails = eGovSupportActivityDetails;
	}

}
