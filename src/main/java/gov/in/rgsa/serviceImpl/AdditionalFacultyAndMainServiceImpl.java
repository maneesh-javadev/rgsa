package gov.in.rgsa.serviceImpl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.collections.CollectionUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import gov.in.rgsa.dao.CommonRepository;
import gov.in.rgsa.entity.AdditionalFacultyProgress;
import gov.in.rgsa.entity.AdditionalFacultyProgressDetail;
import gov.in.rgsa.entity.District;
import gov.in.rgsa.entity.Domains;
import gov.in.rgsa.entity.InstitueInfraHrActivity;
import gov.in.rgsa.entity.InstitueInfraHrActivityDetails;
import gov.in.rgsa.entity.InstituteInfraHrActivityType;
import gov.in.rgsa.entity.PmuProgress;
import gov.in.rgsa.entity.PmuProgressDetails;
import gov.in.rgsa.entity.TIWiseProposedDomainExperts;
import gov.in.rgsa.entity.TrainingInstituteCurrentStatusDetails;
import gov.in.rgsa.model.AdditionalFactultyAndMaintModel;
import gov.in.rgsa.service.AdditionalFacultyAndMainService;
import gov.in.rgsa.service.FacadeService;
import gov.in.rgsa.user.preference.UserPreference;

@Service
public class AdditionalFacultyAndMainServiceImpl implements AdditionalFacultyAndMainService {

	@Autowired
	private CommonRepository  commonRepository;
	
	@Autowired
	private UserPreference userPreference;
	

	@Autowired
	private FacadeService facadeService;
	
	@Override
	public List<InstituteInfraHrActivityType> fetchHrActvityType() {
		return commonRepository.findAll("FETCH_ALL_ACTIVITY_HR_TYPE", null);
	}

