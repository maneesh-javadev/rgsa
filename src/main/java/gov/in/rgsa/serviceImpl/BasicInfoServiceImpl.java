package gov.in.rgsa.serviceImpl;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import javax.servlet.jsp.jstl.sql.Result;

import org.apache.commons.collections.CollectionUtils;
import org.owasp.esapi.util.CollectionsUtil;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import gov.in.rgsa.controller.DashboardDataController;
import gov.in.rgsa.dao.CommonRepository;
import gov.in.rgsa.entity.AdminFinancialDataCellActivityDetails;
import gov.in.rgsa.entity.AdministrativeTechnicalSupportDetails;
import gov.in.rgsa.entity.BasicInfo;
import gov.in.rgsa.entity.BasicInfoDefination;
import gov.in.rgsa.entity.BasicInfoDetails;
import gov.in.rgsa.entity.CapacityBuildingActivityDetails;
import gov.in.rgsa.entity.EEnablementDetails;
import gov.in.rgsa.entity.EGovSupportActivityDetails;
import gov.in.rgsa.entity.FinYear;
import gov.in.rgsa.entity.FocusArea;
import gov.in.rgsa.entity.IecActivityDetails;
import gov.in.rgsa.entity.IncomeEnhancementDetails;
import gov.in.rgsa.entity.InnovativeActivityDetails;
import gov.in.rgsa.entity.InstitueInfraHrActivityDetails;
import gov.in.rgsa.entity.PanchatayBhawanActivityDetails;
import gov.in.rgsa.entity.PesaPlanDetails;
import gov.in.rgsa.entity.Plan;
import gov.in.rgsa.entity.PmuActivityDetails;
import gov.in.rgsa.entity.PmuProgress;
import gov.in.rgsa.entity.SatcomActivityDetails;
import gov.in.rgsa.entity.SatcomActivityProgress;
import gov.in.rgsa.model.BasicInfoModel;
import gov.in.rgsa.service.ActionPlanService;
import gov.in.rgsa.service.BasicInfoService;
import gov.in.rgsa.user.preference.UserPreference;
import gov.in.rgsa.utils.DataUtils;

@Service
public class BasicInfoServiceImpl implements BasicInfoService {
	static Logger logger = LoggerFactory.getLogger(BasicInfoServiceImpl.class);
	@Autowired
	private CommonRepository dao;

	@Autowired
	private UserPreference userPreference;
	
	@Autowired
	private ActionPlanService actionPlanService;

	@Override
	public BasicInfoDefination getBasicInfoDefinationDetails(int finYearId,String type) {
		try {
		Map<String, Object> params = new HashMap<String, Object>();
		//params.put("yearId", finYearId);
		params.put("formType", type);
		return dao.find("FIND_BASIC_DEFINATION_BY_FIN_YEAR_ID", params);
		}catch(Exception e) { e.printStackTrace();
			logger.error("Error found in class=BasicInfoServiceImpl ,  method is getBasicInfoDefinationDetails ==of date "+new Date()+ "=" +e);
		}
		return null;
	}

	@Override
	public UserPreference save(BasicInfoModel basicInfoModel) {

			UserPreference _userPreference=null;
			try {
			BasicInfo _basicInfo = new BasicInfo();
			FinYear _finYear = new FinYear();
			_finYear.setYearId(userPreference.getFinYearId());
			BasicInfoDefination basicInfoDefination = new BasicInfoDefination();
			basicInfoDefination.setBasicInfoDefinationId(basicInfoModel.getBasicInfoDefinationId());
			List<BasicInfoDetails> basicInfoDetails = new ArrayList<BasicInfoDetails>();

			_basicInfo.setStateCode(userPreference.getStateCode());
			_basicInfo.setFinYear(_finYear);

			for (Entry<String, List<String>> map : basicInfoModel.getData().entrySet()) {
				BasicInfoDetails _basicInfoDetail = new BasicInfoDetails();
				_basicInfoDetail.setBasicInfo(_basicInfo);
				_basicInfoDetail.setDefinationKey(map.getKey());
				if (CollectionUtils.isNotEmpty(map.getValue())) {
					_basicInfoDetail.setDefinationValue(DataUtils.getCommaSepValue(map.getValue()));
				}
				basicInfoDetails.add(_basicInfoDetail);
			}
			_basicInfo.setBasicInfoDefination(basicInfoDefination);
			_basicInfo.setBasicInfoDetails(basicInfoDetails);
			_basicInfo.setCreatedBy(userPreference.getUserId());
			_basicInfo.setCreatedOn(new Date());
			_basicInfo.setLastUpdatedBy(userPreference.getUserId());
			_basicInfo.setLastUpdatedOn(new Date());
			_basicInfo.setStatus("S");
			dao.save(_basicInfo);
			
			Plan plan=actionPlanService.actionPlanStatus();
			if(plan!=null){
			 _userPreference	=updatePlanDetailtoSession(plan);
			 userPreference.setPlanVersion(_userPreference.getPlanVersion()); 
			}
			}catch(Exception e) { e.printStackTrace();
				logger.error("Error found in class=BasicInfoServiceImpl ,   method is save ==of date "+new Date()+ "=" +e);
			}
			return _userPreference;
			
	}

