package gov.in.rgsa.serviceImpl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

import org.apache.commons.collections.CollectionUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import gov.in.rgsa.dao.CommonRepository;
import gov.in.rgsa.dto.FinalizeInstInfraDto;
import gov.in.rgsa.dto.InstitutionalInfraProgressReportDTO;
import gov.in.rgsa.entity.InstInfraStatus;
import gov.in.rgsa.entity.InstitutionalInfraActivityPlan;
import gov.in.rgsa.entity.InstitutionalInfraActivityPlanDetails;
import gov.in.rgsa.entity.Plan;
import gov.in.rgsa.entity.QprInstitutionalInfraDetails;
import gov.in.rgsa.entity.QprInstitutionalInfrastructure;
import gov.in.rgsa.entity.TrainingInstitueType;
import gov.in.rgsa.model.Response;
import gov.in.rgsa.service.FacadeService;
import gov.in.rgsa.service.InstitutionalInfraActivityPlanService;
import gov.in.rgsa.user.preference.UserPreference;

@Service
public class InstitutionalInfraActivityPlanServiceImpl implements InstitutionalInfraActivityPlanService {

	@PersistenceContext
	private EntityManager entityManager;
	
	@Autowired
	private CommonRepository commonRepository;
	
	@Autowired
	private UserPreference userPreference;
	
	@Autowired	
	private FacadeService facadeService;
		

	@Override
	public void saveInstitutionalInfraActivityPlanDetails( InstitutionalInfraActivityPlan institutionalInfraActivityPlan,Integer instituteType,String updateStatus) {
		if(institutionalInfraActivityPlan.getInstitutionalInfraActivityId() == null){
			setObjectsForInstitutionalInfraActivityPlanForState(institutionalInfraActivityPlan);
			setInstitutionalInfraDetailsWhileSave(institutionalInfraActivityPlan);
			commonRepository.save(institutionalInfraActivityPlan);
		}else{
			if(userPreference.getUserType().equalsIgnoreCase("M")){
				if(institutionalInfraActivityPlan.getUserType().equalsIgnoreCase("S")){
					setObjectsForInstitutionalInfraActivityPlanForMopr(institutionalInfraActivityPlan);
					setInstitutionalInfraDetailsForMopr(institutionalInfraActivityPlan);
					commonRepository.update(institutionalInfraActivityPlan);
				}else{
					if(institutionalInfraActivityPlan.getDataFor().equalsIgnoreCase("S")){
						setInstitutionalInfraDetailsForMopr(institutionalInfraActivityPlan);
					}else{
						if(institutionalInfraActivityPlan.getDetailsListLength() == institutionalInfraActivityPlan.getInstitutionalInfraActivityPlanDetails().get(0).getLocationName().length){
							setDataForDetailsWhileUpdate(institutionalInfraActivityPlan);
						}else{
							deleteThePreviousDPRCRecod(institutionalInfraActivityPlan);
							setInstitutionalInfraDetailsWhileSave(institutionalInfraActivityPlan);	
						}
					}
					
					commonRepository.update(institutionalInfraActivityPlan);
				}
			}
			if(userPreference.getUserType().equalsIgnoreCase("S")){
				if(updateStatus.equals("saving")){
					setInstitutionalInfraDetailsWhileSave(institutionalInfraActivityPlan);
					commonRepository.update(institutionalInfraActivityPlan);
				}else{
						deleteThePreviousDPRCRecod(institutionalInfraActivityPlan);
						setInstitutionalInfraDetailsWhileSave(institutionalInfraActivityPlan);
						commonRepository.update(institutionalInfraActivityPlan);
					/*
					 * if(institutionalInfraActivityPlan.getDetailsListLength() ==
					 * institutionalInfraActivityPlan.getInstitutionalInfraActivityPlanDetails().get
					 * (0).getLocationName().length){
					 * setDataForDetailsWhileUpdate(institutionalInfraActivityPlan);
					 * commonRepository.update(institutionalInfraActivityPlan); }else{
					 * deleteThePreviousDPRCRecod(institutionalInfraActivityPlan);
					 * setInstitutionalInfraDetailsWhileSave(institutionalInfraActivityPlan);
					 * commonRepository.update(institutionalInfraActivityPlan); }
					 */
				}
				
				}
				
			}
			
		
			
		}
	
