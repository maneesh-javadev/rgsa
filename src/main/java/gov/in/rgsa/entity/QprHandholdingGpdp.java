package gov.in.rgsa.entity;

import java.io.Serializable;

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
 * @author Mohammad Ayaz 01/01/2019
 *
 */
@Entity
@Table(name="qpr_handholding_gpdp" ,schema="rgsa")
public class QprHandholdingGpdp implements Serializable{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 3692187613542590582L;

	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	@Column(name="qpr_handholding_gpdp_id",nullable=false,updatable=false)
	private Integer qprHandholdingGpdpId;
	
	@OneToOne
	@JoinColumn(name="qpr_cb_activity_details_id")
	private QprCbActivityDetails cbActivityDetails;
	
	@Column(name="institute_involved")
	private String instituteInvolved;
	
	@OneToOne(fetch=FetchType.EAGER,cascade=CascadeType.ALL)
	@JoinColumn(name="file_node_id")
	private FileNode fileNode;
	
	@Transient
	private MultipartFile file;

	public Integer getQprHandholdingGpdpId() {
		return qprHandholdingGpdpId;
	}

	public void setQprHandholdingGpdpId(Integer qprHandholdingGpdpId) {
		this.qprHandholdingGpdpId = qprHandholdingGpdpId;
	}

	public QprCbActivityDetails getCbActivityDetails() {
		return cbActivityDetails;
	}

	public void setCbActivityDetails(QprCbActivityDetails cbActivityDetails) {
		this.cbActivityDetails = cbActivityDetails;
	}

	public String getInstituteInvolved() {
		return instituteInvolved;
	}

	public void setInstituteInvolved(String instituteInvolved) {
		this.instituteInvolved = instituteInvolved;
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
