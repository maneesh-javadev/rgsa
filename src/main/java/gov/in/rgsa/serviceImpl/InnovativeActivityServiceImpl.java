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
import gov.in.rgsa.entity.AttachmentMaster;
import gov.in.rgsa.entity.InnovativeActivity;
import gov.in.rgsa.entity.InnovativeActivityDetails;
import gov.in.rgsa.entity.QprEnablement;
import gov.in.rgsa.entity.QprEnablementDetails;
import gov.in.rgsa.entity.QprInnovativeActivity;
import gov.in.rgsa.entity.QprInnovativeActivityDetails;
import gov.in.rgsa.service.FacadeService;
import gov.in.rgsa.service.InnovativeActivityService;
import gov.in.rgsa.user.preference.UserPreference;

@Service
public class InnovativeActivityServiceImpl implements InnovativeActivityService {

	@PersistenceContext
	private EntityManager entityManager;
	@Autowired
	CommonRepository  commonRepository;
	@Autowired
	private UserPreference userPreference;
	
	@Autowired
	private FacadeService facadeService;
	
	@Override
	public void saveDetailsWithUsertype(InnovativeActivity activity) {
		if(userPreference.getUserType().equalsIgnoreCase('s'+"") || userPreference.getUserType().equalsIgnoreCase('c'+"")){
			saveInnovativeActivityDetailsForState(activity);
		}else{
			if(activity.getUserType().equals('S')){
				saveInnovativeActivityDetailsForMinistry(activity);
			}else{
				List<InnovativeActivityDetails> fetchInnovativeActivityDetails = activity.getInnovativeActivityDetails();
				InnovativeActivity innovativeActivity=activity;
				for (InnovativeActivityDetails innovativeActivityDetails : fetchInnovativeActivityDetails) {
					if(innovativeActivityDetails.getInnovativeActivity() == null){
					 innovativeActivityDetails.setInnovativeActivity(innovativeActivity);;
					}
				}
				activity.setLastUpdatedBy(userPreference.getUserId());
				activity.setStateCode(userPreference.getStateCode());
				activity.setYearId(userPreference.getFinYearId());
				activity.setIsFreeze(false);
				activity.setUserType(userPreference.getUserType().charAt(0));
				activity.setVersionId(userPreference.getPlanVersion());
				commonRepository.update(activity);
			}
		}
		
	}
	
	@Override
	public void saveInnovativeActivityDetailsForState(InnovativeActivity innocvativeActivity) {
		
		List<InnovativeActivityDetails> innocvativeActivityDetails =innocvativeActivity.getInnovativeActivityDetails();
		
		if(innocvativeActivity.getInnovativeActivityId()==null || innocvativeActivity.getInnovativeActivityId()==0) {	/*To Persist Data For the FIrst Time*/
			innocvativeActivity.setLastUpdatedBy(userPreference.getUserId());
			innocvativeActivity.setStateCode(userPreference.getStateCode());
			innocvativeActivity.setYearId(userPreference.getFinYearId());
			innocvativeActivity.setIsFreeze(false);
			innocvativeActivity.setUserType(userPreference.getUserType().charAt(0));
			innocvativeActivity.setVersionId(userPreference.getPlanVersion());
			
			for (InnovativeActivityDetails innovativeActivityDetails : innocvativeActivityDetails) {
				if(userPreference.getUserType().equalsIgnoreCase("C")){
					innovativeActivityDetails.setId(null);
				}
				innovativeActivityDetails.setInnovativeActivity(innocvativeActivity);
			}
			commonRepository.save(innocvativeActivity);
	}
		else {			/*To Update Data*/
			for (InnovativeActivityDetails innovativeActivityDetails : innocvativeActivityDetails) {
				innovativeActivityDetails.setInnovativeActivity(innocvativeActivity);
				}
		
			innocvativeActivity.setLastUpdatedBy(userPreference.getUserId());
			innocvativeActivity.setStateCode(userPreference.getStateCode());
			innocvativeActivity.setYearId(userPreference.getFinYearId());
			innocvativeActivity.setIsFreeze(false);
			innocvativeActivity.setUserType(userPreference.getUserType().charAt(0));
			innocvativeActivity.setVersionId(userPreference.getPlanVersion());
			
			commonRepository.update(innocvativeActivity);
		}
	}
	@Override
	public void saveInnovativeActivityDetailsForMinistry(InnovativeActivity innocvativeActivity) {
		
		List<InnovativeActivityDetails> innocvativeActivityDetails =innocvativeActivity.getInnovativeActivityDetails();
		
		/*To Persist Data For the FIrst Time*/
		    innocvativeActivity.setInnovativeActivityId(null);
			innocvativeActivity.setLastUpdatedBy(userPreference.getUserId());
			innocvativeActivity.setStateCode(userPreference.getStateCode());
			innocvativeActivity.setYearId(userPreference.getFinYearId());
			innocvativeActivity.setIsFreeze(false);
			innocvativeActivity.setUserType(userPreference.getUserType().charAt(0));
			innocvativeActivity.setVersionId(userPreference.getPlanVersion());
			
			for (InnovativeActivityDetails innovativeActivityDetails : innocvativeActivityDetails) {
				innovativeActivityDetails.setId(null);
				innovativeActivityDetails.setInnovativeActivity(innocvativeActivity);
			}
			commonRepository.save(innocvativeActivity);
	}
	
