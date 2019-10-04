package gov.in.rgsa.entity;


import java.io.Serializable;
import java.sql.Timestamp;
import java.util.Date;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.OneToMany;
import javax.persistence.Table;

import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;

@Entity
@Table(name="e_enablement", schema="rgsa")
@NamedQueries({@NamedQuery(name="FETCH_ENABLEMENT", query="SELECT E FROM EEnablement E where stateCode =:stateCode and yearId =:yearId and userType =:userType and versionNo=:versionNo and isActive=true")
,@NamedQuery(name="GET_EENABLEMENT_APPROVED_TRAINING", 
query="SELECT EE from EEnablement EE RIGHT OUTER JOIN FETCH EE.eEnablementDetails EED where EE.yearId=:yearId and EE.userType=:userType and EE.stateCode=:stateCode and EE.isActive=true"),
})
public class EEnablement implements Serializable{
	private static final long serialVersionUID = 1L;
	
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name="e_enablement_id")
	private Integer eEnablementId;
	
	@Column(name="state_code")
	private Integer stateCode;
	
	@Column(name="year_id")
	private Integer yearId;
	
	@Column(name="version_no")
	private Integer versionNo;
	
	@Column(name="user_type")
	private Character userType;
	
	@Column(name="additional_requirement")
	private Integer additionalRequirement;
	
	@Column(name="created_by")
	private Integer createdBy;
	
	@Column(name="created_on",updatable=false)
	@CreationTimestamp
	private Timestamp createdOn;
	
	@Column(name="last_updated_by")
	private Integer lastUpdatedBy;
	
	@UpdateTimestamp
	@Column(name="last_updated_on")
	private java.util.Date lastUpdatedOn;
	
	@Column(name="status")
	private String status;
	
	@Column(name="is_active")
	private Boolean isActive;


	@OneToMany(cascade=CascadeType.ALL,mappedBy="eEnablement",fetch=FetchType.EAGER)
	private List<EEnablementDetails> eEnablementDetails;
	
	
	public Integer geteEnablementId() {
		return eEnablementId;
	}

	public void seteEnablementId(Integer eEnablementId) {
		this.eEnablementId = eEnablementId;
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

	public Integer getCreatedBy() {
		return createdBy;
	}

	public void setCreatedBy(Integer createdBy) {
		this.createdBy = createdBy;
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

	public void setLastUpdatedOn(java.util.Date date) {
		this.lastUpdatedOn = (Date) date;
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

	
	

	public Character getUserType() {
		return userType;
	}

	public void setUserType(Character userType) {
		this.userType = userType;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	public Timestamp getCreatedOn() {
		return createdOn;
	}

	public void setCreatedOn(Timestamp createdOn) {
		this.createdOn = createdOn;
	}

	public Boolean getIsActive() {
		return isActive;
	}

	public void setIsActive(Boolean isActive) {
		this.isActive = isActive;
	}
}
