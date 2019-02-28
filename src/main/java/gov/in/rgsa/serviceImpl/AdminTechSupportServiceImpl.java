package gov.in.rgsa.serviceImpl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

import org.apache.commons.collections.CollectionUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import gov.in.rgsa.dao.CommonRepository;
import gov.in.rgsa.entity.AdministrativeTechnicalSupport;
import gov.in.rgsa.entity.AdministrativeTechnicalSupportDetails;
import gov.in.rgsa.entity.PostLevel;
import gov.in.rgsa.entity.PostType;
import gov.in.rgsa.service.AdminTechSupportService;
import gov.in.rgsa.service.FacadeService;
import gov.in.rgsa.user.preference.UserPreference;

@Service
public class AdminTechSupportServiceImpl implements AdminTechSupportService{
	
	@Autowired
	private CommonRepository commonRepository;
	
	@Autowired
	UserPreference userPreference;
	
	@PersistenceContext
	private EntityManager entityManager;
	

	@Autowired
	private FacadeService facadeService;
	
	@Override
	public List<PostType> getTypeOfPost() {
		return commonRepository.findAll("POST_TYPE_LIST", null);
	}

	@Override
	public void saveAdminTechSupportDetails(AdministrativeTechnicalSupport technicalSupport) {
		
	
		if(userPreference.getUserType().equalsIgnoreCase('s'+"")){
			saveAdminTechSupportDetailsForState(technicalSupport);
		}else{
			if(technicalSupport.getUserType().equalsIgnoreCase("s")){
				saveAdminTechSupportDetailsForMinistryAndCEC(technicalSupport);
			}else{
				technicalSupport.setStatus("S");
				technicalSupport.setStateCode(userPreference.getStateCode());
				technicalSupport.setYearId(userPreference.getFinYearId());
				technicalSupport.setVersionNo(1);
				technicalSupport.setUserType(userPreference.getUserType());
				technicalSupport.setCreatedBy(userPreference.getUserId());
				technicalSupport.setLastUpdatedBy(userPreference.getUserId());
				technicalSupport.setStatus("S");
				
				List<AdministrativeTechnicalSupportDetails> supportDetails=technicalSupport.getSupportDetails();
				AdministrativeTechnicalSupport administrativeTechnicalSupport=technicalSupport;
				List<PostType> postTypes = getTypeOfPost();
				int index = 0;
				for (AdministrativeTechnicalSupportDetails administrativeTechnicalSupportDetails : supportDetails) {
					if(administrativeTechnicalSupportDetails.getAdministrativeTechnicalSupport()==null){
						administrativeTechnicalSupportDetails.setAdministrativeTechnicalSupport(administrativeTechnicalSupport);
						administrativeTechnicalSupportDetails.setPostType(postTypes.get(index));
					}
					index++;
				}
				commonRepository.update(technicalSupport);
				
			}
		}
		

		facadeService.populateStateFunds("4");
	}

	private void saveAdminTechSupportDetailsForMinistryAndCEC(AdministrativeTechnicalSupport technicalSupport){
		//support id null
		technicalSupport.setAdministrativeTechnicalSupportId(null);
		List<AdministrativeTechnicalSupportDetails> supportDetails=technicalSupport.getSupportDetails();
		AdministrativeTechnicalSupport administrativeTechnicalSupport=technicalSupport;
		administrativeTechnicalSupport.setStateCode(userPreference.getStateCode());
		administrativeTechnicalSupport.setYearId(userPreference.getFinYearId());
		administrativeTechnicalSupport.setVersionNo(1);
		administrativeTechnicalSupport.setUserType(userPreference.getUserType());
		administrativeTechnicalSupport.setCreatedBy(userPreference.getUserId());
		administrativeTechnicalSupport.setLastUpdatedBy(userPreference.getUserId());
		administrativeTechnicalSupport.setStatus("S");
	
		
		List<PostType> postTypes = getTypeOfPost();
		/*int index = 0;*/
		for (AdministrativeTechnicalSupportDetails administrativeTechnicalSupportDetails : supportDetails) {
			//detail Id null
			if(administrativeTechnicalSupport!=null) {
				 administrativeTechnicalSupportDetails=new AdministrativeTechnicalSupportDetails();
			}
			administrativeTechnicalSupportDetails.setId(null);
			administrativeTechnicalSupportDetails.setAdministrativeTechnicalSupport(administrativeTechnicalSupport);
/*			administrativeTechnicalSupportDetails.setPostType(postTypes.get(index));
*/			
/*			index++;
*/		}
 		commonRepository.save(administrativeTechnicalSupport);
		
	}
	
