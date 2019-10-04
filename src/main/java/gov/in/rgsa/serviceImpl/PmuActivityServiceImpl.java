package gov.in.rgsa.serviceImpl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.collections.CollectionUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import gov.in.rgsa.dao.CommonRepository;
import gov.in.rgsa.entity.District;
import gov.in.rgsa.entity.PmuActivity;
import gov.in.rgsa.entity.PmuActivityDetails;
import gov.in.rgsa.entity.PmuActivityType;
import gov.in.rgsa.entity.PmuDomain;
import gov.in.rgsa.entity.PmuProgress;
import gov.in.rgsa.entity.PmuProgressDetails;
import gov.in.rgsa.entity.PmuWiseProposedDomainExperts;
import gov.in.rgsa.service.FacadeService;
import gov.in.rgsa.service.PmuActivityService;
import gov.in.rgsa.user.preference.UserPreference;
/**
 * @author MOhammad Ayaz 04/10/2018
 *
 */
@Service
public class PmuActivityServiceImpl implements PmuActivityService {

	@Autowired
	private CommonRepository  commonRepository;
	
	@Autowired
	private UserPreference userPreference;
	
	@Autowired
	private FacadeService facadeService;
	
	public List<District> fetchDistrictName() {
		Map<String, Object> params=new HashMap<>();
		params.put("id", userPreference.getStateCode());
		return commonRepository.findAll("DISTRICT_PMU_LIST", params);
	}

	@Override
	public List<PmuActivityType> fetchPmuActvityType() {
		return commonRepository.findAll("FETCH_ALL_ACTIVITY_PMU_TYPE", null);
	}

	@Override
	public List<PmuActivity> fetchPmuActivity(final Character userType) {
		Map<String, Object> params=new HashMap<>();
		List<PmuActivity> pmuActivity = new ArrayList<PmuActivity>();
		if(userType == null){
			params.put("userType", userPreference.getUserType().charAt(0));
		}else{
			params.put("userType", userType);
		}
		params.put("yearId", userPreference.getFinYearId());
		params.put("stateCode", userPreference.getStateCode());
		params.put("versionNo", userPreference.getPlanVersion());
		pmuActivity= commonRepository.findAll("FETCH_PMU_ACTIVITY", params);
		
		if (userPreference.getUserType().equalsIgnoreCase("M") && pmuActivity.size() == 0) {
			params.put("userType", 'S');
			pmuActivity = commonRepository.findAll("FETCH_PMU_ACTIVITY", params);
			pmuActivity.get(0).setIsFreeze(false);
		}
		
		if(!CollectionUtils.isEmpty(pmuActivity) && pmuActivity.size()>0){
			return pmuActivity;
		}
		return null;
		
	}

	@Override
	public List<PmuWiseProposedDomainExperts> fetchPmuWiseDomainExpert() {
		return commonRepository.findAll("FETCH_DOMAIN_EXPERT_PMU_WISE", null);
	}

	@Override
	public List<PmuDomain> fetchPmuDomains() {
		return commonRepository.findAll("FIND_DOMAIN_PMU_TYPE", null);
	}
	
	@Override
	public void saveAndUpdate(PmuActivity pmuActivity)
	{
		if(userPreference.getUserType().equalsIgnoreCase('s'+"") || userPreference.getUserType().equalsIgnoreCase("C")){
			savePmuActivityDetailsForStateAndCEC(pmuActivity);
		}else{
			if(pmuActivity.getUserType()=='S'){
				savePmuActivityDetailsForMinistry(pmuActivity);
			}else{
				List<PmuActivityDetails> pmuActivityDetails = pmuActivity.getPmuActivityDetails();
				for(PmuActivityDetails activityDetails : pmuActivityDetails) {
					activityDetails.setPmuActivity(pmuActivity);
				}
				List<PmuWiseProposedDomainExperts> proposedDomainExperts = pmuActivity.getPmuWiseProposedDomainExperts();
				for(PmuWiseProposedDomainExperts experts : proposedDomainExperts) {
					experts.setPmuActivityDomain(pmuActivity);
				}
				pmuActivity.setLastUpdateBy(userPreference.getUserId());
				pmuActivity.setStateCode(userPreference.getStateCode());
				pmuActivity.setUserType(userPreference.getUserType().charAt(0));
				pmuActivity.setVersionNo(userPreference.getPlanVersion());
				pmuActivity.setIsActive(true);
				pmuActivity.setYearId(userPreference.getFinYearId());
				pmuActivity.setAdditionalRequirement(0);
					commonRepository.update(pmuActivity);
				
				}
			}
		

		
			}
	

