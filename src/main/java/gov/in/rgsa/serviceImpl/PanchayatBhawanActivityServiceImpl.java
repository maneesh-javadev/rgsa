package gov.in.rgsa.serviceImpl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

import org.apache.commons.collections.CollectionUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import gov.in.rgsa.dao.CommonRepository;
import gov.in.rgsa.dto.GramPanchayatProgressReportDTO;
import gov.in.rgsa.entity.GPBhawanStatus;
import gov.in.rgsa.entity.BasicInfoDetails;
import gov.in.rgsa.entity.CapacityBuildingActivityDetails;
import gov.in.rgsa.entity.FinalizeFreezeStatus;
import gov.in.rgsa.entity.GramPanchayatActivity;
import gov.in.rgsa.entity.PanchatayBhawanActivity;
import gov.in.rgsa.entity.PanchatayBhawanActivityDetails;
import gov.in.rgsa.entity.PanchayatBhawanProposedInfo;
import gov.in.rgsa.entity.PanchyatBhawanCurrentStatus;
import gov.in.rgsa.entity.PanchyatBhawanCurrentStatusDetails;
import gov.in.rgsa.entity.PanchyatWiseServicesProvided;
import gov.in.rgsa.entity.QprPanchayatBhawan;
import gov.in.rgsa.entity.QprPanhcayatBhawanDetails;
import gov.in.rgsa.entity.ServiceMaster;
import gov.in.rgsa.model.Response;
import gov.in.rgsa.service.FacadeService;
import gov.in.rgsa.service.PanchayatBhawanService;
import gov.in.rgsa.user.preference.UserPreference;

@Service
public class PanchayatBhawanActivityServiceImpl implements PanchayatBhawanService{
	
	
	@Autowired
	private CommonRepository commonRepository; 
	
	@Autowired
	UserPreference userPreference;
	
	@PersistenceContext
	private EntityManager entityManager;
	
	@Autowired
	private FacadeService facadeService;

	@Override
	public List<GramPanchayatActivity> fetchPanchayatBhawanActivity() {
		return commonRepository.findAll("FETCH_PANCHAYAT_BHAWAN_ACTIVITY", null);
	}

	@Override
	public void savePanchayatBhawanActivity(PanchatayBhawanActivity activity) {
		
		if(userPreference.getUserType().equalsIgnoreCase("S") || userPreference.getUserType().equalsIgnoreCase("C")){
			savePanchayatBhawanActivityForStateAndCEC(activity);
		}else{
			if(activity.getUserType().equalsIgnoreCase("S")){
				savePanchayatBhawanActivityForMOPR(activity);
			}else{
				commonRepository.update(activity);
				List<PanchatayBhawanActivityDetails> panchatayBhawanActivityDetails = activity.getPanchatayBhawanActivityDetails();
				for (PanchatayBhawanActivityDetails panchatayBhawanActivityDetail : panchatayBhawanActivityDetails) {
					panchatayBhawanActivityDetail.setPanchatayBhawanActivity(activity);
					commonRepository.update(panchatayBhawanActivityDetail);
				}
			}
		}
		if(activity.getStatus()!=null && activity.getStatus().length()>0 && activity.getStatus().charAt(0)=='F') {
			facadeService.populateStateFunds("3");
		}
	
		/*List<PanchatayBhawanActivityDetails> activityDetails=activity.getPanchatayBhawanActivityDetails();
		for (PanchatayBhawanActivityDetails details : activityDetails) {
			details.setPanchatayBhawanActivity(activity);
			List<PanchayatBhawanProposedInfo> bhawanProposedInfos =details.getProposedInfo();
			if(bhawanProposedInfos != null || !bhawanProposedInfos.isEmpty()){
			for (PanchayatBhawanProposedInfo panchayatBhawanProposedInfo : bhawanProposedInfos) {
				panchayatBhawanProposedInfo.setActivityDetails(details);
			}
		  }
		}
		if(activity.getPanhcayatBhawanActivityId()==null || activity.getPanhcayatBhawanActivityId()==0){
			activity.setStateCode(userPreference.getStateCode());
			activity.setYearId(userPreference.getFinYearId());
			activity.setCreatedBy(userPreference.getUserId());
			activity.setLastUpdatedBy(userPreference.getUserId());
			activity.setUserType(userPreference.getUserType());
			commonRepository.save(activity);
		}
		else{
			commonRepository.update(activity);
		}*/
		
	}
	
	
	private void savePanchayatBhawanActivityForStateAndCEC(PanchatayBhawanActivity activity){
		
		List<PanchatayBhawanActivityDetails> activityDetails=activity.getPanchatayBhawanActivityDetails();
		for (PanchatayBhawanActivityDetails details : activityDetails) {
			details.setPanchatayBhawanActivity(activity);
			if(details.getIsApproved() == null)
				details.setIsApproved(false);
			List<PanchayatBhawanProposedInfo> bhawanProposedInfos =details.getProposedInfo();
			if(bhawanProposedInfos != null && !bhawanProposedInfos.isEmpty()){
			for (PanchayatBhawanProposedInfo panchayatBhawanProposedInfo : bhawanProposedInfos) {
				panchayatBhawanProposedInfo.setActivityDetails(details);
			}
		  }
		}
		if(activity.getPanhcayatBhawanActivityId()==null || activity.getPanhcayatBhawanActivityId()==0){
			activity.setStateCode(userPreference.getStateCode());
			activity.setYearId(userPreference.getFinYearId());
			activity.setCreatedBy(userPreference.getUserId());
			activity.setVersionNo(userPreference.getPlanVersion());
			activity.setLastUpdatedBy(userPreference.getUserId());
			activity.setUserType(userPreference.getUserType());
			activity.setIsActive(Boolean.TRUE);
			commonRepository.save(activity);
		}
		else{
			commonRepository.update(activity);
		}
		
	}
	
