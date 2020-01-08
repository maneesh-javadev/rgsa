package gov.in.rgsa.entity;


import java.io.Serializable;
import java.sql.Timestamp;

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

import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;

@Entity
@Table(name = "util_cert", schema = "rgsa")
public class UtilCert implements Serializable {
	/**
	 * 
	 */
	private static final long serialVersionUID = 8181296361301049149L;

	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	@Column(name="util_cert_id")
	private Integer utilCertId;

	@Column(name="state_code")
	private Integer stateCode;

	@ManyToOne(fetch=FetchType.LAZY)
	@JoinColumn(name="year_id", nullable=false)
	private FinYear finYear;

	@ManyToOne(fetch=FetchType.LAZY)
	@JoinColumn(name="release_installment_sr_no", nullable=false)
	private ReleaseIntallment releaseInstallment;

	@OneToOne(fetch=FetchType.EAGER)
	@JoinColumn(name="generated_file_id", nullable=false)
	private FileNode generatedFile;
	
	@OneToOne(fetch=FetchType.EAGER)
	@JoinColumn(name="upload_file_id", nullable=true)
	private FileNode uploadFile;
	
	@Column(name="upload_allowed")
	private  Boolean uploadAllowed = true;

	@Column(name="created_by")
	private  Integer createdBy;
	
	@CreationTimestamp
	@Column(name="created_on")
	private Timestamp createdOn;

	@Column(name="last_updated_by")
	private  Integer lastUpdatedBy;

	@UpdateTimestamp
	@Column(name="last_updated_on")
	private Timestamp lastUpdatedOn;

	public Integer getUtilCertId() {
		return utilCertId;
	}

	public void setUtilCertId(Integer utilCertId) {
		this.utilCertId = utilCertId;
	}

	public Integer getStateCode() {
		return stateCode;
	}

	public void setStateCode(Integer stateCode) {
		this.stateCode = stateCode;
	}

	public FinYear getFinYear() {
		return finYear;
	}

	public void setFinYear(FinYear finYear) {
		this.finYear = finYear;
	}

	public ReleaseIntallment getReleaseInstallment() {
		return releaseInstallment;
	}

	public void setReleaseInstallment(ReleaseIntallment releaseInstallment) {
		this.releaseInstallment = releaseInstallment;
	}

	public FileNode getGeneratedFile() {
		return generatedFile;
	}

	public void setGeneratedFile(FileNode generatedFile) {
		this.generatedFile = generatedFile;
	}

	public FileNode getUploadFile() {
		return uploadFile;
	}

	public void setUploadFile(FileNode uploadFile) {
		this.uploadFile = uploadFile;
	}
	
	

	public Boolean getUploadAllowed() {
		return uploadAllowed;
	}

	public void setUploadAllowed(Boolean uploadAllowed) {
		this.uploadAllowed = uploadAllowed;
	}

	public Integer getCreatedBy() {
		return createdBy;
	}

	public void setCreatedBy(Integer createdBy) {
		this.createdBy = createdBy;
	}

	public Timestamp getCreatedOn() {
		return createdOn;
	}

	public void setCreatedOn(Timestamp createdOn) {
		this.createdOn = createdOn;
	}

	public Integer getLastUpdatedBy() {
		return lastUpdatedBy;
	}

	public void setLastUpdatedBy(Integer lastUpdatedBy) {
		this.lastUpdatedBy = lastUpdatedBy;
	}

	public Timestamp getLastUpdatedOn() {
		return lastUpdatedOn;
	}

	public void setLastUpdatedOn(Timestamp lastUpdatedOn) {
		this.lastUpdatedOn = lastUpdatedOn;
	}
	
	// Generated
	

}
