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
import gov.in.rgsa.dto.InstitutionalInfraProgressReportDTO;
import gov.in.rgsa.entity.InstInfraStatus;
import gov.in.rgsa.entity.InstitutionalInfraActivityPlan;
import gov.in.rgsa.entity.InstitutionalInfraActivityPlanDetails;
import gov.in.rgsa.entity.QprInstitutionalInfraDetails;
import gov.in.rgsa.entity.QprInstitutionalInfrastructure;
import gov.in.rgsa.entity.TrainingInstitueType;
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
		institutionalInfraActivityPlan.setVersionNumber(1);
		institutionalInfraActivityPlan.setYearId(userPreference.getFinYearId());
		return institutionalInfraActivityPlan;
	}
	
	private InstitutionalInfraActivityPlan setObjectsForInstitutionalInfraActivityPlanForMopr(InstitutionalInfraActivityPlan institutionalInfraActivityPlan) {
		institutionalInfraActivityPlan.setInstitutionalInfraActivityId(null);
		institutionalInfraActivityPlan.setCreatedBy(userPreference.getUserId());
		institutionalInfraActivityPlan.setLastUpdatedBy(userPreference.getUserId());
		institutionalInfraActivityPlan.setStateCode(userPreference.getStateCode());
		institutionalInfraActivityPlan.setUserType(userPreference.getUserType());
		institutionalInfraActivityPlan.setVersionNumber(1);
		institutionalInfraActivityPlan.setYearId(userPreference.getFinYearId());
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
	public List<InstitutionalInfraActivityPlan> fetchInstitutionalInfraActivity(String userType) {
		Map<String, Object> params=new HashMap<>();
		List<InstitutionalInfraActivityPlan> activity=new ArrayList<>();
		params.put("stateCode", userPreference.getStateCode());
		params.put("yearId", userPreference.getFinYearId());		
		params.put("userType",(userType != null) ? userType : userPreference.getUserType());
		activity= commonRepository.findAll("FETCH_ALL_INSTITUTIONAL_ACTIVITY", params);
		if(userPreference.getUserType().equalsIgnoreCase("M") && CollectionUtils.isEmpty(activity)){
			params.put("userType", "S");
			activity= commonRepository.findAll("FETCH_ALL_INSTITUTIONAL_ACTIVITY", params);
			if(CollectionUtils.isNotEmpty(activity)){
				activity.get(0).setIsFreeze(false);
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
	public List<InstitutionalInfraProgressReportDTO> fetchInstInfraStateDataForProgressReport(Integer trainingInstituteTypeId) {
		Map<String, Object> params=new HashMap<String, Object>();
		params.put("stateCode", userPreference.getStateCode());
		params.put("yearId", userPreference.getFinYearId());
		params.put("userType", 'C');
		params.put("trainingInstituteTypeId", trainingInstituteTypeId);
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
			qprInstitutionalInfraDetails.setTrainingInstitueTypeId(qprInstitutionalInfrastructure.getTrainingTypeId());
		}
		qprInstitutionalInfrastructure.setQprInstitutionalInfraDetails(details);
		return qprInstitutionalInfrastructure;
	}

	@Override
	public List<QprInstitutionalInfrastructure> fetchDataAccordingToQuator(Integer quatorId, int institutionalActivityId ) {
		
		Map<String, Object> params=new HashMap<>();
		params.put("quatorId", quatorId);
		params.put("institutionalActivityId", institutionalActivityId);
		

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
	

	
}
