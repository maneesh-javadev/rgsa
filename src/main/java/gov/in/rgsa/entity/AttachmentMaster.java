package gov.in.rgsa.entity;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.NamedQuery;
import javax.persistence.Table;

@Entity
@Table(name="attachment_master", schema="rgsa")
@NamedQuery(name="FIND_FILE_PATH",
query="FROM AttachmentMaster where fileId=:id")
public class AttachmentMaster implements Serializable {
	
	/**
	 * 
	 */
	private static final long serialVersionUID = -5721206114830945394L;

	
	
	@Id
	@Column(name="file_master_id",nullable=false , updatable =false)
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private Integer fileId;
	
	@Column(name="require_title")
	private String requireTitle;
	
	@Column(name="unique_title")
	private String uniqueTitle;
	
	@Column(name="total_file_size")
	private Integer totalFileSize;
	
	@Column(name="individual_file_size")
	private Integer individualFileSize;
	
	@Column(name="file_limit")
	private Integer fileLimit;
	
	@Column(name="file_type")
	private String fileType;
	
	@Column(name="file_location")
	private String fileLocation;

	public Integer getFileId() {
		return fileId;
	}

	public void setFileId(Integer fileId) {
		this.fileId = fileId;
	}

	public String getRequireTitle() {
		return requireTitle;
	}

	public void setRequireTitle(String requireTitle) {
		this.requireTitle = requireTitle;
	}

	public String getUniqueTitle() {
		return uniqueTitle;
	}

	public void setUniqueTitle(String uniqueTitle) {
		this.uniqueTitle = uniqueTitle;
	}

	public Integer getTotalFileSize() {
		return totalFileSize;
	}

	public void setTotalFileSize(Integer totalFileSize) {
		this.totalFileSize = totalFileSize;
	}

	public Integer getIndividualFileSize() {
		return individualFileSize;
	}

	public void setIndividualFileSize(Integer individualFileSize) {
		this.individualFileSize = individualFileSize;
	}

	public Integer getFileLimit() {
		return fileLimit;
	}

	public void setFileLimit(Integer fileLimit) {
		this.fileLimit = fileLimit;
	}

	public String getFileType() {
		return fileType;
	}

	public void setFileType(String fileType) {
		this.fileType = fileType;
	}

	public String getFileLocation() {
		return fileLocation;
	}

	public void setFileLocation(String fileLocation) {
		this.fileLocation = fileLocation;
	}
	
}