	@Override
	public void delete(int id) {
		List<InnovativeActivity> findAllActivity = findAllActivity(userPreference.getUserType().charAt(0));
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("id", id);
		if(findAllActivity.get(0).getInnovativeActivityDetails().size() > 1) {
		commonRepository.excuteUpdate("FETCH_INNOVATIVE_ACTIVITY_BY_ID", params);
		}
		else if(findAllActivity.get(0).getInnovativeActivityDetails().size() == 1)
		{
			commonRepository.excuteUpdate("FETCH_INNOVATIVE_ACTIVITY_BY_ID", params);
			Map<String, Object> param = new HashMap<String, Object>();
			param.put("innovativeActivityId", findAllActivity.get(0).getInnovativeActivityId());
			commonRepository.excuteUpdate("DELETE_INNOVATIVE_ACTIVITY", param);
		}
	}

	@Override
	public List<InnovativeActivity> findAllActivity(final Character userType) {
		List<InnovativeActivity> innovativeActivities = new ArrayList<>();
		Map<String, Object> params = new HashMap<String, Object>();
		if(userType == null){
			params.put("userType", userPreference.getUserType().charAt(0));
		}else{
			params.put("userType", userType);
		} 
		params.put("yearId", userPreference.getFinYearId());
		params.put("stateCode", userPreference.getStateCode());
		params.put("versionId", userPreference.getPlanVersion());
		innovativeActivities = commonRepository.findAll("FETCH_INNOVATIVE_ACTIVITY", params);
		if(!CollectionUtils.isEmpty(innovativeActivities) && innovativeActivities.size() >0) 
		{
			return innovativeActivities;
		}
		if(userPreference.getUserType().equalsIgnoreCase("M") && CollectionUtils.isEmpty(innovativeActivities)){
			params.put("userType", 'S');
			innovativeActivities= commonRepository.findAll("FETCH_INNOVATIVE_ACTIVITY", params);
			innovativeActivities.get(0).setIsFreeze(false);
			return innovativeActivities;
		}
		/*if(userPreference.getUserType().equalsIgnoreCase("C") && CollectionUtils.isEmpty(innovativeActivities)){
			params.put("userType", 'S');
			innovativeActivities= commonRepository.findAll("FETCH_INNOVATIVE_ACTIVITY", params);
			innovativeActivities.get(0).setIsFreeze(false);
			return innovativeActivities;
		}*/
		return null;
	}