	private void deleteThePreviousDPRCRecod(InstitutionalInfraActivityPlan institutionalInfraActivityPlan) {
		List<InstitutionalInfraActivityPlanDetails> details = fetchInstitutionalInfraActivityDetails(institutionalInfraActivityPlan,institutionalInfraActivityPlan.getInstitutionalInfraActivityId(),institutionalInfraActivityPlan.getInstitutionalInfraActivityPlanDetails().get(0).getTrainingInstitueType().getTrainingInstitueTypeId());
		for (InstitutionalInfraActivityPlanDetails institutionalInfraActivityPlanDetails : details) {
			if(institutionalInfraActivityPlanDetails.getInstitutionalInfraActivityDetailsId() != null)
			commonRepository.delete(InstitutionalInfraActivityPlanDetails.class, institutionalInfraActivityPlanDetails.getInstitutionalInfraActivityDetailsId());
		}
	}

	private InstitutionalInfraActivityPlan setDataForDetailsWhileUpdate(InstitutionalInfraActivityPlan institutionalInfraActivityPlan){
		List<InstitutionalInfraActivityPlanDetails> institutionalInfraActivityPlanDetails=institutionalInfraActivityPlan.getInstitutionalInfraActivityPlanDetails();
		for (InstitutionalInfraActivityPlanDetails institutionalInfraActivityPlanDetails2 : institutionalInfraActivityPlanDetails) {
			institutionalInfraActivityPlanDetails2.setInstitutionalInfraActivityPlan(institutionalInfraActivityPlan);
		}
		institutionalInfraActivityPlan.setInstitutionalInfraActivityPlanDetails(institutionalInfraActivityPlanDetails);
		return institutionalInfraActivityPlan;
	}
	
	private InstitutionalInfraActivityPlan setInstitutionalInfraDetailsWhileSave(InstitutionalInfraActivityPlan institutionalInfraActivityPlan){
	
		List<InstitutionalInfraActivityPlanDetails> institutionalInfraActivityPlanDetails = institutionalInfraActivityPlan.getInstitutionalInfraActivityPlanDetails();
		TrainingInstitueType maindetailTrainingInstituteType=institutionalInfraActivityPlanDetails.get(0).getTrainingInstitueType();
		String[] arrayOfLocations=institutionalInfraActivityPlanDetails.get(0).getLocationName();
		int lengthOfLocationString=institutionalInfraActivityPlanDetails.get(0).getLocationName().length;
		for (InstitutionalInfraActivityPlanDetails details : institutionalInfraActivityPlanDetails) {
			if(details != null) {
				if(lengthOfLocationString==0){break;}
						details.setInstitutionalInfraLocation(Integer.parseInt(arrayOfLocations[arrayOfLocations.length-lengthOfLocationString]));
						details.setInstitutionalInfraActivityDetailsId(details.getInstitutionalInfraActivityDetailsId());
						details.setInstitutionalInfraActivityPlan(institutionalInfraActivityPlan);
						details.setTrainingInstitueType(maindetailTrainingInstituteType);
			}
			lengthOfLocationString--;
		}
		institutionalInfraActivityPlan.setInstitutionalInfraActivityPlanDetails(institutionalInfraActivityPlanDetails);
		return institutionalInfraActivityPlan;
	}

	private InstitutionalInfraActivityPlanDetails constructDetailObjects(InstitutionalInfraActivityPlanDetails infraActivityPlanDetails,InstitutionalInfraActivityPlanDetails institutionalInfraActivityPlanDetails) {
			infraActivityPlanDetails.setFundProposed(institutionalInfraActivityPlanDetails.getFundProposed());
			infraActivityPlanDetails.setTrainingInstitueType(institutionalInfraActivityPlanDetails.getTrainingInstitueType());
			infraActivityPlanDetails.setTotalFund(institutionalInfraActivityPlanDetails.getTotalFund());
			infraActivityPlanDetails.setRemarks(institutionalInfraActivityPlanDetails.getRemarks());
			infraActivityPlanDetails.setIsApproved(institutionalInfraActivityPlanDetails.getIsApproved());
		
		return infraActivityPlanDetails;
	}
	
