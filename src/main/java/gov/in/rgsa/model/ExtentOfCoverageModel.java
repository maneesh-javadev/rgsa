package gov.in.rgsa.model;

import java.util.List;

import gov.in.rgsa.entity.ExtentOfCoverageDetails;

public class ExtentOfCoverageModel {

	

	
	private Integer coverageId;
	
	private Integer trainingCategoryId;
	
	private List<ExtentOfCoverageDetails> extentOfCoverageDetails;
	
	private Integer noOfErsTrained;
	
	private Integer noOfPsTrained;
	
	private Integer noOfErsToBeTrained;
	
	private Integer noOfPsToBeTrained;
	
	

	

	public String getDbFileName() {
		return DbFileName;
	}

	public void setDbFileName(String dbFileName) {
		DbFileName = dbFileName;
	}

	private String DbFileName;
	
	public Integer getCoverageId() {
		return coverageId;
	}

	public void setCoverageId(Integer coverageId) {
		this.coverageId = coverageId;
	}

	public Integer getTrainingCategoryId() {
		return trainingCategoryId;
	}

	public void setTrainingCategoryId(Integer trainingCategoryId) {
		this.trainingCategoryId = trainingCategoryId;
	}

	public List<ExtentOfCoverageDetails> getExtentOfCoverageDetails() {
		return extentOfCoverageDetails;
	}

	public void setExtentOfCoverageDetails(List<ExtentOfCoverageDetails> extentOfCoverageDetails) {
		this.extentOfCoverageDetails = extentOfCoverageDetails;
	}

	public Integer getNoOfErsTrained() {
		return noOfErsTrained;
	}

	public void setNoOfErsTrained(Integer noOfErsTrained) {
		this.noOfErsTrained = noOfErsTrained;
	}

	public Integer getNoOfPsTrained() {
		return noOfPsTrained;
	}

	public void setNoOfPsTrained(Integer noOfPsTrained) {
		this.noOfPsTrained = noOfPsTrained;
	}

	public Integer getNoOfErsToBeTrained() {
		return noOfErsToBeTrained;
	}

	public void setNoOfErsToBeTrained(Integer noOfErsToBeTrained) {
		this.noOfErsToBeTrained = noOfErsToBeTrained;
	}

	public Integer getNoOfPsToBeTrained() {
		return noOfPsToBeTrained;
	}

	public void setNoOfPsToBeTrained(Integer noOfPsToBeTrained) {
		this.noOfPsToBeTrained = noOfPsToBeTrained;
	}
	
	
}
