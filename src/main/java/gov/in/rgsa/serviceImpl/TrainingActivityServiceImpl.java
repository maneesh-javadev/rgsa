package gov.in.rgsa.serviceImpl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;

import org.apache.commons.collections.CollectionUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import gov.in.rgsa.dao.CommonRepository;
import gov.in.rgsa.entity.Subjects;
import gov.in.rgsa.entity.TargetGroupMaster;
import gov.in.rgsa.entity.TrainingActivity;
import gov.in.rgsa.entity.TrainingActivityDetails;
import gov.in.rgsa.entity.TrainingCategories;
import gov.in.rgsa.entity.TrainingMode;
import gov.in.rgsa.entity.TrainingSubjects;
import gov.in.rgsa.entity.TrainingTargetGroups;
import gov.in.rgsa.entity.TrainingVenueLevel;
import gov.in.rgsa.service.FacadeService;
import gov.in.rgsa.service.TrainingActivityService;
import gov.in.rgsa.user.preference.UserPreference;

/**
 * @author Mohammad Ayaz 06/09/2018
 *
 */
@Service
public class TrainingActivityServiceImpl implements TrainingActivityService {

	@PersistenceContext
	private EntityManager entityManager;
	@Autowired
	CommonRepository  commonRepository;
	@Autowired
	private UserPreference userPreference;
	
	@Autowired
	private FacadeService facadeService;
	
	@Override
public void save(TrainingActivity activity) {
		
		List<TrainingActivityDetails> detailsList = activity.getTrainingActivityDetailsList();
		List<TrainingSubjects> subjectsSet = new ArrayList<>();
		List<TrainingTargetGroups> targetGroupsSet = new ArrayList<>();
		
		
		for(TrainingActivityDetails activityDetails : detailsList) {
			
			if(activity.getTrainingActivityDetailsList() != null) {
				Map<String,Object> map = new HashMap<>();
				map.put("trngId",activityDetails.getTrainingActivityDetailsId());
				commonRepository.excuteUpdate("DELETE_TRANGSUBJCT_TRAINING_ID", map);
				
				Map<String,Object> param = new HashMap<>();
				param.put("trngId",activityDetails.getTrainingActivityDetailsId());
				commonRepository.excuteUpdate("DELETE_TARGETGRP_TRAINING_ID", param);
				}
			
			activityDetails.setTrainingActivity(activity);
			activityDetails.setIsActive(true);
			
			String[] tSubjctId = detailsList.get(0).getTrainingSubjectsArray();
			
			for(String subjects : tSubjctId) {
				
				TrainingSubjects trainingSubjects = new TrainingSubjects();
				Subjects subjects2 = new Subjects();
				subjects2.setSubjectId(Integer.parseInt(subjects));
				trainingSubjects.setTrngSubjectId(subjects2);
				subjectsSet.add(trainingSubjects);
				trainingSubjects.setSubjectsTrainingActivityDetails(activityDetails);
			}
			activityDetails.setTrainingSubjectsList(subjectsSet);
			
			String[] tGroupsId = detailsList.get(0).getTrainingTargetGroupsArray();
 			for(String tgtGroups : tGroupsId) {
				
				TrainingTargetGroups targetGroups = new TrainingTargetGroups();
				TargetGroupMaster groupMaster = new TargetGroupMaster();
				groupMaster.setTargetGroupMasterId(Integer.parseInt(tgtGroups));
				targetGroups.setTargetGroupMasterId(groupMaster);
				targetGroupsSet.add(targetGroups);
				targetGroups.setTargetTrainingActivityDetails(activityDetails);
			}
 			
 			
 			activityDetails.setTrainingTargetGroupsList(targetGroupsSet);
		
		}
		activity.setCreatedBy(userPreference.getUserId());
		activity.setUserType(userPreference.getUserType().charAt(0));
		activity.setLastUpdatedBy(userPreference.getUserId());
		activity.setStateCode(userPreference.getStateCode());
		activity.setYearId(userPreference.getFinYearId());
		activity.setVersionId(1);
		activity.setIsFreeze(false);
		commonRepository.update(activity);
		
	}
	
