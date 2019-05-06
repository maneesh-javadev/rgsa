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
@Table(name="satcom_activity",schema="rgsa")
@NamedQueries({@NamedQuery(name="FETCH_SATCOM_ACTIVITY_DETAILS",query="select sa from SatcomActivity sa  where sa.stateCode=:stateCode and sa.yearId=:yearId and sa.userType=:userType"),
@NamedQuery(name="GET_Satcom_ActivityAPPROVED_TRAINING", 
query="SELECT SA from SatcomActivity SA RIGHT OUTER JOIN FETCH SA.activityDetails AD where SA.yearId=:yearId and SA.userType=:userType and SA.stateCode=:stateCode order by AD.satcomActivityDetailsId ")
})
public class SatcomActivity implements Serializable{
	
	/**
	 * Monty
	 */
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name="satcom_activity_id")
	private Integer satcomActivityId;
	
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
	
	
	@Column(name="last_updated_on")
	@UpdateTimestamp
	private Timestamp lastUpdatedOn;
	
	@Column(name="status")
	private String status;
	
	@OneToMany(mappedBy="satcomActivity",cascade=CascadeType.ALL)
	private List<SatcomActivityDetails> activityDetails;

	public Integer getSatcomActivityId() {
		return satcomActivityId;
	}

	public void setSatcomActivityId(Integer satcomActivityId) {
		this.satcomActivityId = satcomActivityId;
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

	public List<SatcomActivityDetails> getActivityDetails() {
		return activityDetails;
	}

	public void setActivityDetails(List<SatcomActivityDetails> activityDetails) {
		this.activityDetails = activityDetails;
	}
	
	

}
