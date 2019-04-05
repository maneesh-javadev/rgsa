package gov.in.rgsa.entity;

import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;

import javax.persistence.*;
import java.nio.file.Paths;
import java.sql.Timestamp;

@Entity
@Table(name = "file_node", schema = "rgsa")
public class FileNode {
	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	@Column(name="file_node_id")
	private Integer fileNodeId;
	
	@Column(name="file_name")
	private String fileName;
	
	@Column(name="upload_name")
	private String uploadName;
	
	@Column(name="file_path")
	private String filePath;
	
	@Column(name="file_mime")
	private String fileMime;
	
	@Column(name="file_size")
	private Long fileSize;
	
	@Column(name="status")
	private Integer status;
	
	@CreationTimestamp
	@Column(name="created_on",updatable=false)
	private Timestamp createdOn;
	
	@UpdateTimestamp
	@Column(name="last_updated_on")
	private Timestamp lastUpdatedOn;
	
	public static enum STATUS {
		DELETED(0), PENDING(3), UPLOADED(5), MODIFIED(7), UPLOAD_FAILED(11), OBSOLETE(13);
		private final int value;
		STATUS (final int newValue) {
            this.value = newValue;
        }
        public int getValue() { return value; }
        public static STATUS valueOf(int value) {
        	for(STATUS status: values()) {
        		if(status.value == value)
        			return status;
        	}
        	return PENDING;
        }
	}

	public Integer getFileNodeId() {
		return fileNodeId;
	}

	public void setFileNodeId(Integer fileNodeId) {
		this.fileNodeId = fileNodeId;
	}

	public String getFileName() {
		return fileName;
	}

	public void setFileName(String fileName) {
		this.fileName = fileName;
	}

	public String getUploadName() {
		return uploadName;
	}

	public void setUploadName(String uploadName) {
		this.uploadName = uploadName;
	}

	public String getFilePath() {
		return filePath;
	}

	public void setFilePath(String filePath) {
		this.filePath = filePath;
	}

	public String getFileMime() {
		return fileMime;
	}

	public void setFileMime(String fileMime) {
		this.fileMime = fileMime;
	}

	public Long getFileSize() {
		return fileSize;
	}

	public void setFileSize(Long fileSize) {
		this.fileSize = fileSize;
	}

	public Integer getStatus() {
		return status;
	}

	public void setStatus(Integer status) {
		this.status = status;
	}

	public Timestamp getCreatedOn() {
		return createdOn;
	}

	public void setCreatedOn(Timestamp createdOn) {
		this.createdOn = createdOn;
	}

	public Timestamp getLastUpdatedOn() {
		return lastUpdatedOn;
	}

	public void setLastUpdatedOn(Timestamp lastUpdatedOn) {
		this.lastUpdatedOn = lastUpdatedOn;
	};
	
	public String getUrl() {
		return getUrl("");
	}
	
	public String getUrl(String base) {
		return Paths.get(base, filePath, fileName).toString();
	}
	
}