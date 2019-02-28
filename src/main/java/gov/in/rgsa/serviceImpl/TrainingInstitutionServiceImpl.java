package gov.in.rgsa.serviceImpl;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.collections.CollectionUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import gov.in.rgsa.dao.CommonRepository;
import gov.in.rgsa.entity.Block;
import gov.in.rgsa.entity.District;
import gov.in.rgsa.entity.SchemeMaster;
import gov.in.rgsa.entity.State;
import gov.in.rgsa.entity.TrainingInstitueActivityType;
import gov.in.rgsa.entity.TrainingInstitueType;
import gov.in.rgsa.entity.TrainingInstituteCarryForward;
import gov.in.rgsa.entity.TrainingInstituteCfDetails;
import gov.in.rgsa.entity.TrainingInstituteCurrentStatus;
import gov.in.rgsa.entity.TrainingInstituteCurrentStatusDetails;
import gov.in.rgsa.entity.TrainingInstituteCurrentStatusFundSource;
import gov.in.rgsa.service.TrainingInstitutionService;
import gov.in.rgsa.user.preference.UserPreference;

@Service
public class TrainingInstitutionServiceImpl implements TrainingInstitutionService{

	@Autowired
	private CommonRepository commonRepository;
	
	@Autowired
	private UserPreference userPreference;
	
	@Override
	public List<TrainingInstitueActivityType> fetchTypesOfTrainingInstitue() {
		return commonRepository.findAll("FETCH_TRAINING_INSTITUTION_ACTIVITY_TYPE",null);
	}

	@Override
	public void saveTrainingInstituetionCF(TrainingInstituteCarryForward carryForward) {
		

		List<TrainingInstituteCfDetails> cfDetails=carryForward.getCfDetails();
		for (TrainingInstituteCfDetails details : cfDetails) {
			details.setCarryForward(carryForward);
		}
		if(carryForward.getTrainingInstituteCfId()==null || carryForward.getTrainingInstituteCfId()==0){
			carryForward.setStateCode(userPreference.getStateCode());
			carryForward.setYearId(userPreference.getFinYearId());
			carryForward.setCreatedBy(userPreference.getUserId());
			carryForward.setLastUpdatedBy(userPreference.getUserId());
			carryForward.setUserType(userPreference.getUserType());
			commonRepository.save(carryForward);
		}
		else{
			commonRepository.update(carryForward);
		}
		
	}

	@Override
	public TrainingInstituteCarryForward getDetailsOfTrainingInstituetionCF() {
		List<TrainingInstituteCarryForward> carryForwards=null;
		Map<String, Object> map = new HashMap<String,Object>();
		map.put("stateCode", userPreference.getStateCode());
		map.put("yearId", userPreference.getFinYearId());
		map.put("userType", userPreference.getUserType());
		carryForwards=commonRepository.findAll("FETCH_TRAINING_INSTITUTION_CF_DETAILS", map);
		if(!CollectionUtils.isEmpty(carryForwards) && carryForwards.size()>0){
			return carryForwards.get(0);
		}
		return null;
	}

	@Override
	public List<TrainingInstitueType> fetchInstituteTypes(Integer selectedLevel) {
		Map<String, Object> params = new HashMap<>();
		params.put("level", selectedLevel);
		return commonRepository.findAll("FETCH_TRAINING_INSTITUTION_TYPE_BASED_ON_LEVEL", params);
	}
	
	@Override
	public List<SchemeMaster> fetchScheme() {
		return commonRepository.findAll("FETCH_SCHEME_MASTER", null);
	}