	private void savePanchayatBhawanActivityForMOPR(PanchatayBhawanActivity activity){
		activity.setPanhcayatBhawanActivityId(null);
		List<PanchatayBhawanActivityDetails> activityDetails=activity.getPanchatayBhawanActivityDetails();
		
		for (PanchatayBhawanActivityDetails details : activityDetails) {
			details.setPanchatayBhawanActivity(activity);
			/*details.setId(null);*/
			if(details.getIsApproved() == null)
				details.setIsApproved(false);
			List<PanchayatBhawanProposedInfo> bhawanProposedInfos =details.getProposedInfo();
			if(bhawanProposedInfos != null && !bhawanProposedInfos.isEmpty()){
			for (PanchayatBhawanProposedInfo panchayatBhawanProposedInfo : bhawanProposedInfos) {
				panchayatBhawanProposedInfo.setProposedInfoId(null);
				panchayatBhawanProposedInfo.setActivityDetails(details);
			}
		  }
		}
		List<PanchatayBhawanActivityDetails> panchatayBhawanActivityDetails  = new ArrayList<>();
		for (PanchatayBhawanActivityDetails panchatayBhawanActivityDetail : activityDetails) {
			/*if(panchatayBhawanActivityDetail.getFunds() != null){*/
				panchatayBhawanActivityDetail.setId(null);
				panchatayBhawanActivityDetails.add(panchatayBhawanActivityDetail);
			
		/*}*/
		}
		activity.setPanchatayBhawanActivityDetails(panchatayBhawanActivityDetails);
		if(activity.getPanhcayatBhawanActivityId()==null || activity.getPanhcayatBhawanActivityId()==0){
			activity.setStateCode(userPreference.getStateCode());
			activity.setYearId(userPreference.getFinYearId());
			activity.setCreatedBy(userPreference.getUserId());
			activity.setLastUpdatedBy(userPreference.getUserId());
			activity.setUserType(userPreference.getUserType());
			activity.setVersionNo(userPreference.getPlanVersion());
			activity.setIsActive(Boolean.TRUE);
			commonRepository.save(activity);
			/*commonRepository.update(activity);*/
		}
		else{
			commonRepository.update(activity);
		}
		
	}