	 public void savePmuActivityDetailsForMinistry(PmuActivity pmuActivity)
	 {
		 	pmuActivity.setPmuActivityId(null);
		 	pmuActivity.setCreatedBy(userPreference.getUserId());
			pmuActivity.setIsFreeze(false);
			pmuActivity.setLastUpdateBy(userPreference.getUserId());
			pmuActivity.setStateCode(userPreference.getStateCode());
			pmuActivity.setUserType(userPreference.getUserType().charAt(0));
			pmuActivity.setVersionNo(userPreference.getPlanVersion());
			pmuActivity.setIsActive(true);
			pmuActivity.setYearId(userPreference.getFinYearId());
			pmuActivity.setAdditionalRequirement(0);
			
			List<PmuActivityDetails> pmuActivityDetails = pmuActivity.getPmuActivityDetails();
			for(PmuActivityDetails activityDetails : pmuActivityDetails) {
				activityDetails.setPmuDetailsId(null);
				activityDetails.setPmuActivity(pmuActivity);
			}
			List<PmuWiseProposedDomainExperts> proposedDomainExperts = pmuActivity.getPmuWiseProposedDomainExperts();
			for(PmuWiseProposedDomainExperts experts : proposedDomainExperts) {
				experts.setPmuWiseProposedDomainExpertsId(null);
				experts.setPmuActivityDomain(pmuActivity);
			}
			commonRepository.update(pmuActivity);
		 
		 
	 }
	
	
	public void savePmuActivityDetailsForStateAndCEC(PmuActivity pmuActivity) {
		pmuActivity.setCreatedBy(userPreference.getUserId());
		pmuActivity.setIsFreeze(false);
		pmuActivity.setLastUpdateBy(userPreference.getUserId());
		pmuActivity.setStateCode(userPreference.getStateCode());
		pmuActivity.setUserType(userPreference.getUserType().charAt(0));
		pmuActivity.setVersionNo(userPreference.getPlanVersion());
		pmuActivity.setIsActive(true);
		pmuActivity.setYearId(userPreference.getFinYearId());
		pmuActivity.setAdditionalRequirement(0);
		
		List<PmuActivityDetails> pmuActivityDetails = pmuActivity.getPmuActivityDetails();
		for(PmuActivityDetails activityDetails : pmuActivityDetails) {
			activityDetails.setPmuActivity(pmuActivity);
		}
		List<PmuWiseProposedDomainExperts> proposedDomainExperts = pmuActivity.getPmuWiseProposedDomainExperts();
		for(PmuWiseProposedDomainExperts experts : proposedDomainExperts) {
			experts.setPmuActivityDomain(pmuActivity);
			/*if(experts.getNoOfExperts() != null)*/
			/*if(experts.getDomainId() != null)
			  commonRepository.save(experts);*/
		}
		commonRepository.update(pmuActivity);
	}

	@Override
	public void pmuFreezUnfreeze(PmuActivity pmuActivity) {
		Map<String, Object> params = new HashMap<>();
		if(pmuActivity.getIsFreeze() == true) {
			params.put("isFreeze", false);	
		}else {
			params.put("isFreeze", true);
		}
		params.put("pmuActivityId", pmuActivity.getPmuActivityId());
		commonRepository.excuteUpdate("PMU_FREEZ_UNFREEZE", params);
		if(!pmuActivity.getIsFreeze()) {
			facadeService.populateStateFunds("12");
	}
		
	}

	@Override
	public List<PmuActivity> fetchApprovedPmu() {
		Map<String, Object> params=new HashMap<>();
		params.put("stateCode", userPreference.getStateCode());
		params.put("yearId", userPreference.getFinYearId());
		params.put("userType",'C');
		return commonRepository.findAll("FETCH_PMU_APPROVED_ACTIVITY", params);
	}
	@Override
	public List<PmuActivityDetails> fetchPmuApprovedDetails(Integer pmuActivityId) {
		Map<String, Object> params=new HashMap<>();
		params.put("pmuActivityId", pmuActivityId);
		return commonRepository.findAll("FETCH_PMU_APPROVED_ACTIVITY_DETAILS", params);
	}

	@Override
	public List<PmuProgressDetails> getPmuProgressActBasedOnActIdAndQtrId(Integer pmuActivityId, int quarterId) {
		Map<String, Object> params = new HashMap();
		params.put("pmuActivityId", pmuActivityId);
		params.put("quarterId", quarterId);	
		List<PmuProgress> pmuProgress= commonRepository.findAll("FETCH_PMU_ACT_QTR_ID_AND_ACT_ID", params);
		List<PmuProgressDetails> pmuProgressDetails=new ArrayList<>();
		if(CollectionUtils.isNotEmpty(pmuProgress)){
			for (PmuProgress pmu_Progress : pmuProgress) {
				pmuProgressDetails.addAll(pmu_Progress.getPmuProgressDetails());
			}
			return pmuProgressDetails;
		}else{
			return null;
		}
	}
}
