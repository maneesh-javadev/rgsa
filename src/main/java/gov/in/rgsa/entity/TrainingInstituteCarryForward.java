package gov.in.rgsa.entity;

import java.sql.Timestamp;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.NamedQuery;
import javax.persistence.OneToMany;
import javax.persistence.Table;

import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;

@Entity
@Table(name="training_institute_carryforward",schema="rgsa")
@NamedQuery(name="FETCH_TRAINING_INSTITUTION_CF_DETAILS",query="from TrainingInstituteCarryForward   where stateCode=:stateCode and yearId=:yearId and userType=:userType")
public class TrainingInstituteCarryForward{
	
	/**
	 * Monty
	 */

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name="training_institute_cf_id")
	private Integer trainingInstituteCfId;
	
	
	@OneToMany(mappedBy="carryForward",cascade=CascadeType.ALL)
	private List<TrainingInstituteCfDetails> cfDetails;
	
	@Column(name = "state_code")
	private Integer stateCode;
	
	@Column(name = "year_id")
	private Integer yearId;
	
	@Column(name = "version_no")
	private Integer versionNo;
	
	@Column(name="user_type")
	private String userType;
	
	@Column(name="created_by")
	private Integer createdBy;
	
	
	@Column(name="created_on",updatable=false)
	@CreationTimestamp
	private Timestamp createdOn;
	
	@Column(name="last_updated_by")
	private Integer lastUpdatedBy;
	
	
	@Column(name="last_updated_on")
	@UpdateTimestamp
	private Timestamp lastUpdatedOn;
	
	@Column(name="status")
	private String status;

	public Integer getTrainingInstituteCfId() {
		return trainingInstituteCfId;
	}

	public void setTrainingInstituteCfId(Integer trainingInstituteCfId) {
		this.trainingInstituteCfId = trainingInstituteCfId;
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

	public String getUserType() {
		return userType;
	}

	public void setUserType(String userType) {
		this.userType = userType;
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

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public List<TrainingInstituteCfDetails> getCfDetails() {
		return cfDetails;
	}

	public void setCfDetails(List<TrainingInstituteCfDetails> cfDetails) {
		this.cfDetails = cfDetails;
	}
	

	
}
