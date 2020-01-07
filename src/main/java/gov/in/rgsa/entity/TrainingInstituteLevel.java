package gov.in.rgsa.entity;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name="training_institute_level",schema="rgsa")
public class TrainingInstituteLevel implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 5287333680715590633L;

	@Id
	@Column(name="training_institute_level_id")
	private Integer trainingInstituteLevelId;
	
	@Column(name="training_institute_level_name")
	private String trainingInstituteLevelName;
	
	@Column(name="ceiling_value")
	private Integer ceilingValue;

	public Integer getTrainingInstituteLevelId() {
		return trainingInstituteLevelId;
	}

	public void setTrainingInstituteLevelId(Integer trainingInstituteLevelId) {
		this.trainingInstituteLevelId = trainingInstituteLevelId;
	}

	public String getTrainingInstituteLevelName() {
		return trainingInstituteLevelName;
	}

	public void setTrainingInstituteLevelName(String trainingInstituteLevelName) {
		this.trainingInstituteLevelName = trainingInstituteLevelName;
	}

	public Integer getCeilingValue() {
		return ceilingValue;
	}

	public void setCeilingValue(Integer ceilingValue) {
		this.ceilingValue = ceilingValue;
	}
	
	
}