	@Override
	public void saveInfrastructureDetails(TrainingInstituteCurrentStatus trainingInstituteCurrentStatus) {
		trainingInstituteCurrentStatus = setTrainingInstituteCurrentStatusObj(trainingInstituteCurrentStatus);
		final TrainingInstituteCurrentStatus currentStatus = trainingInstituteCurrentStatus;
		List<TrainingInstituteCurrentStatusDetails> trainingInstituteDetails = trainingInstituteCurrentStatus.getTrainingInstituteCurrentStatusDetails();
		if(!CollectionUtils.isEmpty(trainingInstituteDetails)) {
			trainingInstituteDetails.forEach(trainingInstituteDetail->{
				if(trainingInstituteDetail != null) {
					List<TrainingInstituteCurrentStatusFundSource> currentStatusFundSourceList = new ArrayList<TrainingInstituteCurrentStatusFundSource>();
					if(trainingInstituteDetail.getTiLocation() == null) {
						trainingInstituteDetail.setTiLocation(userPreference.getStateCode());
					}
					trainingInstituteDetail.setTrainingInstituteCurrentStatus(currentStatus);
					String[] schemes = trainingInstituteDetail.getScheme();
					if(schemes != null) {
						for (String scheme : schemes) {
							TrainingInstituteCurrentStatusFundSource currentStatusFundSource = new TrainingInstituteCurrentStatusFundSource();
							SchemeMaster schemeMaster = new SchemeMaster();
							schemeMaster.setSchemeId(Integer.parseInt(scheme));
							currentStatusFundSource.setScheme(schemeMaster);
							currentStatusFundSource.setTrainingInstituteCurrentStatusDetails(trainingInstituteDetail);
							currentStatusFundSourceList.add(currentStatusFundSource);
						}
					}
					trainingInstituteDetail.setTrainingInstituteFundSource(currentStatusFundSourceList);
				}
			});
		}
		trainingInstituteCurrentStatus.setTrainingInstituteCurrentStatusDetails(trainingInstituteDetails);
		if(trainingInstituteCurrentStatus.getTrainingInstituteCurrentStatusId() == null || trainingInstituteCurrentStatus.getTrainingInstituteCurrentStatusId() == 0) {
			trainingInstituteCurrentStatus.setIsFreeze(Boolean.FALSE);
			commonRepository.save(trainingInstituteCurrentStatus);
		}else {
			Map<String, Object> map = new HashMap<>();
			map.put("detailId", trainingInstituteCurrentStatus.getTrainingInstituteCurrentStatusDetails().get(0).getTrainingInstituteCsDetailsId());
			commonRepository.excuteUpdate("DELETE_FUND_SOURCE", map);
			commonRepository.update(trainingInstituteCurrentStatus);
		}
	}

	private TrainingInstituteCurrentStatus setTrainingInstituteCurrentStatusObj(TrainingInstituteCurrentStatus trainingInstituteCurrentStatus) {
		trainingInstituteCurrentStatus.setCreatedBy(userPreference.getUserId());
		trainingInstituteCurrentStatus.setLastUpdatedBy(userPreference.getUserId());
		trainingInstituteCurrentStatus.setStateCode(userPreference.getStateCode());
		trainingInstituteCurrentStatus.setUserType(userPreference.getUserType().charAt(0));
		trainingInstituteCurrentStatus.setYearId(userPreference.getFinYearId());
		return trainingInstituteCurrentStatus;
	}

	@Override
	public TrainingInstituteCurrentStatus fetchTrainingInstituteDetails(final Integer location,final Integer level) {
		Map<String, Object> params = new HashMap<>();
		params.put("location", location);
		params.put("level", level);
		List<TrainingInstituteCurrentStatus> trainingInstituteCurrentStatus = commonRepository.findAll("TRAINING_INSTITUTE_CURRENTSTATUS_BY_LOCATION_LEVEL", params);
		if(!CollectionUtils.isEmpty(trainingInstituteCurrentStatus)) {
			return trainingInstituteCurrentStatus.get(0);
		}else {
			TrainingInstituteCurrentStatus instituteCurrentStatus = fetchTrainingInstituteBasedOnFinYearAndStateCode();
			if(instituteCurrentStatus == null){
				return new TrainingInstituteCurrentStatus();
			}
			instituteCurrentStatus.setTrainingInstituteCurrentStatusDetails(new ArrayList<>());
			return instituteCurrentStatus;
		}
	}

