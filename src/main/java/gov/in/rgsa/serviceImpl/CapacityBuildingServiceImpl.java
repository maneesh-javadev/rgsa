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
import gov.in.rgsa.entity.CapacityBuildingActivity;
import gov.in.rgsa.entity.CapacityBuildingActivityDetails;
import gov.in.rgsa.entity.CapacityBuildingActivityGPs;
import gov.in.rgsa.model.Response;
import gov.in.rgsa.service.CapacityBuildingService;
import gov.in.rgsa.service.FacadeService;
import gov.in.rgsa.user.preference.UserPreference;

@Service
public class CapacityBuildingServiceImpl implements CapacityBuildingService{
	
	@Autowired
	private CommonRepository commonRepository;
	
	@Autowired
	UserPreference userPreference;
	
	@PersistenceContext
	private EntityManager entityManager;
	
	@Autowired
	FacadeService facadeService;

	@Override
	public CapacityBuildingActivity fetchCapacityBuildingActivity(final Character userType) {
		List<CapacityBuildingActivity> capacityBuildingActivities=new ArrayList<>();
		Map<String, Object> params=new HashMap<String, Object>();
		params.put("stateCode", userPreference.getStateCode());
		params.put("yearId", userPreference.getFinYearId());
		params.put("versionNo", userPreference.getPlanVersion());
		//params.put("userType", userPreference.getUserType().charAt(0));
		//capacityBuildingActivities=commonRepository.findAll("FETCH_CAPACITY_BUILDING", params);
	/*	if(!CollectionUtils.isEmpty(capacityBuildingActivities) && capacityBuildingActivities.size()>0){
			return capacityBuildingActivities.get(0);
		}
		else{
			params.put("userType", 'S');
			capacityBuildingActivities=commonRepository.findAll("FETCH_CAPACITY_BUILDING", params);
			if(!CollectionUtils.isEmpty(capacityBuildingActivities) && capacityBuildingActivities.size()>0){
				return capacityBuildingActivities.get(0);
			}
			return null;
		}*/
		
		if(userType == null){
			params.put("userType", userPreference.getUserType().charAt(0));
		}else{
			params.put("userType", userType);
		}
		capacityBuildingActivities=commonRepository.findAll("FETCH_CAPACITY_BUILDING", params);
		if(userPreference.getUserType().equalsIgnoreCase("M") && CollectionUtils.isEmpty(capacityBuildingActivities)){
			params.put("userType", 'S');
			capacityBuildingActivities=commonRepository.findAll("FETCH_CAPACITY_BUILDING", params);
			if(capacityBuildingActivities!=null && !capacityBuildingActivities.isEmpty()) {
				return capacityBuildingActivities.get(0);
			}
			else {
				return null;
			}
		}
		/*if (userPreference.getUserType().equalsIgnoreCase("C") && CollectionUtils.isEmpty(capacityBuildingActivities)) {
			params.put("userType", 'S');
			capacityBuildingActivities=commonRepository.findAll("FETCH_CAPACITY_BUILDING", params);
			capacityBuildingActivities.get(0).setIsFreeze(false);;
		}*/
		
		if (!CollectionUtils.isEmpty(capacityBuildingActivities)) {
			return capacityBuildingActivities.get(0);
		} else {
			return null;
			
		}
	}
	

