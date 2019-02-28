package gov.in.rgsa.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.Transient;

import org.springframework.web.multipart.MultipartFile;

import com.fasterxml.jackson.annotation.JsonBackReference;

@Entity
@Table(name="qpr_panhcayat_bhawan_details",schema="rgsa")
public class QprPanhcayatBhawanDetails {
	
	@Id
	@Column(name="qpr_panhcayat_bhawan_details_id")
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private Long qprPanhcayatBhawanDetailsId;
	
	@JsonBackReference
	@ManyToOne
	@JoinColumn(name="qpr_panhcayat_bhawan_id")
	private QprPanchayatBhawan qprPanchayatBhawan;
	
	@Column(name="local_body_code")
	private Integer localBodyCode;
	
	@Column(name="gp_bhawan_status_id")
	private Integer gpBhawanStatusId;
	
	@Column(name="expenditure_incurred")
	private Integer expenditureIncurred;
	
	@Column(name="file_name")
	private String fileName;
	
	@Column(name="file_content_type")
	private String fileContentType;
	
	@Column(name="file_location")
	private String fileLocation;
	
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

	@Transient
	private MultipartFile file;

	public Long getQprPanhcayatBhawanDetailsId() {
		return qprPanhcayatBhawanDetailsId;
	}

	public void setQprPanhcayatBhawanDetailsId(Long qprPanhcayatBhawanDetailsId) {
		this.qprPanhcayatBhawanDetailsId = qprPanhcayatBhawanDetailsId;
	}

	public QprPanchayatBhawan getQprPanchayatBhawan() {
		return qprPanchayatBhawan;
	}

	public void setQprPanchayatBhawan(QprPanchayatBhawan qprPanchayatBhawan) {
		this.qprPanchayatBhawan = qprPanchayatBhawan;
	}

	public Integer getLocalBodyCode() {
		return localBodyCode;
	}

	public void setLocalBodyCode(Integer localBodyCode) {
		this.localBodyCode = localBodyCode;
	}

	public Integer getGpBhawanStatusId() {
		return gpBhawanStatusId;
	}

	public void setGpBhawanStatusId(Integer gpBhawanStatusId) {
		this.gpBhawanStatusId = gpBhawanStatusId;
	}

	public Integer getExpenditureIncurred() {
		return expenditureIncurred;
	}

	public void setExpenditureIncurred(Integer expenditureIncurred) {
		this.expenditureIncurred = expenditureIncurred;
	}

	

	public MultipartFile getFile() {
		return file;
	}

	public void setFile(MultipartFile file) {
		this.file = file;
	}

	

}
