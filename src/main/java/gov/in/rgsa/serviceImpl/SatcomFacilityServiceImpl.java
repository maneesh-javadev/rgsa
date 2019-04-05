package gov.in.rgsa.serviceImpl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import org.apache.commons.collections.CollectionUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import gov.in.rgsa.dao.CommonRepository;
import gov.in.rgsa.entity.SatcomActivity;
import gov.in.rgsa.entity.SatcomActivityDetails;
import gov.in.rgsa.entity.SatcomCurrentStatus;
import gov.in.rgsa.entity.SatcomCurrentStatusDetails;
import gov.in.rgsa.entity.SatcomCurrentStatusFundSource;
import gov.in.rgsa.entity.SatcomLevel;
import gov.in.rgsa.entity.SatcomMaster;
import gov.in.rgsa.entity.SchemeMaster;
import gov.in.rgsa.service.FacadeService;
import gov.in.rgsa.service.SatcomFacilityService;
import gov.in.rgsa.user.preference.UserPreference;

@Service
public class SatcomFacilityServiceImpl implements SatcomFacilityService{
	
	@Autowired
	CommonRepository commonRepository;
	
	@Autowired
	UserPreference userPreference;
	

	@Autowired
	private FacadeService facadeService;
	
	
	@Override
	public List<SatcomMaster> getSatcomeActivityName() {
		return commonRepository.findAll("SATCOM_ACTIVTY_NAME", null);
	}

	@Override
	public List<SatcomLevel> getSatcomeLevel() {
		return commonRepository.findAll("SATCOM_LEVEL", null);
	}

	@Override
	public void saveSatcomeFacility(SatcomActivity activity,String userType) {
		
		if(userPreference.getUserType().equalsIgnoreCase('s'+"") || userPreference.getUserType().equalsIgnoreCase("C"))
		{
			saveSatcomeFacilityForStateAndCEC(activity);
		}else{
			if(activity.getUserType().equalsIgnoreCase("S")){
				saveSatcomeFacilityForMOPR(activity);
			}else{
				List<SatcomActivityDetails> activityDetails=activity.getActivityDetails();
				for (SatcomActivityDetails satcomActivityDetails : activityDetails) {
					satcomActivityDetails.setSatcomActivity(activity);
				}
				commonRepository.update(activity);
			}
		}
		System.out.println("***activity.getStatus()"+activity.getStatus());
		if(activity.getStatus()!=null &&  activity.getStatus().length()>0 && activity.getStatus().charAt(0)=='F') {
			facadeService.populateStateFunds("7");
		}
		
	}

	private void saveSatcomeFacilityForStateAndCEC(SatcomActivity activity){
		List<SatcomActivityDetails> activityDetails=activity.getActivityDetails();
		for (SatcomActivityDetails satcomActivityDetails : activityDetails) {
			satcomActivityDetails.setSatcomActivity(activity);
		}
		
		if(activity.getSatcomActivityId()==null || activity.getSatcomActivityId()==0){
			activity.setUserType(userPreference.getUserType());
			activity.setCreatedBy(userPreference.getUserId());
			activity.setVersionNo(1);
			activity.setLastUpdatedBy(userPreference.getUserId());
			activity.setStateCode(userPreference.getStateCode());
			activity.setYearId(userPreference.getFinYearId());
			commonRepository.save(activity);
		}
		else{
			commonRepository.update(activity);
		}
	}
	
	private void saveSatcomeFacilityForMOPR(SatcomActivity activity) {
		activity.setSatcomActivityId(null);
		List<SatcomActivityDetails> activityDetails=activity.getActivityDetails();
		for (SatcomActivityDetails satcomActivityDetails : activityDetails) {
			satcomActivityDetails.setSatcomActivityDetailsId(null);
			satcomActivityDetails.setSatcomActivity(activity);
		}
		activity.setUserType(userPreference.getUserType());
		activity.setCreatedBy(userPreference.getUserId());
		activity.setVersionNo(1);
		activity.setLastUpdatedBy(userPreference.getUserId());
		activity.setStateCode(userPreference.getStateCode());
		activity.setYearId(userPreference.getFinYearId());
		commonRepository.save(activity);
	}
	
