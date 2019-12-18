package gov.in.rgsa.entity;

import java.io.Serializable;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.OneToOne;
import javax.persistence.OrderBy;
import javax.persistence.Table;
import javax.persistence.Transient;

import org.springframework.core.annotation.Order;
import org.springframework.web.multipart.MultipartFile;

import com.fasterxml.jackson.annotation.JsonBackReference;
import com.fasterxml.jackson.annotation.JsonIgnore;

@Entity
@Table(name="qpr_trainings_details",schema="rgsa")
public class QuarterTrainingsDetails implements Serializable {
	 
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	@Column(name="qpr_trainings_details_id" )
	@OrderBy(value = "ASC")
	private Integer qprTrainingsDetailsId ;
	
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
	
	@JsonIgnore
	@OneToMany(fetch=FetchType.EAGER,cascade=CascadeType.ALL,mappedBy="quarterTrainingsDetails")
	private List<QprTrainingBreakup> qprTrainingBreakup;
	
	@Transient
	private Integer totalParticipantsEnter = 0;

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

	public List<QprTrainingBreakup> getQprTrainingBreakup() {
		return qprTrainingBreakup;
	}

	public void setQprTrainingBreakup(List<QprTrainingBreakup> qprTrainingBreakup) {
		this.qprTrainingBreakup = qprTrainingBreakup;
	}

	public Integer getTotalParticipantsEnter() {
		return totalParticipantsEnter;
	}

	public void setTotalParticipantsEnter(Integer totalParticipantsEnter) {
		this.totalParticipantsEnter = totalParticipantsEnter;
	}
	
	

}