	@Override
	public PanchatayBhawanActivity getPanchatayBhawanActivity(String userType) {
		List<PanchatayBhawanActivity> activities=null;
		Map<String, Object> map = new HashMap<String,Object>();
		map.put("stateCode", userPreference.getStateCode());
		map.put("yearId", userPreference.getFinYearId());
		map.put("versionNo", userPreference.getPlanVersion());
		if(userType == null){
			map.put("userType", userPreference.getUserType());
		}else{
			map.put("userType", userType);
		}
		activities=commonRepository.findAll("FETCH_PANCHAYAT_DETAILS", map);
		if(!CollectionUtils.isEmpty(activities) && activities.size()>0){
			return activities.get(0);
		}
		else{
			if(userPreference.getUserType().equalsIgnoreCase("M")){
				map.put("userType", "S");
			}
			activities=commonRepository.findAll("FETCH_PANCHAYAT_DETAILS", map);
			if(!CollectionUtils.isEmpty(activities) && activities.size()>0){
				if(activities.get(0).getUserType().equalsIgnoreCase("S") && activities.get(0).getStatus().equalsIgnoreCase("F")){
					activities.get(0).setStatus("UF");
				}
				return activities.get(0);
			}			
				return null;			
		}
		
	}

	@Override
	public List<ServiceMaster> fetchServicesProvided() {
		return commonRepository.findAll("FETCH_SERVICE_MASTER", null);
	}

	public List<PanchyatBhawanCurrentStatus> fetchPanchyatBhawanCurrentStatusBasedOnLocalBodySelected(List<Long> localbodyList){
		List<PanchyatBhawanCurrentStatus> panchyatBhawanCurrentStatus=null;
		Map<String, Object> map = new HashMap<String,Object>();
		map.put("localBodyCodeList", localbodyList);
		panchyatBhawanCurrentStatus=commonRepository.findAll("FETCH_PANCHAYAT_BHAWAN_CURRENTSTATUS_DETAILS", map);
		if(!CollectionUtils.isEmpty(panchyatBhawanCurrentStatus) && panchyatBhawanCurrentStatus.size()>0){
			return panchyatBhawanCurrentStatus;
		}
		return panchyatBhawanCurrentStatus;
	}
	
	@Override
	public void savePanchayatBhawanCsDetails(PanchyatBhawanCurrentStatus bhawanStatus) {
		bhawanStatus = preparePanchyatBhawanCurrentStatusObject(bhawanStatus);
		final PanchyatBhawanCurrentStatus currentStatus = bhawanStatus;
		List<PanchyatBhawanCurrentStatusDetails> panchyatBhawanDetails = bhawanStatus.getPanchayatBhawanCurrentStatusDetails();
		if(!CollectionUtils.isEmpty(panchyatBhawanDetails)) {
			panchyatBhawanDetails.forEach(panchyatBhawanDetail->{
				if(panchyatBhawanDetail != null) {
					List<PanchyatWiseServicesProvided> servicesProvided = new ArrayList<>();
					panchyatBhawanDetail.setPanchyatBhawanCurrentStatus(currentStatus);
					String[] services = panchyatBhawanDetail.getServices();
					if(services != null) {
						for (String service : services) {
							PanchyatWiseServicesProvided serviceProvided = new PanchyatWiseServicesProvided();
							ServiceMaster serviceMaster = new ServiceMaster();
							serviceMaster.setServiceMasterId(Integer.parseInt(service));
							serviceProvided.setServiceMasterId(serviceMaster);
							serviceProvided.setPanchyatBhawanCurrentStatusDetails(panchyatBhawanDetail);
							servicesProvided.add(serviceProvided);
						}
					}
					panchyatBhawanDetail.setPanchyatWiseServicesProvideds(servicesProvided);
				}
			});
		}
		bhawanStatus.setPanchayatBhawanCurrentStatusDetails(panchyatBhawanDetails);
		if(bhawanStatus.getPanchayat_bhawan_currentstatus_id() == null || bhawanStatus.getPanchayat_bhawan_currentstatus_id() == 0) {
			bhawanStatus.setIsFreeze(Boolean.FALSE);
			commonRepository.save(bhawanStatus);
		}else {
			commonRepository.update(bhawanStatus);
		}
	}
	
