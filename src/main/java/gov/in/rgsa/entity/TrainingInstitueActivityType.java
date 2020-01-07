package gov.in.rgsa.entity;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQuery;
import javax.persistence.Table;

import com.fasterxml.jackson.annotation.JsonManagedReference;

@Entity
@Table(name="training_institue_activity_type",schema="rgsa")
@NamedQuery(name="FETCH_TRAINING_INSTITUTION_ACTIVITY_TYPE",query="from TrainingInstitueActivityType order by trainingInstitueActivityTypeId")
public class TrainingInstitueActivityType implements Serializable {

	
	/**
	 * 
	 */
	private static final long serialVersionUID = -5960536648459612739L;

	@Id
	@Column(name="training_institue_activity_type_id")
	private Integer trainingInstitueActivityTypeId;
	
	@Column(name="training_institue_activity_type_name")
	private String trainingInstitueActivityTypeName;
	
	@ManyToOne
	@JoinColumn(name="training_institue_type_id")
	private TrainingInstitueType trainingInstitueType;

	public Integer getTrainingInstitueActivityTypeId() {
		return trainingInstitueActivityTypeId;
	}

	public void setTrainingInstitueActivityTypeId(Integer trainingInstitueActivityTypeId) {
		this.trainingInstitueActivityTypeId = trainingInstitueActivityTypeId;
	}

	public String getTrainingInstitueActivityTypeName() {
		return trainingInstitueActivityTypeName;
	}

	public void setTrainingInstitueActivityTypeName(String trainingInstitueActivityTypeName) {
		this.trainingInstitueActivityTypeName = trainingInstitueActivityTypeName;
	}

	public TrainingInstitueType getTrainingInstitueType() {
		return trainingInstitueType;
	}

	public void setTrainingInstitueType(TrainingInstitueType trainingInstitueType) {
		this.trainingInstitueType = trainingInstitueType;
	}
	
	
	
}
