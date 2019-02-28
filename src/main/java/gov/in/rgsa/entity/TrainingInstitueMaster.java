package gov.in.rgsa.entity;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name="training_institue_master",schema="rgsa")
public class TrainingInstitueMaster implements Serializable{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "training_institue_id",updatable = false, nullable = false)
	private Integer trainingInstitueId;
	
	@Column(name="training_institue_name")
	private String trainingInstitueName;
	
	@Column(name="level")
	private String level;

	public Integer getTrainingInstitueId() {
		return trainingInstitueId;
	}

	public void setTrainingInstitueId(Integer trainingInstitueId) {
		this.trainingInstitueId = trainingInstitueId;
	}

	public String getTrainingInstitueName() {
		return trainingInstitueName;
	}

	public void setTrainingInstitueName(String trainingInstitueName) {
		this.trainingInstitueName = trainingInstitueName;
	}

	public String getLevel() {
		return level;
	}

	public void setLevel(String level) {
		this.level = level;
	}
	
	

}
