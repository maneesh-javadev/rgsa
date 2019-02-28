package gov.in.rgsa.service;

import java.util.List;

import gov.in.rgsa.entity.ExtentOfCoverage;
import gov.in.rgsa.entity.ExtentOfCoverageDetails;
import gov.in.rgsa.entity.TrainingCategories;
import gov.in.rgsa.entity.TrainingCategory;
import gov.in.rgsa.model.ExtentOfCoverageModel;

public interface ExtentOfCoverageService {

	public List<TrainingCategories> fetchTrainingCategories();


	public void save(ExtentOfCoverageModel extentOfCoverageModel);


	public List<ExtentOfCoverage> fetchExtentOfCoverage(final Character userType);


	public List<ExtentOfCoverageDetails> fetchExtentOfCoverageDetails(Integer getCoverageId);


	public void freezeAndUnfreezeEocs(ExtentOfCoverageModel extentOfCoverageModel);

}
