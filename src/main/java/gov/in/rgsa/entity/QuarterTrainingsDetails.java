package gov.in.rgsa.entity;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToOne;
import javax.persistence.Table;
import javax.persistence.Transient;

import org.springframework.web.multipart.MultipartFile;

import com.fasterxml.jackson.annotation.JsonBackReference;

@Entity
@Table(name="qpr_trainings_details",schema="rgsa")
public class QuarterTrainingsDetails {
	
	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	@Column(name="qpr_trainings_details_id")
	private Integer qprTrainingsDetailsId;
	
	@JsonBackReference
	@ManyToOne
	@JoinColumn(name="qpr_trainings_id")
	private QuarterTrainings quarterTrainings;
	
	@Column(name="training_activity_details_id")
	private Integer trainingActivityDetailsId;
	
	@Column(name="expenditure_incurred")
	private Long expenditureIncurred;
	
	@OneToOne(fetch=FetchType.EAGER,cascade=CascadeType.ALL)
	@JoinColumn(name="file_node_id")
	private FileNode fileNode;
	
	@Transient
	private MultipartFile file;

	public Integer getQprTrainingsDetailsId() {
		return qprTrainingsDetailsId;
	}

	public void setQprTrainingsDetailsId(Integer qprTrainingsDetailsId) {
		this.qprTrainingsDetailsId = qprTrainingsDetailsId;
	}

	public QuarterTrainings getQuarterTrainings() {
		return quarterTrainings;
	}

	public void setQuarterTrainings(QuarterTrainings quarterTrainings) {
		this.quarterTrainings = quarterTrainings;
	}

	

	public Integer getTrainingActivityDetailsId() {
		return trainingActivityDetailsId;
	}

	public void setTrainingActivityDetailsId(Integer trainingActivityDetailsId) {
		this.trainingActivityDetailsId = trainingActivityDetailsId;
	}

	public Long getExpenditureIncurred() {
		return expenditureIncurred;
	}

	public void setExpenditureIncurred(Long expenditureIncurred) {
		this.expenditureIncurred = expenditureIncurred;
	}

	public FileNode getFileNode() {
		return fileNode;
	}

	public void setFileNode(FileNode fileNode) {
		this.fileNode = fileNode;
	}

	public MultipartFile getFile() {
		return file;
	}

	public void setFile(MultipartFile file) {
		this.file = file;
	}
	
	

}
