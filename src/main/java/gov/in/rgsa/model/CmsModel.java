package gov.in.rgsa.model;

import java.io.Serializable;


import org.springframework.web.multipart.commons.CommonsMultipartFile;


public class CmsModel implements Serializable {

	private static final long serialVersionUID = 1L;
	
	private Integer documentType;	
	private Integer stateCode;
	private String fileTitle;
	private CommonsMultipartFile attach;
    private String fileName; 
	
	
	public Integer getDocumentType() {
		return documentType;
	}
	public void setDocumentType(Integer documentType) {
		this.documentType = documentType;
	}
	public Integer getStateCode() {
		return stateCode;
	}
	public void setStateCode(Integer stateCode) {
		this.stateCode = stateCode;
	}
	public String getFileTitle() {
		return fileTitle;
	}
	public void setFileTitle(String fileTitle) {
		this.fileTitle = fileTitle;
	}
	public CommonsMultipartFile getAttach() {
		return attach;
	}
	public void setAttach(CommonsMultipartFile attach) {
		this.attach = attach;
	}
	public String getFileName() {
		return fileName;
	}
	public void setFileName(String fileName) {
		this.fileName = fileName;
	}
	
	private Integer uploadDocumentId;


	public Integer getUploadDocumentId() {
		return uploadDocumentId;
	}
	public void setUploadDocumentId(Integer uploadDocumentId) {
		this.uploadDocumentId = uploadDocumentId;
	}
	
	
	
	
	
	
	
}