	private InstitutionalInfraActivityPlan setObjectsForInstitutionalInfraActivityPlanForState(InstitutionalInfraActivityPlan institutionalInfraActivityPlan) {
		institutionalInfraActivityPlan.setCreatedBy(userPreference.getUserId());
		institutionalInfraActivityPlan.setLastUpdatedBy(userPreference.getUserId());
		institutionalInfraActivityPlan.setStateCode(userPreference.getStateCode());
		institutionalInfraActivityPlan.setUserType(userPreference.getUserType());
		institutionalInfraActivityPlan.setVersionNumber(userPreference.getPlanVersion());
		institutionalInfraActivityPlan.setYearId(userPreference.getFinYearId());
		institutionalInfraActivityPlan.setIsActive(Boolean.TRUE);
		return institutionalInfraActivityPlan;
	}
	
	private InstitutionalInfraActivityPlan setObjectsForInstitutionalInfraActivityPlanForMopr(InstitutionalInfraActivityPlan institutionalInfraActivityPlan) {
		institutionalInfraActivityPlan.setInstitutionalInfraActivityId(null);
		institutionalInfraActivityPlan.setCreatedBy(userPreference.getUserId());
		institutionalInfraActivityPlan.setLastUpdatedBy(userPreference.getUserId());
		institutionalInfraActivityPlan.setStateCode(userPreference.getStateCode());
		institutionalInfraActivityPlan.setUserType(userPreference.getUserType());
		institutionalInfraActivityPlan.setVersionNumber(userPreference.getPlanVersion());
		institutionalInfraActivityPlan.setYearId(userPreference.getFinYearId());
		institutionalInfraActivityPlan.setIsActive(Boolean.TRUE);
		return institutionalInfraActivityPlan;
	}
	
	private InstitutionalInfraActivityPlan setInstitutionalInfraDetailsForMopr(InstitutionalInfraActivityPlan institutionalInfraActivityPlan){
		
		List<InstitutionalInfraActivityPlanDetails> institutionalInfraActivityPlanDetails = institutionalInfraActivityPlan.getInstitutionalInfraActivityPlanDetails();
		for (InstitutionalInfraActivityPlanDetails detail : institutionalInfraActivityPlanDetails) {
			if(detail != null) {
				detail.setInstitutionalInfraActivityDetailsId(null);
				detail.setInstitutionalInfraActivityPlan(institutionalInfraActivityPlan);
			}
		}
		institutionalInfraActivityPlan.setInstitutionalInfraActivityPlanDetails(institutionalInfraActivityPlanDetails);
		return institutionalInfraActivityPlan;
	}

	@Override
	public List<InstitutionalInfraActivityPlan> fetchInstitutionalInfraActivity(String userType)
	{
		Map<String, Object> params = new HashMap<>();
		List<InstitutionalInfraActivityPlan> activity = new ArrayList<>();
		params.put("stateCode", userPreference.getStateCode());
		params.put("yearId", userPreference.getFinYearId());
		params.put("versionNumber", userPreference.getPlanVersion());
		params.put("userType", (userType != null) ? userType : userPreference.getUserType());
		activity = commonRepository.findAll("FETCH_ALL_INSTITUTIONAL_ACTIVITY", params);
		if (userPreference.getUserType().equalsIgnoreCase("M") && CollectionUtils.isEmpty(activity))
		{
			params.put("userType", "S");
			activity = commonRepository.findAll("FETCH_ALL_INSTITUTIONAL_ACTIVITY", params);
			if (activity != null && !activity.isEmpty())
			{
				InstitutionalInfraActivityPlan institutionalInfraActivityPlan = activity.get(0);
				institutionalInfraActivityPlan.setInstitutionalInfraActivityId(null);
				for (InstitutionalInfraActivityPlanDetails institutionalInfraActivityPlanDetails : institutionalInfraActivityPlan.getInstitutionalInfraActivityPlanDetails())
				{
					institutionalInfraActivityPlanDetails.setInstitutionalInfraActivityDetailsId(null);

				}

				activity.set(0, institutionalInfraActivityPlan);
			}

		}

		return activity;
	}

