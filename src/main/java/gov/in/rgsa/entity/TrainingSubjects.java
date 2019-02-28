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

/**
 * @author Mohammad Ayaz 06/09/2018
 *
 */

@Entity
@Table(name="training_subjects" ,schema="rgsa")
@NamedQuery(name="DELETE_TRANGSUBJCT_TRAINING_ID" , query="delete from TrainingSubjects where subjectsTrainingActivityDetails.trainingActivityDetailsId=:trngId")
public class TrainingSubjects {
	
	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	@Column(name="training_wise_subject_id")
	private Integer trainingWiseSubjectId;
	
	@ManyToOne
	@JoinColumn(name="training_id" ,referencedColumnName="training_id")
	private TrainingActivityDetails subjectsTrainingActivityDetails;
	
	@ManyToOne
	@JoinColumn(name="subject_id",referencedColumnName="subject_id")
	private Subjects trngSubjectId;

	public Integer getTrainingWiseSubjectId() {
		return trainingWiseSubjectId;
	}

	public void setTrainingWiseSubjectId(Integer trainingWiseSubjectId) {
		this.trainingWiseSubjectId = trainingWiseSubjectId;
	}

	public TrainingActivityDetails getSubjectsTrainingActivityDetails() {
		return subjectsTrainingActivityDetails;
	}

	public void setSubjectsTrainingActivityDetails(TrainingActivityDetails subjectsTrainingActivityDetails) {
		this.subjectsTrainingActivityDetails = subjectsTrainingActivityDetails;
	}

	public Subjects getTrngSubjectId() {
		return trngSubjectId;
	}

	public void setTrngSubjectId(Subjects trngSubjectId) {
		this.trngSubjectId = trngSubjectId;
	}

	

}