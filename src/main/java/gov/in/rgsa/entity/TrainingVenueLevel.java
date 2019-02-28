package gov.in.rgsa.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.NamedQuery;
import javax.persistence.Table;
/**
 * @author Mohammad Ayaz 06/09/2018
 *
 */

@Entity
@Table(name="training_venue_level",schema="rgsa")
@NamedQuery(name="FETCH_ALL_VENUE_LEVEL",query="FROM TrainingVenueLevel")
public class TrainingVenueLevel {

	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	@Column(name="training_venue_level_id",nullable=false)
	private Integer trainingVenueLevelId;

	@Column(name="training_venue_level_name")
	private String trainingVenueLevelName;
	
	@Column(name="ceiling_value")
	private int ceilingValue;

	public Integer getTrainingVenueLevelId() {
		return trainingVenueLevelId;
	}

	public void setTrainingVenueLevelId(Integer trainingVenueLevelId) {
		this.trainingVenueLevelId = trainingVenueLevelId;
	}

	public String getTrainingVenueLevelName() {
		return trainingVenueLevelName;
	}

	public void setTrainingVenueLevelName(String trainingVenueLevelName) {
		this.trainingVenueLevelName = trainingVenueLevelName;
	}

	public int getCeilingValue() {
		return ceilingValue;
	}

	public void setCeilingValue(int ceilingValue) {
		this.ceilingValue = ceilingValue;
	}
	
}