	@Override
	public List<InstitutionalInfraActivityPlanDetails> fetchInstitutionalInfraActivityDetails(InstitutionalInfraActivityPlan institutionalInfraActivityPlan,Integer institutionalInfraActivityId, Integer instituteType) {
		Map<String, Object> params=new HashMap<>();
		Map<String, Object> map=new HashMap<>();
		List<InstitutionalInfraActivityPlanDetails> details=new ArrayList<>();
			List<InstitutionalInfraActivityPlan> activity=new ArrayList<>();
			params.put("institutionalInfraActivityId", institutionalInfraActivityId);
		params.put("instituteType", instituteType);
		details = commonRepository.findAll("FETCH_ALL_INSTITUTIONAL_ACTIVITY_DETAILS", params);
		institutionalInfraActivityPlan.setDataFor(userPreference.getUserType());
		if((userPreference.getUserType().equalsIgnoreCase("M") || userPreference.getUserType().equalsIgnoreCase("C"))  && CollectionUtils.isEmpty(details)){
			map.put("stateCode", userPreference.getStateCode());
			map.put("yearId", userPreference.getFinYearId());
			map.put("versionNumber", userPreference.getPlanVersion());
			map.put("userType", "S");
			activity=commonRepository.findAll("FETCH_ALL_INSTITUTIONAL_ACTIVITY", map);
			params.put("institutionalInfraActivityId", activity.get(0).getInstitutionalInfraActivityId());
			details=commonRepository.findAll("FETCH_ALL_INSTITUTIONAL_ACTIVITY_DETAILS", params);
			institutionalInfraActivityPlan.setDataFor("S");
		}
		return details;
	}

	@Override
	public InstitutionalInfraActivityPlan feezUnFreezInstitutionalInfraActivityPlan(InstitutionalInfraActivityPlan institutionalInfraActivityPlan) {
		setDataForDetailsWhileUpdate(institutionalInfraActivityPlan);
		commonRepository.update(institutionalInfraActivityPlan);
		if(institutionalInfraActivityPlan.getIsFreeze()) {
			facadeService.populateStateFunds("2");
		}
		return institutionalInfraActivityPlan;
	}

	@Override
	public List<TrainingInstitueType> fetchTrainingInstituteType() {
		return commonRepository.findAll("FETCH_TRAINING_INSTITUTION_TYPE", null);
		
	}

	@Override
	public List<InstitutionalInfraActivityPlanDetails> fetchAllDetails(Integer institutionalInfraActivityId) {
		Map<String, Object> params=new HashMap<>();
		params.put("institutionalInfraActivityId", institutionalInfraActivityId);
		return commonRepository.findAll("FETCH_ALL_DETAILS", params);
	}

	@Override
	public List<InstitutionalInfraProgressReportDTO> fetchInstInfraStateDataForProgressReport() {
		Map<String, Object> params=new HashMap<String, Object>();
		params.put("stateCode", userPreference.getStateCode());
		params.put("yearId", userPreference.getFinYearId());
		params.put("userType", 'C');
		
		return commonRepository.findAll("GET_INITIAL_DATA_FOR_INST_INFRA", params);
	}

	@Override
	public List<InstInfraStatus> fetchInstInfraStatus(Integer trainingInstituteTypeId) {
		Map<String, Object> params=new HashMap<String, Object>();
		params.put("trainingInstituteTypeId", trainingInstituteTypeId);
		return commonRepository.findAll("GET_INST_INFRA_STATUS", params);
	}

	@Override
	public void saveQprInstInfraData(QprInstitutionalInfrastructure qprInstitutionalInfrastructure) {
		qprInstitutionalInfrastructure=setObjectForQprInstInfra(qprInstitutionalInfrastructure);
		qprInstitutionalInfrastructure=setDetailsForQprInstInfra(qprInstitutionalInfrastructure);
		if(qprInstitutionalInfrastructure.getQprInstInfraId() == null || qprInstitutionalInfrastructure.getQprInstInfraId()== 0){
			commonRepository.save(qprInstitutionalInfrastructure);
		}else{
			commonRepository.update(qprInstitutionalInfrastructure);
		}
		
	}
	
