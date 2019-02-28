package gov.in.rgsa.dto;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.NamedNativeQueries;
import javax.persistence.NamedNativeQuery;
import javax.persistence.Transient;

import gov.in.rgsa.entity.UploadDocument;


@Entity
@NamedNativeQueries({@NamedNativeQuery(query = "SELECT upload_document_id,file_title,state_code,file_content_type,file_location,file_name,created_by,created_on,type_id, "
        + " CASE WHEN U.state_code is null THEN 'CENTER' WHEN U.state_code=0 THEN 'CENTER' ELSE "
        + " (SELECT state_name_english FROM lgd.get_states_by_code_fn(U.state_code)) END state_name,"
        + " (SELECT name FROM rgsa.upload_document_type WHERE type_id=U.type_id) as typeName "
        + " FROM rgsa.upload_document U where created_by =:createdBy order by state_name", name = "GET_DOCUMENT_LIST", resultClass = UploadDocumentDTO.class),
@NamedNativeQuery(query = "SELECT upload_document_id,file_title,state_code,file_content_type,file_location,file_name,created_by,created_on,type_id, "
        + " CASE WHEN U.state_code is null THEN 'CENTER' WHEN U.state_code=0 THEN 'CENTER' ELSE "
        + " (SELECT state_name_english FROM lgd.get_states_by_code_fn(U.state_code)) END state_name,"
        + " (SELECT name FROM rgsa.upload_document_type WHERE type_id=U.type_id) as typeName "
        + " FROM rgsa.upload_document U where U.state_code=:stateCode ORDER BY state_name ,type_id asc", name = "GET_STATE_DOCUMENT_LIST",
	resultClass = UploadDocumentDTO.class),
@NamedNativeQuery(query = "SELECT upload_document_id,file_title,state_code,file_content_type,file_location,file_name,created_by,created_on,type_id, "
        + " CASE WHEN U.state_code is null THEN 'CENTER' WHEN U.state_code=0 THEN 'CENTER' ELSE "
        + " (SELECT state_name_english FROM lgd.get_states_by_code_fn(U.state_code)) END state_name,"
        + " (SELECT name FROM rgsa.upload_document_type WHERE type_id=U.type_id) as typeName "
        + " FROM rgsa.upload_document U ORDER BY state_name,type_id asc ", name = "GET_CENTER_DOCUMENT_LIST",
resultClass = UploadDocumentDTO.class),	

})
public class UploadDocumentDTO implements Serializable {
	
	private static final long serialVersionUID = 1L;
	@Id
	@Column(name = "upload_document_id")
	private Integer uploadDocumentId;
	@Column(name = "file_name")
	private String fileName;
	@Column(name = "file_title")
	private String fileTitle;
	@Column(name = "state_code")
	private Integer stateCode;
	@Column(name = "file_content_type")
	private String fileContentType;
	@Column(name = "file_location")
	private String fileLocation;
	@Column(name = "created_by")
	private Integer createdBy;
	@Column(name = "created_on")
	private Date createdOn;
	@Column(name = "type_id")
	private Integer typeId;	
	
	@Column(name = "state_name")
	private String stateName;	
	
	@Column(name = "typeName")
	private String typeName;
	
/*	@Column(name ="is_new")
	private Boolean isNew;*/
	
	
	public Integer getUploadDocumentId() {
		return uploadDocumentId;
	}
	public void setUploadDocumentId(Integer uploadDocumentId) {
		this.uploadDocumentId = uploadDocumentId;
	}
	public String getFileName() {
		return fileName;
	}
	public void setFileName(String fileName) {
		this.fileName = fileName;
	}
	public String getFileTitle() {
		return fileTitle;
	}
	public void setFileTitle(String fileTitle) {
		this.fileTitle = fileTitle;
	}
	public Integer getStateCode() {
		return stateCode;
	}
	public void setStateCode(Integer stateCode) {
		this.stateCode = stateCode;
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
	public Integer getTypeId() {
		return typeId;
	}
	public void setTypeId(Integer typeId) {
		this.typeId = typeId;
	}

	
	public String getStateName() {
		return stateName;
	}
	public void setStateName(String stateName) {
		this.stateName = stateName;
	}
	public String getTypeName() {
		return typeName;
	}
	public void setTypeName(String typeName) {
		this.typeName = typeName;
	}
	/*public Boolean getIsNew() {
		return isNew;
	}
	public void setIsNew(Boolean isNew) {
		this.isNew = isNew;
	}*/
	
	
	
}
