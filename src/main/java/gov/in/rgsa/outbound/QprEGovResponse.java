package gov.in.rgsa.outbound;

import javax.persistence.Entity;
import javax.persistence.Id;

@Entity
public class QprEGovResponse {
	@Id
	private Integer egovSupportActivityDetailsId;	
	private Integer egovPostLevelId;
	private String egovPostLevelName;
	private Integer egovSupportActivityId;
	private Integer stateCode;
	private Integer yearId;
	private Integer versionNo;
	private Integer additionalRequirement;
	private Boolean isFreez;
	
	private Integer qprEGovDetailsId;
	private Integer qprEGovId;
	private Integer postApproved;
	private Integer costApproved;
	private Integer isApproved;
	private String egovPostName;
	private Integer egovPostId;
	private Integer postFilled;
	private Double incurred;
	
	public Integer getEgovSupportActivityDetailsId() {
		return egovSupportActivityDetailsId;
	}
	public void setEgovSupportActivityDetailsId(Integer egovSupportActivityDetailsId) {
		this.egovSupportActivityDetailsId = egovSupportActivityDetailsId;
	}
	public Integer getEgovPostLevelId() {
		return egovPostLevelId;
	}
	public void setEgovPostLevelId(Integer egovPostLevelId) {
		this.egovPostLevelId = egovPostLevelId;
	}
	public Integer getEgovSupportActivityId() {
		return egovSupportActivityId;
	}
	public void setEgovSupportActivityId(Integer egovSupportActivityId) {
		this.egovSupportActivityId = egovSupportActivityId;
	}
	public Integer getStateCode() {
		return stateCode;
	}
	public void setStateCode(Integer stateCode) {
		this.stateCode = stateCode;
	}
	public Integer getYearId() {
		return yearId;
	}
	public void setYearId(Integer yearId) {
		this.yearId = yearId;
	}
	public Integer getVersionNo() {
		return versionNo;
	}
	public void setVersionNo(Integer versionNo) {
		this.versionNo = versionNo;
	}
	public Integer getAdditionalRequirement() {
		return additionalRequirement;
	}
	public void setAdditionalRequirement(Integer additionalRequirement) {
		this.additionalRequirement = additionalRequirement;
	}
	public Integer getPostApproved() {
		return postApproved;
	}
	public void setPostApproved(Integer postApproved) {
		this.postApproved = postApproved;
	}
	public Integer getCostApproved() {
		return costApproved;
	}
	public void setCostApproved(Integer costApproved) {
		this.costApproved = costApproved;
	}
	public Integer getIsApproved() {
		return isApproved;
	}
	public void setIsApproved(Integer isApproved) {
		this.isApproved = isApproved;
	}
	public String getEgovPostName() {
		return egovPostName;
	}
	public void setEgovPostName(String egovPostName) {
		this.egovPostName = egovPostName;
	}
	public Integer getEgovPostId() {
		return egovPostId;
	}
	public void setEgovPostId(Integer egovPostId) {
		this.egovPostId = egovPostId;
	}
	public Boolean getIsFreez() {
		return isFreez;
	}
	public void setIsFreez(Boolean isFreez) {
		this.isFreez = isFreez;
	}
	public Integer getPostFilled() {
		return postFilled;
	}
	public void setPostFilled(Integer postFilled) {
		this.postFilled = postFilled;
	}
	public Double getIncurred() {
		return incurred;
	}
	public void setIncurred(Double incurred) {
		this.incurred = incurred;
	}
	public Integer getQprEGovDetailsId() {
		return qprEGovDetailsId;
	}
	public void setQprEGovDetailsId(Integer qprEGovDetailsId) {
		this.qprEGovDetailsId = qprEGovDetailsId;
	}
	public Integer getQprEGovId() {
		return qprEGovId;
	}
	public void setQprEGovId(Integer qprEGovId) {
		this.qprEGovId = qprEGovId;
	}
	public String getEgovPostLevelName() {
		return egovPostLevelName;
	}
	public void setEgovPostLevelName(String egovPostLevelName) {
		this.egovPostLevelName = egovPostLevelName;
	}

	
}