	public QprInstitutionalInfrastructure setObjectForQprInstInfra(QprInstitutionalInfrastructure qprInstitutionalInfrastructure){
		qprInstitutionalInfrastructure.setCreatedBy(userPreference.getUserId());
		qprInstitutionalInfrastructure.setLastUpdatedBy(userPreference.getUserId());
		return qprInstitutionalInfrastructure;
	}
	
	
	public QprInstitutionalInfrastructure setDetailsForQprInstInfra(QprInstitutionalInfrastructure qprInstitutionalInfrastructure){
		List<QprInstitutionalInfraDetails> details = qprInstitutionalInfrastructure.getQprInstitutionalInfraDetails();
		for (QprInstitutionalInfraDetails qprInstitutionalInfraDetails : details) {
			qprInstitutionalInfraDetails.setQprInstitutionalInfrastructure(qprInstitutionalInfrastructure);
			//qprInstitutionalInfraDetails.setTrainingInstitueTypeId(qprInstitutionalInfrastructure.getTrainingTypeId());
		}
		qprInstitutionalInfrastructure.setQprInstitutionalInfraDetails(details);
		return qprInstitutionalInfrastructure;
	}

	@Override
	public List<QprInstitutionalInfrastructure> fetchDataAccordingToQuator(Integer quatorId,Integer activityId) {
		Map<String, Object> params=new HashMap<>();
		params.put("quatorId", quatorId);
		params.put("activityId", activityId);
		return commonRepository.findAll("FETCH_QPR_INST_ACTIVITY_DEPEND_ON_QUATOR", params);
				
				
	}


	@Override
	public List<QprInstitutionalInfraDetails> fetchDataOfDetailAccordingToQuator( int trainingInstituteTypeId ,int qprInstInfraId) {
		
		Map<String, Object> params=new HashMap<>();
		params.put("trainingInstituteTypeId", trainingInstituteTypeId);
		params.put("qprInstInfraId", qprInstInfraId);

		
		return commonRepository.findAll("FETCH_QPR_INST_ACTIVITY_DETAILS_DEPEND_ON_QUATOR", params);
	}

	@Override
	public InstitutionalInfraActivityPlan saveCecData(InstitutionalInfraActivityPlan institutionalInfraActivityPlan) {
		
		if(institutionalInfraActivityPlan.getUserType().equalsIgnoreCase("S")){
			institutionalInfraActivityPlan.setInstitutionalInfraActivityId(null);
			List<InstitutionalInfraActivityPlanDetails> details=institutionalInfraActivityPlan.getInstitutionalInfraActivityPlanDetails();
			for (InstitutionalInfraActivityPlanDetails institutionalInfraActivityPlanDetail : details) {
				institutionalInfraActivityPlanDetail.setInstitutionalInfraActivityDetailsId(null);
				institutionalInfraActivityPlanDetail.setInstitutionalInfraActivityPlan(institutionalInfraActivityPlan);
			}
			institutionalInfraActivityPlan.setInstitutionalInfraActivityPlanDetails(details);
		}else{
			List<InstitutionalInfraActivityPlanDetails> details=institutionalInfraActivityPlan.getInstitutionalInfraActivityPlanDetails();
			for (InstitutionalInfraActivityPlanDetails institutionalInfraActivityPlanDetail : details) {
				institutionalInfraActivityPlanDetail.setInstitutionalInfraActivityPlan(institutionalInfraActivityPlan);
			}
			institutionalInfraActivityPlan.setInstitutionalInfraActivityPlanDetails(details);
		}
		
		institutionalInfraActivityPlan.setUserType(userPreference.getUserType());
		commonRepository.update(institutionalInfraActivityPlan);
		return institutionalInfraActivityPlan;
	}
	
	@Override
	public List<TrainingInstitueType> fetchTrainingInstituteTypeId() {
		return commonRepository.findAll("FETCH_TRAINING_INSTITUTION_TYPE_BASED_ON_TYPE_ID_2_4", null);
		
	}
	