	private PanchyatBhawanCurrentStatus preparePanchyatBhawanCurrentStatusObject(PanchyatBhawanCurrentStatus panchyatBhawanCurrentStatus) {
		panchyatBhawanCurrentStatus.setCreatedBy(userPreference.getUserId());
		panchyatBhawanCurrentStatus.setLastUpdatedBy(userPreference.getUserId());
		panchyatBhawanCurrentStatus.setStateCode(userPreference.getStateCode());
		panchyatBhawanCurrentStatus.setUserType(userPreference.getUserType().charAt(0));
		panchyatBhawanCurrentStatus.setYearId(userPreference.getFinYearId());
		return panchyatBhawanCurrentStatus;
	}
	
	
	@Override
	public BasicInfoDetails findNumberOfPnchayatWithOutBhawanByState(Integer stateCode) {
		Map<String, Object> map = new HashMap<String,Object>();
		map.put("stateCode", stateCode);
		map.put("yearId", userPreference.getFinYearId());
	return commonRepository.find("PANCHAYAT_WITHOUT_BHAWAN", map);
	}
	
	@Override
	public List<GPBhawanStatus> fetchGPBhawanStatus(Integer panchayatBhawanActvityId) {
		Map<String, Object> params=new HashMap<>();
		params.put("activityId", panchayatBhawanActvityId);
		return commonRepository.findAll("FETCH_GP_BHAWAN_STATUS", params);
	}

	@Override
	public List<GramPanchayatProgressReportDTO> fetchGPBhawanData(Integer activityId,
			Integer districtListId ,Integer panchayatBhawanActivityId) {
		Map<String, Object> params = new HashMap<>();
		params.put("activityId", activityId);
		params.put("districtCode", districtListId);
		params.put("panchayatBhawanActivityId", panchayatBhawanActivityId);
		
		return commonRepository.findAll("FETCH_GRAM_PANCHAYAT_REPORT_DETAILS", params);
	}

	@Override
	public void saveQprPanchayatBhawanData(QprPanchayatBhawan qprPanchayatBhawan) {
		qprPanchayatBhawan=setObjectForQprPanchayatBhawan(qprPanchayatBhawan);
		qprPanchayatBhawan=setDetailsForQprPanchayatBhawan(qprPanchayatBhawan);
		if(qprPanchayatBhawan.getQprPanchayatBhawanId() == null || qprPanchayatBhawan.getQprPanchayatBhawanId() == 0){
			commonRepository.save(qprPanchayatBhawan);
		}else{
			commonRepository.update(qprPanchayatBhawan);
		}	
	}
	
	public QprPanchayatBhawan setObjectForQprPanchayatBhawan(QprPanchayatBhawan qprPanchayatBhawan){
		qprPanchayatBhawan.setCreatedBy(userPreference.getUserId());
		qprPanchayatBhawan.setLastUpdatedBy(userPreference.getUserId());
		return qprPanchayatBhawan;
	}
	
	
	public QprPanchayatBhawan setDetailsForQprPanchayatBhawan(QprPanchayatBhawan qprPanchayatBhawan){
		List<QprPanhcayatBhawanDetails> details = qprPanchayatBhawan.getQprPanhcayatBhawanDetails();
		for (QprPanhcayatBhawanDetails qprPanhcayatBhawanDetails : details) {
			qprPanhcayatBhawanDetails.setQprPanchayatBhawan(qprPanchayatBhawan);
		}
		qprPanchayatBhawan.setQprPanhcayatBhawanDetails(details);
		return qprPanchayatBhawan;
	}

