package gov.in.rgsa.entity;

import java.sql.Timestamp;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Transient;

import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;
import org.hibernate.annotations.Where;

/**
 * 
 * @author Ashish
 *
 */

@Entity
@Table(name="institutional_infra_activity", schema = "rgsa")
@NamedQueries({
@NamedQuery(name="FETCH_ALL_INSTITUTIONAL_ACTIVITY",query="SELECT I FROM InstitutionalInfraActivityPlan I where stateCode =:stateCode and yearId =:yearId and userType =:userType "),
@NamedQuery(name="UPDATE_FREEZE_UNFREEZE_STATUS_Institutional",query="UPDATE InstitutionalInfraActivityPlan SET isFreeze = :isFreeze,additionalRequirement=:additionalRequirement,additionalRequirementDPRC=:additionalRequirementDPRC  where institutionalInfraActivityId=:institutionalInfraActivityId"),
})
public class InstitutionalInfraActivityPlan {
	
	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	@Column(name="institutional_infra_activity_id",updatable=false,nullable=false)
	private Integer institutionalInfraActivityId;
	
	@Column(name="state_code")
	private Integer stateCode;
	
	@Column(name="year_id")
	private Integer yearId;
	
	@Column(name="version_no")
	private int versionNumber;
	
	@Column(name="user_type")
	private String userType;
	
	@Column(name="additional_requirement")
	private int additionalRequirement;
	
	@Column(name="created_by")
	private Integer createdBy;
	
	@CreationTimestamp
	@Column(name="created_on",updatable=false)
	private Timestamp createdOn;
	
	@Column(name="last_updated_by")
	private Integer lastUpdatedBy;
	
	@UpdateTimestamp
	@Column(name="last_updated_on")
	private Timestamp lastUpdatedOn;
	
	@OneToMany(mappedBy="institutionalInfraActivityPlan",cascade=CascadeType.ALL)
	private List<InstitutionalInfraActivityPlanDetails> institutionalInfraActivityPlanDetails;
	
	@Column(name="is_freeze")
	private Boolean isFreeze;
	
	@Column(name="additional_requirement_dprc")
	private int additionalRequirementDPRC;
	
	
	@Transient
	private Integer detailsListLength;
	
	@Transient
	private String dataFor;
	

	public Integer getDetailsListLength() {
		return detailsListLength;
	}

	public void setDetailsListLength(Integer detailsListLength) {
		this.detailsListLength = detailsListLength;
	}

	public Integer getInstitutionalInfraActivityId() {
		return institutionalInfraActivityId;
	}

	public void setInstitutionalInfraActivityId(Integer institutionalInfraActivityId) {
		this.institutionalInfraActivityId = institutionalInfraActivityId;
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

	public int getVersionNumber() {
		return versionNumber;
	}

	public void setVersionNumber(int versionNumber) {
		this.versionNumber = versionNumber;
	}

	public int getAdditionalRequirement() {
		return additionalRequirement;
	}

	public void setAdditionalRequirement(int additionalRequirement) {
		this.additionalRequirement = additionalRequirement;
	}

	public Integer getCreatedBy() {
		return createdBy;
	}

	public void setCreatedBy(Integer createdBy) {
		this.createdBy = createdBy;
	}

	public Timestamp getCreatedOn() {
		return createdOn;
	}

	public void setCreatedOn(Timestamp createdOn) {
		this.createdOn = createdOn;
	}

	public Integer getLastUpdatedBy() {
		return lastUpdatedBy;
	}

	public void setLastUpdatedBy(Integer lastUpdatedBy) {
		this.lastUpdatedBy = lastUpdatedBy;
	}

	public Timestamp getLastUpdatedOn() {
		return lastUpdatedOn;
	}

	public void setLastUpdatedOn(Timestamp lastUpdatedOn) {
		this.lastUpdatedOn = lastUpdatedOn;
	}

	public List<InstitutionalInfraActivityPlanDetails> getInstitutionalInfraActivityPlanDetails() {
		return institutionalInfraActivityPlanDetails;
	}

	public void setInstitutionalInfraActivityPlanDetails(
			List<InstitutionalInfraActivityPlanDetails> institutionalInfraActivityPlanDetails) {
		this.institutionalInfraActivityPlanDetails = institutionalInfraActivityPlanDetails;
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

	public String getDataFor() {
		return dataFor;
	}

	public void setDataFor(String dataFor) {
		this.dataFor = dataFor;
	}

	public int getAdditionalRequirementDPRC() {
		return additionalRequirementDPRC;
	}

	public void setAdditionalRequirementDPRC(int additionalRequirementDPRC) {
		this.additionalRequirementDPRC = additionalRequirementDPRC;
	}
	
	
}