	@Override
	public void saveInstitutionalInfra(InstitutionalInfraActivityPlan institutionalInfraActivityPlan,String updateStatus) {
		Integer institutionalInfraActivityId=institutionalInfraActivityPlan.getInstitutionalInfraActivityId();
		if(institutionalInfraActivityId!=null) {
			Map<String,Object> params = new HashMap<>();
			params.put("institutionalInfraActivityId", institutionalInfraActivityId);
			commonRepository.excuteUpdate("UPDATE_DELETE_STATUS_BY_MULTIPLE_ID_Institutional", params);
		}
		
		
		
		if(institutionalInfraActivityPlan.getInstitutionalInfraActivityId() == null){
			institutionalInfraActivityPlan=setObjectsForInstitutionalInfraActivityPlanForState(institutionalInfraActivityPlan);
			for(InstitutionalInfraActivityPlanDetails institutionalInfraActivityPlanDetails:institutionalInfraActivityPlan.getInstitutionalInfraActivityPlanDetails()) {
				institutionalInfraActivityPlanDetails.setInstitutionalInfraActivityPlan(institutionalInfraActivityPlan);
				institutionalInfraActivityPlanDetails.setIsactive(Boolean.TRUE);
			}
			commonRepository.save(institutionalInfraActivityPlan);
		}else {
			
			Map<String,Object> params = new HashMap<>();
			params.put("institutionalInfraActivityId", institutionalInfraActivityId);
			params.put("isFreeze", institutionalInfraActivityPlan.getIsFreeze());
			params.put("additionalRequirement", institutionalInfraActivityPlan.getAdditionalRequirement());
			params.put("additionalRequirementDPRC", institutionalInfraActivityPlan.getAdditionalRequirementDPRC());
			commonRepository.excuteUpdate("UPDATE_FREEZE_UNFREEZE_STATUS_Institutional", params);
			
			for(InstitutionalInfraActivityPlanDetails institutionalInfraActivityPlanDetails:institutionalInfraActivityPlan.getInstitutionalInfraActivityPlanDetails()) {
				institutionalInfraActivityPlanDetails.setInstitutionalInfraActivityPlan(institutionalInfraActivityPlan);
				institutionalInfraActivityPlanDetails.setIsactive(Boolean.TRUE);
				if(institutionalInfraActivityPlanDetails.getInstitutionalInfraActivityDetailsId()==null) {
					commonRepository.save(institutionalInfraActivityPlanDetails);
				}else {
					commonRepository.update(institutionalInfraActivityPlanDetails);
				}
			}
		}
		if(institutionalInfraActivityPlan.getIsFreeze()) {
			facadeService.populateStateFunds("2");
		}
		
		
			
		}
	
	
	
	@Override
	public void saveInstitutionalInfraMOPRCEC(InstitutionalInfraActivityPlan institutionalInfraActivityPlan) {
		Integer institutionalInfraActivityId=institutionalInfraActivityPlan.getInstitutionalInfraActivityId();
		
		if(institutionalInfraActivityPlan.getInstitutionalInfraActivityId() == null){
			institutionalInfraActivityPlan=setObjectsForInstitutionalInfraActivityPlanForState(institutionalInfraActivityPlan);
			for(InstitutionalInfraActivityPlanDetails institutionalInfraActivityPlanDetails:institutionalInfraActivityPlan.getInstitutionalInfraActivityPlanDetails()) {
				institutionalInfraActivityPlanDetails.setInstitutionalInfraActivityPlan(institutionalInfraActivityPlan);
				institutionalInfraActivityPlanDetails.setIsactive(Boolean.TRUE);
			}
			
			commonRepository.save(institutionalInfraActivityPlan);
		}else {
			
			Map<String,Object> params = new HashMap<>();
			params.put("institutionalInfraActivityId", institutionalInfraActivityId);
			params.put("isFreeze", institutionalInfraActivityPlan.getIsFreeze());
			params.put("additionalRequirement", institutionalInfraActivityPlan.getAdditionalRequirement());
			params.put("additionalRequirementDPRC", institutionalInfraActivityPlan.getAdditionalRequirementDPRC());
			
			commonRepository.excuteUpdate("UPDATE_FREEZE_UNFREEZE_STATUS_Institutional", params);
			
			for(InstitutionalInfraActivityPlanDetails institutionalInfraActivityPlanDetails:institutionalInfraActivityPlan.getInstitutionalInfraActivityPlanDetails()) {
				institutionalInfraActivityPlanDetails.setInstitutionalInfraActivityPlan(institutionalInfraActivityPlan);
				institutionalInfraActivityPlanDetails.setIsactive(Boolean.TRUE);
				commonRepository.update(institutionalInfraActivityPlanDetails);
				
			}
		}
		if(institutionalInfraActivityPlan.getIsFreeze()) {
			facadeService.populateStateFunds("2");
		}
		
		
			
		}
	
