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
import gov.in.rgsa.entity.AttachmentMaster;
import gov.in.rgsa.entity.IncomeEnhancementActivity;
import gov.in.rgsa.entity.IncomeEnhancementDetails;
import gov.in.rgsa.entity.InnovativeActivity;
import gov.in.rgsa.entity.InnovativeActivityDetails;
import gov.in.rgsa.entity.SchemeMaster;
import gov.in.rgsa.service.FacadeService;
import gov.in.rgsa.service.IncomeEnhancementService;
import gov.in.rgsa.user.preference.UserPreference;

/**
 * @author Mohammad Ayaz
 *
 */
@Service
public class IncomeEnhancementServiceImpl implements IncomeEnhancementService {

	@PersistenceContext
	private EntityManager entityManager;
	@Autowired
	CommonRepository  commonRepository;
	@Autowired
	private UserPreference userPreference;
	
	@Autowired
	private FacadeService facadeService;
	
	
	@Override
	public List<SchemeMaster> schemeMasterList() {
		Query query = entityManager.createNamedQuery("FETCH_SCHEME_MASTER");
		return query.getResultList();
	}

	@Override
	public void saveDetailsWithUsertype(IncomeEnhancementActivity enhancementActivity) {
		if(userPreference.getUserType().equalsIgnoreCase('s'+"") || userPreference.getUserType().equalsIgnoreCase("c")){
			update(enhancementActivity);
		}else{
			if(enhancementActivity.getUserType().equals('S')){
				saveEnhancementActivityMinistry(enhancementActivity);
			}else{
				List<IncomeEnhancementDetails> fetchIncomeEnhancementDetails = enhancementActivity.getIncomeEnhancementDetails();
				for (IncomeEnhancementDetails incomeEnhancementDetails : fetchIncomeEnhancementDetails) {
					if(incomeEnhancementDetails.getIncomeEnhancementActivity() == null){
						incomeEnhancementDetails.setIncomeEnhancementActivity(enhancementActivity);
					}
				}
				enhancementActivity.setLastUpdatedBy(userPreference.getUserId());
				enhancementActivity.setStateCode(userPreference.getStateCode());
				enhancementActivity.setYearId(userPreference.getFinYearId());
				enhancementActivity.setIsFreeze(false);
				enhancementActivity.setUserType(userPreference.getUserType().charAt(0));
				enhancementActivity.setVersionNo(1);
				commonRepository.update(enhancementActivity);
			}
		}
		
	}
	
	private void saveEnhancementActivityMinistry(IncomeEnhancementActivity enhancementActivity) {
		List<IncomeEnhancementDetails> enhancementDetailsList = enhancementActivity.getIncomeEnhancementDetails();
		 
		enhancementActivity.setIncomeEnhancementId(null);
		enhancementActivity.setCreatedBy(userPreference.getUserId());
		enhancementActivity.setIsFreeze(false);
		enhancementActivity.setLastUpdatedBy(userPreference.getUserId());
		enhancementActivity.setStateCode(userPreference.getStateCode());
		enhancementActivity.setUserType(userPreference.getUserType().charAt(0));
		enhancementActivity.setVersionNo(1);
		enhancementActivity.setYearId(userPreference.getFinYearId());
		
		for(IncomeEnhancementDetails details :enhancementDetailsList) {
			details.setIsActive(true);
			details.setIncomeEnhancementDetailsId(null);
			details.setIncomeEnhancementActivity(enhancementActivity);
		}
		commonRepository.save(enhancementActivity);
	}