	@Override
	public void saveAddFacAndMain(AdditionalFactultyAndMaintModel additionalFactultyAndMaintModel) {
		String previousRecordUserType= additionalFactultyAndMaintModel.getUserType();
		InstitueInfraHrActivity institueInfraHrActivity=new InstitueInfraHrActivity();
		List<InstitueInfraHrActivityDetails> institueInfraHrActivityDetails=additionalFactultyAndMaintModel.getInstitueInfraHrActivityDetails();
		List<TIWiseProposedDomainExperts> tIWiseProposedDomainExperts=additionalFactultyAndMaintModel.gettIWiseProposedDomainExperts();
		institueInfraHrActivity.setStateCode(userPreference.getStateCode());
		institueInfraHrActivity.setYearId(userPreference.getFinYearId());
		institueInfraHrActivity.setUserType(userPreference.getUserType());
		institueInfraHrActivity.setAdditionalRequirementSprc(additionalFactultyAndMaintModel.getAdditionalRequirementSprc());
		institueInfraHrActivity.setAdditionalRequirementDprc(additionalFactultyAndMaintModel.getAdditionalRequirementDprc());
		institueInfraHrActivity.setCreatedBy(userPreference.getUserId());
		institueInfraHrActivity.setLastUpdateBy(userPreference.getUserId());
		institueInfraHrActivity.setDistrictsSupported(additionalFactultyAndMaintModel.getDistrictsSupported());
		institueInfraHrActivity.setIsFreeze(false);
		
		if(additionalFactultyAndMaintModel.getInstituteInfraHrActivityId() == null || additionalFactultyAndMaintModel.getInstituteInfraHrActivityId() == 0)
		{
			for(TIWiseProposedDomainExperts domainExpert : tIWiseProposedDomainExperts)
			{
				if(domainExpert != null)
				{
					if(domainExpert.getDomainId() < 4)
					{
						domainExpert.setInstitueInfraHrActivity(institueInfraHrActivity);
					}
					else
					{
						domainExpert.setDistrictCode(additionalFactultyAndMaintModel.getDistrictCode());
						domainExpert.setInstitueInfraHrActivity(institueInfraHrActivity);
					}
					}
			}
			institueInfraHrActivity.settIWiseProposedDomainExperts(tIWiseProposedDomainExperts);
			institueInfraHrActivity.setAdditionalRequirementSprc(additionalFactultyAndMaintModel.getAdditionalRequirementSprc());
			institueInfraHrActivity.setAdditionalRequirementDprc(additionalFactultyAndMaintModel.getAdditionalRequirementDprc());
		commonRepository.save(institueInfraHrActivity);
		for(InstitueInfraHrActivityDetails details : institueInfraHrActivityDetails )
		{
			if(details != null)
			{
				
				details.setInstituteInfraHrActivityId(institueInfraHrActivity.getInstituteInfraHrActivityId());
				commonRepository.save(details);
			}
		}
		
		}
		else
		{
			institueInfraHrActivity.setAdditionalRequirementSprc(additionalFactultyAndMaintModel.getAdditionalRequirementSprc());
			institueInfraHrActivity.setAdditionalRequirementDprc(additionalFactultyAndMaintModel.getAdditionalRequirementDprc());
			if(userPreference.getUserType().equalsIgnoreCase("M") && previousRecordUserType.equalsIgnoreCase("S")){
					commonRepository.save(institueInfraHrActivity);
					institueInfraHrActivity.setUserType(userPreference.getUserType());
					for(TIWiseProposedDomainExperts domainExpert : tIWiseProposedDomainExperts)
					{
						if(domainExpert != null)
						{
							if(domainExpert.getDomainId() < 4)
							{
								domainExpert.setInstitueInfraHrActivity(institueInfraHrActivity);
							}
							else
							{
								domainExpert.setDistrictCode(additionalFactultyAndMaintModel.getDistrictCode());
								domainExpert.setInstitueInfraHrActivity(institueInfraHrActivity);
							}
							domainExpert.setTiWiseProposedDomainExpertsId(null);
							}
					}
					institueInfraHrActivity.settIWiseProposedDomainExperts(tIWiseProposedDomainExperts);
					institueInfraHrActivity.setAdditionalRequirementSprc(additionalFactultyAndMaintModel.getAdditionalRequirementSprc());
					institueInfraHrActivity.setAdditionalRequirementDprc(additionalFactultyAndMaintModel.getAdditionalRequirementDprc());
				commonRepository.save(institueInfraHrActivity);
					for(InstitueInfraHrActivityDetails details: institueInfraHrActivityDetails)
					{
						details.setInstituteInfrsaHrActivityDetailsId(null);
						details.setInstituteInfraHrActivityId(institueInfraHrActivity.getInstituteInfraHrActivityId());
						commonRepository.save(details);
					}
			}else{
				for(TIWiseProposedDomainExperts domainExpert : tIWiseProposedDomainExperts)
				{
					if(domainExpert != null)
					{
						if(domainExpert.getDomainId() < 4)
						{
							domainExpert.setInstitueInfraHrActivity(institueInfraHrActivity);
						}
						else
						{
							domainExpert.setDistrictCode(additionalFactultyAndMaintModel.getDistrictCode());
							domainExpert.setInstitueInfraHrActivity(institueInfraHrActivity);
						}
					}
				}
				institueInfraHrActivity.settIWiseProposedDomainExperts(tIWiseProposedDomainExperts);
				institueInfraHrActivity.setInstituteInfraHrActivityId(additionalFactultyAndMaintModel.getInstituteInfraHrActivityId());
				commonRepository.update(institueInfraHrActivity);
				
				
				
				for(InstitueInfraHrActivityDetails details: institueInfraHrActivityDetails)
				{
					details.setInstituteInfraHrActivityId(institueInfraHrActivity.getInstituteInfraHrActivityId());
					commonRepository.update(details);
				}
			}
			
			
			
			if(additionalFactultyAndMaintModel.getDbFileName().equals("freeze"))
			{
				institueInfraHrActivity.setIsFreeze(true);
				institueInfraHrActivity.setInstituteInfraHrActivityId(additionalFactultyAndMaintModel.getInstituteInfraHrActivityId());
				commonRepository.update(institueInfraHrActivity);
			}
			else if(additionalFactultyAndMaintModel.getDbFileName().equals("unfreeze")){
				institueInfraHrActivity.setIsFreeze(false);
				institueInfraHrActivity.setInstituteInfraHrActivityId(additionalFactultyAndMaintModel.getInstituteInfraHrActivityId());
				commonRepository.update(institueInfraHrActivity);
			}
			
		}
		
		if(additionalFactultyAndMaintModel.getDbFileName().equals("freeze"))
		{
			facadeService.populateStateFunds("14");
		}
		
	}

	@Override
	public List<InstitueInfraHrActivity> fetchInstituteHrActivity(String userType) {
		Map<String, Object> params=new HashMap<>();
		List<InstitueInfraHrActivity> activity=new ArrayList<>(); 
		params.put("stateCode", userPreference.getStateCode());
		params.put("yearId", userPreference.getFinYearId());
		if(userType != null){
			params.put("userType", userType);
		}else{
			params.put("userType", userPreference.getUserType());
		}
		activity = commonRepository.findAll("FETCH_INSTITUTE_HR_ACTIVITY", params);
		if((userPreference.getUserType().equalsIgnoreCase("M")) && CollectionUtils.isEmpty(activity)){
			params.put("userType", "S");
			activity = commonRepository.findAll("FETCH_INSTITUTE_HR_ACTIVITY", params);
			if(activity.get(0).getUserType().equalsIgnoreCase("S") && activity.get(0).getIsFreeze() == true) {
				activity.get(0).setIsFreeze(false);
		}
		}
		return activity;
	}