	@Override
	public List<InstInfraStatus> fetchALLInstInfraStatus() {
	return commonRepository.findAll("GET_ALL_INST_INFRA_STATUS", null);
	}

	@Override
	public void deleteRecord(Integer detailId) {
		commonRepository.delete(InstitutionalInfraActivityPlanDetails.class, detailId);
	}

	@Override
	public List<InstitutionalInfraActivityPlanDetails> fetchAllDetailsExceptCurrentVersion() {
		 
		Map<String, Object> parameters=new HashMap<String, Object>();
		parameters.put("stateCode",userPreference.getStateCode());
		parameters.put("versionNo",userPreference.getPlanVersion());
		return commonRepository.findAll("FETCH_ALL_DETAILS_EXCEPT_CURRENT_VERSION", parameters);
	}

	@Override
	public List<FinalizeInstInfraDto> fetchInstitutionalInfraActivityDataCEC(String userType) {
		List<FinalizeInstInfraDto> instInfoList=null;
		FinalizeInstInfraDto instinfo=null;
		try {
		instInfoList=new ArrayList<>();
		System.out.println(userPreference.getStateCode()+"   "+userPreference.getFinYearId());
		String nativeQuery="select iiad.institutional_infra_location,iiad.work_type,iiad.institutional_activity_type_id,iiad.institutional_infra_activity_id,"
				+ "iiad.institutional_infra_activity_details_id from rgsa.institutional_infra_activity iia " +  
				"inner join rgsa.institutional_infra_activity_details iiad on iia.institutional_infra_activity_id=iiad.institutional_infra_activity_id " + 
				"where iia.state_code="+userPreference.getStateCode()+" and iia.year_id="+userPreference.getFinYearId()+" and iia.user_type='C' order by iiad.institutional_infra_location";
		List<Object> activities=commonRepository.findAllByNativeQuery(nativeQuery,null);
		
		if(!CollectionUtils.isEmpty(activities) && activities.size()>0){
			int count=0;
			for(Object obj :activities)
			{
				Object[] objarr=(Object[]) obj;
				instinfo=new FinalizeInstInfraDto();
				instinfo.setWorkLocation((int) objarr[0]);
				instinfo.setWorkType((Character) objarr[1]);
				instinfo.setActivityId((Integer) objarr[2]);
				instinfo.setInstId((Integer) objarr[3]);
				instinfo.setInstDtlsId((Integer) objarr[4]);
				instinfo.setCount(count);
				instInfoList.add(instinfo);
				count++;
			}
		}
		else{
			if(userPreference.getUserType().equalsIgnoreCase("M")){
				String nativeQuery1="select iiad.institutional_infra_location,iiad.work_type,iiad.institutional_activity_type_id,iiad.institutional_infra_activity_id,"
						+ "iiad.institutional_infra_activity_details_id from rgsa.institutional_infra_activity iia " +  
						"inner join rgsa.institutional_infra_activity_details iiad on iia.institutional_infra_activity_id=iiad.institutional_infra_activity_id " + 
						"where iia.state_code="+userPreference.getStateCode()+" and iia.year_id="+userPreference.getFinYearId()+" and iia.user_type='S' order by iiad.institutional_infra_location";
				activities=commonRepository.findAllByNativeQuery(nativeQuery1,null);
			}			
			if(!CollectionUtils.isEmpty(activities) && activities.size()>0){
				//if(activities.get(0).getUserType().equalsIgnoreCase("S") && activities.get(0).getIsFreeze()){
					//activities.get(0).setStatus("UF");
				//}
				for(Object obj : activities)
				{
					Object[] objarr=(Object[]) obj;
					instinfo=new FinalizeInstInfraDto();
					instinfo.setWorkLocation((int) objarr[0]);
					instinfo.setWorkType((Character) objarr[1]);
					instinfo.setActivityId((Integer) objarr[2]);
					instinfo.setInstId((Integer) objarr[3]);
					instinfo.setInstDtlsId((Integer) objarr[4]);
					instInfoList.add(instinfo);
				}
			}			
		}
		}
		catch(Exception e) {e.printStackTrace();}
		return instInfoList;
	}
	