	@Override
	public void saveCapacityBuildingActivityAndDetails(CapacityBuildingActivity capacityBuildingActivity) {

		if(userPreference.getUserType().equalsIgnoreCase('s'+"") || userPreference.getUserType().equalsIgnoreCase('c'+"")){
			saveCapacityBuildingActivityAndDetailsForStateAndCec(capacityBuildingActivity);
		}else{
			if(capacityBuildingActivity.getUserType() == 'S'){
				saveCapacityBuildingActivityAndDetailsForMopr(capacityBuildingActivity);
			}else{
				capacityBuildingActivity.setCreatedBy(userPreference.getUserId());
				capacityBuildingActivity.setStateCode(userPreference.getStateCode());
				capacityBuildingActivity.setYearId(userPreference.getFinYearId());
				capacityBuildingActivity.setUserType(userPreference.getUserType().charAt(0));
				capacityBuildingActivity.setIsFreeze(false);
				capacityBuildingActivity.setVersionNo(userPreference.getPlanVersion());

				//commonRepository.update(capacityBuildingActivity);
				List<CapacityBuildingActivityDetails> capacityBuildingActivityDetails = capacityBuildingActivity.getCapacityBuildingActivityDetails();
				for (CapacityBuildingActivityDetails capacityBuildingActivityDetail : capacityBuildingActivityDetails) {
					capacityBuildingActivityDetail.setCapacityBuildingActivity(capacityBuildingActivity);
					
				}
				commonRepository.update(capacityBuildingActivity);
			}
		}
		
		/*
		capacityBuildingActivity= setCapacityBuildingActivityObject(capacityBuildingActivity);
		List<CapacityBuildingActivityDetails> capacityBuildingActivityDetails = capacityBuildingActivity.getCapacityBuildingActivityDetails();
		final CapacityBuildingActivity capacityActivity = capacityBuildingActivity;
		
		capacityBuildingActivityDetails.forEach(
				(capacityBuildingActivityDetail)-> {
					if(capacityBuildingActivityDetail != null) {
						capacityBuildingActivityDetail.setCapacityBuildingActivity(capacityActivity);
					}
				}
			);
		List<CapacityBuildingActivityDetails> CapacityBuildingActivityDetails2  = new ArrayList<>();
		for (CapacityBuildingActivityDetails capacityBuildingActivityDetails3 : capacityBuildingActivityDetails) {
			if(capacityBuildingActivityDetails3.getFunds() != null)
				CapacityBuildingActivityDetails2.add(capacityBuildingActivityDetails3);
			
		}
		
		capacityBuildingActivity.setCapacityBuildingActivityDetails(CapacityBuildingActivityDetails2);
		
		if(capacityBuildingActivity.getCbActivityId() == null || capacityBuildingActivity.getCbActivityId() == 0 ) {
			commonRepository.save(capacityBuildingActivity);
		}else {
			
					commonRepository.update(capacityBuildingActivity);
			}*/
			
		}

private void saveCapacityBuildingActivityAndDetailsForStateAndCec(CapacityBuildingActivity capacityBuildingActivity){
		
		capacityBuildingActivity= setCapacityBuildingActivityObject(capacityBuildingActivity);
		List<CapacityBuildingActivityDetails> capacityBuildingActivityDetails = capacityBuildingActivity.getCapacityBuildingActivityDetails();
		final CapacityBuildingActivity capacityActivity = capacityBuildingActivity;
		
		capacityBuildingActivityDetails.forEach(
				(capacityBuildingActivityDetail)-> {
					if(capacityBuildingActivityDetail != null) {
						capacityBuildingActivityDetail.setCapacityBuildingActivity(capacityActivity);
					}
				}
			);
		/*
		 * List<CapacityBuildingActivityDetails> CapacityBuildingActivityDetails2 = new
		 * ArrayList<>(); for (CapacityBuildingActivityDetails
		 * capacityBuildingActivityDetails3 : capacityBuildingActivityDetails) {
		 * if(capacityBuildingActivityDetails3.getFunds() != null){
		 * if(capacityBuildingActivityDetails3.getIsApproved() == null)
		 * capacityBuildingActivityDetails3.setIsApproved(false);
		 * CapacityBuildingActivityDetails2.add(capacityBuildingActivityDetails3);
		 * 
		 * } }
		 */
		
		capacityBuildingActivity.setCapacityBuildingActivityDetails(capacityBuildingActivityDetails);
		
		if(capacityBuildingActivity.getCbActivityId() == null || capacityBuildingActivity.getCbActivityId() == 0 ) {
			commonRepository.save(capacityBuildingActivity);
		}else {
			
					commonRepository.update(capacityBuildingActivity);
			}
			
		if(capacityBuildingActivity!=null && capacityBuildingActivity.getIsFreeze()==true && userPreference.getUserType().charAt(0)=='C') {
			facadeService.populateStateFunds("13");
		}
	}
	
