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
/**
 * @author Mohammad Ayaz 01/01/2019
 *
 */
@Entity
@Table(name="qpr_tna_trg_evaluation" ,schema="rgsa")
public class QprTnaTrgEvaluation {

	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	@Column(name="qpr_tna_trg_evaluation_id",nullable=false,updatable=false)
	private Integer qprTnaTrgEvaluationId;
	
	@ManyToOne
	@JoinColumn(name="qpr_cb_activity_details_id")
	private QprCbActivityDetails cbActivityDetails;
	
	@Column(name="no_of_persons")
	private Integer noOfPersons;
	
	@ManyToOne
	@JoinColumn(name="trg_subjects")
	private Subjects trngSubject;

	@OneToOne(fetch=FetchType.EAGER,cascade=CascadeType.ALL)
	@JoinColumn(name="file_node_id")
	private FileNode fileNode;
	
	@Transient
	private MultipartFile file;
	
	public MultipartFile getFile() {
		return file;
	}

	public void setFile(MultipartFile file) {
		this.file = file;
	}

	public Integer getQprTnaTrgEvaluationId() {
		return qprTnaTrgEvaluationId;
	}

	public void setQprTnaTrgEvaluationId(Integer qprTnaTrgEvaluationId) {
		this.qprTnaTrgEvaluationId = qprTnaTrgEvaluationId;
	}

	public QprCbActivityDetails getCbActivityDetails() {
		return cbActivityDetails;
	}

	public void setCbActivityDetails(QprCbActivityDetails cbActivityDetails) {
		this.cbActivityDetails = cbActivityDetails;
	}

	public Integer getNoOfPersons() {
		return noOfPersons;
	}

	public void setNoOfPersons(Integer noOfPersons) {
		this.noOfPersons = noOfPersons;
	}

	public Subjects getTrngSubject() {
		return trngSubject;
	}

	public void setTrngSubject(Subjects trngSubject) {
		this.trngSubject = trngSubject;
	}

	public FileNode getFileNode() {
		return fileNode;
	}

	public void setFileNode(FileNode fileNode) {
		this.fileNode = fileNode;
	}
	
}
