package gov.in.rgsa.serviceImpl;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import org.apache.commons.collections.CollectionUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import gov.in.rgsa.dao.CommonRepository;
import gov.in.rgsa.entity.BasicInfo;
import gov.in.rgsa.entity.BasicInfoDefination;
import gov.in.rgsa.entity.BasicInfoDetails;
import gov.in.rgsa.entity.FinYear;
import gov.in.rgsa.entity.FocusArea;
import gov.in.rgsa.entity.Plan;
import gov.in.rgsa.model.BasicInfoModel;
import gov.in.rgsa.service.ActionPlanService;
import gov.in.rgsa.service.BasicInfoService;
import gov.in.rgsa.user.preference.UserPreference;
import gov.in.rgsa.utils.DataUtils;

@Service
public class BasicInfoServiceImpl implements BasicInfoService {

	@Autowired
	private CommonRepository dao;

	@Autowired
	private UserPreference userPreference;
	
	@Autowired
	private ActionPlanService actionPlanService;

	@Override
	public BasicInfoDefination getBasicInfoDefinationDetails(int finYearId,String type) {

		Map<String, Object> params = new HashMap<String, Object>();
		params.put("yearId", finYearId);
		params.put("formType", type);
		return dao.find("FIND_BASIC_DEFINATION_BY_FIN_YEAR_ID", params);
	}

	@Override
	public UserPreference save(BasicInfoModel basicInfoModel) {

			UserPreference _userPreference=null;
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
			}
			return _userPreference;
			
	}

	@Override
	public BasicInfo getBasicInfoDetails(int finYearId, int stateCode,int basicInfoDefId) {
		BasicInfo basicInfo = null;
		
			Map<String, Object> params = new HashMap<String, Object>();
			params.put("yearId", finYearId);
			params.put("stateCode", stateCode);
			params.put("basicInfoDefinationId", basicInfoDefId);
			basicInfo = dao.find("FIND_BASIC_INFO_DETAILS_BY_STATE", params);
		
		return basicInfo;
	}

	@Override
	public List<FocusArea> fetchFocusAreas() {
		return dao.findAll("FATCH_FOCUS_AREAS", null);
	}

	@Override
	public BasicInfo findBesicInfo(Integer finYearId, Integer stateCode,Integer basicInfoDefId) {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("yearId", finYearId);
		params.put("stateCode", stateCode);
		params.put("basicInfoDefinationId", basicInfoDefId);
		List<BasicInfo> basicInfo = dao.findAll("FIND_BASIC_INFO_DETAILS_BY_STATE", params);
		if (CollectionUtils.isNotEmpty(basicInfo))
			return basicInfo.get(0);
		else
			return null;
	}

	@Override
	public void delete(BasicInfoModel basicInfoModel) {
		List<BasicInfoDetails> basicInfoDetails = new ArrayList<BasicInfoDetails>();
		Map<String, Object> params = new HashMap<String, Object>();
		Integer id= basicInfoModel.getBasicInfoId();
		if(id==null){
			id=basicInfoModel.getBasicInfoDefinationId();
		}
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
	}

	@Override
	public void freezeBasicInfoDetails(Integer basicInfoId) {
		// TODO Auto-generated method stub
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("basicInfoId", basicInfoId);
		BasicInfo basicInfo= dao.find("FIND_BASIC_INFO_BY_ID", params);
		basicInfo.setStatus("F");
		dao.update(basicInfo);
	}
	
	public String fillFirstBasicInfo() {
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
				if(basicInfoDtls.get(0).getDefinationValue() == null) {
					return "modify";
				}else {
					return "dataFound";
				}
			}else {
				return "create";
			}
			
		}else {
			return "create";
		}
		
		
	}
	
	public UserPreference updatePlanDetailtoSession(Plan plan) {
		Map<String, Object> param=new HashMap<>();
		param.put("yearId", userPreference.getFinYearId());
		param.put("stateCode", userPreference.getStateCode());
		//param.put("planStatusId", 1);
	
		UserPreference _preference = new UserPreference();
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
		return _preference;
	}
	

}