	@Override
	public void saveAndUpdateCEC(TrainingActivity trainingActivity) {
		if(trainingActivity.getUserType().equals('S')){
			trainingActivity.setTrainingActivityId(null);
		}
		List<TrainingActivityDetails> detailsList = trainingActivity.getTrainingActivityDetailsList();
		for (TrainingActivityDetails detail : detailsList) {
			detail.setTrainingActivity(trainingActivity);
			detail.setIsActive(true);
			List<TrainingSubjects> trainingSubj = new ArrayList<>();
			trainingSubj=detail.getTrainingSubjectsList();
			for (TrainingSubjects trainingSubject : trainingSubj) {
				if(trainingActivity.getUserType().equals('S')){
					trainingSubject.setTrainingWiseSubjectId(null);
				}
				trainingSubject.setSubjectsTrainingActivityDetails(detail);
			}
			List<TrainingTargetGroups> trainingTrgGrp = new ArrayList<>();
			trainingTrgGrp=detail.getTrainingTargetGroupsList();
			for (TrainingTargetGroups trainingTargetGroup : trainingTrgGrp) {
				if(trainingActivity.getUserType().equals('S')){
					trainingTargetGroup.setTrainingWiseTargetGroupId(null);
				}
				trainingTargetGroup.setTargetTrainingActivityDetails(detail);
			}
			if(trainingActivity.getUserType().equals('S')){
				detail.setTrainingActivityDetailsId(null);
			}
		}
		trainingActivity.setCreatedBy(userPreference.getUserId());
		trainingActivity.setUserType(userPreference.getUserType().charAt(0));
		trainingActivity.setLastUpdatedBy(userPreference.getUserId());
		trainingActivity.setStateCode(userPreference.getStateCode());
		trainingActivity.setYearId(userPreference.getFinYearId());
		trainingActivity.setVersionId(1);
		trainingActivity.setIsFreeze(false);
		commonRepository.update(trainingActivity);	
			
		
	}

	@Override
	public void update(TrainingActivity trainingActivity) {
		Map<String,Object> params = new HashMap<>();
		params.put("additionalRequirement", trainingActivity.getAdditionalRequirement());
		params.put("trainingActivityId", trainingActivity.getTrainingActivityId());
		commonRepository.excuteUpdate("UPDATE_ADDTNL_REQRMNT", params);

	}

	@Override
	public List<TrainingActivity> findAllTrainingActivity(final Character userType) {
		Map<String,Object> params = new HashMap<>();
		params.put("yearId", userPreference.getFinYearId());
		params.put("stateCode", userPreference.getStateCode());
		if(userType == null){
			params.put("userType", userPreference.getUserType().charAt(0));
		}else{
			params.put("userType", userType);
		}
		List<TrainingActivity> dbList = commonRepository.findAll("FIND_ALL_TRAINING_ACTIVITY_WITH_DETAILS", params);
		
		if(CollectionUtils.isEmpty(dbList) && userPreference.getUserType().equalsIgnoreCase("M")){
			params.put("userType", 'S');
			dbList = commonRepository.findAll("FIND_ALL_TRAINING_ACTIVITY_WITH_DETAILS", params);
		}
		else if((CollectionUtils.isEmpty(dbList) && userPreference.getUserType().charAt(0) == 'C') && userType == null){
			params.put("userType", 'S');
			dbList = commonRepository.findAll("FIND_ALL_TRAINING_ACTIVITY_WITH_DETAILS", params);
			
		}
		return dbList;
	}


	@Override
	public void delete(int id) {
		Map<String,Object> params = new HashMap<>();
		params.put("trainingActivityDetailsId", id);
		commonRepository.excuteUpdate("UPDATE_DELETE_STATUS", params);
	}

	@Override
	public void freezeUnfreeze(TrainingActivity trainingActivity) {
		Map<String,Object> params = new HashMap<>();
		if(trainingActivity.getIsFreeze() == true) {
		params.put("isFreeze", false);}
		else if(trainingActivity.getIsFreeze() == false) {
			params.put("isFreeze", true);
		}
		params.put("trainingActivityId", trainingActivity.getTrainingActivityId());
		commonRepository.excuteUpdate("UPDATE_FRZUNFRZ_STATUS", params);
		if(trainingActivity.getIsFreeze() == false) {
			facadeService.populateStateFunds("1");
		}

	}

	@Override
	public List<TargetGroupMaster> targetGroupMastersList() {
		Map<String,Object> params = new HashMap<>();
		params.put("finYear", userPreference.getFinYearId());
		return commonRepository.findAll("FETCH_TARGET_GROUP_LIST", params);
	}

	@Override
	public List<Subjects> subjectsList() {
		Map<String,Object> params = new HashMap<>();
		params.put("finYearId", userPreference.getFinYearId());
		return commonRepository.findAll("FIND_SUBJECT_BY_FIN_YEAR_ID", params);
	}

