package gov.in.rgsa.entity;

import java.util.Date;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.NamedQuery;
import javax.persistence.OneToMany;
import javax.persistence.Table;

@Entity
@Table(name="egov_support_activity",schema="rgsa")
@NamedQuery(name="FETCH_EGOV_ACTIVITY", query="SELECT E FROM EGovSupportActivity E where stateCode =:stateCode and yearId =:yearId and userType =:userType")
public class EGovSupportActivity {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name="egov_support_activity_id")
	public Integer eGovSupportActivityId;
	
	@Column(name="state_code")
	public Integer stateCode;
	
	@Column(name="year_id")
	public Integer yearId;
	
	@Column(name="version_no")
	public Integer versionNo;
	
	
	@Column(name="user_type")
	public Character userType;
	
	@Column(name="additional_requirement")
	public Integer additionalRequirement;

	@Column(name="created_by")
	public Integer createdBy;
	
	@Column(name="created_on")
	public Date createdOn;
	
	@Column(name="last_updated_by")
	public Integer lastUpdatedBy;
	
	@Column(name="last_updated_on")
	public Date lastUpdatedOn;
	
	@Column(name="is_freeze")
	public Boolean status;
	
	@OneToMany(cascade=CascadeType.ALL,mappedBy="eGovSupportActivity",fetch=FetchType.EAGER)
	private List<EGovSupportActivityDetails> eGovSupportActivityDetails;
	

	public Integer geteGovSupportActivityId() {
		return eGovSupportActivityId;
	}

	public void seteGovSupportActivityId(Integer eGovSupportActivityId) {
		this.eGovSupportActivityId = eGovSupportActivityId;
	}

	public Integer getStateCode() {
		return stateCode;
	}

	public void setStateCode(Integer stateCode) {
		this.stateCode = stateCode;
	}

	public Integer getyearId() {
		return yearId;
	}

	public void setyearId(Integer yearId) {
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

	public Integer getCreatedBy() {
		return createdBy;
	}

	public void setCreatedBy(Integer createdBy) {
		this.createdBy = createdBy;
	}

	public Date getCreatedOn() {
		return createdOn;
	}

	public void setCreatedOn(Date createdOn) {
		this.createdOn = createdOn;
	}

	public Integer getLastUpdatedBy() {
		return lastUpdatedBy;
	}

	public void setLastUpdatedBy(Integer lastUpdatedBy) {
		this.lastUpdatedBy = lastUpdatedBy;
	}

	public Date getLastUpdatedOn() {
		return lastUpdatedOn;
	}

	public void setLastUpdatedOn(Date lastUpdatedOn) {
		this.lastUpdatedOn = lastUpdatedOn;
	}

	public Integer getYearId() {
		return yearId;
	}

	public void setYearId(Integer yearId) {
		this.yearId = yearId;
	}

	public Boolean getStatus() {
		return status;
	}

	public void setStatus(Boolean status) {
		this.status = status;
	}

	public Character getUserType() {
		return userType;
	}

	public void setUserType(Character userType) {
		this.userType = userType;
	}

	public List<EGovSupportActivityDetails> geteGovSupportActivityDetails() {
		return eGovSupportActivityDetails;
	}

	public void seteGovSupportActivityDetails(List<EGovSupportActivityDetails> eGovSupportActivityDetails) {
		this.eGovSupportActivityDetails = eGovSupportActivityDetails;
	}

	/*public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}*/

}
