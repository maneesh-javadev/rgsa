package gov.in.rgsa.serviceImpl;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.collections.CollectionUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import gov.in.rgsa.dao.CommonRepository;
import gov.in.rgsa.entity.EGovPost;
import gov.in.rgsa.entity.EGovSupportActivity;
import gov.in.rgsa.entity.EGovSupportActivityDetails;
import gov.in.rgsa.model.EGovernanceSupportModel;
import gov.in.rgsa.service.EGovernanceSupportService;
import gov.in.rgsa.service.FacadeService;
import gov.in.rgsa.user.preference.UserPreference;

@Service
public class EGovernanceSupportServiceImpl implements EGovernanceSupportService {

	@Autowired
	private CommonRepository commonRepository;

	@Autowired
	private UserPreference userPreference;
	
	@Autowired
	private FacadeService facadeService;

	@Override
	public List<EGovPost> fetchPostLevel() {
		return commonRepository.findAll("FIND_ALL_POST_LEVEL", null);
	}

	@Override
	public void saveEGovSupportActivity(EGovSupportActivity eGovSupportActivity) {

		if (userPreference.getUserType().equalsIgnoreCase('s' + "") || userPreference.getUserType().equalsIgnoreCase("C")) {
			saveEGovSupportActivitysForState(eGovSupportActivity);
		} else {
			if (eGovSupportActivity.getUserType() == 'S') {
				saveEGovSupportActivitysForMOPR(eGovSupportActivity);
			} else {

				List<EGovSupportActivityDetails> egovDetails = eGovSupportActivity.geteGovSupportActivityDetails();
				for (EGovSupportActivityDetails eGovActivityDetails : egovDetails) {
					eGovActivityDetails.seteGovSupportActivity(eGovSupportActivity);
				}

				eGovSupportActivity.setLastUpdatedOn(new Date());
				eGovSupportActivity.setLastUpdatedBy(userPreference.getUserId());
				eGovSupportActivity.setStateCode(userPreference.getStateCode());
				eGovSupportActivity.setYearId(userPreference.getFinYearId());
				eGovSupportActivity.setVersionNo(1);
				eGovSupportActivity.setStatus(false);
				eGovSupportActivity.setCreatedBy(userPreference.getUserId());
				eGovSupportActivity.setCreatedOn(new Date());

				commonRepository.update(eGovSupportActivity);
			}
		}
		
		
	}

	private void saveEGovSupportActivitysForState(EGovSupportActivity eGovSupportActivity) {
		List<EGovSupportActivityDetails> egovDetails = eGovSupportActivity.geteGovSupportActivityDetails();
		if (eGovSupportActivity.geteGovSupportActivityId() == null || eGovSupportActivity.geteGovSupportActivityId() == 0) {
			eGovSupportActivity.setStateCode(userPreference.getStateCode());
			eGovSupportActivity.setyearId(userPreference.getFinYearId());
			eGovSupportActivity.setUserType(userPreference.getUserType().charAt(0));
			eGovSupportActivity.setCreatedBy(userPreference.getUserId());
			eGovSupportActivity.setCreatedOn(new Date());
			eGovSupportActivity.setStatus(false);
			eGovSupportActivity.setLastUpdatedOn(new Date());
			eGovSupportActivity.setLastUpdatedBy(userPreference.getUserId());
			commonRepository.save(eGovSupportActivity);
			for (EGovSupportActivityDetails eGovActivityDetails : egovDetails) {
				if (egovDetails != null) {
					eGovActivityDetails.seteGovSupportActivity(eGovSupportActivity);
					commonRepository.save(eGovActivityDetails);
				}
			}
		} else {

			eGovSupportActivity.seteGovSupportActivityId(eGovSupportActivity.geteGovSupportActivityId());
			eGovSupportActivity.setLastUpdatedOn(new Date());
			eGovSupportActivity.setLastUpdatedBy(userPreference.getUserId());
			eGovSupportActivity.setStatus(false);
			eGovSupportActivity.setCreatedBy(userPreference.getUserId());
			eGovSupportActivity.setCreatedOn(new Date());
			eGovSupportActivity.setStateCode(userPreference.getStateCode());
			eGovSupportActivity.setYearId(userPreference.getFinYearId());
			eGovSupportActivity.setVersionNo(1);
			commonRepository.update(eGovSupportActivity);
			for (EGovSupportActivityDetails eGovActivityDetails : egovDetails) {

				eGovActivityDetails.seteGovSupportActivity(eGovSupportActivity);
				commonRepository.update(eGovActivityDetails);

			}
		}

	}

