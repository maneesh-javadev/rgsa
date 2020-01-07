package gov.in.rgsa.entity;

import java.io.Serializable;
import java.sql.Timestamp;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.NamedNativeQueries;
import javax.persistence.NamedNativeQuery;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.OneToMany;
import javax.persistence.Table;

import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.LazyCollection;
import org.hibernate.annotations.LazyCollectionOption;
import org.hibernate.annotations.UpdateTimestamp;

@Entity
@NamedQueries({@NamedQuery(name="FETCH_INSTITUTE_HR_ACTIVITY",query="SELECT I FROM InstitueInfraHrActivity I where stateCode =:stateCode and yearId =:yearId and userType =:userType and versionNo=:versionNo and isActive=true")
,@NamedQuery(name="FETCH_INSTITUTE_APPROVED_HR_ACTIVITY" ,query="SELECT I FROM InstitueInfraHrActivity I where stateCode =:stateCode and yearId =:yearId and userType =:userType and isActive=true")

})

	

@Table(name="institue_infra_hr_activity",schema="rgsa")
public class InstitueInfraHrActivity implements Serializable{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 4007710382543127223L;

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name="institue_infra_hr_activity_id")
	private Integer instituteInfraHrActivityId;
	
	@Column(name="state_code")
	private Integer stateCode;
	
	@Column(name="year_id")
	private Integer yearId;
	
	@Column(name="version_no")
	private Integer versionNo;
	
	@Column(name="user_type")
	private String userType;
	
	@Column(name="created_by")
	private Integer createdBy;
	
	@CreationTimestamp
	@Column(name="created_on",updatable=false)
	private Timestamp createdOn;
	
	@Column(name="last_updated_by")
	private Integer lastUpdateBy;
	
	@UpdateTimestamp
	@Column(name="last_updated_on ")
	private Timestamp lastUpdateOn;

	@Column(name="is_freeze")
	private Boolean isFreeze;
	
	@Column(name="no_of_districts_supported")
	private Integer districtsSupported;
	
	@OneToMany(mappedBy="institueInfraHrActivity",cascade= CascadeType.ALL)
	@LazyCollection(LazyCollectionOption.FALSE)
	private List<TIWiseProposedDomainExperts> tIWiseProposedDomainExperts;
	
	@Column(name="additional_req_sprc")
	public Integer additionalRequirementSprc;
	
	@Column(name="additional_req_dprc")
	public Integer additionalRequirementDprc;
	
	@Column(name="is_active")
	private Boolean isActive;
	

	public Integer getInstituteInfraHrActivityId() {
		return instituteInfraHrActivityId;
	}

	public void setInstituteInfraHrActivityId(Integer instituteInfraHrActivityId) {
		this.instituteInfraHrActivityId = instituteInfraHrActivityId;
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

	public Integer getLastUpdateBy() {
		return lastUpdateBy;
	}

	public void setLastUpdateBy(Integer lastUpdateBy) {
		this.lastUpdateBy = lastUpdateBy;
	}

	public Timestamp getLastUpdateOn() {
		return lastUpdateOn;
	}

	public void setLastUpdateOn(Timestamp lastUpdateOn) {
		this.lastUpdateOn = lastUpdateOn;
	}

	public Boolean getIsFreeze() {
		return isFreeze;
	}

	public void setIsFreeze(Boolean isFreeze) {
		this.isFreeze = isFreeze;
	}

	public List<TIWiseProposedDomainExperts> gettIWiseProposedDomainExperts() {
		return tIWiseProposedDomainExperts;
	}

	public void settIWiseProposedDomainExperts(List<TIWiseProposedDomainExperts> tIWiseProposedDomainExperts) {
		this.tIWiseProposedDomainExperts = tIWiseProposedDomainExperts;
	}

	public Integer getDistrictsSupported() {
		return districtsSupported;
	}

	public void setDistrictsSupported(Integer districtsSupported) {
		this.districtsSupported = districtsSupported;
	}

	public Integer getAdditionalRequirementSprc() {
		return additionalRequirementSprc;
	}

	public void setAdditionalRequirementSprc(Integer additionalRequirementSprc) {
		this.additionalRequirementSprc = additionalRequirementSprc;
	}

	public Integer getAdditionalRequirementDprc() {
		return additionalRequirementDprc;
	}

	public void setAdditionalRequirementDprc(Integer additionalRequirementDprc) {
		this.additionalRequirementDprc = additionalRequirementDprc;
	}

	public Boolean getIsActive() {
		return isActive;
	}

	public void setIsActive(Boolean isActive) {
		this.isActive = isActive;
	}


	
	
}