	private void saveCapacityBuildingActivityAndDetailsForMopr(CapacityBuildingActivity capacityBuildingActivity){
		capacityBuildingActivity.setCbActivityId(null);
		
		/*capacityBuildingActivity = setCapacityBuildingActivityObject(capacityBuildingActivity);
		
		List<CapacityBuildingActivityDetails> capacityBuildingActivityDetails = capacityBuildingActivity.getCapacityBuildingActivityDetails();
		
		List<PesaPost> pesaPostList = fetchPesaPost();
		for (int i = 0; i < capacityBuildingActivityDetails.size(); i++) {
			if(capacityBuildingActivityDetails.get(i) != null) {
				capacityBuildingActivityDetails.get(i).setPesaPostId(pesaPostList.get(i).getPesaPostId());
			}
		}
		
		if(capacityBuildingActivity.getPesaPlanId() == null || capacityBuildingActivity.getPesaPlanId() == 0) {

			commonRepository.save(pesaPlan);
			
			for (PesaPlanDetails planDetails : pesaPlanDetails) {
				if(planDetails != null) {
					planDetails.setPesaPlanDetailsId(null);
					planDetails.setPesaPlanId(pesaPlan.getPesaPlanId());
					commonRepository.save(planDetails);
				}
			}
		}*/
		capacityBuildingActivity= setCapacityBuildingActivityObject(capacityBuildingActivity);
		List<CapacityBuildingActivityDetails> capacityBuildingActivityDetails = capacityBuildingActivity.getCapacityBuildingActivityDetails();
		final CapacityBuildingActivity capacityActivity = capacityBuildingActivity;
		
		capacityBuildingActivityDetails.forEach(
				(capacityBuildingActivityDetail)-> {
					if(capacityBuildingActivityDetail != null) {
						capacityBuildingActivityDetail.setCapacityBuildingActivity(capacityActivity);
					}
				}
			);
		List<CapacityBuildingActivityDetails> CapacityBuildingActivityDetails2  = new ArrayList<>();
		for (CapacityBuildingActivityDetails capacityBuildingActivityDetails3 : capacityBuildingActivityDetails) {
			if(capacityBuildingActivityDetails3.getFunds() != null){
				capacityBuildingActivityDetails3.setCapacityBuildingActivityDetailsId(null);
				CapacityBuildingActivityDetails2.add(capacityBuildingActivityDetails3);
			
		}
		}
		
		capacityBuildingActivity.setCapacityBuildingActivityDetails(CapacityBuildingActivityDetails2);
		
		if(capacityBuildingActivity.getCbActivityId() == null || capacityBuildingActivity.getCbActivityId() == 0 ) {
			commonRepository.save(capacityBuildingActivity);
		}else {
			
					commonRepository.update(capacityBuildingActivity);
			}
			
	}
	
	@Override
	public CapacityBuildingActivity feezUnFreezCapacityBuildingActivity(CapacityBuildingActivity capacityBuildingActivity) {
		capacityBuildingActivity = setCapacityBuildingActivityObject(capacityBuildingActivity);
		
		List<CapacityBuildingActivityDetails> capacityBuildingActivityDetails = capacityBuildingActivity.getCapacityBuildingActivityDetails();
		final CapacityBuildingActivity capacityActivity = capacityBuildingActivity;
		
		capacityBuildingActivityDetails.forEach(
				(capacityBuildingActivityDetail)-> {
					if(capacityBuildingActivityDetail != null) {
						capacityBuildingActivityDetail.setCapacityBuildingActivity(capacityActivity);
					}
				}
			);
		
		capacityBuildingActivity.setCapacityBuildingActivityDetails(capacityBuildingActivityDetails);
		
		commonRepository.update(capacityBuildingActivity);
		if(capacityBuildingActivity.getIsFreeze()) {
			facadeService.populateStateFunds("13");
		}
			
		return capacityBuildingActivity;
	}

