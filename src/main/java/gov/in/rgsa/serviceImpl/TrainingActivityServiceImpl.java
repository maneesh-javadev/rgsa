package gov.in.rgsa.serviceImpl;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Scanner;

import javax.persistence.Column;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;

import org.apache.commons.collections.CollectionUtils;
import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;



import gov.in.rgsa.dao.CommonRepository;
import gov.in.rgsa.entity.FetchTraining;
import gov.in.rgsa.entity.FetchTrainingDetails;
import gov.in.rgsa.entity.FileNode;
import gov.in.rgsa.entity.Plan;
import gov.in.rgsa.entity.QprHandholdingGpdp;
import gov.in.rgsa.entity.QprPanchayatLearningCenter;
import gov.in.rgsa.entity.QprTnaTrgEvaluation;
import gov.in.rgsa.entity.Subjects;
import gov.in.rgsa.entity.TargetGroupMaster;
import gov.in.rgsa.entity.TrainingActivity;
import gov.in.rgsa.entity.TrainingActivityDetails;
import gov.in.rgsa.entity.TrainingCategories;
import gov.in.rgsa.entity.TrainingMode;
import gov.in.rgsa.entity.TrainingSubjects;
import gov.in.rgsa.entity.TrainingTargetGroups;
import gov.in.rgsa.entity.TrainingVenueLevel;
import gov.in.rgsa.entity.TrainingWiseCategory;
import gov.in.rgsa.model.Response;
import gov.in.rgsa.service.BasicInfoService;
import gov.in.rgsa.service.FacadeService;
import gov.in.rgsa.service.PlanAllocationService;
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
	
	@Autowired
	private BasicInfoService basicInfoService;
	
	@Autowired
	private PlanAllocationService planAllocationService;
	
	
	
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
		activity.setVersionId(userPreference.getPlanVersion());
		activity.setIsFreeze(false);
		activity.setIsActive(true);
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
		trainingActivity.setVersionId(userPreference.getPlanVersion());
		trainingActivity.setIsFreeze(false);
		trainingActivity.setIsActive(true);
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
		if(userPreference.getUserType().charAt(0) == 'C') {
			this.saveAndUpdateCEC(trainingActivity);
		}
		
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
		activity.setVersionId(userPreference.getPlanVersion());
		activity.setIsFreeze(false);
		activity.setIsActive(true);
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
			activity.setVersionId(userPreference.getPlanVersion());
			activity.setIsFreeze(false);
			activity.setIsActive(true);
			commonRepository.update(activity);
		}
	}

	@Override
	public List<TrainingMode> fetchModeOfTraining() {
		Query query = entityManager.createNamedQuery("FETCH_TRAINING_MODES");
		List<TrainingMode> list = query.getResultList();
		return list;
	}
	
	@Override
	public Map<String,Object> fetchTrainingDetails(final Character userType) {
		List<FetchTrainingDetails> fetchTrainingDetailsList=new ArrayList<FetchTrainingDetails>();
		Map<String,Object> data = new HashMap<>();
		FetchTraining fetchTraining=new FetchTraining();
		
		Map<String,Object> params = new HashMap<>();
		params.put("yearId", userPreference.getFinYearId());
		params.put("stateCode", userPreference.getStateCode());
		params.put("versionId", userPreference.getPlanVersion());
		if(userType == null){
			params.put("userType", userPreference.getUserType().charAt(0));
		}else{
			params.put("userType", userType);
		}
		List<FetchTraining> fetchTrainingList = commonRepository.findAll("Fetch_Training", params);
		
		if(fetchTrainingList!=null && !fetchTrainingList.isEmpty()) {
			fetchTraining=fetchTrainingList.get(0);
			Integer trainingActivityId=fetchTraining.getTrainingActivityId();
			params = new HashMap<>();
			params.put("trainingActivityId", trainingActivityId);
			params.put("isactive", Boolean.TRUE);
			fetchTrainingDetailsList = commonRepository.findAll("Fetch_Training_Details", params);
			Map<String, List<List<String>>> map = basicInfoService.fetchStateAndMoprPreComments(fetchTrainingDetailsList.size(),1);
			data.put("STATE_PRE_COMMENTS", map.get("statePreviousComments"));
			data.put("MOPR_PRE_COMMENTS", map.get("moprPreviousComments"));
		}
		
		
		Integer planStatus=0;
		List<Plan> planList = planAllocationService.showHidePlanStatus(userPreference.getStateCode());
		if(planList!=null && !planList.isEmpty())
		{
			planStatus=planList.get(0).getPlanStatusId();
		}
		data.put("fetchTraining", fetchTraining);
		data.put("fetchTrainingDetailsList", fetchTrainingDetailsList);
		data.put("targetGrpMstrList",this.targetGroupMastersList());
		data.put("trainingCatgryList",this.trainingCategoriesList());
		data.put("trngVenueList",this.trainingVenueLevelsList());
		data.put("subjectsList",this.subjectsList());
		data.put("modeOfTraining",this.fetchModeOfTraining());
		data.put("planStateStatus",planStatus==1);
		return data;
	}
	
	public Map<String,Object> fetchTrainingDetailsbyId(Integer trngId){
		Map<String,Object> params = new HashMap<>();
		params.put("trngId", trngId);
		List<TrainingTargetGroups> trainingTargetGroupsList = commonRepository.findAll("FETCH_TARGETGRP_TRAINING_ID", params);
		List<String> targetGroupMasterIds=new ArrayList<String>();
		for(TrainingTargetGroups trainingTargetGroups:trainingTargetGroupsList) {
			targetGroupMasterIds.add(trainingTargetGroups.getTargetGroupMasterId().getTargetGroupMasterId().toString());
		}
		
		List<TrainingSubjects> trainingSubjectsList = commonRepository.findAll("FETCH_TRANGSUBJCT_TRAINING_ID", params);
		List<String> trainingSubjectsIds=new ArrayList<String>();
		for(TrainingSubjects trainingSubjects:trainingSubjectsList) {
			trainingSubjectsIds.add(trainingSubjects.getTrngSubjectId().getSubjectId().toString());
		}
		
		List<TrainingWiseCategory> trainingwiseCatgryList = this.fetchTrainingWiseCategoryList(trngId);
		List<String> trainingCategoryIds=new ArrayList<String>();
		for(TrainingWiseCategory trainingWiseCategory:trainingwiseCatgryList) {
			trainingCategoryIds.add(trainingWiseCategory.getTrainingCategories().getTrainingCategoryId().toString());
		}
		
		
		Map<String,Object> data = new HashMap<>();
		data.put("targetGroupMasterIds",targetGroupMasterIds);
		data.put("trainingSubjectsIds",trainingSubjectsIds);
		data.put("trainingCategoryIds",trainingCategoryIds);
		return data;
	}
	
	@Override
	public Response saveorUpdateTrainingActivityDetails(FetchTrainingDetails fetchTrainingDetails) {
		Response response1=new Response();
		try {
			
			if(fetchTrainingDetails.getTrainingActivityId()==null) {
				TrainingActivity activity=new TrainingActivity();
				
				activity.setCreatedBy(userPreference.getUserId());
				activity.setUserType(userPreference.getUserType().charAt(0));
				activity.setLastUpdatedBy(userPreference.getUserId());
				activity.setStateCode(userPreference.getStateCode());
				activity.setYearId(userPreference.getFinYearId());
				activity.setVersionId(userPreference.getPlanVersion());
				activity.setIsFreeze(false);
				activity.setIsActive(true);
				
				
				TrainingActivityDetails trainingActivityDetails=new TrainingActivityDetails();
				trainingActivityDetails.setRemarks(fetchTrainingDetails.getRemarks());
				trainingActivityDetails.setNoOfDays(fetchTrainingDetails.getNoOfDays());
				trainingActivityDetails.setNoOfParticipants(fetchTrainingDetails.getNoOfParticipants());
				trainingActivityDetails.setUnitCost(fetchTrainingDetails.getUnitCost());
				trainingActivityDetails.setFunds(fetchTrainingDetails.getFunds());
				trainingActivityDetails.setTrainingActivity(activity);
				trainingActivityDetails.setIsActive(Boolean.TRUE);
				 Scanner scanner =null;
					List<TrainingTargetGroups> selectTrainingTargetGroups=new ArrayList<TrainingTargetGroups>();
					scanner = new Scanner(fetchTrainingDetails.getTargetGrptArr());
					 scanner.useDelimiter(",");
					 TrainingTargetGroups trainingTargetGroups=new TrainingTargetGroups();
					 Map<String,Object> params1 = new HashMap<>();
					while (scanner.hasNext()) {
							params1.put("targetGroupMasterId", Integer.parseInt(scanner.next()));
							TargetGroupMaster targetGroupMaster = commonRepository.find("FETCH_TARGET_GROUP_LIST_BY_ID", params1);
							trainingTargetGroups=new TrainingTargetGroups();
							trainingTargetGroups.setTargetTrainingActivityDetails(trainingActivityDetails);
							trainingTargetGroups.setTargetGroupMasterId(targetGroupMaster);
							selectTrainingTargetGroups.add(trainingTargetGroups);
					}
				trainingActivityDetails.setTrainingTargetGroupsList(selectTrainingTargetGroups);
				params1 = new HashMap<>();
				params1.put("trainingVenueLevelId",fetchTrainingDetails.getTrainingVenueLevelId() );
				TrainingVenueLevel trainingVenueLevel=commonRepository.find("FETCH_ALL_VENUE_LEVEL_by_Id",params1);
				trainingActivityDetails.setTrainingVenueLevelId(trainingVenueLevel);
				
				params1 = new HashMap<>();
				params1.put("trainingModeId",fetchTrainingDetails.getTrainingVenueLevelId() );
				TrainingMode trainingMode=commonRepository.find("FETCH_TRAINING_MODES_by_Id",params1);
				trainingActivityDetails.setTrainingMode(trainingMode);
				
				
				List<TrainingSubjects> selectSubList=new ArrayList<TrainingSubjects>();
				scanner = new Scanner(fetchTrainingDetails.getTrainingSubjectArr());
				 scanner.useDelimiter(",");
				 TrainingSubjects trainingSubjects=null;
				while (scanner.hasNext()) {
						params1 = new HashMap<>();
						params1.put("subjectId", Integer.parseInt(scanner.next()));
						Subjects subjects = commonRepository.find("FIND_SUBJECT_ID", params1);
						trainingSubjects=new TrainingSubjects();
						trainingSubjects.setSubjectsTrainingActivityDetails(trainingActivityDetails);
						trainingSubjects.setTrngSubjectId(subjects);
						selectSubList.add(trainingSubjects);
				}
				trainingActivityDetails.setTrainingSubjectsList(selectSubList);
				
				List<TrainingWiseCategory> trainingWiseCategoryList=new ArrayList<TrainingWiseCategory>();
				scanner = new Scanner(fetchTrainingDetails.getTrgCategoryArr());
				 scanner.useDelimiter(",");
				 TrainingWiseCategory trainingWiseCategory=null;
				while (scanner.hasNext()) {
						params1 = new HashMap<>();
						params1.put("trainingCategoryId", Integer.parseInt(scanner.next()));
						TrainingCategories trainingCategories = commonRepository.find("Fetch_Training_Categories_BY_Id", params1);
						trainingWiseCategory=new TrainingWiseCategory();
						trainingWiseCategory.setTargetTrainingActivityDetails(trainingActivityDetails);
						trainingWiseCategory.setTrainingCategories(trainingCategories);
						trainingWiseCategoryList.add(trainingWiseCategory);
				}				
				trainingActivityDetails.setTrainingWiseCategoryList(trainingWiseCategoryList);
				
				
				/*params1 = new HashMap<>();
				params1.put("trainingCategoryId", fetchTrainingDetails.getTrainingCategoryId());
				TrainingCategories trainingCategories = commonRepository.find("Fetch_Training_Categories_BY_Id", params1);
				trainingActivityDetails.setTrainingCategoryId(trainingCategories);*/
				
				List<TrainingActivityDetails> trainingActivityDetailsList=new ArrayList<TrainingActivityDetails>();
				trainingActivityDetailsList.add(trainingActivityDetails);
				activity.setTrainingActivityDetailsList(trainingActivityDetailsList);
				
				commonRepository.save(activity);
				response1.setResponseMessage("Training Details save sucessfully");
				response1.setResponseCode(200);
				
			}else {
				
			
				TrainingActivityDetails trainingActivityDetails=null;
				if(fetchTrainingDetails.getTrainingId()==null) {
					
					Map<String,Object> param = new HashMap<>();
					param.put("trainingActivityId", fetchTrainingDetails.getTrainingActivityId());
					TrainingActivity trainingActivity = commonRepository.find("FIND_ALL_TRAINING_ACTIVITY_BY_ID", param);
					
					
					trainingActivityDetails=new TrainingActivityDetails();
					trainingActivityDetails.setRemarks(fetchTrainingDetails.getRemarks());
					trainingActivityDetails.setNoOfDays(fetchTrainingDetails.getNoOfDays());
					trainingActivityDetails.setNoOfParticipants(fetchTrainingDetails.getNoOfParticipants());
					trainingActivityDetails.setUnitCost(fetchTrainingDetails.getUnitCost());
					trainingActivityDetails.setFunds(fetchTrainingDetails.getFunds());
					trainingActivityDetails.setTrainingActivity(trainingActivity);
					trainingActivityDetails.setIsActive(Boolean.TRUE);
					
					
					/*param = new HashMap<>();
					param.put("trainingCategoryId", fetchTrainingDetails.getTrainingCategoryId());
					TrainingCategories trainingCategories = commonRepository.find("Fetch_Training_Categories_BY_Id", param);
					trainingActivityDetails.setTrainingCategoryId(trainingCategories);*/
					
					
				}else {
					
					Map<String,Object> map = new HashMap<>();
					map.put("trngId",fetchTrainingDetails.getTrainingId());
					commonRepository.excuteUpdate("DELETE_TRANGSUBJCT_TRAINING_ID", map);
					
					Map<String,Object> param = new HashMap<>();
					param.put("trngId",fetchTrainingDetails.getTrainingId());
					commonRepository.excuteUpdate("DELETE_TARGETGRP_TRAINING_ID", param);
					
					Map<String,Object> param1 = new HashMap<>();
					param.put("trngId",fetchTrainingDetails.getTrainingId());
					commonRepository.excuteUpdate("DELETE_TRANGCATEGORY_TRAINING_ID", param);	
					
					
					Map<String,Object> params = new HashMap<>();
					params.put("trainingActivityDetailsId", fetchTrainingDetails.getTrainingId());
					trainingActivityDetails = commonRepository.find("FIND_TrainingActivityDetails_BY_ID", params);
					
					trainingActivityDetails.setRemarks(fetchTrainingDetails.getRemarks());
					trainingActivityDetails.setNoOfDays(fetchTrainingDetails.getNoOfDays());
					trainingActivityDetails.setNoOfParticipants(fetchTrainingDetails.getNoOfParticipants());
					trainingActivityDetails.setUnitCost(fetchTrainingDetails.getUnitCost());
					trainingActivityDetails.setFunds(fetchTrainingDetails.getFunds());
					
					
				}
			
			
				 Scanner scanner =null;
				List<TrainingTargetGroups> selectTrainingTargetGroups=new ArrayList<TrainingTargetGroups>();
				scanner = new Scanner(fetchTrainingDetails.getTargetGrptArr());
				 scanner.useDelimiter(",");
				 TrainingTargetGroups trainingTargetGroups=new TrainingTargetGroups();
				 Map<String,Object> params1 = new HashMap<>();
				while (scanner.hasNext()) {
						params1.put("targetGroupMasterId", Integer.parseInt(scanner.next()));
						TargetGroupMaster targetGroupMaster = commonRepository.find("FETCH_TARGET_GROUP_LIST_BY_ID", params1);
						trainingTargetGroups=new TrainingTargetGroups();
						trainingTargetGroups.setTargetTrainingActivityDetails(trainingActivityDetails);
						trainingTargetGroups.setTargetGroupMasterId(targetGroupMaster);
						selectTrainingTargetGroups.add(trainingTargetGroups);
				}
			trainingActivityDetails.setTrainingTargetGroupsList(selectTrainingTargetGroups);
			
			params1 = new HashMap<>();
			params1.put("trainingVenueLevelId",fetchTrainingDetails.getTrainingVenueLevelId() );
			TrainingVenueLevel trainingVenueLevel=commonRepository.find("FETCH_ALL_VENUE_LEVEL_by_Id",params1);
			trainingActivityDetails.setTrainingVenueLevelId(trainingVenueLevel);
			
			params1 = new HashMap<>();
			params1.put("trainingModeId",fetchTrainingDetails.getTrainingMode());
			TrainingMode trainingMode=commonRepository.find("FETCH_TRAINING_MODES_by_Id",params1);
			trainingActivityDetails.setTrainingMode(trainingMode);
			
			
			
			
			List<TrainingSubjects> selectSubList=new ArrayList<TrainingSubjects>();
			scanner = new Scanner(fetchTrainingDetails.getTrainingSubjectArr());
			 scanner.useDelimiter(",");
			 TrainingSubjects trainingSubjects=null;
			while (scanner.hasNext()) {
					params1 = new HashMap<>();
					params1.put("subjectId", Integer.parseInt(scanner.next()));
					Subjects subjects = commonRepository.find("FIND_SUBJECT_ID", params1);
					trainingSubjects=new TrainingSubjects();
					trainingSubjects.setSubjectsTrainingActivityDetails(trainingActivityDetails);
					trainingSubjects.setTrngSubjectId(subjects);
					selectSubList.add(trainingSubjects);
			}
			
			List<TrainingWiseCategory> trainingWiseCategoryList=new ArrayList<TrainingWiseCategory>();
			scanner = new Scanner(fetchTrainingDetails.getTrgCategoryArr());
			 scanner.useDelimiter(",");
			 TrainingWiseCategory trainingWiseCategory=null;
			while (scanner.hasNext()) {
					params1 = new HashMap<>();
					params1.put("trainingCategoryId", Integer.parseInt(scanner.next()));
					TrainingCategories trainingCategories = commonRepository.find("Fetch_Training_Categories_BY_Id", params1);
					trainingWiseCategory=new TrainingWiseCategory();
					trainingWiseCategory.setTargetTrainingActivityDetails(trainingActivityDetails);
					trainingWiseCategory.setTrainingCategories(trainingCategories);
					trainingWiseCategoryList.add(trainingWiseCategory);
			}				
			trainingActivityDetails.setTrainingWiseCategoryList(trainingWiseCategoryList);
			
			trainingActivityDetails.setTrainingSubjectsList(selectSubList);
			trainingActivityDetails.setUnitCost(fetchTrainingDetails.getUnitCost());
			trainingActivityDetails.setRemarks(fetchTrainingDetails.getRemarks());
			trainingActivityDetails.setNoOfDays(fetchTrainingDetails.getNoOfDays());
			trainingActivityDetails.setNoOfParticipants(fetchTrainingDetails.getNoOfParticipants());
			trainingActivityDetails.setFunds(fetchTrainingDetails.getFunds());
			if(fetchTrainingDetails.getTrainingId()==null) {
				commonRepository.save(trainingActivityDetails);
				response1.setResponseMessage("Training Details save sucessfully");
			}else {
				commonRepository.update(trainingActivityDetails);
				response1.setResponseMessage("Training Details update sucessfully");
			}
			
			
			
			response1.setResponseCode(200);
			
			}
			
			
			
			

		
		}catch(Exception e) {
			response1.setResponseMessage(e.getMessage());
			response1.setResponseCode(500);
		}
		return response1;
	}
	
	@Override
	public List<Subjects> fetchSubjectsList(String strTrainingCategoryIds) {
		
		List<Integer> trainingCategoryIds=new ArrayList<Integer>();
		trainingCategoryIds.add(-1);
		Scanner scanner = new Scanner(strTrainingCategoryIds);
		 scanner.useDelimiter(",");
		while (scanner.hasNext()) {
		trainingCategoryIds.add(Integer.parseInt(scanner.next()));
		}
		
		Map<String,Object> params = new HashMap<>();
		params.put("trainingCategoryIds", trainingCategoryIds);
		return commonRepository.findAll("FETCH_SUBJECT_LIST_by_CATEGORIES",params );
	}
	
	@Override
	public Response updateTrainingActivity(FetchTraining fetchTraining) {
		Response response1=new Response();
		try {
			
			Map<String,Object> param = new HashMap<>();
			param.put("additionalRequirement",fetchTraining.getAdditionalRequirement());
			param.put("isFreeze",fetchTraining.getIsFreeze());
			param.put("trainingActivityId",fetchTraining.getTrainingActivityId());
			
			commonRepository.excuteUpdate("UPDATE_Training_Activity", param);	
			
			String delIds= fetchTraining.getDelIds();
			if(delIds!=null && delIds.length()>0) {
				Scanner scanner = new Scanner(delIds);
				 scanner.useDelimiter(",");
				List<Integer> delIdArr=new ArrayList<Integer>();
				while (scanner.hasNext()) {
					delIdArr.add(Integer.parseInt(scanner.next()));	
				}
				
				this.deleteMultiple(delIdArr);
			}
			
			if(fetchTraining.getIsFreeze()) {
				facadeService.populateStateFunds("1");
			}
			
			
			
			response1.setResponseMessage("Training Details update");
			response1.setResponseCode(200);
			
		}catch(Exception e) {
			response1.setResponseMessage(e.getMessage());
			response1.setResponseCode(500);
		}
		return response1;
	}
	
	@Override
	public void deleteMultiple(List<Integer> deleteIds) {
		Map<String,Object> params = new HashMap<>();
		params.put("trainingActivityDetailsId", deleteIds);
		commonRepository.excuteUpdate("UPDATE_DELETE_STATUS_BY_MULTIPLE_ID", params);
	}
	
	@Override
	public Map<String,Object> fetchTrainingDetailsMOPRCEC() {
		List<FetchTrainingDetails> fetchTrainingDetailsList=new ArrayList<FetchTrainingDetails>();
		FetchTraining fetchTraining=new FetchTraining();
		
		Map<String,Object> params = new HashMap<>();
		params.put("yearId", userPreference.getFinYearId());
		params.put("stateCode", userPreference.getStateCode());
		params.put("versionId", userPreference.getPlanVersion());
		params.put("userType", 'S');
		List<FetchTraining> fetchTrainingList = commonRepository.findAll("Fetch_Training", params);
		
		if(fetchTrainingList!=null && !fetchTrainingList.isEmpty()) {
			fetchTraining=fetchTrainingList.get(0);
			Integer trainingActivityId=fetchTraining.getTrainingActivityId();
			params = new HashMap<>();
			params.put("trainingActivityId", trainingActivityId);
			params.put("isactive", Boolean.TRUE);
			fetchTrainingDetailsList = commonRepository.findAll("Fetch_Training_Details", params);
		}
		
		Map<String,Object> data = new HashMap<>();
		data.put("fetchTrainingState", fetchTraining);
		Map<String, List<List<String>>> map = basicInfoService.fetchStateAndMoprPreComments(fetchTrainingDetailsList.size(),1);
		data.put("STATE_PRE_COMMENTS", map.get("statePreviousComments"));
		data.put("MOPR_PRE_COMMENTS", map.get("moprPreviousComments"));
		data.put("fetchTrainingDetailsListState", fetchTrainingDetailsList);
		
		fetchTraining=new FetchTraining();
		fetchTrainingDetailsList=new ArrayList<FetchTrainingDetails>();
		
		params = new HashMap<>();
		params.put("yearId", userPreference.getFinYearId());
		params.put("stateCode", userPreference.getStateCode());
		params.put("versionId", userPreference.getPlanVersion());
		params.put("userType", 'M');
		fetchTrainingList = commonRepository.findAll("Fetch_Training", params);
		
		if(fetchTrainingList!=null && !fetchTrainingList.isEmpty()) {
			fetchTraining=fetchTrainingList.get(0);
			Integer trainingActivityId=fetchTraining.getTrainingActivityId();
			params = new HashMap<>();
			params.put("trainingActivityId", trainingActivityId);
			params.put("isactive", Boolean.TRUE);
			fetchTrainingDetailsList = commonRepository.findAll("Fetch_Training_Details", params);
		}
		
		data.put("fetchTrainingMOPR", fetchTraining);
		data.put("fetchTrainingDetailsListMOPR", fetchTrainingDetailsList);
		
		if(userPreference.getUserType().charAt(0)=='C') {
			fetchTraining=new FetchTraining();
			fetchTrainingDetailsList=new ArrayList<FetchTrainingDetails>();
			params = new HashMap<>();
			params.put("yearId", userPreference.getFinYearId());
			params.put("stateCode", userPreference.getStateCode());
			params.put("versionId", userPreference.getPlanVersion());
			params.put("userType", 'C');
			fetchTrainingList = commonRepository.findAll("Fetch_Training", params);
			
			if(fetchTrainingList!=null && !fetchTrainingList.isEmpty()) {
				fetchTraining=fetchTrainingList.get(0);
				Integer trainingActivityId=fetchTraining.getTrainingActivityId();
				params = new HashMap<>();
				params.put("trainingActivityId", trainingActivityId);
				params.put("isactive", Boolean.TRUE);
				fetchTrainingDetailsList = commonRepository.findAll("Fetch_Training_Details", params);
			}
			
			data.put("fetchTrainingCEC", fetchTraining);
			data.put("fetchTrainingDetailsListCEC", fetchTrainingDetailsList);
		}
		
		return data;
	}
	
	
	@Override
	public Response saveorUpdateTrainingActivityDetailsCECMOPR(FetchTraining fetchTraining) {
		Response response1=new Response();
		try {
			
			if(fetchTraining.getTrainingActivityId()==null) {
				
				TrainingActivity activity=new TrainingActivity();
				
				activity.setCreatedBy(userPreference.getUserId());
				activity.setUserType(userPreference.getUserType().charAt(0));
				activity.setLastUpdatedBy(userPreference.getUserId());
				activity.setStateCode(userPreference.getStateCode());
				activity.setYearId(userPreference.getFinYearId());
				activity.setVersionId(userPreference.getPlanVersion());
				activity.setIsFreeze(Boolean.FALSE);
				activity.setIsActive(Boolean.TRUE);
				activity.setAdditionalRequirement(fetchTraining.getAdditionalRequirement());
				List<TrainingActivityDetails> trainingActivityDetailsList=new ArrayList<TrainingActivityDetails>();
				TrainingActivityDetails trainingActivityDetails=null;
				Map<String,Object> params =null;
				
				
				Map<Integer,Object> trainingActivityDetailsPreLvlList =new HashMap<Integer, Object>();
				
				Map<String,Object> param = new HashMap<>();
				param.put("trainingActivityId", fetchTraining.getPreTrainingActivityId());
				TrainingActivity preActivity = commonRepository.find("FIND_ALL_TRAINING_ACTIVITY_BY_ID", param);
				for(TrainingActivityDetails obj:preActivity.getTrainingActivityDetailsList()) {
					trainingActivityDetailsPreLvlList.put(obj.getTrainingActivityDetailsId(), obj);
				}
				
				TrainingActivityDetails trainingActivityDetailsPreLvl;
				
				
				for(FetchTrainingDetails fetchTrainingDetails:fetchTraining.getTrainingDetailList() ) {
					trainingActivityDetails=new TrainingActivityDetails();
					trainingActivityDetailsPreLvl=null;
					trainingActivityDetails.setRemarks(fetchTrainingDetails.getRemarks());
					trainingActivityDetails.setNoOfDays(fetchTrainingDetails.getNoOfDays());
					trainingActivityDetails.setNoOfParticipants(fetchTrainingDetails.getNoOfParticipants());
					trainingActivityDetails.setUnitCost(fetchTrainingDetails.getUnitCost());
					trainingActivityDetails.setFunds(fetchTrainingDetails.getFunds());
					trainingActivityDetails.setTrainingActivity(activity);
					trainingActivityDetails.setIsActive(Boolean.TRUE);
					trainingActivityDetails.setIsApproved(fetchTrainingDetails.getIsApproved()!=null?fetchTrainingDetails.getIsApproved():Boolean.FALSE);
					
					
					params= new HashMap<>();
					params.put("trainingActivityDetailsId", fetchTrainingDetails.getPreLevelTrainActivityId());
					trainingActivityDetailsPreLvl =(TrainingActivityDetails)trainingActivityDetailsPreLvlList.get( fetchTrainingDetails.getPreLevelTrainActivityId());
					
					
					
						//trainingActivityDetails.setTrainingCategoryId(trainingActivityDetailsPreLvl.getTrainingCategoryId());	
						trainingActivityDetails.setTrainingVenueLevelId(trainingActivityDetailsPreLvl.getTrainingVenueLevelId());
						trainingActivityDetails.setTrainingMode(trainingActivityDetailsPreLvl.getTrainingMode());
						
					
						
						 TrainingTargetGroups trainingTargetGroups=new TrainingTargetGroups();
						 Map<String,Object> params1 = new HashMap<>();
						
						List<TrainingTargetGroups> newTrainingTargetGroups=new ArrayList<TrainingTargetGroups>();
						for(TrainingTargetGroups preTrainingTargetGroups: trainingActivityDetailsPreLvl.getTrainingTargetGroupsList())
						{
							params1.put("targetGroupMasterId", preTrainingTargetGroups.getTargetGroupMasterId().getTargetGroupMasterId());
							TargetGroupMaster targetGroupMaster = commonRepository.find("FETCH_TARGET_GROUP_LIST_BY_ID", params1);
							
							trainingTargetGroups=new TrainingTargetGroups();
							trainingTargetGroups.setTargetTrainingActivityDetails(trainingActivityDetails);
							trainingTargetGroups.setTargetGroupMasterId(targetGroupMaster);
							newTrainingTargetGroups.add(trainingTargetGroups);
						}
						trainingActivityDetails.setTrainingTargetGroupsList(newTrainingTargetGroups);
						
						
						
						
						
						
						TrainingSubjects trainingSubjects=null;
						List<TrainingSubjects> newList=new ArrayList<TrainingSubjects>();
						for(TrainingSubjects preTrainingSubjects:trainingActivityDetailsPreLvl.getTrainingSubjectsList()) {
							params1 = new HashMap<>();
							params1.put("subjectId", preTrainingSubjects.getTrngSubjectId().getSubjectId());
							Subjects subjects = commonRepository.find("FIND_SUBJECT_ID", params1);
							trainingSubjects=new TrainingSubjects();
							trainingSubjects.setSubjectsTrainingActivityDetails(trainingActivityDetails);
							trainingSubjects.setTrngSubjectId(subjects);
							newList.add(trainingSubjects);
							
						}
						trainingActivityDetails.setTrainingSubjectsList(newList);
						
						 TrainingWiseCategory trainingWiseCategory=null;
						List<TrainingWiseCategory> trainingWiseCategoryList=new ArrayList<TrainingWiseCategory>();
						for(TrainingWiseCategory preTrainingWiseCategory:trainingActivityDetailsPreLvl.getTrainingWiseCategoryList()) {
							params1 = new HashMap<>();
							params1.put("trainingCategoryId", preTrainingWiseCategory.getTrainingCategories().getTrainingCategoryId());
							TrainingCategories trainingCategories = commonRepository.find("Fetch_Training_Categories_BY_Id", params1);
							trainingWiseCategory=new TrainingWiseCategory();
							trainingWiseCategory.setTargetTrainingActivityDetails(trainingActivityDetails);
							trainingWiseCategory.setTrainingCategories(trainingCategories);
							trainingWiseCategoryList.add(trainingWiseCategory);
							
						}
						trainingActivityDetails.setTrainingWiseCategoryList(trainingWiseCategoryList);
						
						trainingActivityDetailsList.add(trainingActivityDetails);
						
						}
						activity.setTrainingActivityDetailsList(trainingActivityDetailsList);
						commonRepository.save(activity);
						if(activity.getIsFreeze()) {
							facadeService.populateStateFunds("1");
						}
						response1.setResponseMessage("Training Details save sucessfully");
						response1.setResponseCode(200);
						
						
						
				}else {
					
					Map<String,Object> param = new HashMap<>();
					param.put("trainingActivityId", fetchTraining.getTrainingActivityId());
					TrainingActivity activity = commonRepository.find("FIND_ALL_TRAINING_ACTIVITY_BY_ID", param);
					
					activity.setLastUpdatedBy(userPreference.getUserId());
					activity.setIsFreeze(fetchTraining.getIsFreeze());
					activity.setAdditionalRequirement(fetchTraining.getAdditionalRequirement());
					FetchTrainingDetails fetchTrainingDetails=null;
					List<TrainingActivityDetails> trainingActivityDetailsList=activity.getTrainingActivityDetailsList();
					List<TrainingActivityDetails> updatetrainingActivityDetailsList=new ArrayList<TrainingActivityDetails>();
					
					for(TrainingActivityDetails trainingActivityDetails:trainingActivityDetailsList ) {
					fetchTrainingDetails=	findFetchTrainingDetail(trainingActivityDetails.getTrainingActivityDetailsId(),fetchTraining.getTrainingDetailList());
					trainingActivityDetails.setRemarks(fetchTrainingDetails.getRemarks());
					trainingActivityDetails.setNoOfDays(fetchTrainingDetails.getNoOfDays());
					trainingActivityDetails.setNoOfParticipants(fetchTrainingDetails.getNoOfParticipants());
					trainingActivityDetails.setUnitCost(fetchTrainingDetails.getUnitCost());
					trainingActivityDetails.setFunds(fetchTrainingDetails.getFunds());
					trainingActivityDetails.setTrainingActivity(activity);
					trainingActivityDetails.setIsActive(Boolean.TRUE);
					trainingActivityDetails.setIsApproved(fetchTrainingDetails.getIsApproved());
					updatetrainingActivityDetailsList.add(trainingActivityDetails);
					}
					
					activity.setTrainingActivityDetailsList(updatetrainingActivityDetailsList);
					
					commonRepository.update(activity);
					if(activity.getIsFreeze()) {
						facadeService.populateStateFunds("1");
					}
					response1.setResponseMessage("Training Details update sucessfully");
					response1.setResponseCode(200);
			
			
			
			}
			
			}catch(Exception e) {
			response1.setResponseMessage(e.getMessage());
			response1.setResponseCode(500);
		}
		return response1;
	}
	
	private FetchTrainingDetails findFetchTrainingDetail(Integer trainingId ,List<FetchTrainingDetails> trainingDetailList) {
		FetchTrainingDetails fetchTrainingDetails=null;
		for(FetchTrainingDetails obj:trainingDetailList) {
			if(obj.getTrainingId().equals(trainingId)) {
				fetchTrainingDetails=obj;
				break;
			}
		}
		return fetchTrainingDetails;
	}
	
	@Override
	public List<TrainingWiseCategory> fetchTrainingWiseCategoryList(Integer trngId) {
		Map<String,Object> params = new HashMap<>();
		params.put("trngId", trngId);
		return commonRepository.findAll("FETCH_TRANGCATEGORY_TRAINING_ID", params);
	}

	@Override
	public FileNode loadFileNode(FileNode fileNode) {
		return commonRepository.find(FileNode.class, fileNode.getFileNodeId());
	}

	@Override
	public FileNode fetchQprTnaTrgEvaluation(Integer tableId) {
		return commonRepository.find(QprTnaTrgEvaluation.class, tableId).getFileNode();
	}

	@Override
	public FileNode fetchQprHandholdingGpdp(Integer tableId) {
		return commonRepository.find(QprHandholdingGpdp.class, tableId).getFileNode();
	}

	@Override
	public FileNode fetchQprPanchayatLearningCenter(Integer tableId) {
		return commonRepository.find(QprPanchayatLearningCenter.class, tableId).getFileNode();
	}

}
	
