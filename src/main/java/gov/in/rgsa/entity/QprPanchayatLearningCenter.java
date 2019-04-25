package gov.in.rgsa.entity;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.OneToOne;
import javax.persistence.Table;
import javax.persistence.Transient;

import org.springframework.web.multipart.MultipartFile;

/**
 * @author Mohammad Ayaz 07/01/2019
 *
 */
@Entity
@Table(name="qpr_panchayat_learning_center" ,schema="rgsa")
public class QprPanchayatLearningCenter {
	
	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	@Column(name="qpr_panchayat_learning_id",nullable=false,updatable=false)
	private Integer qprPanchayatLearningId;
	
	@OneToOne
	@JoinColumn(name="qpr_cb_activity_details_id")
	private QprCbActivityDetails cbActivityDetails;
	
	@OneToOne(fetch=FetchType.EAGER,cascade=CascadeType.ALL)
	@JoinColumn(name="file_node_id")
	private FileNode fileNode;
	
	@Transient
	private MultipartFile file;

	public Integer getQprPanchayatLearningId() {
		return qprPanchayatLearningId;
	}

	public void setQprPanchayatLearningId(Integer qprPanchayatLearningId) {
		this.qprPanchayatLearningId = qprPanchayatLearningId;
	}

	public QprCbActivityDetails getCbActivityDetails() {
		return cbActivityDetails;
	}

	public void setCbActivityDetails(QprCbActivityDetails cbActivityDetails) {
		this.cbActivityDetails = cbActivityDetails;
	}

	public MultipartFile getFile() {
		return file;
	}

	public void setFile(MultipartFile file) {
		this.file = file;
	}

	public FileNode getFileNode() {
		return fileNode;
	}

	public void setFileNode(FileNode fileNode) {
		this.fileNode = fileNode;
	}

}
