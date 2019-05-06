package gov.in.rgsa.entity;

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
@Table(name="qpr_trainings",schema="rgsa")

@NamedQueries({
@NamedQuery(name="FETCH_QPR_TRAINING_DETAIL_DEPEND_ON_QUATOR",query ="SELECT Q FROM QuarterTrainings Q WHERE Q.qtrId=:qtrId and Q.trainingActivityId=:trainingActivityId"),
@NamedQuery(name="UPDATE_QPR_TRAINING_DETAIL_DEPEND_ON_QUATOR",query="UPDATE QuarterTrainings SET additionalRequirement=:additionalRequirement where qprTrainingsId=:qprTrainingsId"),
})
public class QuarterTrainings {
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name="qpr_trainings_id")
	private Integer qprTrainingsId;
	
	@Column(name="training_activity_id")
	private Integer trainingActivityId;
	
	@Column(name="qtr_id")
	private Integer qtrId;
	
	@Column(name="additional_requirement")
	private Integer additionalRequirement;
	
	@Column(name="created_by")
	private Integer createdBy;
	
	@CreationTimestamp
	@Column(name="created_on",updatable=false)
	private Date createdOn;
	
	@Column(name="last_updated_by")
	private Integer lastUpdatedBy;
	
	@UpdateTimestamp
	@Column(name="last_updated_on")
	private Date lastUpdateOn;
	
	@Column(name="is_freeze")
	private Boolean isFreeze;
	
	@OneToMany(fetch=FetchType.EAGER,cascade=CascadeType.ALL,mappedBy="quarterTrainings")
	private List<QuarterTrainingsDetails> quarterTrainingsDetailsList;

	public Integer getQprTrainingsId() {
		return qprTrainingsId;
	}

	public void setQprTrainingsId(Integer qprTrainingsId) {
		this.qprTrainingsId = qprTrainingsId;
	}

	public Integer getTrainingActivityId() {
		return trainingActivityId;
	}

	public void setTrainingActivityId(Integer trainingActivityId) {
		this.trainingActivityId = trainingActivityId;
	}

	public Integer getQtrId() {
		return qtrId;
	}

	public void setQtrId(Integer qtrId) {
		this.qtrId = qtrId;
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

	public Date getCreatedOn() {
		return createdOn;
	}

	public void setCreatedOn(Date createdOn) {
		this.createdOn = createdOn;
	}

	public Integer getLastUpdatedBy() {
		return lastUpdatedBy;
	}

	public void setLastUpdatedBy(Integer lastUpdatedBy) {
		this.lastUpdatedBy = lastUpdatedBy;
	}

	public Date getLastUpdateOn() {
		return lastUpdateOn;
	}

	public void setLastUpdateOn(Date lastUpdateOn) {
		this.lastUpdateOn = lastUpdateOn;
	}

	public Boolean getIsFreeze() {
		return isFreeze;
	}

	public void setIsFreeze(Boolean isFreeze) {
		this.isFreeze = isFreeze;
	}

	public List<QuarterTrainingsDetails> getQuarterTrainingsDetailsList() {
		return quarterTrainingsDetailsList;
	}

	public void setQuarterTrainingsDetailsList(List<QuarterTrainingsDetails> quarterTrainingsDetailsList) {
		this.quarterTrainingsDetailsList = quarterTrainingsDetailsList;
	}
	
	

}