	@Override
	public List<TrainingCategories> trainingCategoriesList() {
		Map<String,Object> params = new HashMap<>();
		params.put("finYear", userPreference.getFinYearId());
		return commonRepository.findAll("FETCH_ALL_TRAINING_CATEGORIES", params);
	}

	@Override
	public List<TrainingVenueLevel> trainingVenueLevelsList() {
		Query query = entityManager.createNamedQuery("FETCH_ALL_VENUE_LEVEL");
		List<TrainingVenueLevel> list = query.getResultList();
		return list;
	}

	@Override
	public List<TrainingActivityDetails> findActivityById(int id) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<TrainingActivity> findTrainingActivity() {
		Map<String,Object> params = new HashMap<>();
		params.put("yearId", userPreference.getFinYearId());
		params.put("stateCode" ,userPreference.getStateCode());
		params.put("userType", userPreference.getUserType().charAt(0));
		List<TrainingActivity> dbList = commonRepository.findAll("FIND_ALL_TRAINING_ACTIVITY", params);
	return dbList;
	}

	@Override
	public List<TrainingActivity> getApprovedTrainingActivity() {
		Map<String,Object> params = new HashMap<>();
		params.put("yearId", userPreference.getFinYearId());
		params.put("stateCode", userPreference.getStateCode());
		params.put("userType", userPreference.getUserType().charAt(0));
		List<TrainingActivity> dbList = commonRepository.findAll("GET_APPROVED_TRAINING", params);
		return dbList;
	}

	@Override
	public void saveAndUpdateMopr(TrainingActivity activity) {
		
		List<TrainingActivityDetails> detailsList = activity.getTrainingActivityDetailsList();
		
		if(activity.getTrainingActivityId() == null) {
			
		List<TrainingSubjects> subjectsSet = new ArrayList<>();
		List<TrainingTargetGroups> targetGroupsSet = new ArrayList<>();
		
		int i=0;
		for(TrainingActivityDetails activityDetails : detailsList) {
			activityDetails.setTrainingActivityDetailsId(null);
			String[] tSubjctId = detailsList.get(i).getTrainingSubjectsArray();
			
			for(String subjects : tSubjctId) {
				
				TrainingSubjects trainingSubjects = new TrainingSubjects();
				Subjects subjects2 = new Subjects();
				subjects2.setSubjectId(Integer.parseInt(subjects));
				trainingSubjects.setTrngSubjectId(subjects2);
				subjectsSet.add(trainingSubjects);
				trainingSubjects.setSubjectsTrainingActivityDetails(activityDetails);
			}
			activityDetails.setTrainingSubjectsList(subjectsSet);
			
			String[] tGroupsId = detailsList.get(i).getTrainingTargetGroupsArray();
 			for(String tgtGroups : tGroupsId) {
				
				TrainingTargetGroups targetGroups = new TrainingTargetGroups();
				TargetGroupMaster groupMaster = new TargetGroupMaster();
				groupMaster.setTargetGroupMasterId(Integer.parseInt(tgtGroups));
				targetGroups.setTargetGroupMasterId(groupMaster);
				targetGroupsSet.add(targetGroups);
				targetGroups.setTargetTrainingActivityDetails(activityDetails);
			}
 			
 			
 			activityDetails.setTrainingTargetGroupsList(targetGroupsSet);
 			activityDetails.setTrainingActivity(activity);
			activityDetails.setIsActive(true);
 			i++;
		}
		activity.setCreatedBy(userPreference.getUserId());
		activity.setUserType(userPreference.getUserType().charAt(0));
		activity.setLastUpdatedBy(userPreference.getUserId());
		activity.setStateCode(userPreference.getStateCode());
		activity.setYearId(userPreference.getFinYearId());
		activity.setVersionId(1);
		activity.setIsFreeze(false);
		commonRepository.save(activity);
		}
		else
		{
			for(TrainingActivityDetails activityDetails : detailsList) {
				
				activityDetails.setTrainingActivity(activity);
				activityDetails.setIsActive(true);
			}
			activity.setCreatedBy(userPreference.getUserId());
			activity.setUserType(userPreference.getUserType().charAt(0));
			activity.setLastUpdatedBy(userPreference.getUserId());
			activity.setStateCode(userPreference.getStateCode());
			activity.setYearId(userPreference.getFinYearId());
			activity.setVersionId(1);
			activity.setIsFreeze(false);
			commonRepository.update(activity);
		}
	}

	@Override
	public List<TrainingMode> fetchModeOfTraining() {
		Query query = entityManager.createNamedQuery("FETCH_TRAINING_MODES");
		List<TrainingMode> list = query.getResultList();
		return list;
	}
	
	

}
	