	private void saveEGovSupportActivitysForMOPR(EGovSupportActivity eGovSupportActivity) {
		eGovSupportActivity.seteGovSupportActivityId(null);
		List<EGovSupportActivityDetails> egovDetails = eGovSupportActivity.geteGovSupportActivityDetails();

		eGovSupportActivity.setStateCode(userPreference.getStateCode());
		eGovSupportActivity.setyearId(userPreference.getFinYearId());
		eGovSupportActivity.setUserType(userPreference.getUserType().charAt(0));
		eGovSupportActivity.setCreatedBy(userPreference.getUserId());
		eGovSupportActivity.setCreatedOn(new Date());
		eGovSupportActivity.setStatus(false);

		eGovSupportActivity.setLastUpdatedOn(new Date());
		eGovSupportActivity.setLastUpdatedBy(userPreference.getUserId());
		for (EGovSupportActivityDetails eGovActivityDetails : egovDetails) {
			if (eGovActivityDetails != null) {
				eGovActivityDetails.seteGovDetailsId(null);
				eGovActivityDetails.seteGovSupportActivity(eGovSupportActivity);
			}
		}

		commonRepository.save(eGovSupportActivity);

	}

	@Override
	public List<EGovSupportActivity> fetchEGovActivity(final Character userType) {
		Map<String, Object> params = new HashMap<>();
		List<EGovSupportActivity> eGovSupportActivity = new ArrayList<EGovSupportActivity>();
		params.put("yearId", userPreference.getFinYearId());
		params.put("stateCode", userPreference.getStateCode());
		if (userType == null) {
			params.put("userType", userPreference.getUserType().charAt(0));
		} else {
			params.put("userType", userType);
		}

		eGovSupportActivity = commonRepository.findAll("FETCH_EGOV_ACTIVITY", params);

		if (userPreference.getUserType().equalsIgnoreCase("M")  && eGovSupportActivity.size() == 0) {
			params.put("userType", 'S');
			eGovSupportActivity = commonRepository.findAll("FETCH_EGOV_ACTIVITY", params);
			if(eGovSupportActivity.get(0).getUserType()=='S' && eGovSupportActivity.get(0).getStatus()==true){
				eGovSupportActivity.get(0).setStatus(false);
			}
		}
		if (!CollectionUtils.isEmpty(eGovSupportActivity) && eGovSupportActivity.size() > 0) {
			return eGovSupportActivity;
		}
		return null;

	}

	@Override
	public List<EGovSupportActivityDetails> fetchEGovActivityDetails(Integer eGovSupportActivityId) {
		Map<String, Object> params = new HashMap<>();
		params.put("eGovSupportActivityId", eGovSupportActivityId);
		return commonRepository.findAll("FIND_ACTIVITY_DETAILS", params);
	}

	@Override
	public void freezeAndUnfreeze(EGovernanceSupportModel form) {
		if (form.geteGovSupportActivityId() != null || form.geteGovSupportActivityId() != 0) {
			EGovSupportActivity eGovSupportActivity = new EGovSupportActivity();
			eGovSupportActivity.setStateCode(userPreference.getStateCode());
			eGovSupportActivity.setYearId(userPreference.getFinYearId());
			eGovSupportActivity.setCreatedBy(userPreference.getUserId());
			eGovSupportActivity.setCreatedOn(new Date());
			eGovSupportActivity.setUserType(userPreference.getUserType().charAt(0));
			eGovSupportActivity.setLastUpdatedBy(userPreference.getUserId());
			eGovSupportActivity.setLastUpdatedOn(new Date());

			if (form.getDbFileName().equals("freeze")) {
				eGovSupportActivity.seteGovSupportActivityId(form.geteGovSupportActivityId());
				eGovSupportActivity.setAdditionalRequirement(form.getAdditionalRequirement());
				eGovSupportActivity.setStatus(true);
			}

			else {
				eGovSupportActivity.seteGovSupportActivityId(form.geteGovSupportActivityId());
				eGovSupportActivity.setAdditionalRequirement(form.getAdditionalRequirement());
				eGovSupportActivity.setStatus(false);
			}
			commonRepository.update(eGovSupportActivity);
			if (form.getDbFileName().equals("freeze")) {
				facadeService.populateStateFunds("15");
			}
		}

	}

	@Override
	public void saveEGovSupportActivityCEC(EGovSupportActivity eGovSupportActivity) {
		saveEGovSupportActivitysForState(eGovSupportActivity);

	}

	/*
	 * public Boolean handelDataForMOPR(){ Map<String, Object> parameter = new
	 * HashMap<String, Object>(); parameter.put("planStatusId",2);
	 * parameter.put("stateCode", userPreference.getStateCode());
	 * parameter.put("yearId", userPreference.getFinYearId()); List<Plan>
	 * planForwardedByState=commonRepository.findAll("PLAN_STATUS", parameter);
	 * if(!CollectionUtils.isEmpty(planForwardedByState) &&
	 * userPreference.getUserType().equalsIgnoreCase("S")) {
	 * 
	 * return true;
	 * 
	 * }
	 * 
	 * Plan plan = planForwardedByState.get(0); plan.setIsactive(true);
	 * 
	 * return false; }
	 */
}