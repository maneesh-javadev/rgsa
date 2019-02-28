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

import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;

/**
 * 
 * @author sourabh
 *
 */

@Entity
@Table(name="training_institute_currentstatus", schema = "rgsa")

@NamedQueries({
	@NamedQuery(name="TRAINING_INSTITUTE_CURRENTSTATUS",query="SELECT tics FROM TrainingInstituteCurrentStatus tics where stateCode=:stateCode and yearId=:yearId and userType=:userType"),
	@NamedQuery(name="TRAINING_INSTITUTE_CURRENTSTATUS_BY_ID",query="SELECT tics FROM TrainingInstituteCurrentStatus tics where trainingInstituteCurrentStatusId=:trainingInstituteCurrentStatusId"),
	@NamedQuery(name="TRAINING_INSTITUTE_CURRENTSTATUS_BY_LOCATION_LEVEL",
		query="FROM TrainingInstituteCurrentStatus tics left outer join fetch tics.trainingInstituteCurrentStatusDetails tid where tid.tiLocation=:location and tid.trainingInstitueType.instituteLevel.trainingInstituteLevelId=:level")
})
public class TrainingInstituteCurrentStatus {
	
	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	@Column(name="ti_cs_id",updatable=false,nullable=false)
	private Integer trainingInstituteCurrentStatusId;
	
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
	
	@OneToMany(mappedBy="trainingInstituteCurrentStatus",cascade=CascadeType.ALL)
	private List<TrainingInstituteCurrentStatusDetails> trainingInstituteCurrentStatusDetails;
	
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

	public Boolean getIsFreeze() {
		return isFreeze;
	}

	public void setIsFreeze(Boolean isFreeze) {
		this.isFreeze = isFreeze;
	}

	public Integer getTrainingInstituteCurrentStatusId() {
		return trainingInstituteCurrentStatusId;
	}

	public void setTrainingInstituteCurrentStatusId(Integer trainingInstituteCurrentStatusId) {
		this.trainingInstituteCurrentStatusId = trainingInstituteCurrentStatusId;
	}

	public List<TrainingInstituteCurrentStatusDetails> getTrainingInstituteCurrentStatusDetails() {
		return trainingInstituteCurrentStatusDetails;
	}

	public void setTrainingInstituteCurrentStatusDetails(
			List<TrainingInstituteCurrentStatusDetails> trainingInstituteCurrentStatusDetails) {
		this.trainingInstituteCurrentStatusDetails = trainingInstituteCurrentStatusDetails;
	}
}