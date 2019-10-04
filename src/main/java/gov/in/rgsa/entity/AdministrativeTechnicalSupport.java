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

@Entity

@Table(name="administrative_technical_support",schema="rgsa")
@NamedQueries({@NamedQuery(name="GET_Admin_Technical_Support_APPROVED_TRAINING", 
query="SELECT adm from AdministrativeTechnicalSupport adm RIGHT OUTER JOIN FETCH adm.supportDetails sd where adm.yearId=:yearId and adm.userType=:userType and adm.stateCode=:stateCode and adm.isActive=true"),
@NamedQuery(query="FROM AdministrativeTechnicalSupport adm left outer join fetch adm.supportDetails sd where adm.stateCode=:stateCode and adm.userType=:userType and adm.yearId=:yearId and adm.versionNo=:versionNo and adm.isActive=true order by sd.id asc",name="FETCH_ADMIN_TECH_SUPPORT")})
public class AdministrativeTechnicalSupport{
	
	/**
	 * Monty Garg
	 */
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "administrative_technical_support_id")
	private Integer administrativeTechnicalSupportId;
	
	@Column(name = "state_code")
	private Integer stateCode;
	
	@Column(name = "year_id")
	private Integer yearId;
	
	@Column(name = "version_no")
	private Integer versionNo;
	
	@Column(name="user_type")
	private String userType;
	
	@Column(name="additional_requirement")
	private Integer additionalRequirement;
	
	@Column(name="created_by")
	private Integer createdBy;
	
	@Column(name="created_on",updatable=false)
	@CreationTimestamp
	private Timestamp createdOn;
	
	@Column(name="last_updated_by")
	private Integer lastUpdatedBy;
	
	@Transient
	private String dbFileName;
	
	@Column(name="last_updated_on")
	@UpdateTimestamp
	private Timestamp lastUpdatedOn;
	
	
	@OneToMany(mappedBy="administrativeTechnicalSupport",cascade=CascadeType.ALL)
	private List<AdministrativeTechnicalSupportDetails> supportDetails;
	
	@Column(name="status")
	private String status;
	
	@Column(name="is_active")
	private Boolean isActive;

	public Integer getAdministrativeTechnicalSupportId() {
		return administrativeTechnicalSupportId;
	}

	public void setAdministrativeTechnicalSupportId(Integer administrativeTechnicalSupportId) {
		this.administrativeTechnicalSupportId = administrativeTechnicalSupportId;
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

	public Timestamp getCreatedOn() {
		return createdOn;
	}

	public void setCreatedOn(Timestamp createdOn) {
		this.createdOn = createdOn;
	}

	public void setLastUpdatedOn(Timestamp lastUpdatedOn) {
		this.lastUpdatedOn = lastUpdatedOn;
	}

	public Integer getLastUpdatedBy() {
		return lastUpdatedBy;
	}

	public void setLastUpdatedBy(Integer lastUpdatedBy) {
		this.lastUpdatedBy = lastUpdatedBy;
	}

	public List<AdministrativeTechnicalSupportDetails> getSupportDetails() {
		return supportDetails;
	}

	public void setSupportDetails(List<AdministrativeTechnicalSupportDetails> supportDetails) {
		this.supportDetails = supportDetails;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public Timestamp getLastUpdatedOn() {
		return lastUpdatedOn;
	}

	public String getDbFileName() {
		return dbFileName;
	}

	public void setDbFileName(String dbFileName) {
		this.dbFileName = dbFileName;
	}

	public Boolean getIsActive() {
		return isActive;
	}

	public void setIsActive(Boolean isActive) {
		this.isActive = isActive;
	}
	
}