	@Override
	public List<SatcomActivity> fetchSatcomActivities(String userType) {
		List<SatcomActivity> satcomActivities = new ArrayList<>();
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("yearId", userPreference.getFinYearId());
		params.put("stateCode", userPreference.getStateCode());
		
		if(userType == null){
			params.put("userType", userPreference.getUserType().charAt(0));
		}else{
			params.put("userType", userType);
		}
		satcomActivities = commonRepository.findAll("FETCH_SATCOM_ACTIVITY_DETAILS",params);
		//satcomActivities = commonRepository.findAll("FETCH_SATCOM_ACTIVITY_DETAILS",params);
		if(userPreference.getUserType().equalsIgnoreCase("M") && CollectionUtils.isEmpty(satcomActivities)){
			params.put("userType", "S");
			satcomActivities = commonRepository.findAll("FETCH_SATCOM_ACTIVITY_DETAILS",params);
			satcomActivities.get(0).setStatus("UF");
			return satcomActivities;
		}
		/*if (userPreference.getUserType().equalsIgnoreCase("C") && CollectionUtils.isEmpty(satcomActivities)) {
			params.put("userType", "S");
			satcomActivities = commonRepository.findAll("FETCH_SATCOM_ACTIVITY_DETAILS",params);
			satcomActivities.get(0).setStatus("UF");
		}*/
		return satcomActivities;
	}

	@Override
	public List<SatcomCurrentStatus> fetchSatcomStatus() {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("stateCode", userPreference.getStateCode());
		params.put("yearId", userPreference.getFinYearId());
		params.put("userType", userPreference.getUserType().charAt(0));
		return commonRepository.findAll("FETCH_SATCOM_CURRENTSTATUS",params);
	}

	@Override
	public List<SchemeMaster> fetchSchemeMaster() {
		return commonRepository.findAll("FETCH_SCHEME_MASTER", null);
	}

	@Override
	public void saveSatcomCurrentStatus(SatcomCurrentStatus satcomCurrentStatus) {
		satcomCurrentStatus = setCapacityBuildingActivityObject(satcomCurrentStatus);
		List<SatcomCurrentStatusDetails> satcomCurrentStatusDetails = satcomCurrentStatus.getActivityDetails();
		final SatcomCurrentStatus satcomCurrentStatusToSet = satcomCurrentStatus;
		satcomCurrentStatusDetails.forEach(
				(satcomCurrentStatusDetail)-> {
					if(satcomCurrentStatusDetail != null) {
						List<SatcomCurrentStatusFundSource> satcomCurrentStatusFundSourceList = new ArrayList<SatcomCurrentStatusFundSource>();
						satcomCurrentStatusDetail.setSatcomCurrentStatus(satcomCurrentStatusToSet);
						String[] schemes = satcomCurrentStatusDetail.getScheme();
						if(schemes != null) {
							for (String scheme : schemes) {
									SatcomCurrentStatusFundSource currentStatusFundSource = new SatcomCurrentStatusFundSource();
									SchemeMaster schemeMaster = new SchemeMaster();
									schemeMaster.setSchemeId(Integer.parseInt(scheme));
									currentStatusFundSource.setScheme(schemeMaster);
									currentStatusFundSource.setSatcomCurrentStatusDetails(satcomCurrentStatusDetail);
									satcomCurrentStatusFundSourceList.add(currentStatusFundSource);
							}
						}
						satcomCurrentStatusDetail.setSatcomCurrentStatusFundSource(satcomCurrentStatusFundSourceList);
					}
					
				}
			);
		
		satcomCurrentStatus.setActivityDetails(satcomCurrentStatusDetails);
		if(satcomCurrentStatus.getSatcom_currentstatus_id() == null || satcomCurrentStatus.getSatcom_currentstatus_id() == 0) {
			satcomCurrentStatus.setIsFreeze(Boolean.FALSE);
			commonRepository.save(satcomCurrentStatus);
		}else {
			commonRepository.update(satcomCurrentStatus);
		}
	}

	private SatcomCurrentStatus setCapacityBuildingActivityObject(SatcomCurrentStatus satcomCurrentStatus) {
		satcomCurrentStatus.setCreatedBy(userPreference.getUserId());
		satcomCurrentStatus.setLastUpdatedBy(userPreference.getUserId());
		satcomCurrentStatus.setStateCode(userPreference.getStateCode());
		satcomCurrentStatus.setUserType(userPreference.getUserType().charAt(0));
		satcomCurrentStatus.setYearId(userPreference.getFinYearId());
		return satcomCurrentStatus;
	}
	
	public SchemeMaster fetchSchemeMasterById(Integer id) {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("schemeId",id);
		return commonRepository.find("FETCH_SCHEME_MASTER_BY_ID", params);
	}
	
	@Override
	public List<SatcomActivity> getApprovedSatcomActivity() {
		Map<String,Object> params = new HashMap<>();
		params.put("yearId", userPreference.getFinYearId());
		params.put("stateCode", userPreference.getStateCode());
		params.put("userType", "C");
		List<SatcomActivity> satcomActivity = commonRepository.findAll("GET_Satcom_ActivityAPPROVED_TRAINING", params);
		return satcomActivity;
	}
	
}