	private void saveAdminTechSupportDetailsForState(AdministrativeTechnicalSupport technicalSupport){
		List<AdministrativeTechnicalSupportDetails> supportDetails=technicalSupport.getSupportDetails();
		AdministrativeTechnicalSupport administrativeTechnicalSupport=technicalSupport;
		if(technicalSupport.getAdministrativeTechnicalSupportId()==null || technicalSupport.getAdministrativeTechnicalSupportId()==0){
			
			administrativeTechnicalSupport.setStateCode(userPreference.getStateCode());
			administrativeTechnicalSupport.setYearId(userPreference.getFinYearId());
			administrativeTechnicalSupport.setVersionNo(1);
			administrativeTechnicalSupport.setUserType(userPreference.getUserType());
			administrativeTechnicalSupport.setCreatedBy(userPreference.getUserId());
			administrativeTechnicalSupport.setLastUpdatedBy(userPreference.getUserId());
/*			List<PostType> postTypes = getTypeOfPost();
*/			
			/*int index = 0;*/
			for (AdministrativeTechnicalSupportDetails administrativeTechnicalSupportDetails : supportDetails) {
				
				
				if(administrativeTechnicalSupportDetails!=null) {
/*					administrativeTechnicalSupportDetails.setPostType(postTypes.get(index));	
*/				administrativeTechnicalSupportDetails.setAdministrativeTechnicalSupport(administrativeTechnicalSupport);
				}else {
					administrativeTechnicalSupportDetails=new AdministrativeTechnicalSupportDetails();
/*					administrativeTechnicalSupportDetails.setPostType(postTypes.get(index));	
*/					administrativeTechnicalSupportDetails.setAdministrativeTechnicalSupport(administrativeTechnicalSupport);
/*					supportDetails.set(index, administrativeTechnicalSupportDetails);
*/				}
/*				index++;
*/				
			}
	 		commonRepository.save(administrativeTechnicalSupport);
		}
		else{
			List<PostType> postTypes = getTypeOfPost();
			/*int index = 0;*/
			for (AdministrativeTechnicalSupportDetails administrativeTechnicalSupportDetails : supportDetails) {
				if(administrativeTechnicalSupportDetails!=null) {
/*					administrativeTechnicalSupportDetails.setPostType(postTypes.get(index));
*/					if(administrativeTechnicalSupportDetails.getAdministrativeTechnicalSupport()==null){
					administrativeTechnicalSupportDetails.setAdministrativeTechnicalSupport(administrativeTechnicalSupport);
						
				}
				}else {
					administrativeTechnicalSupportDetails=new AdministrativeTechnicalSupportDetails();
/*					administrativeTechnicalSupportDetails.setPostType(postTypes.get(index));
*/					if(administrativeTechnicalSupportDetails.getAdministrativeTechnicalSupport()==null){
					administrativeTechnicalSupportDetails.setAdministrativeTechnicalSupport(administrativeTechnicalSupport);
			}
/*					supportDetails.set(index, administrativeTechnicalSupportDetails);
*/					
				}
				
				
/*				index++;
*/			}
			commonRepository.update(technicalSupport);
		}
	}
	
