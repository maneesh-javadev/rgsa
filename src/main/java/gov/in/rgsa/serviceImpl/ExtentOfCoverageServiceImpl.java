package gov.in.rgsa.serviceImpl;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import gov.in.rgsa.dao.CommonRepository;
import gov.in.rgsa.entity.ExtentOfCoverage;
import gov.in.rgsa.entity.ExtentOfCoverageDetails;
import gov.in.rgsa.entity.TrainingCategories;
import gov.in.rgsa.entity.TrainingCategory;
import gov.in.rgsa.model.ExtentOfCoverageModel;
import gov.in.rgsa.service.ExtentOfCoverageService;
import gov.in.rgsa.user.preference.UserPreference;


@Service
public class ExtentOfCoverageServiceImpl implements ExtentOfCoverageService {


	@Autowired
	private CommonRepository commonRepository; 
	
	@Autowired
	private UserPreference user;
	
	
	
	@Override
	public List<TrainingCategories> fetchTrainingCategories() {
		return commonRepository.findAll("Fetch_Training_Categories", null);
		
	}

	@Override
	public void save(ExtentOfCoverageModel extentOfCoverageModel) {
		
	
		ExtentOfCoverage extentOfCoverage=new ExtentOfCoverage();
		List<ExtentOfCoverageDetails> extentOfCoverageDetails= extentOfCoverageModel.getExtentOfCoverageDetails();
		extentOfCoverage.setStateCode(user.getStateCode());
		extentOfCoverage.setyearId(user.getFinYearId());
		extentOfCoverage.setUserType(user.getUserType());
		extentOfCoverage.setCreatedBy(user.getUserId());
		extentOfCoverage.setCreatedOn(new Date());
		extentOfCoverage.setIsfreez(false);
		
		if(extentOfCoverageModel.getCoverageId() == null || extentOfCoverageModel.getCoverageId()== 0)
		{
			extentOfCoverage.setLastUpdatedOn(new Date());
			extentOfCoverage.setLastUpdatedBy(user.getUserId());
			commonRepository.save(extentOfCoverage);
			for(ExtentOfCoverageDetails extentOfCoverageDetail : extentOfCoverageDetails)
			{
				if(extentOfCoverageDetail != null)
				{
					extentOfCoverageDetail.setCoverageId(extentOfCoverage.getCoverageId());
					commonRepository.save(extentOfCoverageDetail);
				}
			}
		
		
		}
		
		else
		{
			extentOfCoverage.setCoverageId(extentOfCoverageModel.getCoverageId());
			extentOfCoverage.setLastUpdatedOn(new Date());
			extentOfCoverage.setLastUpdatedBy(user.getUserId());
			commonRepository.update(extentOfCoverage);
			for(ExtentOfCoverageDetails extentOfCoverageDetail : extentOfCoverageDetails)
			{
				
				extentOfCoverageDetail.setCoverageId(extentOfCoverage.coverageId);
					commonRepository.update(extentOfCoverageDetail);
				
			}
		}
	
		
	}

	/*@Override
	public List<ExtentOfCoverage> fetchExtentOfCoverage() {
		Map<String, Object> params=new HashMap<>();
		params.put("yearId",user.getFinYearId());
		params.put("stateCode", user.getStateCode());
		params.put("userType", user.getUserType());
		return commonRepository.findAll("FETCH_Extent_Of_Coverage",params);
		
	}*/

	@Override
	public List<ExtentOfCoverageDetails> fetchExtentOfCoverageDetails(Integer coverageId) {
		Map<String, Object> params=new HashMap<>();
		params.put("coverageId", coverageId);
		return commonRepository.findAll("FIND_Extent_Of_Coverage_Details", params) ;
	}

	@Override
	public void freezeAndUnfreezeEocs(ExtentOfCoverageModel extentOfCoverageModel) {
		if(extentOfCoverageModel.getCoverageId() != null || extentOfCoverageModel.getCoverageId() !=0)
		{
			ExtentOfCoverage extentOfCoverage=new ExtentOfCoverage();
			extentOfCoverage.setStateCode(user.getStateCode());
			extentOfCoverage.setYearId(user.getFinYearId());
			extentOfCoverage.setCreatedBy(user.getUserId());
			extentOfCoverage.setCreatedOn(new Date());
			extentOfCoverage.setUserType(user.getUserType());
			extentOfCoverage.setLastUpdatedBy(user.getUserId());
			extentOfCoverage.setLastUpdatedOn(new Date());
		
		
		if(extentOfCoverageModel.getDbFileName().equals("freeze"))
		{
			extentOfCoverage.setCoverageId(extentOfCoverageModel.getCoverageId());
			extentOfCoverage.setIsfreez(true);
		}
		
		else
		{
			extentOfCoverage.setCoverageId(extentOfCoverageModel.getCoverageId());
			extentOfCoverage.setIsfreez(false);
		}
		commonRepository.update(extentOfCoverage);
		
		}
		
	}

	@Override
	public List<ExtentOfCoverage> fetchExtentOfCoverage(Character userType) {
		// TODO Auto-generated method stub
		return null;
	}
	
	

}