	@Override
	public Response savePanchayatBhwanFinalizeWorkLocaion(List<PanchayatBhawanProposedInfo> panchayatBhawanProposedInfoList) {
		Response response = new Response();
		Integer proposedInfoId=null;
		//EntityTransaction tx=entityManager.getTransaction();
		//tx.begin();
		try {
			
			
			Set<Integer> activityDetailIdList = new HashSet<Integer>();
			for(PanchayatBhawanProposedInfo obj:panchayatBhawanProposedInfoList) {
				activityDetailIdList.add(obj.getActivityDetails().getId());
			}
			
			Map<String, Object> params=new HashMap<String, Object>();
			Map<String, Integer> exitingObj=new HashMap<String, Integer>();
			params.put("activityDetailIdList", activityDetailIdList);
			List<PanchayatBhawanProposedInfo>  panchayatBhawanProposedInfoListOld= commonRepository.findAll("RESET_PANCHYAT_BHWAN_GP", params);
			if(panchayatBhawanProposedInfoListOld!=null && !panchayatBhawanProposedInfoListOld.isEmpty()) {
				for(PanchayatBhawanProposedInfo objold:panchayatBhawanProposedInfoListOld) {
					if(!objold.isIsactive()) {
						exitingObj.put(objold.getActivityDetails()+"_"+objold.getLocalBodyCode(), objold.getProposedInfoId());
					}
					objold.setIsactive(Boolean.FALSE);
					commonRepository.update(objold);
				}
			}
				
			
			
		for(PanchayatBhawanProposedInfo obj:panchayatBhawanProposedInfoList) {
			
			Integer activityId=obj.getActivityDetails().getId();
			if(activityId!=null) {
				PanchatayBhawanActivityDetails activityDetails=	commonRepository.find(PanchatayBhawanActivityDetails.class, activityId)	;
				obj.setActivityDetails(activityDetails);
			}
			
			proposedInfoId=obj.getProposedInfoId();
			if(proposedInfoId==null) {
				proposedInfoId=exitingObj.get(obj.getActivityDetails()+"_"+obj.getLocalBodyCode());
			}
			obj.setIsactive(Boolean.TRUE);
			if(proposedInfoId!=null) {
				obj.setProposedInfoId(proposedInfoId);
				commonRepository.update(obj);
			}else {
				commonRepository.save(obj);
			}
		}
		response.setResponseMessage("GP of Panchayat Bhawan save Successfully");
		response.setResponseCode(200);
		}catch(Exception e) {
			response.setResponseMessage("GP of Panchayat Bhawan save UnSuccessfully"+e.getMessage());
			response.setResponseCode(500);
		}
		//tx.commit();
		return response;
	}
	
	public List<PanchayatBhawanProposedInfo> fetchPanchayatBhawanProposedGPsList(Integer activityDetailsId){
		Map<String, Object> params=new HashMap<String, Object>();
		params.put("activityDetailsId", activityDetailsId);
		List<PanchayatBhawanProposedInfo> PanchayatBhawanProposedInfoGPsList= commonRepository.findAll("FIND_PANCHYAT_BHWAN_GP", params);
		if(PanchayatBhawanProposedInfoGPsList!=null && !PanchayatBhawanProposedInfoGPsList.isEmpty()) {
			return PanchayatBhawanProposedInfoGPsList;
		}
		return null;
	}

	@Override
	public List<QprPanchayatBhawan> fetchDataAccordingToQuator(Integer quatorId,Integer activityId,Integer districtCode,Integer panchayatBhawanActivityId ) {
		Map<String, Object> params=new HashMap<>();
		params.put("quatorId", quatorId);
		params.put("activityId", activityId);
		params.put("districtCode", districtCode);
		params.put("panchayatBhawanActivityId", panchayatBhawanActivityId);
		return commonRepository.findAll("FETCH_ACTIVITY_DEPEND_ON_QUATOR", params);
	}
	
	@Override
	public Integer fetchBasicInfoKeyValue(Integer stateCode,String defination_key) {
		Integer d=null;
		Map<String, Object> map = new HashMap<String,Object>();
		map.put("stateCode", stateCode);	
		map.put("defination_key", defination_key);
		map.put("yearId", userPreference.getFinYearId());
		String defination_value= commonRepository.find("BASIC_INFO_KEY_VALUE", map);
		if(defination_value!=null && defination_value.length()>0) {
			d=Integer.parseInt(defination_value);
		}
		return d;
	}

