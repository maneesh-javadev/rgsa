package gov.in.rgsa.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;

@Entity
@Table(name="training_wise_category" ,schema="rgsa")
@NamedQueries({
@NamedQuery(name="DELETE_TRANGCATEGORY_TRAINING_ID" , query="delete from TrainingWiseCategory where targetTrainingActivityDetails.trainingActivityDetailsId=:trngId"),
@NamedQuery(name="FETCH_TRANGCATEGORY_TRAINING_ID" , query="from TrainingWiseCategory where targetTrainingActivityDetails.trainingActivityDetailsId=:trngId")
})

public class TrainingWiseCategory {
	
	
	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	@Column(name="id")
	private Integer id;
	
	@ManyToOne
	@JoinColumn(name="training_id" ,referencedColumnName="training_id")
	private TrainingActivityDetails targetTrainingActivityDetails;
	
	@ManyToOne
	@JoinColumn(name="training_category_id",referencedColumnName="training_category_id")
	private TrainingCategories trainingCategories;

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	

	public TrainingActivityDetails getTargetTrainingActivityDetails() {
		return targetTrainingActivityDetails;
	}

	public void setTargetTrainingActivityDetails(TrainingActivityDetails targetTrainingActivityDetails) {
		this.targetTrainingActivityDetails = targetTrainingActivityDetails;
	}

	public TrainingCategories getTrainingCategories() {
		return trainingCategories;
	}

	public void setTrainingCategories(TrainingCategories trainingCategories) {
		this.trainingCategories = trainingCategories;
	}

	
}
