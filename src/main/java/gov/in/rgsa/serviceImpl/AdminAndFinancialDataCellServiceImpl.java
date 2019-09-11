package gov.in.rgsa.serviceImpl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.collections.CollectionUtils;
import org.apache.tiles.request.collection.CollectionUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import gov.in.rgsa.dao.CommonRepository;
import gov.in.rgsa.entity.AdminAndFinancialDataActivity;
import gov.in.rgsa.entity.AdminFinancialDataCellActivityDetails;
import gov.in.rgsa.entity.PmuProgress;
import gov.in.rgsa.entity.PmuProgressDetails;
import gov.in.rgsa.entity.QprAdminAndFinancialDataActivity;
import gov.in.rgsa.entity.QprAdminAndFinancialDataActivityDetails;
import gov.in.rgsa.service.AdminAndFinancialDataCellService;
import gov.in.rgsa.service.FacadeService;
import gov.in.rgsa.user.preference.UserPreference;

@Service
public class AdminAndFinancialDataCellServiceImpl implements AdminAndFinancialDataCellService{
	
	@Autowired
	private UserPreference userPreference;
	
	@Autowired
	private FacadeService facadeService;
	
	@Autowired
	private CommonRepository commonRepository;
 
	@Override
	public void saveData(AdminAndFinancialDataActivity adminAndFinancialDataActivity) {
		String userType=adminAndFinancialDataActivity.getUserType();
		adminAndFinancialDataActivity=setObjectForActivity(adminAndFinancialDataActivity);
		if(userPreference.getUserType().equals("S")){
		     adminAndFinancialDataActivity=setdetailsForActivity(adminAndFinancialDataActivity);
		}else{
			if((userPreference.getUserType().equals("M") || userPreference.getUserType().equals("C"))  && userType.equals("S")){
				adminAndFinancialDataActivity.setAdminFinancialDataActivityId(null);
				adminAndFinancialDataActivity=setdetailsForActivityForMopr(adminAndFinancialDataActivity);
			}else{
				 adminAndFinancialDataActivity=setdetailsForActivity(adminAndFinancialDataActivity);
			}
		}
     if(adminAndFinancialDataActivity.getAdminFinancialDataActivityId() == null || adminAndFinancialDataActivity.getAdminFinancialDataActivityId() == 0){
    	 commonRepository.save(adminAndFinancialDataActivity);
     }else{
    	 commonRepository.update(adminAndFinancialDataActivity);
     }

     if(adminAndFinancialDataActivity.getIsFreeze()!=null && adminAndFinancialDataActivity.getIsFreeze()) {
    	 facadeService.populateStateFunds("8"); 
     }
	
	}

	private AdminAndFinancialDataActivity setdetailsForActivityForMopr(AdminAndFinancialDataActivity adminAndFinancialDataActivity) {
		List<AdminFinancialDataCellActivityDetails> adminFinancialDataCellActivityDetails=new ArrayList<>();
		adminFinancialDataCellActivityDetails=adminAndFinancialDataActivity.getAdminFinancialDataCellActivityDetails();
		for (AdminFinancialDataCellActivityDetails details : adminFinancialDataCellActivityDetails) {
			details.setAdminFinancialDataActivityDetailId(null);
			details.setAdminAndFinancialDataActivity(adminAndFinancialDataActivity);
		}
		adminAndFinancialDataActivity.setAdminFinancialDataCellActivityDetails(adminFinancialDataCellActivityDetails);
		return adminAndFinancialDataActivity;
	}

	private AdminAndFinancialDataActivity setdetailsForActivity(AdminAndFinancialDataActivity adminAndFinancialDataActivity) {
		List<AdminFinancialDataCellActivityDetails> adminFinancialDataCellActivityDetails=new ArrayList<>();
		adminFinancialDataCellActivityDetails=adminAndFinancialDataActivity.getAdminFinancialDataCellActivityDetails();
		for (AdminFinancialDataCellActivityDetails details : adminFinancialDataCellActivityDetails) {
			details.setAdminAndFinancialDataActivity(adminAndFinancialDataActivity);
		}
		adminAndFinancialDataActivity.setAdminFinancialDataCellActivityDetails(adminFinancialDataCellActivityDetails);
		return adminAndFinancialDataActivity;
	}

