package gov.in.rgsa.controller;

import java.sql.Timestamp;
import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Transient;

import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;

import gov.in.rgsa.entity.QprTrainingBreakup;

@Entity
@Table(name="qpr_trainings",schema="rgsa")
public class QuarterTrainings {
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name="qpr_trainings_id")
	private Integer qprTrainingsId;
	
	@Column(name="plan_code")
	private Integer planCode;
	
	@Column(name="qtr_id")
	private Integer qtrId;
	
	@Column(name="training_id")
	private Integer trainingId;
	
	@Column(name="conducted_at_id")
	private Integer conductedAtId;
	
	@Column(name="no_of_participants")
	private Integer noOfParticipants;
	
	@Column(name="expenditure_incurred")
	private Integer expenditureIncurred;
	
	@Column(name="created_on",updatable=false)
	@CreationTimestamp
	private Timestamp createdOn;
	
	@Column(name="modified_on")
	@UpdateTimestamp
	private Timestamp lastUpdatedOn;
	
	
	@Transient
	List<QprTrainingBreakup> trainingBreakups;

	public Integer getQprTrainingsId() {
		return qprTrainingsId;
	}

	public void setQprTrainingsId(Integer qprTrainingsId) {
		this.qprTrainingsId = qprTrainingsId;
	}

	public Integer getPlanCode() {
		return planCode;
	}

	public void setPlanCode(Integer planCode) {
		this.planCode = planCode;
	}

	public Integer getQtrId() {
		return qtrId;
	}

	public void setQtrId(Integer qtrId) {
		this.qtrId = qtrId;
	}

	public Integer getTrainingId() {
		return trainingId;
	}

	public void setTrainingId(Integer trainingId) {
		this.trainingId = trainingId;
	}

	public Integer getConductedAtId() {
		return conductedAtId;
	}

	public void setConductedAtId(Integer conductedAtId) {
		this.conductedAtId = conductedAtId;
	}

	public Integer getNoOfParticipants() {
		return noOfParticipants;
	}

	public void setNoOfParticipants(Integer noOfParticipants) {
		this.noOfParticipants = noOfParticipants;
	}

	public Integer getExpenditureIncurred() {
		return expenditureIncurred;
	}

	public void setExpenditureIncurred(Integer expenditureIncurred) {
		this.expenditureIncurred = expenditureIncurred;
	}

	public Timestamp getCreatedOn() {
		return createdOn;
	}

	public void setCreatedOn(Timestamp createdOn) {
		this.createdOn = createdOn;
	}

	public Timestamp getLastUpdatedOn() {
		return lastUpdatedOn;
	}

	public void setLastUpdatedOn(Timestamp lastUpdatedOn) {
		this.lastUpdatedOn = lastUpdatedOn;
	}

	public List<QprTrainingBreakup> getTrainingBreakups() {
		return trainingBreakups;
	}

	public void setTrainingBreakups(List<QprTrainingBreakup> trainingBreakups) {
		this.trainingBreakups = trainingBreakups;
	}

}