	@Override
	public List<InstitueInfraHrActivityDetails> fetchInstituteHrActivityDetails(Integer instituteInfraHrActivityId) {
		Map<String, Object> params=new HashMap<>();
		params.put("instituteInfraHrActivityId", instituteInfraHrActivityId);
		return commonRepository.findAll("FETCH_INSTITUTE_HR_ACTIVITY_DETAILS", params);
	}

	@Override
	public List<Domains> fetchDomains() {
		return commonRepository.findAll("FIND_TRAINING_INSTITUTION_TYPE", null);
	}

	@Override
	public List<TrainingInstituteCurrentStatusDetails> fetchTiLocation(Integer trainingInstitueTypeId) {
        Map<String, Object> params=new HashMap<>();
        params.put("trainingInstitueTypeId", trainingInstitueTypeId);
		return commonRepository.findAll("FETCH_TRAINING_DETAILS_OF_DPRC", params);
	}

	@Override
	public List<District> fetchDistrictName() {
		return commonRepository.findAll("DISTRICT_NAME_LIST", null);
	}

	@Override
	public List<TIWiseProposedDomainExperts> fetchTiWiseDomainExpert() {
		return commonRepository.findAll("FETCH_DOMAIN_EXPERT_TI_WISE", null);
	}
	
	@Override
	public List<InstitueInfraHrActivity> fetchApprovedInstituteHrActivity() {
		Map<String, Object> params=new HashMap<>();
		params.put("stateCode", userPreference.getStateCode());
		params.put("yearId", userPreference.getFinYearId());
		params.put("userType", "C");
		return commonRepository.findAll("FETCH_INSTITUTE_APPROVED_HR_ACTIVITY", params);
	}
	@Override
	public List<InstitueInfraHrActivityDetails> fetchInstituteHrActivityApprovedDetails(Integer instituteInfraHrActivityId) {
		Map<String, Object> params=new HashMap<>();
		params.put("instituteInfraHrActivityId", instituteInfraHrActivityId);
		return commonRepository.findAll("FETCH_INSTITUTE_HR_APPROVED_ACTIVITY_DETAILS", params);
	}

	@Override
	public List<TIWiseProposedDomainExperts> fetchTiWiseDomainExpertById(Integer instituteInfraHrActivityId) {
		Map<String, Object> params=new HashMap<>();
		params.put("instituteInfraHrActivityId", instituteInfraHrActivityId);
		return commonRepository.findAll("FETCH_DOMAIN_EXPERT_TI_WISE_ACT_ID", params);
	}

	@Override
	public List<AdditionalFacultyProgressDetail> getAdditionalFacultyProgressBasedOnActIdAndQtrId(
			Integer instituteInfraHrActivityId, int quarterId) {
		List<AdditionalFacultyProgress> additionalFacultyProgress = getQprHrSupportActivityExceptCurrentQtr(instituteInfraHrActivityId, quarterId);
		List<AdditionalFacultyProgressDetail> additionalFacultyProgressDetail=new ArrayList<>();
		if(CollectionUtils.isNotEmpty(additionalFacultyProgress)){
			for (AdditionalFacultyProgress additionalFaculty_Progress : additionalFacultyProgress) {
				additionalFacultyProgressDetail.addAll(additionalFaculty_Progress.getAdditionalFacultyProgressDetail());
			}
			return additionalFacultyProgressDetail;
		}else{
			return null;
		}
	}
	
	public List<AdditionalFacultyProgress> getQprHrSupportActivityExceptCurrentQtr(Integer instituteInfraHrActivityId , int quarterId){
		Map<String, Object> params = new HashMap<String,Object>();
		params.put("instituteInfraHrActivityId", instituteInfraHrActivityId);
		params.put("quarterId", quarterId);	
		return commonRepository.findAll("FETCH_HR_SUPPORT_ACT_QTR_ID_AND_ACT_ID", params);
	}

	@Override
	public Map<? extends String, ? extends Object> getTotalAddReqBesidesCurrentQtr(Integer instituteInfraHrActivityId,
			int quarterId) {
		Map<String, Object> params = new HashMap<String,Object>();
		List<AdditionalFacultyProgress> additionalFacultyProgress = getQprHrSupportActivityExceptCurrentQtr(instituteInfraHrActivityId, quarterId);
		int total_sprc_additional_req=0,total_dprc_additional_req=0;
		for (AdditionalFacultyProgress additional_Faculty_Progress : additionalFacultyProgress) {
			if(additional_Faculty_Progress.getAdditionalReqSprc() != null) {
				total_sprc_additional_req += additional_Faculty_Progress.getAdditionalReqSprc();
			}
			if(additional_Faculty_Progress.getAdditionalReqDprc() != null) {
				total_dprc_additional_req += additional_Faculty_Progress.getAdditionalReqDprc();
			}
		}
		params.put("total_add_req_sprc", total_sprc_additional_req);
		params.put("total_add_req_dprc", total_dprc_additional_req);
		return params;
	}

}
