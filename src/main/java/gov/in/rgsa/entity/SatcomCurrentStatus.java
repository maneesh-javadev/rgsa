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
@Table(name="satcom_currentstatus", schema = "rgsa")
@NamedQuery(name="FETCH_SATCOM_CURRENTSTATUS",query="SELECT scs FROM SatcomCurrentStatus scs where stateCode=:stateCode and yearId=:yearId and userType=:userType")
public class SatcomCurrentStatus {
	
	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	@Column(name="satcom_cs_id",updatable=false,nullable=false)
	private Integer satcom_currentstatus_id;
	
	@Column(name="state_code")
	private Integer stateCode;
	
	@Column(name="year_id")
	private Integer yearId;
	
	@Column(name="user_type")
	private Character userType;
	
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
	
	@OneToMany(mappedBy="satcomCurrentStatus",cascade=CascadeType.ALL)
	private List<SatcomCurrentStatusDetails> activityDetails;
	
	@Column(name="is_freeze")
	private Boolean isFreeze;
	
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

	public Integer getSatcom_currentstatus_id() {
		return satcom_currentstatus_id;
	}

	public void setSatcom_currentstatus_id(Integer satcom_currentstatus_id) {
		this.satcom_currentstatus_id = satcom_currentstatus_id;
	}

	public List<SatcomCurrentStatusDetails> getActivityDetails() {
		return activityDetails;
	}

	public void setActivityDetails(List<SatcomCurrentStatusDetails> activityDetails) {
		this.activityDetails = activityDetails;
	}

	public Boolean getIsFreeze() {
		return isFreeze;
	}

	public void setIsFreeze(Boolean isFreeze) {
		this.isFreeze = isFreeze;
	}

}