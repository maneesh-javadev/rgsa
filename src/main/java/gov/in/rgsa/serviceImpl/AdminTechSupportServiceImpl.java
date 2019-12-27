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
import gov.in.rgsa.entity.AdministrativeTechnicalDetailProgress;
import gov.in.rgsa.entity.AdministrativeTechnicalProgress;
import gov.in.rgsa.entity.AdministrativeTechnicalSupport;
import gov.in.rgsa.entity.AdministrativeTechnicalSupportDetails;
import gov.in.rgsa.entity.PmuProgress;
import gov.in.rgsa.entity.PmuProgressDetails;
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
				technicalSupport.setStatus(technicalSupport.getStatus());
				technicalSupport.setStateCode(userPreference.getStateCode());
				technicalSupport.setYearId(userPreference.getFinYearId());
				technicalSupport.setVersionNo(userPreference.getPlanVersion());
				technicalSupport.setUserType(userPreference.getUserType());
				technicalSupport.setCreatedBy(userPreference.getUserId());
				technicalSupport.setLastUpdatedBy(userPreference.getUserId());
				technicalSupport.setIsActive(Boolean.TRUE);
				/*technicalSupport.setStatus("S");*/
				
				List<AdministrativeTechnicalSupportDetails> supportDetails=technicalSupport.getSupportDetails();
				AdministrativeTechnicalSupport administrativeTechnicalSupport=technicalSupport;
			/*	List<PostType> postTypes = getTypeOfPost();
				int index = 0;*/
				for (AdministrativeTechnicalSupportDetails administrativeTechnicalSupportDetails : supportDetails) {
					if(administrativeTechnicalSupportDetails.getAdministrativeTechnicalSupport()==null){
						administrativeTechnicalSupportDetails.setAdministrativeTechnicalSupport(administrativeTechnicalSupport);
					/*	administrativeTechnicalSupportDetails.setPostType(postTypes.get(index));*/
					}
					/*index++;*/
				}
				commonRepository.update(technicalSupport);
				
			}
		}
		

		if(technicalSupport.getStatus()!=null && technicalSupport.getStatus().length()>0 && technicalSupport.getStatus().charAt(0)=='F') {
       	 facadeService.populateStateFunds("4");
        }
	}

	private void saveAdminTechSupportDetailsForMinistryAndCEC(AdministrativeTechnicalSupport technicalSupport){
		//support id null
		technicalSupport.setAdministrativeTechnicalSupportId(null);
		List<AdministrativeTechnicalSupportDetails> supportDetails=technicalSupport.getSupportDetails();
		AdministrativeTechnicalSupport administrativeTechnicalSupport=technicalSupport;
		administrativeTechnicalSupport.setStateCode(userPreference.getStateCode());
		administrativeTechnicalSupport.setYearId(userPreference.getFinYearId());
		administrativeTechnicalSupport.setVersionNo(userPreference.getPlanVersion());
		administrativeTechnicalSupport.setUserType(userPreference.getUserType());
		administrativeTechnicalSupport.setCreatedBy(userPreference.getUserId());
		administrativeTechnicalSupport.setLastUpdatedBy(userPreference.getUserId());
		administrativeTechnicalSupport.setStatus(technicalSupport.getStatus());
		administrativeTechnicalSupport.setIsActive(Boolean.TRUE);
	

		
		List<PostType> postTypes = getTypeOfPost();
		/*int index = 0;*/
		for (AdministrativeTechnicalSupportDetails administrativeTechnicalSupportDetails : supportDetails) {
			//detail Id null
			if(administrativeTechnicalSupport!=null) {
				 //administrativeTechnicalSupportDetails=new AdministrativeTechnicalSupportDetails();
			
			administrativeTechnicalSupportDetails.setId(null);
			administrativeTechnicalSupportDetails.setAdministrativeTechnicalSupport(administrativeTechnicalSupport);
	}
			}
 		commonRepository.save(administrativeTechnicalSupport);
		
	}
	
	private void saveAdminTechSupportDetailsForState(AdministrativeTechnicalSupport technicalSupport){
		List<AdministrativeTechnicalSupportDetails> supportDetails=technicalSupport.getSupportDetails();
		AdministrativeTechnicalSupport administrativeTechnicalSupport=technicalSupport;
		if(technicalSupport.getAdministrativeTechnicalSupportId()==null || technicalSupport.getAdministrativeTechnicalSupportId()==0){
			
			administrativeTechnicalSupport.setStateCode(userPreference.getStateCode());
			administrativeTechnicalSupport.setYearId(userPreference.getFinYearId());
			administrativeTechnicalSupport.setVersionNo(userPreference.getPlanVersion());
			administrativeTechnicalSupport.setUserType(userPreference.getUserType());
			administrativeTechnicalSupport.setCreatedBy(userPreference.getUserId());
			administrativeTechnicalSupport.setLastUpdatedBy(userPreference.getUserId());
			administrativeTechnicalSupport.setIsActive(Boolean.TRUE);
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
	params.put("versionNo", userPreference.getPlanVersion());
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
		if(CollectionUtils.isNotEmpty(administrativeTechnicalSupport)) {
			administrativeTechnicalSupport.get(0).setStatus("U");
			return administrativeTechnicalSupport.get(0);
		}
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
		params.put("userType", "C");
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
			administrativeTechnicalSupport1.setVersionNo(administrativeTechnicalSupport.getVersionNo());
			administrativeTechnicalSupport1.setIsActive(administrativeTechnicalSupport.getIsActive());
		

		if(administrativeTechnicalSupport.getDbFileName().equals("F"))
		{
			administrativeTechnicalSupport1.setStatus("F");
			administrativeTechnicalSupport1.setAdministrativeTechnicalSupportId(administrativeTechnicalSupport.getAdministrativeTechnicalSupportId());
			commonRepository.update(administrativeTechnicalSupport1);
		}
		else if(administrativeTechnicalSupport.getDbFileName().equals("U") || administrativeTechnicalSupport.getDbFileName().equals("U")){
			administrativeTechnicalSupport1.setStatus(administrativeTechnicalSupport.getDbFileName());
			administrativeTechnicalSupport1.setAdministrativeTechnicalSupportId(administrativeTechnicalSupport.getAdministrativeTechnicalSupportId());
			commonRepository.update(administrativeTechnicalSupport1);
		}
		
	}
		
		if(administrativeTechnicalSupport.getDbFileName().equals("F")) {
			facadeService.populateStateFunds("4");
		}
		
	}

	@Override
	public List<AdministrativeTechnicalDetailProgress> getadminTechProgressActBasedOnActIdAndQtrId(
			Integer administrativeTechnicalSupportId, int quarterId) {
		Map<String, Object> params = new HashMap();
		params.put("administrativeTechnicalSupportId", administrativeTechnicalSupportId);
		params.put("quarterId", quarterId);	
		List<AdministrativeTechnicalProgress> adminTechProgress= commonRepository.findAll("FETCH_ADMIN_TECH_ACT_QTR_ID_AND_ACT_ID", params);
		List<AdministrativeTechnicalDetailProgress> adminTechProgressDetails=new ArrayList<>();
		if(CollectionUtils.isNotEmpty(adminTechProgress)){
			for (AdministrativeTechnicalProgress admin_tech_Progress : adminTechProgress) {
				adminTechProgressDetails.addAll(admin_tech_Progress.getAdministrativeTechnicalDetailProgress());
			}
			return adminTechProgressDetails;
		}else{
			return null;
		}
	}

	@Override
	public Integer getExpenditureDetailsOfQpr(Integer administrativeTechnicalSupportId, int quarterId) {
		 Integer data=null;
		 String sum =null;
			try {
			   StringBuilder  query=new StringBuilder();
			   query.append("select sum(expenditure_incurred) from rgsa.qpr_ats qa inner join rgsa.qpr_ats_details qad  on qa.qpr_ats_id=qad.qpr_ats_id");
			 	   query.append(" where qa.qtr_id !="+quarterId+" ");
			 	  query.append(" and qa.administrative_technical_support_id= "+administrativeTechnicalSupportId+" ");
			 	  
			  List<Object> list= commonRepository.findAllByNativeQuery(query.toString(), null);
			  if( list.get(0)!=null && !"null".equals(list.get(0)) )
			  {
				  sum= String.valueOf(list.get(0));
				  data =Integer.valueOf(sum);
			  }else {
				  data=0;
			  }
			  
			 
				 
			}catch(Exception e) {e.printStackTrace(); }
			
			return data;
		}

	}