	@Override
		public BasicInfo getBasicInfoDetails(int finYearId, int stateCode,int basicInfoDefId) {
			BasicInfo basicInfo = null;
			try {
				Map<String, Object> params = new HashMap<String, Object>();
				params.put("yearId", finYearId);
				params.put("stateCode", stateCode);
				params.put("basicInfoDefinationId", basicInfoDefId);
				basicInfo = dao.find("FIND_BASIC_INFO_DETAILS_BY_STATE", params);
				}catch(Exception e) { e.printStackTrace();
					logger.error("Error found in class=BasicInfoServiceImpl ,   method is save ==of date "+new Date()+ "=" +e);
				}
		return basicInfo;
	}

	@Override
	public List<FocusArea> fetchFocusAreas() {
		return dao.findAll("FATCH_FOCUS_AREAS", null);
	}

	@Override
	public BasicInfo findBesicInfo(Integer finYearId, Integer stateCode,Integer basicInfoDefId) {
		try {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("yearId", finYearId);
		params.put("stateCode", stateCode);
		params.put("basicInfoDefinationId", basicInfoDefId);
		List<BasicInfo> basicInfo = dao.findAll("FIND_BASIC_INFO_DETAILS_BY_STATE", params);
		if (CollectionUtils.isNotEmpty(basicInfo))
			return basicInfo.get(0);
		}catch(Exception e) { e.printStackTrace();
			logger.error("Error found in class=BasicInfoServiceImpl ,   method is findBesicInfo ==of date "+new Date()+ "=" +e);
		}
			return null;
	}

	@Override
	public void delete(BasicInfoModel basicInfoModel) {
		try {
		List<BasicInfoDetails> basicInfoDetails = new ArrayList<BasicInfoDetails>();
		Map<String, Object> params = new HashMap<String, Object>();
		Integer id= basicInfoModel.getBasicInfoId();
		 
		params.put("basicInfoId",id);
		dao.excuteUpdate("DELETE_BASICINFO_DETAILS", params);
		BasicInfo basicInfo= dao.find("FIND_BASIC_INFO_BY_ID", params);
		basicInfo.setLastUpdatedOn(new Date());
		for (Entry<String, List<String>> map : basicInfoModel.getData().entrySet()) {
			BasicInfoDetails _basicInfoDetail = new BasicInfoDetails();
			_basicInfoDetail.setBasicInfo(basicInfo);
			_basicInfoDetail.setDefinationKey(map.getKey());
			if (CollectionUtils.isNotEmpty(map.getValue())) {
				_basicInfoDetail.setDefinationValue(DataUtils.getCommaSepValue(map.getValue()));
			}
			basicInfoDetails.add(_basicInfoDetail);
		}
		basicInfo.setBasicInfoDetails(basicInfoDetails);
		basicInfo.setStatus(basicInfoModel.getStatus());		
		dao.update(basicInfo);
		
	}catch(Exception e) { e.printStackTrace();
		logger.error("Error found in class=BasicInfoServiceImpl ,   method is delete ==of date "+new Date()+ "=" +e);
	}
	}

	@Override
	public void freezeBasicInfoDetails(Integer basicInfoId) {  
		try {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("basicInfoId", basicInfoId);
		BasicInfo basicInfo= dao.find("FIND_BASIC_INFO_BY_ID", params);
		basicInfo.setStatus("F");
		dao.update(basicInfo);
		}catch(Exception e) { e.printStackTrace();
			logger.error("Error found in class=BasicInfoServiceImpl ,   method is delete ==of date "+new Date()+ "=" +e);
		}
	}
	
