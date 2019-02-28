package gov.in.rgsa.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.NamedQuery;
import javax.persistence.Table;

/**
* @author Mohammad Ayaz 08/01/2019
*
*/

@Entity
@Table(name="training_mode" , schema="rgsa")
@NamedQuery(name="FETCH_TRAINING_MODES" ,query="from TrainingMode")
public class TrainingMode {
	
	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	@Column(name="training_mode_id",nullable=false)
	private Integer trainingModeId;
	
	@Column(name="training_mode_name")
	private String trainingModeName;

	public Integer getTrainingModeId() {
		return trainingModeId;
	}

	public void setTrainingModeId(Integer trainingModeId) {
		this.trainingModeId = trainingModeId;
	}

	public String getTrainingModeName() {
		return trainingModeName;
	}

	public void setTrainingModeName(String trainingModeName) {
		this.trainingModeName = trainingModeName;
	}
}