	@Override
	public TrainingInstituteCurrentStatus fetchTrainingInstituteBasedOnFinYearAndStateCode() {
		Map<String, Object> params = new HashMap<>();
		params.put("stateCode", userPreference.getStateCode());
		params.put("yearId", userPreference.getFinYearId());
		params.put("userType", userPreference.getUserType().charAt(0));
		List<TrainingInstituteCurrentStatus> instituteCurrentStatus = commonRepository.findAll("TRAINING_INSTITUTE_CURRENTSTATUS", params);
		if(!CollectionUtils.isEmpty(instituteCurrentStatus)) {
			TrainingInstituteCurrentStatus currentStatus = instituteCurrentStatus.get(0);
			currentStatus = findLocationName(currentStatus);
			return instituteCurrentStatus.get(0);
		}
		return null;
	}

	private TrainingInstituteCurrentStatus findLocationName(TrainingInstituteCurrentStatus currentStatus) {
		List<TrainingInstituteCurrentStatusDetails> currentStatusDetails = currentStatus.getTrainingInstituteCurrentStatusDetails();
		for (TrainingInstituteCurrentStatusDetails currentStatusDetail : currentStatusDetails) {
			Map<String, Object> params = new HashMap<>();
			params.put("typeId", currentStatusDetail.getTrainingInstitueType().getTrainingInstitueTypeId());
			List<TrainingInstitueType> institueTypes = commonRepository.findAll("FETCH_TRAINING_INSTITUTION_TYPE_BASED_ON_TYPE_ID", params);
			if(!CollectionUtils.isEmpty(institueTypes)){
				TrainingInstitueType institueType = institueTypes.get(0);
					if (institueType.getInstituteLevel().getTrainingInstituteLevelId() == 1) {
						Map<String, Object> stateParams = new HashMap<>();
						stateParams.put("id", currentStatusDetail.getTiLocation());
						List<State> states = commonRepository.findAll("FETCH_STATE_BY_CODE", stateParams);
						if(!CollectionUtils.isEmpty(states)){
							State state = states.get(0);
							currentStatusDetail.setLocationName(state.getStateNameEnglish());
						}
					}else if(institueType.getInstituteLevel().getTrainingInstituteLevelId() == 2){
						Map<String, Object> districtParams = new HashMap<>();
						districtParams.put("dlc", currentStatusDetail.getTiLocation());
						List<District> district = commonRepository.findAll("DISTRICT_BY_ID", districtParams);
						if(!CollectionUtils.isEmpty(district)){
							District district2 = district.get(0);
							currentStatusDetail.setLocationName(district2.getDistrictNameEnglish());
						}
					} else if(institueType.getInstituteLevel().getTrainingInstituteLevelId() == 5){
						Map<String, Object> blockParams = new HashMap<>();
						blockParams.put("blockCode", currentStatusDetail.getTiLocation());
						List<Block> blocks = commonRepository.findAll("BLOCK_LIST_BY_BLOCK_CODE", blockParams);
						if(!CollectionUtils.isEmpty(blocks)){
							Block block2 = blocks.get(0);
							currentStatusDetail.setLocationName(block2.getBlockNameEnglish());
						}
					}
			}
		}
		currentStatus.setTrainingInstituteCurrentStatusDetails(currentStatusDetails);
		return currentStatus;
	}

	@Override
	public void deleteTrainingInfrastructureDetails(Integer infractureDetailsObjToDelete) {
		Map<String, Object> params = new HashMap<>();
		params.put("detailId", infractureDetailsObjToDelete);
		commonRepository.excuteUpdate("DELETE_DETAILS_BY_ID", params);
		commonRepository.excuteUpdate("DELETE_FUND_SOURCE", params);
	}

	@Override
	public List<TrainingInstitueType> getTrainingIsntituteType() {
		return commonRepository.findAll("FETCH_TRAINING_INSTITUTION_TYPE",null);
	}

}