	public String fillFirstBasicInfo() {
		try {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("yearId", userPreference.getFinYearId());
		params.put("stateCode", userPreference.getStateCode());
		List<BasicInfo> basicInfo  = dao.findAll("FIND_BASIC_INFO_BY_STATE", params);
		Integer basicInfoId=null;
		if(basicInfo!=null && !basicInfo.isEmpty()) {
			for(BasicInfo obj:basicInfo) {
				if(obj.getBasicInfoDefination().getBasicInfoDefinationId()==1) {
					basicInfoId=obj.getBasicInfoId();
				}
			}
			if(basicInfoId!=null) {
				Map<String, Object> param = new HashMap<String, Object>();
				param.put("basicInfoId",basicInfoId);
				List<BasicInfoDetails> basicInfoDtls  = dao.findAll("FIND_BASIC_INFO_DETAILS", param);
				if(!CollectionUtils.isEmpty(basicInfoDtls)) {
					if(basicInfoDtls.get(0).getDefinationValue() == null) {
						return "modify";
					}else {
						return "dataFound";
					}
				}else {
					return "modify";
				}
				
			}else {
				return "create";
			}
			
		}else {
			return "create";
		}
		}catch(Exception e) { e.printStackTrace();
			logger.error("Error found in class=BasicInfoServiceImpl ,   method is fillFirstBasicInfo ==of date "+new Date()+ "=" +e);
		}
		return null;
	}
	
