package gov.in.rgsa.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import com.fasterxml.jackson.annotation.JsonBackReference;

@Entity
@Table(name="training_institute_cf_details",schema="rgsa")
public class TrainingInstituteCfDetails {
	
	/**
	 * 
	 */

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name="training_institute_cf_details_id")
	private Integer trainingInstituteCfDetailsId;
	
	@JsonBackReference
	@ManyToOne
	@JoinColumn(name="training_institute_cf_id")
	private TrainingInstituteCarryForward carryForward;
	
	
	@ManyToOne
	@JoinColumn(name="training_institue_activity_type_id")
	private TrainingInstitueActivityType trainingInstitueType;
	
	@Column(name="units_approved")
	private Integer unitsApproved;
	
	@Column(name="funds_released")
	private Integer fundsReleased;
	
	@Column(name="units_completed")
	private Integer unitsCompleted;
	
	@Column(name="units_under_progress")
	private Integer unitsUnderProgress;
	
	@Column(name="funds_required")
	private Integer fundsRequired;
	
	@Column(name="remarks")
	private String remarks;

	public Integer getTrainingInstituteCfDetailsId() {
		return trainingInstituteCfDetailsId;
	}

	public void setTrainingInstituteCfDetailsId(Integer trainingInstituteCfDetailsId) {
		this.trainingInstituteCfDetailsId = trainingInstituteCfDetailsId;
	}

	public TrainingInstituteCarryForward getCarryForward() {
		return carryForward;
	}

	public void setCarryForward(TrainingInstituteCarryForward carryForward) {
		this.carryForward = carryForward;
	}

	
	public Integer getUnitsApproved() {
		return unitsApproved;
	}

	public void setUnitsApproved(Integer unitsApproved) {
		this.unitsApproved = unitsApproved;
	}

	public Integer getFundsReleased() {
		return fundsReleased;
	}

	public void setFundsReleased(Integer fundsReleased) {
		this.fundsReleased = fundsReleased;
	}

	public Integer getUnitsCompleted() {
		return unitsCompleted;
	}

	public void setUnitsCompleted(Integer unitsCompleted) {
		this.unitsCompleted = unitsCompleted;
	}

	public Integer getUnitsUnderProgress() {
		return unitsUnderProgress;
	}

	public void setUnitsUnderProgress(Integer unitsUnderProgress) {
		this.unitsUnderProgress = unitsUnderProgress;
	}

	public Integer getFundsRequired() {
		return fundsRequired;
	}

	public void setFundsRequired(Integer fundsRequired) {
		this.fundsRequired = fundsRequired;
	}

	public String getRemarks() {
		return remarks;
	}

	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}

	public TrainingInstitueActivityType getTrainingInstitueType() {
		return trainingInstitueType;
	}

	public void setTrainingInstitueType(TrainingInstitueActivityType trainingInstitueType) {
		this.trainingInstitueType = trainingInstitueType;
	}
	
	
}
