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
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.OneToMany;
import javax.persistence.Table;

import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;

@Entity
@Table(name="administrative_technical_support_currentstatus",schema="rgsa")
@NamedQueries({
@NamedQuery(query="FROM AdministrativeAndTechnicalStaffStatus adm left outer join fetch adm.administrativeAndTechnicalStaffStatusDetails sd where adm.stateCode=:stateCode and adm.userType=:userType and adm.yearId=:yearId order by sd.postType.postId asc",name="FETCH_ADMIN_TECH_STAFF_STATUS"),
@NamedQuery(query="UPDATE AdministrativeAndTechnicalStaffStatus set isFreeze=:isFreeze where administrativeAndTechnicalStaffStatusId=:id",name="UPDATE_STATUS")
})
public class AdministrativeAndTechnicalStaffStatus implements Serializable{
	
	/**
	 * Sourabh rai
	 */
	
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "at_cs_id")
	private Integer administrativeAndTechnicalStaffStatusId;
	
	@Column(name = "state_code")
	private Integer stateCode;
	
	@Column(name = "year_id")
	private Integer yearId;
	
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
	
	@OneToMany(mappedBy="administrativeAndTechnicalStaffStatus",cascade=CascadeType.ALL)
	private List<AdministrativeAndTechnicalStaffStatusDetails> administrativeAndTechnicalStaffStatusDetails;
	
	@Column(name="is_freeze")
	private Boolean isFreeze;

	public Integer getAdministrativeAndTechnicalStaffStatusId() {
		return administrativeAndTechnicalStaffStatusId;
	}

	public void setAdministrativeAndTechnicalStaffStatusId(Integer administrativeAndTechnicalStaffStatusId) {
		this.administrativeAndTechnicalStaffStatusId = administrativeAndTechnicalStaffStatusId;
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

	public List<AdministrativeAndTechnicalStaffStatusDetails> getAdministrativeAndTechnicalStaffStatusDetails() {
		return administrativeAndTechnicalStaffStatusDetails;
	}

	public void setAdministrativeAndTechnicalStaffStatusDetails(
			List<AdministrativeAndTechnicalStaffStatusDetails> administrativeAndTechnicalStaffStatusDetails) {
		this.administrativeAndTechnicalStaffStatusDetails = administrativeAndTechnicalStaffStatusDetails;
	}

	public Boolean getIsFreeze() {
		return isFreeze;
	}

	public void setIsFreeze(Boolean isFreeze) {
		this.isFreeze = isFreeze;
	}
}