	private AdminAndFinancialDataActivity setObjectForActivity(AdminAndFinancialDataActivity adminAndFinancialDataActivity) {
		adminAndFinancialDataActivity.setStateCode(userPreference.getStateCode());
		adminAndFinancialDataActivity.setYearId(userPreference.getFinYearId());
		adminAndFinancialDataActivity.setUserType(userPreference.getUserType());
		adminAndFinancialDataActivity.setCreatedBy(userPreference.getUserId());
		adminAndFinancialDataActivity.setLastUpdatedBy(userPreference.getUserId());
		adminAndFinancialDataActivity.setLastUpdatedBy(userPreference.getPlanVersion());
	return 	adminAndFinancialDataActivity;
	}

	@Override
	public List<AdminAndFinancialDataActivity> fetchAdminAndFinancialActivity(final String userType) {
		Map<String,Object> params=new HashMap<>();
		List<AdminAndFinancialDataActivity> adminAndFinancialDataActivity=new ArrayList<>();
		params.put("stateCode", userPreference.getStateCode());
		params.put("yearId", userPreference.getFinYearId());
		params.put("userType",userType);
		adminAndFinancialDataActivity = commonRepository.findAll("FETCH_ADMIN_FIN_DATA_ACTIVITY", params);
		if(userPreference.getUserType().equals("M") && CollectionUtils.isEmpty(adminAndFinancialDataActivity)){
			params.put("userType", "S");
			adminAndFinancialDataActivity = commonRepository.findAll("FETCH_ADMIN_FIN_DATA_ACTIVITY", params);
			if(adminAndFinancialDataActivity.get(0).getUserType().equalsIgnoreCase("S") && adminAndFinancialDataActivity.get(0).getIsFreeze()==true){
				adminAndFinancialDataActivity.get(0).setIsFreeze(false);
			}
		}
		if(!CollectionUtils.isEmpty(adminAndFinancialDataActivity) && adminAndFinancialDataActivity.size()>0){
			return adminAndFinancialDataActivity;
		}
		return adminAndFinancialDataActivity;
	}
	
	@Override
	public List<AdminFinancialDataCellActivityDetails> fetchAdminAndFinancialDetails(Integer adminFinancialDataActivityId) {
		Map<String,Object> params=new HashMap<>();
		params.put("adminFinancialDataActivityId",adminFinancialDataActivityId);
		return commonRepository.findAll("FETCH_ADMIN_FIN_DATA_DETAILS", params);
	}

	@Override
	public List<AdminAndFinancialDataActivity> fetchApprovedActivity() {
		Map<String, Object> params=new HashMap<>();
		params.put("stateCode", userPreference.getStateCode());
		params.put("userType", "C");
		params.put("yearId", userPreference.getFinYearId());
		return commonRepository.findAll("FETCH_APPROVED_ACTIVITY", params);
	}

	@Override
	public List<QprAdminAndFinancialDataActivityDetails> getPmuProgressActBasedOnActIdAndQtrId(
			Integer adminFinancialDataActivityId, int quarterId) {
		Map<String, Object> params = new HashMap();
		params.put("adminFinancialDataActivityId", adminFinancialDataActivityId);
		params.put("quarterId", quarterId);	
		List<QprAdminAndFinancialDataActivity> adminFinCellProgress= commonRepository.findAll("FETCH_ADMIN_FIN_CELL_QPR_ACT_BY_QTR_ID_AND_ACT_ID", params);
		List<QprAdminAndFinancialDataActivityDetails> adminFinCellProgressDetails=new ArrayList<>();
		if(CollectionUtils.isNotEmpty(adminFinCellProgress)){
			for (QprAdminAndFinancialDataActivity adminFinCell_Progress : adminFinCellProgress) {
				adminFinCellProgressDetails.addAll(adminFinCell_Progress.getQprAdminAndFinancialDataActivityDetails());
			}
			return adminFinCellProgressDetails;
		}else{
			return null;
		}
	}

}