	@Override
	public boolean fetchInstInfraActFreezDataCEC(String cecUserType) {
		boolean isFreez = false;
		try {
			List<Integer> qtrId=new ArrayList<>();
			if(userPreference.getFinYearId()==2 || userPreference.getFinYearId()==3)
			{
				qtrId.add(0);
			}
			else
			{
				qtrId.add(1);
				qtrId.add(2);
				qtrId.add(3);
				qtrId.add(4);
			}
			
			String qid=",";
			if(qtrId!=null && !qtrId.isEmpty())
			{
				for(int id :qtrId)
				{
					qid=qid+id;
				}
			}
			qid=qid.substring(1);
			System.out.println("after "+qid);
			
		String nativeQuery="select qii.is_freez from rgsa.institutional_infra_activity iia inner join rgsa.qpr_inst_infra qii on "
				+ "iia.institutional_infra_activity_id=qii.institutional_infra_activity_id where iia.state_code="+userPreference.getStateCode()+" "
						+ "and iia.year_id="+userPreference.getFinYearId()+" and iia.user_type='"+cecUserType+"' and iia.is_active=true and qii.qtr_id in("+qid+")";
		
		List<Object> obj=	commonRepository.findAllByNativeQuery(nativeQuery,null);
		
		System.out.println(" list  "+obj);
		if(obj!=null && !obj.isEmpty())
		{
			for(Object innerObj : obj)
			{
				if((boolean) innerObj==true)
				{
					isFreez=(boolean) innerObj;
					break;
				}
			}
			
		}
		}
		catch(Exception e) {e.printStackTrace();}
		return isFreez;
	}
	
	@Override
	public Response saveModifyDistrictInInstInfra(List<InstitutionalInfraActivityPlanDetails> instInfoActDtlsList) {
		Response response = new Response();
		try {
			for(InstitutionalInfraActivityPlanDetails instInfoActDtls :instInfoActDtlsList)
			{
				Integer instId=instInfoActDtls.getInstitutionalInfraActivityPlan().getInstitutionalInfraActivityId();
				Integer instDtlsId=instInfoActDtls.getInstitutionalInfraActivityDetailsId();
				int infraLocation=instInfoActDtls.getInstitutionalInfraLocation();
				String nativeQuery ="update rgsa.institutional_infra_activity_details set institutional_infra_location="+infraLocation+""
						+ " where institutional_infra_activity_id="+instId+" and institutional_infra_activity_details_id="+instDtlsId+"";
				commonRepository.excuteUpdateNativeQuery(nativeQuery,null);
			}
			response.setResponseMessage("District of Institutional Infra save Successfully");
			response.setResponseCode(200);
		}catch(Exception e) {
			response.setResponseMessage("District of Institutional Infra save UnSuccessfully"+e.getMessage());
			response.setResponseCode(500);
		}
		return response;
	}
	
	@Override
	public boolean fetchPlanApprovedByCEC() {
		boolean isApprove = false;
		Plan status=null;
		try {	
			Map<String,Object> params=new HashMap<>();
			
			params.put("stateCode", userPreference.getStateCode());
			params.put("planStatusId",5);
			params.put("yearId", userPreference.getFinYearId());
			params.put("planVersion", userPreference.getPlanVersion());
			
			status=commonRepository.find("PLAN_STATUS", params);
			
		if(status!=null)
		{
			if(status.getIsactive())
			{
				isApprove=true;
			}
			else {isApprove=false;}
		}
		
		}
		catch(Exception e) {e.printStackTrace();}
		return isApprove;
	}	


/////



@Override
public boolean fetchInstitutionalInfraActivityData() {
	List<InstitutionalInfraActivityPlanDetails> instInfodtlsList=null;
	boolean flag=false;
	try {		
		String nativeQuery="select * from  rgsa.institutional_infra_activity_details where institutional_infra_activity_id="+
				"(select institutional_infra_activity_id from rgsa.institutional_infra_activity where state_code="+userPreference.getStateCode()+" "
				+ "and year_id="+userPreference.getFinYearId()+" and user_type='S' and version_no="+userPreference.getPlanVersion()+" and is_active=true)";
		
		instInfodtlsList=commonRepository.findAllByNativeQuery(nativeQuery, null);
		if(instInfodtlsList!=null && !instInfodtlsList.isEmpty())
			{
				flag=true;
			}
	}
	catch(Exception e) {e.printStackTrace();}
	return flag;
}




}