	public UserPreference updatePlanDetailtoSession(Plan plan) {
		UserPreference _preference = new UserPreference();
		try {
			Map<String, Object> param=new HashMap<>();
			param.put("yearId", userPreference.getFinYearId());
			param.put("stateCode", userPreference.getStateCode());
			//param.put("planStatusId", 1);
		_preference.setUserId(userPreference.getUserId());
		_preference.setUserName(userPreference.getUserName());
		_preference.setUserType(userPreference.getUserType());
		_preference.setStateCode(userPreference.getStateCode());
		_preference.setDistrictcode(userPreference.getDistrictcode());
		_preference.setMenus(userPreference.getMenus());
		_preference.setFinYearId(userPreference.getFinYearId());
		_preference.setFinYear(userPreference.getFinYear());
//		_preference.setActivityPlanStatus(activityPlanStatus);
		_preference.setPlanComponents(userPreference.getPlanComponents());
		_preference.setStatePlanComponentsFunds(userPreference.getStatePlanComponentsFunds());
		_preference.setPlansAreFreezed(userPreference.isPlansAreFreezed());
		
		_preference.setPlanCode(plan.getPlanPK().getPlanCode());
		_preference.setPlanStatus(plan.getPlanPK().getPlanStatusId());
		_preference.setPlanVersion(plan.getPlanPK().getPlanVersion());
		
		_preference.setCountPlanSubmittedByState(userPreference.getCountPlanSubmittedByState());
		_preference.setCountPlanSubmittedByMOPR(userPreference.getCountPlanSubmittedByMOPR());
		}catch(Exception e) { e.printStackTrace();
			logger.error("Error found in class=BasicInfoServiceImpl ,   method is updatePlanDetailtoSession ==of date "+new Date()+ "=" +e);
		}
		return _preference;
	}
	
	
	@Override
	public Map<String, List<List<String>>> fetchStateAndMoprPreComments(int detailSize ,int componentId) { 
		List<List<String>> statePreviousComments = new ArrayList<List<String>>();
		List<List<String>> moprPreviousComments = new ArrayList<List<String>>();
		Map<String, List<List<String>>> response=new HashMap<String, List<List<String>>>();
		try {
		int index = 0;
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("stateCode", userPreference.getStateCode());
		params.put("versionNo", userPreference.getPlanVersion());
		
		for (int i = 0; i < detailSize; i++) {
			statePreviousComments.add(new ArrayList<String>());
			moprPreviousComments.add(new ArrayList<String>());
		}
		
		switch(componentId) {
		case 1:
			params.put("yearId", userPreference.getFinYearId());
			List<Object[]> trainingDetails = dao.findAllByNativeQuery("select ta.user_type,tad.remarks from rgsa.training_activity  ta inner join rgsa.training_activity_details tad on(ta.training_activity_id = tad.training_activity_id) where ta.state_code=:stateCode and ta.version_no !=:versionNo and ta.year_id=:yearId and ta.user_type in('S','M') order by tad.training_id", params);
			if (!CollectionUtils.isEmpty(trainingDetails )) {
				for (int i = 0; i < trainingDetails.size(); i++) {
					if (index == detailSize) {
						index = 0;
					}
					if (trainingDetails .get(i)[0].toString().equalsIgnoreCase("S")) {
						statePreviousComments.get(index).add((trainingDetails.get(i)[1] != null) ? trainingDetails.get(i)[1].toString() : "");
					} else {
						moprPreviousComments.get(index).add((trainingDetails.get(i)[1] != null) ? trainingDetails.get(i)[1].toString() : "");
					}
					index ++;
				}
			}
			break;
		case 3 :
			params.put("yearId", userPreference.getFinYearId());
			List<PanchatayBhawanActivityDetails> panchDetails= dao.findAll("FETCH_ALL_PANCH_DETAILS_EXCEPT_CURRENT_VERSION", params);
			if(!CollectionUtils.isEmpty(panchDetails)) {
				for(int i = 0; i < panchDetails.size() ; i++) {
					 if(index == detailSize) {
						 index = 0;
					 }
					if(panchDetails.get(i).getPanchatayBhawanActivity().getUserType().toString().equalsIgnoreCase("S")) {
						statePreviousComments.get(index).add(panchDetails.get(i).getRemarks());
					}else {
						moprPreviousComments.get(index).add(panchDetails.get(i).getRemarks());
					}
					 index ++;
				}
			}
			break;
		case 4 :
			params.put("yearId", userPreference.getFinYearId());
			List<AdministrativeTechnicalSupportDetails> adminTechDetails= dao.findAll("FETCH_ALL_ADMIN_TECH_DETAILS_EXCEPT_CURRENT_VERSION", params);
			if(!CollectionUtils.isEmpty(adminTechDetails)) {
				for(int i = 0; i < adminTechDetails.size() ; i++) {
					 if(index == detailSize) {
						 index = 0;
					 }
					if(adminTechDetails.get(i).getAdministrativeTechnicalSupport().getUserType().toString().equalsIgnoreCase("S")) {
						statePreviousComments.get(index).add(adminTechDetails.get(i).getRemarks());
					}else {
						moprPreviousComments.get(index).add(adminTechDetails.get(i).getRemarks());
					}
					 index ++;
				}
			}
			break;
		case 5 :
			params.put("yearId", userPreference.getFinYearId());
			List<EEnablementDetails> eEnablementDetails= dao.findAll("FETCH_ALL_EENABLEMENT_DETAILS_EXCEPT_CURRENT_VERSION", params);
			if(!CollectionUtils.isEmpty(eEnablementDetails)) {
				for(int i = 0; i < eEnablementDetails.size() ; i++) {
					 if(index == detailSize) {
						 index = 0;
					 }
					if(eEnablementDetails.get(i).geteEnablement().getUserType().toString().equalsIgnoreCase("S")) {
						statePreviousComments.get(index).add(eEnablementDetails.get(i).getRemarks());
					}else {
						moprPreviousComments.get(index).add(eEnablementDetails.get(i).getRemarks());
					}
					 index ++;
				}
			}
			break;
		case 6 :
			params.put("yearId", userPreference.getFinYearId());
			List<Object[]> pesaResult = dao.findAllByNativeQuery("select p.user_type,pd.remarks from rgsa.pesa_plan p inner join rgsa.pesa_plan_details pd on (p.pesa_plan_id = pd.pesa_plan_id) where p.state_code =:stateCode and p.version_no !=:versionNo and p.year_id=:yearId and p.user_type in('S','M') order by pd.id", params);
			if (!CollectionUtils.isEmpty(pesaResult )) {
				for (int i = 0; i < pesaResult.size(); i++) {
					if (index == detailSize) {
						index = 0;
					}
					if (pesaResult .get(i)[0].toString().equalsIgnoreCase("S")) {
						statePreviousComments.get(index).add((pesaResult .get(i)[1] != null) ? pesaResult .get(i)[1].toString() : "");
					} else {
						moprPreviousComments.get(index).add((pesaResult .get(i)[1] != null) ? pesaResult .get(i)[1].toString() : "");
					}
					index ++;
				}
			}
			break;
		case 7 :
			params.put("yearId", userPreference.getFinYearId());
			List<SatcomActivityDetails> satcomActivityDetails = dao.findAll("FETCH_ALL_SATCOM_DETAILS_EXCEPT_CURRENT_VERSION", params);
			if(!CollectionUtils.isEmpty(satcomActivityDetails)) {
				for(int i = 0; i < satcomActivityDetails.size() ; i++) {
					 if(index == detailSize) {
						 index = 0;
					 }
					if(satcomActivityDetails.get(i).getSatcomActivity().getUserType().equalsIgnoreCase("S")) {
						statePreviousComments.get(index).add(satcomActivityDetails.get(i).getRemarks());
					}else {
						moprPreviousComments.get(index).add(satcomActivityDetails.get(i).getRemarks());
					}
					 index ++;
				}
			}
			break;	
		case 8 :
			params.put("yearId", userPreference.getFinYearId());
			List<AdminFinancialDataCellActivityDetails> adminActivityDetails = dao.findAll("FETCH_ALL_ADMIN_ACTIVITY_DETAILS_EXCEPT_CURRENT_VERSION", params);
			if(!CollectionUtils.isEmpty(adminActivityDetails)) {
				for(int i = 0; i < adminActivityDetails.size() ; i++) {
					 if(index == detailSize) {
						 index = 0;
					 }
					if(adminActivityDetails.get(i).getAdminAndFinancialDataActivity().getUserType().equalsIgnoreCase("S")) {
						statePreviousComments.get(index).add(adminActivityDetails.get(i).getRemarks());
					}else {
						moprPreviousComments.get(index).add(adminActivityDetails.get(i).getRemarks());
					}
					 index ++;
				}
			}
			break;
		case 9 :
			params.put("yearId", userPreference.getFinYearId());
			List<InnovativeActivityDetails> innovativeActivityDetails = dao.findAll("FETCH_ALL_INNOVATIVE_DETAILS_EXCEPT_CURRENT_VERSION", params);
			detailSize = innovativeActivityDetails.size() / (userPreference.getPlanVersion());
			if(!CollectionUtils.isEmpty(innovativeActivityDetails)) {
				for(int i = 0; i < innovativeActivityDetails.size() ; i++) {
					 if(index == detailSize) {
						 index = 0;
					 }
					if(innovativeActivityDetails.get(i).getInnovativeActivity().getUserType().toString().equalsIgnoreCase("S")) {
						statePreviousComments.get(index).add(innovativeActivityDetails.get(i).getRemarks());
					}else {
						moprPreviousComments.get(index).add(innovativeActivityDetails.get(i).getRemarks());
					}
					 index ++;
				}
			}
			break;
		case 10 : 
			params.put("yearId", userPreference.getFinYearId());
			List<IncomeEnhancementDetails> incomeDetails = dao.findAll("FETCH_ALL_INCOME_DETAILS_EXCEPT_CURRENT_VERSION", params);
			detailSize = incomeDetails.size() / (userPreference.getPlanVersion());
			if(!CollectionUtils.isEmpty(incomeDetails)) {
				for(int i = 0; i < incomeDetails.size() ; i++) {
					 if(index == detailSize) {
						 index = 0;
					 }
					if(incomeDetails.get(i).getIncomeEnhancementActivity().getUserType().toString().equalsIgnoreCase("S")) {
						statePreviousComments.get(index).add(incomeDetails.get(i).getRemarks());
					}else {
						moprPreviousComments.get(index).add(incomeDetails.get(i).getRemarks());
					}
					 index++;
				}
			}
			break;
		case 11 : 
			params.put("yearId", userPreference.getFinYearId());
			List<IecActivityDetails> iecDetails = dao.findAll("FETCH_ALL_IEC_DETAILS_EXCEPT_CURRENT_VERSION", params);
			if(!CollectionUtils.isEmpty(iecDetails)) {
				for(int i = 0; i < iecDetails.size() ; i++) {
					 if(index == detailSize) {
						 index = 0;
					 }
					if(iecDetails.get(i).getIecActivity().getUserType().toString().equalsIgnoreCase("S")) {
						statePreviousComments.get(index).add(iecDetails.get(i).getRemarks());
					}else {
						moprPreviousComments.get(index).add(iecDetails.get(i).getRemarks());
					}
					 index++;
				}
			}
			break;
		case 12 :
			params.put("yearId", userPreference.getFinYearId());
			List<PmuActivityDetails> pmuActivityDetails = dao.findAll("FETCH_ALL_PMU_DETAILS_EXCEPT_CURRENT_VERSION", params);
			if(!CollectionUtils.isEmpty(pmuActivityDetails)) {
				for(int i = 0; i < pmuActivityDetails.size() ; i++) {
					 if(index == detailSize) {
						 index = 0;
					 }
					if(pmuActivityDetails.get(i).getPmuActivity().getUserType().toString().equalsIgnoreCase("S")) {
						statePreviousComments.get(index).add(pmuActivityDetails.get(i).getRemarks());
					}else {
						moprPreviousComments.get(index).add(pmuActivityDetails.get(i).getRemarks());
					}
					 index ++;
				}
			}
			break;	
		case 13 :
			params.put("yearId", userPreference.getFinYearId());
			List<CapacityBuildingActivityDetails> trainingActivityDetails= dao.findAll("FETCH_ALL_TRAINING_ACTIVITY_DETAILS_EXCEPT_CURRENT_VERSION", params);
			if(!CollectionUtils.isEmpty(trainingActivityDetails)) {
				for(int i = 0; i < trainingActivityDetails.size() ; i++) {
					 if(index == detailSize) {
						 index = 0;
					 }
					if(trainingActivityDetails.get(i).getCapacityBuildingActivity().getUserType().toString().equalsIgnoreCase("S")) {
						statePreviousComments.get(index).add(trainingActivityDetails.get(i).getRemarks());
					}else {
						moprPreviousComments.get(index).add(trainingActivityDetails.get(i).getRemarks());
					}
					 index ++;
				}
			}
			break;
		case 14 :
			params.put("yearId", userPreference.getFinYearId());
			List<Object[]> result=dao.findAllByNativeQuery("select ih.user_type,ihd.remarks from rgsa.institue_infra_hr_activity ih inner join rgsa.institue_infra_hr_activity_details ihd on (ihd.institue_infra_hr_activity_id = ih.institue_infra_hr_activity_id) where ih.state_code =:stateCode and ih.version_no !=:versionNo and  ih.year_id =:yearId and ih.user_type in('S','M')order by ihd.institue_infra_hr_activity_details_id", params);
			
			if (!CollectionUtils.isEmpty(result)) {
				for (int i = 0; i < result.size(); i++) {
					if (index == detailSize) {
						index = 0;
					}
					if (result.get(i)[0].toString().equalsIgnoreCase("S")) {
						if(result.get(i)[1]!=null) {
							statePreviousComments.get(index).add( result.get(i)[1].toString());
						}
						
					} else {
						moprPreviousComments.get(index).add(result.get(i)[1].toString());
					}
					index ++;
				}
			}
			 
			break;	
		case 15 :
			params.put("yearId", userPreference.getFinYearId());
			List<EGovSupportActivityDetails> egovDetails= dao.findAll("FETCH_ALL_EGOV_DETAILS_EXCEPT_CURRENT_VERSION", params);
			if(!CollectionUtils.isEmpty(egovDetails)) {
				for(int i = 0; i < egovDetails.size() ; i++) {
					 if(index == detailSize) {
						 index = 0;
					 }
					if(egovDetails.get(i).geteGovSupportActivity().getUserType().toString().equalsIgnoreCase("S")) {
						statePreviousComments.get(index).add(egovDetails.get(i).getRemarks());
					}else {
						moprPreviousComments.get(index).add(egovDetails.get(i).getRemarks());
					}
					 index ++;
				}
			}
			break;
		default : 
		}
		response.put("statePreviousComments", statePreviousComments);
		response.put("moprPreviousComments", moprPreviousComments);
		}catch(Exception e) {
			e.printStackTrace();
			logger.error("Error found in class=BasicInfoServiceImpl ,   method is fetchStateAndMoprPreComments ==of date "+new Date()+ "=" +e);
		}
		
		return response;
	}

}