	@Override
	public void update(IncomeEnhancementActivity enhancementActivity) {
		
		 List<IncomeEnhancementDetails> enhancementDetailsList = enhancementActivity.getIncomeEnhancementDetails();
		 
		enhancementActivity.setCreatedBy(userPreference.getUserId());
		enhancementActivity.setIsFreeze(false);
		enhancementActivity.setLastUpdatedBy(userPreference.getUserId());
		enhancementActivity.setStateCode(userPreference.getStateCode());
		enhancementActivity.setUserType(userPreference.getUserType().charAt(0));
		enhancementActivity.setVersionNo(1);
		enhancementActivity.setYearId(userPreference.getFinYearId());
		
		for(IncomeEnhancementDetails details :enhancementDetailsList) {
			details.setIsActive(true);
			if(enhancementActivity.getIncomeEnhancementId() == null){
				details.setIncomeEnhancementDetailsId(null);
			}
			details.setIncomeEnhancementActivity(enhancementActivity);
		}
		commonRepository.update(enhancementActivity);
	}

	@Override
	public AttachmentMaster findDetailsofAttachmentMaster() {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("id", 1 );
		return commonRepository.find("FIND_FILE_PATH", params);
	}

	@Override
	public List<IncomeEnhancementActivity> fetchAllIncmEnhncmntActvty(final Character userType) {
		List<IncomeEnhancementActivity> enhancementActivities = new ArrayList<>();
		Map<String, Object> params = new HashMap<>();
		
		params.put("stateCode", userPreference.getStateCode());
		params.put("yearId", userPreference.getFinYearId());
		if(userType == null) {
		params.put("userType", userPreference.getUserType().charAt(0));
		} else {
			params.put("userType", userType);
		}
		enhancementActivities = commonRepository.findAll("FETCH_ALL_INCOME_ENHNCMNT_ACTIVITY", params);
		if(!CollectionUtils.isEmpty(enhancementActivities) && enhancementActivities.size() >0) 
		{
			return enhancementActivities;
		}
		if(userPreference.getUserType().equalsIgnoreCase("M") && CollectionUtils.isEmpty(enhancementActivities)){
			params.put("userType", 'S');
			enhancementActivities= commonRepository.findAll("FETCH_ALL_INCOME_ENHNCMNT_ACTIVITY", params);
			if(enhancementActivities!=null && !enhancementActivities.isEmpty()) {
				enhancementActivities.get(0).setIsFreeze(false);
					
			}
			return enhancementActivities;
		}
		return enhancementActivities;
	}

	@Override
	public void FrzUnfrz(IncomeEnhancementActivity incomeEnhancementActivity) {
		Map<String,Object> params = new HashMap<>();
		if(incomeEnhancementActivity.getIsFreeze() == true) {
		params.put("isFreeze", false);}
		else if(incomeEnhancementActivity.getIsFreeze() == false) {
			params.put("isFreeze", true);}
		params.put("incomeEnhancementId", incomeEnhancementActivity.getIncomeEnhancementId());
		commonRepository.excuteUpdate("UPDATE_FRZUNFREEZ_STATUS", params);
		 if(incomeEnhancementActivity.getIsFreeze() == false) {
		   facadeService.populateStateFunds("10");
		 }
	}

	@Override
	public void deleteIncmEnhncmntDtls(int id) {
		List<IncomeEnhancementActivity> findAllActivity = fetchAllIncmEnhncmntActvty(userPreference.getUserType().charAt(0));
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("incomeEnhancementDetailsId", id);
		if(findAllActivity.get(0).getIncomeEnhancementDetails().size() > 1) {
		commonRepository.excuteUpdate("DELETE_INCM_ENHNCMNT_DETAILS_BY_ID", params);
		}
		else if(findAllActivity.get(0).getIncomeEnhancementDetails().size() == 1)
		{
			commonRepository.excuteUpdate("DELETE_INCM_ENHNCMNT_DETAILS_BY_ID", params);
			Map<String, Object> param = new HashMap<String, Object>();
			param.put("incomeEnhancementId", findAllActivity.get(0).getIncomeEnhancementId());
			commonRepository.excuteUpdate("DELETE_INCM_ENHNCMNT_ACTIVITY", param);
		}
	}
	
}
