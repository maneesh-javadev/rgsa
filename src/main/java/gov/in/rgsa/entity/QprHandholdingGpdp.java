package gov.in.rgsa.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
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
public class QprHandholdingGpdp {
	
	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	@Column(name="qpr_handholding_gpdp_id",nullable=false,updatable=false)
	private Integer qprHandholdingGpdpId;
	
	@OneToOne
	@JoinColumn(name="qpr_cb_activity_details_id")
	private QprCbActivityDetails cbActivityDetails;
	
	@Column(name="institute_involved")
	private String instituteInvolved;
	
	@Column(name="file_name")
	private String fileName;
	
	@Column(name="file_content_type")
	private String fileContentType;
	
	@Column(name="file_location")
	private String fileLocation;
	
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

	public String getFileName() {
		return fileName;
	}

	public void setFileName(String fileName) {
		this.fileName = fileName;
	}

	public String getFileContentType() {
		return fileContentType;
	}

	public void setFileContentType(String fileContentType) {
		this.fileContentType = fileContentType;
	}

	public String getFileLocation() {
		return fileLocation;
	}

	public void setFileLocation(String fileLocation) {
		this.fileLocation = fileLocation;
	}

	public MultipartFile getFile() {
		return file;
	}

	public void setFile(MultipartFile file) {
		this.file = file;
	}
	
}