	@Override
public AdministrativeTechnicalSupport fetchAdministrativeTechnicalSupport(final String userType) {
	List<AdministrativeTechnicalSupport> administrativeTechnicalSupport=null;
	Map<String, Object> params=new HashMap<String, Object>();
	params.put("stateCode", userPreference.getStateCode());
	params.put("yearId", userPreference.getFinYearId());
	if(userType == null){
		params.put("userType", userPreference.getUserType());
	}else{
		params.put("userType", userType);
	}

	administrativeTechnicalSupport=commonRepository.findAll("FETCH_ADMIN_TECH_SUPPORT", params);
	if(!CollectionUtils.isEmpty(administrativeTechnicalSupport) && administrativeTechnicalSupport.size()>0){
		return administrativeTechnicalSupport.get(0);
	}
	
	if(userPreference.getUserType().equalsIgnoreCase("M") && CollectionUtils.isEmpty(administrativeTechnicalSupport)){
		params.put("userType", "S");
		administrativeTechnicalSupport=commonRepository.findAll("FETCH_ADMIN_TECH_SUPPORT", params);
		if(CollectionUtils.isNotEmpty(administrativeTechnicalSupport))
		return administrativeTechnicalSupport.get(0);
	}
	/*if(userPreference.getUserType().equalsIgnoreCase("C") && CollectionUtils.isEmpty(administrativeTechnicalSupport)){
		params.put("userType", "S");
		administrativeTechnicalSupport=commonRepository.findAll("FETCH_ADMIN_TECH_SUPPORT", params);
		
		if(CollectionUtils.isNotEmpty(administrativeTechnicalSupport))
		return administrativeTechnicalSupport.get(0);
	}*/
	return null;
}


	@Override
	public List<PostLevel> fetchAdministrativeLevel() {
		return commonRepository.findAll("ADINISTRATIVE_LEVELS", null);
	}

	@Override
	public List<AdministrativeTechnicalSupport> getApprovedSatcomActivity() {
		Map<String,Object> params = new HashMap<>();
		params.put("yearId", userPreference.getFinYearId());
		params.put("stateCode", userPreference.getStateCode());
		params.put("userType", userPreference.getUserType());
		List<AdministrativeTechnicalSupport> AdminTechnicalSupport = commonRepository.findAll("GET_Admin_Technical_Support_APPROVED_TRAINING", params);
		return AdminTechnicalSupport;
	}

	@Override
	public void freezeAndUnfreeze(AdministrativeTechnicalSupport administrativeTechnicalSupport) {
		if (administrativeTechnicalSupport.getAdministrativeTechnicalSupportId() != null || administrativeTechnicalSupport.getAdministrativeTechnicalSupportId() != 0) {
			AdministrativeTechnicalSupport administrativeTechnicalSupport1 = new AdministrativeTechnicalSupport();
			administrativeTechnicalSupport1.setStateCode(userPreference.getStateCode());
			administrativeTechnicalSupport1.setYearId(userPreference.getFinYearId());
			administrativeTechnicalSupport1.setCreatedBy(userPreference.getUserId());
			administrativeTechnicalSupport1.setAdditionalRequirement(administrativeTechnicalSupport.getAdditionalRequirement());
			administrativeTechnicalSupport1.setUserType(userPreference.getUserType());
			administrativeTechnicalSupport1.setLastUpdatedBy(userPreference.getUserId());
		

		if(administrativeTechnicalSupport.getDbFileName().equals("F"))
		{
			administrativeTechnicalSupport1.setStatus("F");
			administrativeTechnicalSupport1.setAdministrativeTechnicalSupportId(administrativeTechnicalSupport.getAdministrativeTechnicalSupportId());
			commonRepository.update(administrativeTechnicalSupport1);
		}
		else if(administrativeTechnicalSupport.getDbFileName().equals("UF")){
			administrativeTechnicalSupport1.setStatus("UF");
			administrativeTechnicalSupport1.setAdministrativeTechnicalSupportId(administrativeTechnicalSupport.getAdministrativeTechnicalSupportId());
			commonRepository.update(administrativeTechnicalSupport1);
		}
		
	}
	}
}
