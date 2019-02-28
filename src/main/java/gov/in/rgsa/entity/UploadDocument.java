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
import javax.persistence.Transient;

@Entity
@Table(name = "upload_document", schema = "rgsa")
@NamedNativeQueries({
/*@NamedNativeQuery(query = "SELECT upload_document_id,file_title,state_code,file_content_type,file_location,file_name,created_by,created_on,type_id, "
        + " CASE WHEN U.state_code is null THEN 'CENTER' WHEN U.state_code=0 THEN 'CENTER' ELSE "
        + " (SELECT state_name_english FROM lgd.get_states_by_code_fn(U.state_code)) END state_name,"
        + " (SELECT name FROM gpdp.upload_document_type WHERE type_id=U.type_id) as typeName "
        + " FROM gpdp.upload_document U  ", name = "GET_DOCUMENT_LIST", resultClass = UploadDocument.class),*/
/*@NamedNativeQuery(query = "SELECT * FROM  gpdp.upload_document where state_code<>0 ORDER BY state_code,type_id asc ", name = "GET_STATE_DOCUMENT_LIST",
			resultClass = UploadDocument.class),
@NamedNativeQuery(query = "SELECT * FROM  gpdp.upload_document where state_code=0 ORDER BY state_code,type_id asc ", name = "GET_CENTER_DOCUMENT_LIST",
resultClass = UploadDocument.class),*/
@NamedNativeQuery(query = "SELECT * FROM  rgsa.upload_document where upload_document_id=:uploadDocumentId ", name = "GET_DOCUMENT",
resultClass = UploadDocument.class),
@NamedNativeQuery(query = "select * from rgsa.upload_document where created_on BETWEEN SYMMETRIC now() - interval '1 year' AND now() order by created_on desc", name = "GET_WHATS_NEW",
resultClass = UploadDocument.class)
})

public class UploadDocument implements Serializable {

	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Basic(optional = false)
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

	/*@Column(name ="is_new")
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

	public String getFileTitle() {
		return fileTitle;
	}

	public void setFileTitle(String fileTitle) {
		this.fileTitle = fileTitle;
	}

	@Transient
	private String StateName;
	
	@Transient
	private String typeName;
	
	public String getStateName() {
		return StateName;
	}

	public void setStateName(String stateName) {
		StateName = stateName;
	}

	
	public String getTypeName() {
		return typeName;
	}

	public void setTypeName(String typeName) {
		this.typeName = typeName;
	}
	
/*	public Boolean getIsNew() {
		return isNew;
	}

	public void setIsNew(Boolean isNew) {
		this.isNew = isNew;
	}*/

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((uploadDocumentId == null) ? 0 : uploadDocumentId.hashCode());
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
		UploadDocument other = (UploadDocument) obj;
		if (uploadDocumentId == null) {
			if (other.uploadDocumentId != null)
				return false;
		} else if (!uploadDocumentId.equals(other.uploadDocumentId))
			return false;
		return true;
	}

}