	@Override
	public Response freezeUnfreezeFinalizeWorkLocation(FinalizeFreezeStatus finalizeFreezeStatus) {
		Response response = new Response();
		try {
		finalizeFreezeStatus.setIsActive(true);
		if(finalizeFreezeStatus.getId()!=null) {
			commonRepository.update(finalizeFreezeStatus);
		}else {
			commonRepository.save(finalizeFreezeStatus);
		}
		String status=finalizeFreezeStatus.getIsFreeze()?"Freeze":"Unfreeze";
		String name="Panchayat Bhawan";
		if(finalizeFreezeStatus.getFinalizeType()=='E') {
		name="e-Enablement";	
		}else if(finalizeFreezeStatus.getFinalizeType()=='T') {
		name="Training Activity";	
		}
				
		
		response.setResponseMessage("GP of "+name+" "+status+" Successfully");
		response.setResponseCode(200);
		}catch(Exception e) {
			response.setResponseMessage("Finalize Freeze/Unfreeze UnSuccessfully"+e.getMessage());
			response.setResponseCode(500);
		}
		return response;
	}

	@Override
	public FinalizeFreezeStatus loadFreezeUnfreezeFinalizeWorkLocation(FinalizeFreezeStatus finalizeFreezeStatus) {
		FinalizeFreezeStatus finalizeFreezeObj=null;
		Map<String, Object> params=new HashMap<>();
		params.put("activityId", finalizeFreezeStatus.getActivityId());
		params.put("finalizeType", finalizeFreezeStatus.getFinalizeType());
		List<FinalizeFreezeStatus> finalizeFreezeObjList=commonRepository.findAll("FETCH_FINALIZE_FREEZE_STATUS", params);
		if(finalizeFreezeObjList!=null && !finalizeFreezeObjList.isEmpty())
		{
			finalizeFreezeObj=finalizeFreezeObjList.get(0);
		}
		return finalizeFreezeObj;
	}
	
	public boolean validateFinalizeWorklocationBasedonQPR(Character finalizeType) {
		boolean isvalidate=false;
		String queryStr="select case when count(1)>0 then true else false end from panhcayat_bhawan_activity pb  inner join qpr_panhcayat_bhawan qpb on pb.panhcayat_bhawan_activity_id=qpb.panhcayat_bhawan_activity_id " + 
		" where pb.state_code=:stateCode and pb.year_id=:yearId  and pb.user_type='C' and pb.is_active and (CASE WHEN pb.year_id=2 or pb.year_id=3 then " + 
		" qpb.qtr_id=0 else qpb.qtr_id in(1,2,3,4) END)";
		if(finalizeType=='E') {
			queryStr="select case when count(1)>0 then true else false end from e_enablement ee  inner join qpr_e_enablement qee on ee.e_enablement_id=qee.e_enablement_id "
			+ " where ee.state_code=:stateCode and ee.year_id=:yearId  and ee.user_type='C' and ee.is_active and (CASE WHEN ee.year_id=2 or ee.year_id=3 then " + 
			" qee.qtr_id=0 else qee.qtr_id in(1,2,3,4) END)";
		}else if(finalizeType=='T') {
			queryStr="select case when count(1)>0 then true else false end from cb_activity cb  inner join qpr_cb_activity qcb on cb.cb_activity_id=qcb.cb_activity_id "
			+ " where cb.state_code=:stateCode and cb.year_id=:yearId  and cb.user_type='C' and cb.is_active and (CASE WHEN cb.year_id=2 or cb.year_id=3 then  "
			+ " qcb.qtr_id=0 else qcb.qtr_id in(1,2,3,4) END)";
		}
		Map<String, Object> parameter = new HashMap<String, Object>();
		parameter.put("stateCode", userPreference.getStateCode());
		parameter.put("yearId", userPreference.getFinYearId());
		isvalidate=(Boolean)commonRepository.findByNativeQuery(queryStr, parameter);
		return isvalidate;
	}
	
}