	private CapacityBuildingActivity setCapacityBuildingActivityObject(CapacityBuildingActivity capacityBuildingActivity) {
		capacityBuildingActivity.setCreatedBy(userPreference.getUserId());
		capacityBuildingActivity.setLastUpdatedBy(userPreference.getUserId());
		capacityBuildingActivity.setStateCode(userPreference.getStateCode());
		capacityBuildingActivity.setUserType(userPreference.getUserType().charAt(0));
		capacityBuildingActivity.setVersionNo(userPreference.getPlanVersion());
		capacityBuildingActivity.setYearId(userPreference.getFinYearId());
		return capacityBuildingActivity;
	}
	
	@Override
	public Response saveCBFinalizeWorkLocaion(List<CapacityBuildingActivityGPs> capacityBuildingActivityGPsList) {
		Response response = new Response();
		Integer activityGPsId=null;
		//EntityTransaction tx=entityManager.getTransaction();
		//tx.begin();
		try {
			
			
			Set<Integer> activityDetailIdList = new HashSet<Integer>();
			for(CapacityBuildingActivityGPs obj:capacityBuildingActivityGPsList) {
				activityDetailIdList.add(obj.getCapacityBuildingActivityDetailsId());
			}
			
			Map<String, Object> params=new HashMap<String, Object>();
			Map<String, Integer> exitingObj=new HashMap<String, Integer>();
			params.put("activityDetailIdList", activityDetailIdList);
			List<CapacityBuildingActivityGPs>  capacityBuildingActivityGPsListOld= commonRepository.findAll("RESET_CB_ACTIVITY_GP", params);
			if(capacityBuildingActivityGPsListOld!=null && !capacityBuildingActivityGPsListOld.isEmpty()) {
				for(CapacityBuildingActivityGPs objold:capacityBuildingActivityGPsListOld) {
					if(!objold.isIsactive()) {
						exitingObj.put(objold.getCapacityBuildingActivityDetailsId()+"_"+objold.getLocalbodyCode(), objold.getCapacityBuildingActivityGPsId());
					}
					objold.setIsactive(Boolean.FALSE);
					commonRepository.update(objold);
				}
			}
				
			
			
		for(CapacityBuildingActivityGPs obj:capacityBuildingActivityGPsList) {
			activityGPsId=obj.getCapacityBuildingActivityGPsId();
			if(activityGPsId==null) {
				activityGPsId=exitingObj.get(obj.getCapacityBuildingActivityDetailsId()+"_"+obj.getLocalbodyCode());
			}
			obj.setIsactive(Boolean.TRUE);
			if(activityGPsId!=null) {
				obj.setCapacityBuildingActivityGPsId(activityGPsId);
				commonRepository.update(obj);
			}else {
				commonRepository.save(obj);
			}
		}
		response.setResponseMessage("GP of Training Activity save Successfully");
		response.setResponseCode(200);
		}catch(Exception e) {
			response.setResponseMessage("GP of Training Activity save UnSuccessfully"+e.getMessage());
			response.setResponseCode(500);
		}
		//tx.commit();
		return response;
	}
	
	public List<CapacityBuildingActivityGPs> fetchCapacityBuildingActivityGPsList(Integer capacityBuildingActivityDetailsId,Integer cbMasterId){
		Map<String, Object> params=new HashMap<String, Object>();
		params.put("capacityBuildingActivityDetailsId", capacityBuildingActivityDetailsId);
		params.put("cbMasterId", cbMasterId);
		List<CapacityBuildingActivityGPs>  capacityBuildingActivityGPsList= commonRepository.findAll("FIND_CB_ACTIVITY_GP", params);
		if(capacityBuildingActivityGPsList!=null && !capacityBuildingActivityGPsList.isEmpty()) {
			return capacityBuildingActivityGPsList;
		}
		return null;
	}
	
}
