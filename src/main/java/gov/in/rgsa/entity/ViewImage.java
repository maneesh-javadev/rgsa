package gov.in.rgsa.entity;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.NamedNativeQueries;
import javax.persistence.NamedNativeQuery;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.persistence.Transient;

@Entity
@NamedNativeQueries({
	@NamedNativeQuery(query = "select upload_files_id,state_code ,is_approved,(select  state_name_english from lgd.get_states_by_code_fn(state_code) "
		+ "limit 1) ,mobile_no,remarks,upload_type,testimonials,local_body_code,file_name,created_on,created_by,gp_code from rgsa..upload_files where "
		+ "is_approved=true order by created_on desc limit 100  ", name = "FIND_LATEST_UPLOAD_IMAGE", resultClass = ViewImage.class),
	@NamedNativeQuery(query = "select upload_files_id,state_code,is_approved,(select  state_name_english from lgd.get_states_by_code_fn(state_code) "
		+ "limit 1) ,mobile_no,remarks,upload_type,testimonials,local_body_code, file_name,created_on,created_by,gp_code from rgsa.upload_files where "
		+ "is_approved=true and state_code =:stateCode and upload_type=:uploadType order by created_on desc OFFSET :min  limit :max   ", name = "FIND_UPLOAD_IMAGE", resultClass = ViewImage.class),
	@NamedNativeQuery(query = "select upload_files_id,state_code,is_approved,(select  state_name_english from lgd.get_states_by_code_fn(state_code) limit 1) ,mobile_no,remarks,upload_type,testimonials,local_body_code, "
		+ " file_name,created_on,created_by,gp_code from rgsa.upload_files where  state_code =:stateCode AND is_approved IN(:status)  order by created_on desc OFFSET :min  limit :max  ", name = "FIND_MODERATE_IMAGE_BY_STATE_CODE", resultClass = ViewImage.class),
	@NamedNativeQuery(query = "select upload_files_id,state_code,is_approved,(select  state_name_english from lgd.get_states_by_code_fn(state_code) limit 1) ,mobile_no,remarks,upload_type,testimonials,local_body_code, "
		+ " file_name,created_on,created_by,gp_code from rgsa.upload_files where  state_code =:stateCode AND is_approved IN(:status)  "
		+ "AND (local_body_code IN(:lbCode) or gp_code in(select * from rgsa.get_image_by_level(:lbCode,1))) order by created_on desc OFFSET :min  limit :max  ", name = "FIND_MODERATE_IMAGE_BY_STATE_CODE_AND_LB_CODE", resultClass = ViewImage.class),
	@NamedNativeQuery(query = "select upload_files_id,state_code,is_approved,(select  state_name_english from lgd.get_states_by_code_fn(state_code) limit 1) ,mobile_no,remarks,upload_type,testimonials,local_body_code,"
		+ " file_name,created_on,created_by,gp_code from rgsa.upload_files where is_approved IN(:status) order by created_on desc OFFSET :min  limit :max ", name = "FIND_ALL_MODERATE_IMAGE", resultClass = ViewImage.class),
	@NamedNativeQuery(query = "select upload_files_id,state_code,is_approved,(select  state_name_english from lgd.get_states_by_code_fn(state_code) limit 1) ,"
		+ "	mobile_no,remarks,upload_type,testimonials,local_body_code, file_name,created_on,created_by,gp_code from rgsa.upload_files "
		+ " where is_approved=true and gp_code in (select * from rgsa.get_image_by_level(:localBodyCode, :level)) and upload_type=:uploadType and state_code =:stateId"
		+ " order by created_on desc OFFSET :min  limit :max ", name = "FIND_ALL_LOCALBODY_IMAGE", resultClass = ViewImage.class),
	@NamedNativeQuery(query = "select upload_files_id, state_code, is_approved, (select state_name_english from "
		+ "lgd.get_states_by_code_fn(state_code) limit 1), mobile_no, remarks, upload_type, testimonials, local_body_code, file_name, "
		+ "created_on, created_by, gp_code from rgsa.upload_files where latitude =:latitude and longitude =:longtitude", name = "FIND_BY_LAT_LNG", resultClass = ViewImage.class),
	@NamedNativeQuery(query = "select upload_files_id, state_code, is_approved,(select state_name_english from lgd.get_states_by_code_fn(state_code) "
			+ "limit 1), mobile_no, remarks, upload_type, testimonials, local_body_code, file_name, created_on, created_by, gp_code from rgsa.upload_files "
			+ "where is_approved = true and gp_code =:gpCode and upload_type =:uploadType and state_code =:stateId "
			+ "order by created_on", name = "FIND_ALL_IMAGE_BY_GPCODE", resultClass = ViewImage.class),
	@NamedNativeQuery(query = "select upload_files_id,state_code,is_approved,(select  state_name_english from lgd.get_states_by_code_fn(state_code) limit 1) ,mobile_no,remarks,upload_type,testimonials,local_body_code, "
			+ "file_name,created_on,created_by,gp_code from rgsa.upload_files where state_code =:stateCode and gp_code =:gpCode  AND is_approved IN(:status) "
			+ "order by created_on desc OFFSET :min  limit :max ", name = "FIND_MODERATE_IMAGE_BY_GP_CODE", resultClass = ViewImage.class),
	@NamedNativeQuery(query = "select upload_files_id,state_code,is_approved,(select  state_name_english from lgd.get_states_by_code_fn(state_code) limit 1) ,mobile_no,remarks,upload_type,testimonials,local_body_code, "
			+ " file_name,created_on,created_by,gp_code from rgsa.upload_files where  state_code =:stateCode AND is_approved IN(:status)  "
			+ "AND local_body_code IN(:lbCode) AND gp_code =:gpCode order by created_on desc OFFSET :min  limit :max  ", name = "FIND_MODERATE_IMAGE_BY_STATE_CODE_AND_LB_CODE_AND_GPCODE", resultClass = ViewImage.class),
	@NamedNativeQuery(query = "select upload_files_id,state_code,is_approved,(select  state_name_english from lgd.get_states_by_code_fn(state_code) limit 1) ,mobile_no,remarks,upload_type,testimonials,local_body_code,"
			+ " file_name,created_on,created_by,gp_code from rgsa.upload_files where is_approved IN(:status) and created_by is null order by created_on desc OFFSET :min  limit :max ", name = "FIND_ALL_MODERATE_IMAGE_UPLOADED_BY_CITIZEN", resultClass = ViewImage.class),
	@NamedNativeQuery(query = "select upload_files_id,state_code,is_approved,(select  state_name_english from lgd.get_states_by_code_fn(state_code) limit 1) ,mobile_no,remarks,upload_type,testimonials,local_body_code,"
			+ " file_name,created_on,created_by,gp_code from rgsa.upload_files where is_approved IN(:status) and created_by is not null order by created_on desc OFFSET :min  limit :max ", name = "FIND_ALL_MODERATE_IMAGE_UPLOADED_BY_OFFICER", resultClass = ViewImage.class),
	@NamedNativeQuery(query = "select upload_files_id,state_code,is_approved,(select  state_name_english from lgd.get_states_by_code_fn(state_code) limit 1) ,mobile_no,remarks,upload_type,testimonials,local_body_code, "
			+ " file_name,created_on,created_by,gp_code from rgsa.upload_files where  state_code =:stateCode AND is_approved IN(:status) AND created_by is null  order by created_on desc OFFSET :min  limit :max  ", name = "FIND_MODERATE_IMAGE_BY_STATE_CODE_UPLOADED_BY_CITIZEN", resultClass = ViewImage.class),
	@NamedNativeQuery(query = "select upload_files_id,state_code,is_approved,(select  state_name_english from lgd.get_states_by_code_fn(state_code) limit 1) ,mobile_no,remarks,upload_type,testimonials,local_body_code, "
			+ " file_name,created_on,created_by,gp_code from rgsa.upload_files where  state_code =:stateCode AND is_approved IN(:status) AND created_by is not null order by created_on desc OFFSET :min  limit :max  ", name = "FIND_MODERATE_IMAGE_BY_STATE_CODE_UPLOADED_BY_OFFICER", resultClass = ViewImage.class),
	@NamedNativeQuery(query = "select upload_files_id,state_code,is_approved,(select  state_name_english from lgd.get_states_by_code_fn(state_code) limit 1) ,mobile_no,remarks,upload_type,testimonials,local_body_code, "
			+ "file_name,created_on,created_by,gp_code from rgsa.upload_files where state_code =:stateCode and gp_code =:gpCode  AND is_approved IN(:status) AND created_by is null "
			+ "order by created_on desc OFFSET :min  limit :max ", name = "FIND_MODERATE_IMAGE_BY_GP_CODE_UPLOADED_BY_CITIZEN", resultClass = ViewImage.class),
	@NamedNativeQuery(query = "select upload_files_id,state_code,is_approved,(select  state_name_english from lgd.get_states_by_code_fn(state_code) limit 1) ,mobile_no,remarks,upload_type,testimonials,local_body_code, "
			+ "file_name,created_on,created_by,gp_code from rgsa.upload_files where state_code =:stateCode and gp_code =:gpCode  AND is_approved IN(:status) AND created_by is not null "
			+ "order by created_on desc OFFSET :min  limit :max ", name = "FIND_MODERATE_IMAGE_BY_GP_CODE_UPLOADED_BY_OFFICER", resultClass = ViewImage.class),
	@NamedNativeQuery(query = "select upload_files_id,state_code,is_approved,(select  state_name_english from lgd.get_states_by_code_fn(state_code) limit 1) ,mobile_no,remarks,upload_type,testimonials,local_body_code, "
			+ " file_name,created_on,created_by,gp_code from rgsa.upload_files where  state_code =:stateCode AND is_approved IN(:status) AND created_by is null "
			+ "AND local_body_code IN(:lbCode) order by created_on desc OFFSET :min  limit :max  ", name = "FIND_MODERATE_IMAGE_BY_STATE_CODE_AND_LB_CODE_UPLOADED_BY_CITIZEN", resultClass = ViewImage.class),
	@NamedNativeQuery(query = "select upload_files_id,state_code,is_approved,(select  state_name_english from lgd.get_states_by_code_fn(state_code) limit 1) ,mobile_no,remarks,upload_type,testimonials,local_body_code, "
			+ " file_name,created_on,created_by,gp_code from rgsa.upload_files where  state_code =:stateCode AND is_approved IN(:status) AND created_by is not null "
			+ "AND local_body_code IN(:lbCode) order by created_on desc OFFSET :min  limit :max  ", name = "FIND_MODERATE_IMAGE_BY_STATE_CODE_AND_LB_CODE_UPLOADED_BY_OFFICER", resultClass = ViewImage.class),
	@NamedNativeQuery(query = "select upload_files_id,state_code,is_approved,(select  state_name_english from lgd.get_states_by_code_fn(state_code) limit 1) ,mobile_no,remarks,upload_type,testimonials,local_body_code, "
			+ " file_name,created_on,created_by,gp_code from rgsa.upload_files where  state_code =:stateCode AND is_approved IN(:status)  "
			+ "AND local_body_code IN(:lbCode) AND gp_code =:gpCode AND created_by is null order by created_on desc OFFSET :min  limit :max  ", name = "FIND_MODERATE_IMAGE_BY_STATE_CODE_AND_LB_CODE_AND_GPCODE_UPLOADED_BY_CITIZEN", resultClass = ViewImage.class),
	@NamedNativeQuery(query = "select upload_files_id,state_code,is_approved,(select  state_name_english from lgd.get_states_by_code_fn(state_code) limit 1) ,mobile_no,remarks,upload_type,testimonials,local_body_code, "
			+ " file_name,created_on,created_by,gp_code from rgsa.upload_files where  state_code =:stateCode AND is_approved IN(:status)  "
			+ "AND local_body_code IN(:lbCode) AND gp_code =:gpCode AND created_by is not null order by created_on desc OFFSET :min  limit :max  ", name = "FIND_MODERATE_IMAGE_BY_STATE_CODE_AND_LB_CODE_AND_GPCODE_UPLOADED_BY_OFFICER", resultClass = ViewImage.class),
		
		
})
public class ViewImage implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@Id
	@Column(name = "upload_files_id")
	private Integer uploadFileId;

	@Column(name = "file_name")
	private String fileName;

	@Column(name = "state_code")
	private Integer stateCode;

	@Column(name = "remarks")
	private String remarks;

	@Column(name = "testimonials")
	private String testimonials;

	@Column(name = "local_body_code")
	private Integer localBodyCode;

	@Column(name = "upload_type")
	private String uploadType;

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "created_on")
	private Date createdOn;

	@Column(name = "created_by")
	private Integer createdBy;

	@Column(name = "state_name_english")
	private String stateName;

	@Column(name = "mobile_no")
	private String mobileNo;

	@Column(name = "is_approved")
	private boolean isApproved;
	
	@Column(name = "gp_code")
	private Integer gpCode;

	@Transient
	private String path;

	public Integer getStateCode() {
		return stateCode;
	}

	public void setStateCode(Integer stateCode) {
		this.stateCode = stateCode;
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

	public Integer getLocalBodyCode() {
		return localBodyCode;
	}

	public void setLocalBodyCode(Integer localBodyCode) {
		this.localBodyCode = localBodyCode;
	}

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

	public Date getCreatedOn() {
		return createdOn;
	}

	public void setCreatedOn(Date createdOn) {
		this.createdOn = createdOn;
	}
	public String getPath() {
		return path;
	}

	public void setPath(String path) {
		this.path = path;
	}

	public String getUploadType() {
		return uploadType;
	}

	public void setUploadType(String uploadType) {
		this.uploadType = uploadType;
	}

	public Integer getCreatedBy() {
		return createdBy;
	}

	public void setCreatedBy(Integer createdBy) {
		this.createdBy = createdBy;
	}

	public String getStateName() {
		return stateName;
	}

	public void setStateName(String stateName) {
		this.stateName = stateName;
	}

	public String getMobileNo() {
		return mobileNo;
	}

	public void setMobileNo(String mobileNo) {
		this.mobileNo = mobileNo;
	}

	public boolean isApproved() {
		return isApproved;
	}

	public void setApproved(boolean isApproved) {
		this.isApproved = isApproved;
	}

	public Integer getGpCode() {
		return gpCode;
	}

	public void setGpCode(Integer gpCode) {
		this.gpCode = gpCode;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((uploadFileId == null) ? 0 : uploadFileId.hashCode());
		return result;
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		ViewImage other = (ViewImage) obj;
		if (uploadFileId == null) {
			if (other.uploadFileId != null)
				return false;
		} else if (!uploadFileId.equals(other.uploadFileId))
			return false;
		return true;
	}

}