	@Override
	public void freezeUnfreeze(InnovativeActivity innovativeActivity) {

		List<InnovativeActivityDetails> innocvativeActivityDetails =innovativeActivity.getInnovativeActivityDetails();
		for (InnovativeActivityDetails innovativeActivityDetails : innocvativeActivityDetails) {
			innovativeActivityDetails.setInnovativeActivity(innovativeActivity);
			}
		if(innovativeActivity.getDbFileName().contains("Frz")) {
			//innovativeActivity.setCreatedBy(userPreference.getUserId());
			innovativeActivity.setLastUpdatedBy(userPreference.getUserId());
			innovativeActivity.setStateCode(userPreference.getStateCode());
			innovativeActivity.setYearId(userPreference.getFinYearId());
			innovativeActivity.setVersionId(userPreference.getPlanVersion());
			innovativeActivity.setUserType(userPreference.getUserType().charAt(0));
			innovativeActivity.setIsFreeze(true);
			
		}
		else if(innovativeActivity.getDbFileName().contains("Unf")) {
			//innovativeActivity.setCreatedBy(userPreference.getUserId());
			innovativeActivity.setLastUpdatedBy(userPreference.getUserId());
			innovativeActivity.setStateCode(userPreference.getStateCode());
			innovativeActivity.setYearId(userPreference.getFinYearId());
			innovativeActivity.setIsFreeze(false);
			innovativeActivity.setUserType(userPreference.getUserType().charAt(0));
			innovativeActivity.setVersionId(userPreference.getPlanVersion());
			
		}
		
		
	commonRepository.update(innovativeActivity);
	if(innovativeActivity.getDbFileName()!=null && innovativeActivity.getDbFileName().length()>0 && innovativeActivity.getDbFileName().contains("Frz")) {
		facadeService.populateStateFunds("9");	
	}
	}
	
	
	@Override
	public AttachmentMaster findfilePath() {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("id", 1 );
		return commonRepository.find("FIND_FILE_PATH", params);
	}
	
	@Override
	public AttachmentMaster findfilePath(Integer id) {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("id", id );
		return commonRepository.find("FIND_FILE_PATH", params);
	}
	
	@Override
	public void update(InnovativeActivityDetails activityDetails) {
		// TODO Auto-generated method stub
		
	}
	
	@Override
	public List<InnovativeActivityDetails> findActivityById(Integer id) {
		// TODO Auto-generated method stub
		return null;
	}
	
	
	@Override
	public List<InnovativeActivityDetails> findByAcitvityName(String activityName) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<InnovativeActivity> fetchApprovedInnovative() {
		
		Map<String, Object> params=new HashMap<>();
		params.put("stateCode", userPreference.getStateCode());
		params.put("yearId", userPreference.getFinYearId());
		params.put("userType", 'C');
		return commonRepository.findAll("FETCH_INNOVATIVE_ACTIVITY_APPROVED_ACTIVITY", params);
	}

	@Override
	public List<QprInnovativeActivityDetails> getInnovativeQprActBasedOnActIdAndQtrId(Integer innovativeActivityId,
			int quarterId) {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("innovativeActivityId", innovativeActivityId);
		params.put("quarterId", quarterId);	
		List<QprInnovativeActivity> qprInnovativeActivity= commonRepository.findAll("FETCH_INNOVATIVE_QPR_ACT_BY_QTR_ID_AND_ACT_ID", params);
		List<QprInnovativeActivityDetails> qprInnovativeActivityDetails=new ArrayList<>();
		if(CollectionUtils.isNotEmpty(qprInnovativeActivity)){
			for (QprInnovativeActivity qpr_innovative : qprInnovativeActivity) {
				qprInnovativeActivityDetails.addAll(qpr_innovative.getQprInnovativeActivityDetails());
			}
			return qprInnovativeActivityDetails;
		}else{
			return null;
		}
	}
	
	
}
