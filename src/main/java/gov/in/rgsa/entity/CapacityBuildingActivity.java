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

/**
 * 
 * @author sourabh
 *
 */

@Entity
@Table(name="cb_activity", schema = "rgsa")
@NamedQuery(name="FETCH_CAPACITY_BUILDING",query="SELECT cb FROM CapacityBuildingActivity cb left outer join fetch cb.capacityBuildingActivityDetails cbad where cb.stateCode=:stateCode and cb.userType=:userType and cb.yearId=:yearId and cb.versionNo=:versionNo order by cbad.capacityBuildingActivityDetailsId asc")
public class CapacityBuildingActivity {
	
	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	@Column(name="cb_activity_id",updatable=false,nullable=false)
	private Integer cbActivityId;
	
	@Column(name="state_code")
	private Integer stateCode;
	
	@Column(name="year_id")
	private Integer yearId;
	
	@Column(name="version_no")
	private Integer versionNo;
	
	@Column(name="user_type")
	private Character userType;
	
	@Column(name="additional_requirement")
	private Double additionalRequirement;
	
	@Column(name="if_freeze")
	private Boolean isFreeze;
	
//	@JsonManagedReference
	@OneToMany(mappedBy="capacityBuildingActivity",cascade=CascadeType.ALL)
	private List<CapacityBuildingActivityDetails> capacityBuildingActivityDetails;
	
	@Column(name="created_by")
	private Integer createdBy;
	
	@Column(name="is_active")
	private Boolean isActive;
	
	@CreationTimestamp
	@Column(name="created_on",updatable=false)
	private Timestamp createdOn;
	
	public Integer getCbActivityId() {
		return cbActivityId;
	}

	public void setCbActivityId(Integer cbActivityId) {
		this.cbActivityId = cbActivityId;
	}

	public Boolean getIsFreeze() {
		return isFreeze;
	}

	public void setIsFreeze(Boolean isFreeze) {
		this.isFreeze = isFreeze;
	}

	public List<CapacityBuildingActivityDetails> getCapacityBuildingActivityDetails() {
		return capacityBuildingActivityDetails;
	}

	public void setCapacityBuildingActivityDetails(List<CapacityBuildingActivityDetails> capacityBuildingActivityDetails) {
		this.capacityBuildingActivityDetails = capacityBuildingActivityDetails;
	}

	@Column(name="last_updated_by")
	private Integer lastUpdatedBy;
	
	@UpdateTimestamp
	@Column(name="last_updated_on")
	private Timestamp lastUpdatedOn;

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

	public Character getUserType() {
		return userType;
	}

	public void setUserType(Character userType) {
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

	public Double getAdditionalRequirement() {
		return additionalRequirement;
	}

	public void setAdditionalRequirement(Double additionalRequirement) {
		this.additionalRequirement = additionalRequirement;
	}

	public Boolean getIsActive() {
		return isActive;
	}

	public void setIsActive(Boolean isActive) {
		this.isActive = isActive;
	}

}