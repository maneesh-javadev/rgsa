package gov.in.rgsa.entity;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.NamedNativeQueries;
import javax.persistence.NamedNativeQuery;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.persistence.Transient;

@Entity
@Table(name = "upload_files", schema = "rgsa")
@NamedNativeQuery(query = "select * from rgsa.upload_files where upload_files_id =:updateFileId",name= "FIND_UPLOAD_FILES_BY_UPLOAD_FILE_ID",resultClass=FileUpload.class)

/*@NamedNativeQueries({
	@NamedNativeQuery(query = "select * from gpdp.upload_files where state_code =:stateCode order by upload_files_id",name= "FIND_UPLOAD_FILES_BY_SATAE_CODE",resultClass=FileUpload.class),
,
	@NamedNativeQuery(query = "select * from gpdp.upload_files where local_body_code =:entityCode and is_approved = true order by "
			+ "upload_files_id",name= "FIND_APPROVED_FILES_BY_ENTITY_CODE",resultClass=FileUpload.class),
	@NamedNativeQuery(query = "select * from gpdp.upload_files where local_body_code =:localBodyCode and upload_type='P' and is_approved = true order by upload_files_id",name= "FIND_UPLOAD_FILES_BY_LOCAL_BODY_CODE_FOR_P",resultClass=FileUpload.class),
	@NamedNativeQuery(query = "select * from gpdp.upload_files where local_body_code =:localBodyCode and upload_type='G' and is_approved = true order by upload_files_id",name= "FIND_UPLOAD_FILES_BY_LOCAL_BODY_CODE_G",resultClass=FileUpload.class),
	@NamedNativeQuery(query = "select * from gpdp.upload_files where state_code =:stateCode  order by upload_files_id",name= "FIND_UPLOAD_FILES_BY_STATE_CODE",resultClass=FileUpload.class),
	@NamedNativeQuery(query = "select * from gpdp.upload_files where local_body_code =:entityCode  order by upload_files_id",name= "FIND_UPLOAD_FILES_BY_ENTITY_CODE",resultClass=FileUpload.class),
	@NamedNativeQuery(query = "select * from gpdp.upload_files",name= "FIND_UPLOAD_FILES_ALL",resultClass=FileUpload.class)
	
})*/
public class FileUpload implements Serializable{
	
	
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Basic(optional = false)
	@Column(name = "upload_files_id")
	private Integer uploadFileId;
	
	@Column(name = "file_name")
	private String fileName;
	
	@Column(name = "file_content_type")
	private String fileContentType;
	
	@Column(name = "file_location")
	private String fileLocation;
	
	
	@Column(name = "remarks")
	private String remarks;
	
	@Column(name = "testimonials")
	private String testimonials;
	
	@Column(name = "state_code")
	private Integer stateCode;
	
	@Column(name = "local_body_code")
	private Integer localBodyCode;
	
	@Column(name = "latitude")
	private String latitude;
	
	@Column(name = "longitude")
	private String longitude;
	
	@Column(name = "imei_number")
	private String imeiNumber;
	
	@Column(name = "mobile_no")
	private String mobileNo;
	
	@Column(name = "email_id")
    private String emailId;
	
	@Column(name = "is_approved")
    private Boolean isApproved;

	
	@Column(name = "created_by")
	private Integer createdBy;
	
	@Column(name="upload_type")
	private String uploadType;
	
	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "created_on")
	private Date createdOn;
	
	@Column(name = "last_updated_by")
	private Integer lastUpdatedBy;
	
	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "last_updated_on")
	private Date lastUpdatedOn;
	
	@Column(name = "gp_code")
	private Integer gpCode;
	
	
	@Column(name = "bp_code")
	private Integer bpCode;
	
	@Column(name= "category")
	private String category;
	
	
	@Transient
	private String base64image;

	public Integer getUploadFileId() {
		return uploadFileId;
	}

	public void setUploadFileId(Integer uploadFileId) {
		this.uploadFileId = uploadFileId;
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

	public String getRemarks() {
		return remarks;
	}

	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}

	public String getTestimonials() {
		return testimonials;
	}

	public void setTestimonials(String testimonials) {
		this.testimonials = testimonials;
	}

	public Integer getStateCode() {
		return stateCode;
	}

	public void setStateCode(Integer stateCode) {
		this.stateCode = stateCode;
	}

	public Integer getLocalBodyCode() {
		return localBodyCode;
	}

	public void setLocalBodyCode(Integer localBodyCode) {
		this.localBodyCode = localBodyCode;
	}

	public String getLatitude() {
		return latitude;
	}

	public void setLatitude(String latitude) {
		this.latitude = latitude;
	}

	public String getLongitude() {
		return longitude;
	}

	public void setLongitude(String longitude) {
		this.longitude = longitude;
	}

	public String getImeiNumber() {
		return imeiNumber;
	}

	public void setImeiNumber(String imeiNumber) {
		this.imeiNumber = imeiNumber;
	}

	public Integer getCreatedBy() {
		return createdBy;
	}

	public void setCreatedBy(Integer createdBy) {
		this.createdBy = createdBy;
	}

	public Date getCreatedOn() {
		return createdOn;
	}

	public void setCreatedOn(Date createdOn) {
		this.createdOn = createdOn;
	}

	public Integer getLastUpdatedBy() {
		return lastUpdatedBy;
	}

	public void setLastUpdatedBy(Integer lastUpdatedBy) {
		this.lastUpdatedBy = lastUpdatedBy;
	}

	public Date getLastUpdatedOn() {
		return lastUpdatedOn;
	}

	public void setLastUpdatedOn(Date lastUpdatedOn) {
		this.lastUpdatedOn = lastUpdatedOn;
	}

	public String getMobileNo() {
		return mobileNo;
	}

	public void setMobileNo(String mobileNo) {
		this.mobileNo = mobileNo;
	}

	public String getEmailId() {
		return emailId;
	}

	public void setEmailId(String emailId) {
		this.emailId = emailId;
	}

	public Boolean getIsApproved() {
		return isApproved;
	}

	public void setIsApproved(Boolean isApproved) {
		this.isApproved = isApproved;
	}

	public String getUploadType() {
		return uploadType;
	}

	public void setUploadType(String uploadType) {
		this.uploadType = uploadType;
	}
	
	public String getBase64image() {
		return base64image;
	}

	public void setBase64image(String base64image) {
		this.base64image = base64image;
	}

	public Integer getGpCode() {
		return gpCode;
	}

	public void setGpCode(Integer gpCode) {
		this.gpCode = gpCode;
	}

	public Integer getBpCode() {
		return bpCode;
	}

	public void setBpCode(Integer bpCode) {
		this.bpCode = bpCode;
	}

	public String getCategory() {
		return category;
	}

	public void setCategory(String category) {
		this.category = category;
	}
	
	
	
}
