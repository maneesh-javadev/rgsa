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
import gov.in.rgsa.entity.AdministrativeAndTechnicalStaffStatus;
import gov.in.rgsa.entity.AdministrativeAndTechnicalStaffStatusDetails;
import gov.in.rgsa.entity.PostLevel;
import gov.in.rgsa.entity.PostType;
import gov.in.rgsa.entity.SatcomActivity;
import gov.in.rgsa.service.AdminAndTechStatusService;
import gov.in.rgsa.user.preference.UserPreference;

@Service
public class AdminAndTechStatusServiceImpl implements AdminAndTechStatusService{
	
	@Autowired
	private CommonRepository commonRepository;
	
	@Autowired
	UserPreference userPreference;
	
	@PersistenceContext
	private EntityManager entityManager;

	@Override
	public AdministrativeAndTechnicalStaffStatus fetchAdministrativeTechnicalSupport() {
		List<AdministrativeAndTechnicalStaffStatus> administrativeAndTechnicalStaffStatus=null;
		Map<String, Object> params=new HashMap<String, Object>();
		params.put("stateCode", userPreference.getStateCode());
		params.put("userType", userPreference.getUserType());
		params.put("yearId", userPreference.getFinYearId());
		administrativeAndTechnicalStaffStatus=commonRepository.findAll("FETCH_ADMIN_TECH_STAFF_STATUS", params);
		if(!CollectionUtils.isEmpty(administrativeAndTechnicalStaffStatus) && administrativeAndTechnicalStaffStatus.size()>0){
			return administrativeAndTechnicalStaffStatus.get(0);
		}
		return null;
	}

	@Override
	public void saveAdminAndTechnicalStaffStatusAndDetails(AdministrativeAndTechnicalStaffStatus administrativeAndTechnicalStaffStatus) {
		administrativeAndTechnicalStaffStatus = setAdminAndTechStaffDetailsObj(administrativeAndTechnicalStaffStatus);
		List<AdministrativeAndTechnicalStaffStatusDetails> administrativeAndTechnicalStaffStatusDetails = administrativeAndTechnicalStaffStatus.getAdministrativeAndTechnicalStaffStatusDetails();
		final AdministrativeAndTechnicalStaffStatus adminAndTechnicalStaffStatus = administrativeAndTechnicalStaffStatus;
		administrativeAndTechnicalStaffStatusDetails.forEach(
			(administrativeAndTechnicalStaffStatusDetail)-> {
				if(administrativeAndTechnicalStaffStatusDetail != null) {
					administrativeAndTechnicalStaffStatusDetail.setPostType(fetchPostType(administrativeAndTechnicalStaffStatusDetail.getPostType().getPostId()));
					administrativeAndTechnicalStaffStatusDetail.setPostLevel(fetchPostLevel(administrativeAndTechnicalStaffStatusDetail.getPostLevel().getPostLevelId()));
					administrativeAndTechnicalStaffStatusDetail.setAdministrativeAndTechnicalStaffStatus(adminAndTechnicalStaffStatus);
				}
			}
		);
		administrativeAndTechnicalStaffStatus.setAdministrativeAndTechnicalStaffStatusDetails(administrativeAndTechnicalStaffStatusDetails);
		System.out.println(administrativeAndTechnicalStaffStatus);
		if(administrativeAndTechnicalStaffStatus.getAdministrativeAndTechnicalStaffStatusId()==null)
			commonRepository.save(administrativeAndTechnicalStaffStatus);
		else
			commonRepository.update(administrativeAndTechnicalStaffStatus);
	}

	private AdministrativeAndTechnicalStaffStatus setAdminAndTechStaffDetailsObj(AdministrativeAndTechnicalStaffStatus administrativeAndTechnicalStaffStatus) {
		administrativeAndTechnicalStaffStatus.setCreatedBy(userPreference.getUserId());
		administrativeAndTechnicalStaffStatus.setLastUpdatedBy(userPreference.getUserId());
		administrativeAndTechnicalStaffStatus.setStateCode(userPreference.getStateCode());
		administrativeAndTechnicalStaffStatus.setUserType(userPreference.getUserType());
		administrativeAndTechnicalStaffStatus.setYearId(userPreference.getFinYearId());
		return administrativeAndTechnicalStaffStatus;
	}
	
	private PostType fetchPostType(Integer postTypeId) {
		PostType postType = entityManager.find(PostType.class, postTypeId);
		return postType;
	}
	
	private PostLevel fetchPostLevel(Integer postLevelId) {
		PostLevel postLevel = entityManager.find(PostLevel.class, postLevelId);
		return postLevel;
	}

	@Override
	public AdministrativeAndTechnicalStaffStatus freezUnFreezAdminAndTechStaffStatus(AdministrativeAndTechnicalStaffStatus administrativeAndTechnicalStaffStatus) {
		administrativeAndTechnicalStaffStatus = setAdminAndTechStaffDetailsObj(administrativeAndTechnicalStaffStatus);
		Map<String, Object> params=new HashMap<String, Object>();
		params.put("isFreeze", administrativeAndTechnicalStaffStatus.getIsFreeze());
		params.put("id", administrativeAndTechnicalStaffStatus.getAdministrativeAndTechnicalStaffStatusId());
		commonRepository.excuteUpdate("UPDATE_STATUS", params);
		return administrativeAndTechnicalStaffStatus;
	}
	
	
}
