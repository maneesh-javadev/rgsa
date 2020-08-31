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
    private Integer additionalReqSpmu;
    private Integer additionalReqDpmu;
    private Integer isFreez;
    private Integer isPost;

    private Integer qprEGovDetailsId;
    private Integer qprEGovId;
    private Integer postApproved;
    private Integer costApproved;
    private Integer isApproved;
    private String egovPostName;
    private Integer egovPostId;
    private Integer postFilled;
    private Double incurred;
    private Double funds;
    private Double spent;
    private Integer addReqSpmuApproved;
    private Integer addReqDpmuApproved;
    private Integer addReqSpmuUsed;
    private Integer addReqDpmuUsed;

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

    public Integer getAdditionalReqSpmu() {
        return additionalReqSpmu;
    }

    public void setAdditionalReqSpmu(Integer additionalReqSpmu) {
        this.additionalReqSpmu = additionalReqSpmu;
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



    public Double getSpent() {
        return spent;
    }

    public void setSpent(Double spent) {
        this.spent = spent;
    }

    public Double getFunds() {
        return funds;
    }

    public void setFunds(Double funds) {
        this.funds = funds;
    }

    public Integer getAdditionalReqDpmu() {
        return additionalReqDpmu;
    }

    public void setAdditionalReqDpmu(Integer additionalReqDpmu) {
        this.additionalReqDpmu = additionalReqDpmu;
    }

    public Integer getAddReqSpmuApproved() {
        return addReqSpmuApproved;
    }

    public void setAddReqSpmuApproved(Integer addReqSpmuApproved) {
        this.addReqSpmuApproved = addReqSpmuApproved;
    }

    public Integer getAddReqDpmuApproved() {
        return addReqDpmuApproved;
    }

    public void setAddReqDpmuApproved(Integer addReqDpmuApproved) {
        this.addReqDpmuApproved = addReqDpmuApproved;
    }

    public Integer getAddReqSpmuUsed() {
        return addReqSpmuUsed;
    }

    public void setAddReqSpmuUsed(Integer addReqSpmuUsed) {
        this.addReqSpmuUsed = addReqSpmuUsed;
    }

    public Integer getAddReqDpmuUsed() {
        return addReqDpmuUsed;
    }

    public void setAddReqDpmuUsed(Integer addReqDpmuUsed) {
        this.addReqDpmuUsed = addReqDpmuUsed;
    }

	public Integer getIsFreez() {
		return isFreez;
	}

	public void setIsFreez(Integer isFreez) {
		this.isFreez = isFreez;
	}

	public Integer getIsPost() {
		return isPost;
	}

	public void setIsPost(Integer isPost) {
		this.isPost = isPost;
	}
    
    
}
