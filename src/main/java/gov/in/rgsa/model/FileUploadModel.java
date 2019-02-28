package gov.in.rgsa.model;

import java.util.List;

import org.springframework.web.multipart.commons.CommonsMultipartFile;

public class FileUploadModel {

	private String fileName;
	private String file;
	private String fileExt;
	private String fileContentType;
	private String remarks;
	private String testimonials;
	private Integer stateCode;
	private Integer localBodyCode;
	private String latitude;
	private String longitude;
	private String imeiNumber;
	private Integer createdBy;
	private String mobileNo;
    private String emailId;
    private UploadType uploadType;
    private List<CommonsMultipartFile> pibImageId;
    private List<String> webRemarks;
    private List<String> webTestimonials;
    
    private List<FileUploadModel> fileList;
    
    
	private Integer gpCode;
	private Integer bpCode;
	private String category;
	private Integer dpCode;
	
	
	public String getFileName() {
		return fileName;
	}
	public void setFileName(String fileName) {
		this.fileName = fileName;
	}
	public String getFile() {
		return file;
	}
	public void setFile(String file) {
		this.file = file;
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
	public String getFileExt() {
		return fileExt;
	}
	public void setFileExt(String fileExt) {
		this.fileExt = fileExt;
	}
	public String getFileContentType() {
		return fileContentType;
	}
	public void setFileContentType(String fileContentType) {
		this.fileContentType = fileContentType;
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
	public UploadType getUploadType() {
		return uploadType;
	}
	public void setUploadType(UploadType uploadType) {
		this.uploadType = uploadType;
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
	public Integer getDpCode() {
		return dpCode;
	}
	public void setDpCode(Integer dpCode) {
		this.dpCode = dpCode;
	}
	public List<CommonsMultipartFile> getPibImageId() {
		return pibImageId;
	}
	public void setPibImageId(List<CommonsMultipartFile> pibImageId) {
		this.pibImageId = pibImageId;
	}
	public List<String> getWebRemarks() {
		return webRemarks;
	}
	public void setWebRemarks(List<String> webRemarks) {
		this.webRemarks = webRemarks;
	}
	public List<String> getWebTestimonials() {
		return webTestimonials;
	}
	public void setWebTestimonials(List<String> webTestimonials) {
		this.webTestimonials = webTestimonials;
	}
	public List<FileUploadModel> getFileList() {
		return fileList;
	}
	public void setFileList(List<FileUploadModel> fileList) {
		this.fileList = fileList;
	}
	
	
}
