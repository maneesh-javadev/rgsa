package gov.in.rgsa.serviceImpl;

import java.math.BigInteger;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.persistence.Query;

import org.apache.commons.collections.CollectionUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import gov.in.rgsa.dao.CommonRepository;
import gov.in.rgsa.dto.IsFreezeStatusDto;
import gov.in.rgsa.entity.ActionPlanStatus;
import gov.in.rgsa.entity.FinYear;
import gov.in.rgsa.entity.MenuProfile;
import gov.in.rgsa.entity.Plan;
import gov.in.rgsa.entity.PlanComponents;
import gov.in.rgsa.entity.PlanPK;
import gov.in.rgsa.entity.PlanSubcomponents;
import gov.in.rgsa.entity.StatePlanComponentsFunds;
import gov.in.rgsa.entity.Users;
import gov.in.rgsa.entity.VisitorCount;
import gov.in.rgsa.exception.RGSAException;
import gov.in.rgsa.model.FacadeModel;
import gov.in.rgsa.service.CommonService;
import gov.in.rgsa.service.FacadeService;
import gov.in.rgsa.service.PlanDetailsService;
import gov.in.rgsa.user.preference.UserPreference;


/**
 *
 * @author ANJIT
 */
@Service
public class FacadeServiceImpl implements FacadeService {

	@Autowired
	private CommonRepository dao;

	@Autowired
	private CommonService commonService;
	
	@Autowired
	private UserPreference userPreference;
	
	@Autowired
	private CommonRepository commonRepository;
	
	@Autowired
	private PlanDetailsService planDetailsService;
	
	private static final int PLAN_STATUS_SUBMITTED_TO_PD=2;
	
	private static final int PLAN_STATUS_FORWARD_TO_CEC=4;

	private static final String ALREADY_SAVED = "A";

	private static final String DATA_SAVE = "S";

	private static final String SOMETHING_WENT_WRONG = "W";

	private static final String UNKNOWN_ACTION = "U";

	static Logger logger = LoggerFactory.getLogger(FacadeServiceImpl.class);

	@Override
	public UserPreference findUser(FacadeModel model) {

		Map<String, Object> params = new HashMap<String, Object>();
		params.put("userName", model.getLoginId());
		params.put("password", model.getPassword());

		Users user = dao.find("USER_AUTHENTICATE", params);
		if(user.getIsLocked()==null || !user.getIsLocked()){
			throw new RGSAException("Your login Id has been deactivated");
		}
		
		UserPreference _preference = new UserPreference();
		_preference.setUserId(user.getUserId());
		_preference.setUserName(user.getUserName());
		_preference.setUserType(user.getUserType());
		_preference.setStateCode(user.getStateId());
		_preference.setDistrictcode(user.getDistrictcode());
		
		Map<String, Object> menuParam = new HashMap<String, Object>();
		menuParam.put("active", true);
		if (user.getUserType().equalsIgnoreCase("J") || user.getUserType().equalsIgnoreCase("G"))
			menuParam.put("itemType", "W");
		else
			menuParam.put("itemType", user.getUserType());

		List<MenuProfile> menus = dao.findAll("FIND_MENU_BY_ITEM_TYPE", menuParam);
		
		FinYear finYear = commonService.findActiveFinYear();
		
		Map<String, Object> parameter = new HashMap<String, Object>();
		parameter.put("yearId",finYear.getYearId());
		parameter.put("stateCode", user.getStateId());
		List<IsFreezeStatusDto> isFreezeStatusDto = commonRepository.findAll("FETCH_FORMS_FREEZE_STATUS", parameter);
		
		Boolean plansAreFreezed = checkForFreezeStatus(parameter);
		
		
		List<PlanComponents> components= commonRepository.findAll("PLAN_COMPONENTS_LIST", null);
		List<FinYear> finYearList = commonRepository.findAll("FETCH_ALL_FIN_YEAR",null);
		parameter.put("userType", user.getUserType());
		List<StatePlanComponentsFunds> componentsFunds= commonRepository.findAll("STATE_PLAN_FUNDS", parameter);
		
		for(StatePlanComponentsFunds obj : componentsFunds) {
			logger.debug("component id-->"+obj.getComponentsId()+" ");
			logger.debug("sub component id-->"+obj.getSubcomponentsId()+" ");
			logger.debug("fund -->"+obj.getAmountProposed()+" ");
		}
		/*
		 * if(componentsFunds!=null && !componentsFunds.isEmpty()){ for
		 * (StatePlanComponentsFunds statePlanComponentsFunds : componentsFunds) { for
		 * (PlanComponents planComponents : components) { List<PlanSubcomponents>
		 * planSubcomponents=planComponents.getSubcomponents(); for (PlanSubcomponents 
		 * planSubcomponent : planSubcomponents) {
		 * if(statePlanComponentsFunds.getSubcomponentsId() ==
		 * planSubcomponent.getSubcomponentId()){
		 * planSubcomponent.setStateFunds(statePlanComponentsFunds.getAmountProposed());
		 * planSubcomponent.setStateUnitCost(statePlanComponentsFunds.getNoOfUnits());
		 * break; } } } } }
		 */
		Map<String, Object> param=new HashMap<>();
		param.put("yearId", finYear.getYearId());
		param.put("stateCode", user.getStateId());
		//param.put("planStatusId", 1);
		List<Plan> planList = commonRepository.findAll("SHOW_HIDE_BUTTON_PLAN_STATUS",param);
		
		_preference.setMenus(menus);
		_preference.setFinYearId(finYear.getYearId());
		_preference.setFinYear(finYear.getFinYear());
//		_preference.setActivityPlanStatus(activityPlanStatus);
		_preference.setPlanComponents(components);
		_preference.setStatePlanComponentsFunds(componentsFunds);
		_preference.setPlansAreFreezed(plansAreFreezed);
		_preference.setFinYearList(finYearList);
		if(!CollectionUtils.isEmpty(planList)) {
		_preference.setPlanCode(planList.get(0).getPlanCode());
		_preference.setPlanStatus(planList.get(0).getPlanStatusId());
		_preference.setPlanVersion(planList.get(0).getPlanVersion());
		}
		_preference.setCountPlanSubmittedByState(planDetailsService.countPlanSubmittedByState("M"));
		_preference.setCountPlanSubmittedByMOPR(planDetailsService.countPlanSubmittedByState("C"));
		_preference.setIsFreezeStatusList(isFreezeStatusDto);
		return _preference;
	}

	public Boolean checkForFreezeStatus(Map<String, Object> parameter){
		List<ActionPlanStatus> activityPlanStatus=dao.findAll("PLAN_ACTIVITY_STATUS", parameter);
		boolean plansAreFreezed = false;
		for (ActionPlanStatus actionPlanStatus : activityPlanStatus) {
			
			if(actionPlanStatus!=null && actionPlanStatus.getIsFreezed()){
				plansAreFreezed=true;
				break;
			}
		}
		return plansAreFreezed;
	}
	
	@Override
	public String forwardPlans() {
		Map<String, Object> params = new HashMap<>();
		if(userPreference.getUserType().equalsIgnoreCase("s")) {
			params.put("plan_status_id", 2);
		}else if(userPreference.getUserType().equalsIgnoreCase("m")){
			params.put("plan_status_id", 4);
		}
		params.put("stateCode", userPreference.getStateCode());
		params.put("yearId", userPreference.getFinYearId());
		BigInteger count = commonRepository.find("PLAN_FORWARDED_OR_NOT", params);
		if(count.intValue() > 0){
			return ALREADY_SAVED;
		}else if(userPreference.getUserType().equalsIgnoreCase("s")){
			return handelDataForState();
		}else if (userPreference.getUserType().equalsIgnoreCase("m")){
			return handelDataForMOPR();
		}else {
			return UNKNOWN_ACTION;
		}
	}
	
	private String handelDataForMOPR(){
		Map<String, Object> parameter = new HashMap<String, Object>();
		parameter.put("planStatusId",2);
		parameter.put("stateCode", userPreference.getStateCode());
		parameter.put("yearId", userPreference.getFinYearId());
		parameter.put("planVersion", userPreference.getPlanVersion());
		List<Plan> planForwardedByState=dao.findAll("PLAN_STATUS", parameter);
		if(!CollectionUtils.isEmpty(planForwardedByState)) {
			Plan planold = planForwardedByState.get(0);
			planold.setIsactive(false);
			dao.update(planold);
			
			
			Plan status=new Plan();
			PlanPK planPK=new PlanPK();
			planPK.setPlanCode(planold.getPlanCode());
			planPK.setPlanVersion(userPreference.getPlanVersion());
			planPK.setPlanStatusId(PLAN_STATUS_FORWARD_TO_CEC);
			status.setPlanPK(planPK);
			status.setStateCode(planold.getStateCode());
			status.setYearId(planold.getYearId());
			status.setIsactive(true);
			status.setCreatedBy(userPreference.getUserId());
			try {
				commonRepository.save(status);
			}catch(Exception e) {
				return SOMETHING_WENT_WRONG;
			}
		}
		return DATA_SAVE;
	}
	
	
	private String handelDataForState(){
		Map<String, Object> parameter = new HashMap<String, Object>();
		parameter.put("planStatusId",1);
		parameter.put("stateCode", userPreference.getStateCode());
		parameter.put("yearId", userPreference.getFinYearId());
		parameter.put("planVersion", userPreference.getPlanVersion());
		List<Plan> planInDraftMode=dao.findAll("PLAN_STATUS", parameter);
		if(!CollectionUtils.isEmpty(planInDraftMode)) {
			Plan planold = planInDraftMode.get(0);
			planold.setIsactive(false);
			dao.update(planold);
			
			Plan status=new Plan();
			PlanPK planPK=new PlanPK();
			planPK.setPlanCode(planold.getPlanCode());
			planPK.setPlanVersion(userPreference.getPlanVersion());
			planPK.setPlanStatusId(PLAN_STATUS_SUBMITTED_TO_PD);
			status.setPlanPK(planPK);
			status.setStateCode(planold.getStateCode());
			status.setYearId(planold.getYearId());
			status.setIsactive(true);
			status.setCreatedBy(userPreference.getUserId());
			try {
				commonRepository.save(status);
			}catch(Exception e) {
				return SOMETHING_WENT_WRONG;
			}
		}
		return DATA_SAVE;
	}
	
	@Override
	public int findVisitorCount() {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("id", 1 );
		VisitorCount visitorCount =commonRepository.find("FIND_VISITOR_COUNT", params);
		int count=visitorCount.getCount();
		count++;
		visitorCount.setCount(count);
		commonRepository.update(visitorCount);
		//count=count/2;	
		
		return count;
	}

	@Override
	public String getPlanStatusName() {
		Map<String, Object> parameter = new HashMap<String, Object>();
		parameter.put("stateCode", userPreference.getStateCode());
		parameter.put("yearId", userPreference.getFinYearId());
		List<String> plan=dao.findAll("PLAN_NAME", parameter);
		if(!CollectionUtils.isEmpty(plan)) {
		return plan.get(0);
		}
		return "In Draft Mode";
	}
	
	
	@Override
	public void populateStateFunds(String componentIds) {
		if (userPreference.getUserType() != null && userPreference.getUserType().length() > 0 && componentIds != null && componentIds.length() > 0) {
			if (userPreference.getUserType().charAt(0) != 'S' && componentIds != null) {
				populateFundbyUserType(componentIds);
			} else {
				Map<String, Object> parameter = new HashMap<String, Object>();
				parameter.put("componentIds", componentIds);
				parameter.put("stateCode", userPreference.getStateCode());
				parameter.put("yearId", userPreference.getFinYearId());

				logger.debug("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
				logger.debug("populate value for component id->" + componentIds + " stateCode->"
						+ userPreference.getStateCode() + "  yearId->" + userPreference.getFinYearId());
				boolean status = commonRepository.find("POPULATE_SUMMARY_STATE_FUNDS", parameter);
				if (status) {
					parameter = new HashMap<String, Object>();
					parameter.put("stateCode", userPreference.getStateCode());
					parameter.put("yearId", userPreference.getFinYearId());
					parameter.put("userType", userPreference.getUserType());
					List<StatePlanComponentsFunds> statePlanComponentsFundsList = commonRepository.findAll("STATE_PLAN_FUNDS", parameter);
					if (statePlanComponentsFundsList != null && !statePlanComponentsFundsList.isEmpty()) {
						userPreference.setStatePlanComponentsFunds(statePlanComponentsFundsList);
						logger.debug("########################## set user preference  ###########");
					}
				}

			}
		}


	}
	
	@Override
	public List<PlanSubcomponents> getPlanSubComponents() {
		return commonRepository.findAll("PLAN_SUB_COMPONENTS_LIST", null);
	}
	
	@Override
	public boolean populateFundbyUserType(String componentIds){
		Map<String, Object> parameter = new HashMap<String, Object>();
		parameter.put("componentIds",componentIds);
		parameter.put("stateCode", userPreference.getStateCode());
		parameter.put("yearId", userPreference.getFinYearId());
		logger.debug("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
		logger.debug("populate value for component id->"+componentIds+" stateCode->"
		+userPreference.getStateCode()+	"  yearId->"+userPreference.getFinYearId()+" userType->"+userPreference.getUserType());
		if(userPreference.getUserType()!=null && userPreference.getUserType().length()>0) {
			if( userPreference.getUserType().charAt(0)=='M') {
				return commonRepository.find("POPULATE_SUMMARY_MINISTRY_FUNDS", parameter); 
			}else if( userPreference.getUserType().charAt(0)=='C') {
				return commonRepository.find("POPULATE_SUMMARY_CEC_FUNDS", parameter);
			}
		}
		return false;
	}

	@Override
	public List<StatePlanComponentsFunds> fetchFundDetailsByUserType(Map<String, Object> parameter ){
		//System.out.println("><><><><><><<<<<<<<<<<<<");
		return commonRepository.findAll("STATE_PLAN_FUNDS", parameter);
	}

	@Override
	public UserPreference changeAccToNewFinYearId(UserPreference _userPreference, String finYearId) {
		String newFinYear=null;
		_userPreference.setFinYearId(Integer.parseInt(finYearId));
		for(FinYear finyear : _userPreference.getFinYearList()) {
			if(finyear.getYearId() == Integer.parseInt(finYearId)) {
				newFinYear = finyear.getFinYear();
			}
				
		}
		_userPreference.setFinYear(newFinYear);
		Map<String, Object> parameter = new HashMap<String, Object>();
		parameter.put("yearId",_userPreference.getFinYearId());
		parameter.put("stateCode", _userPreference.getStateCode());
		parameter.put("userType", _userPreference.getUserType());
		List<StatePlanComponentsFunds> componentsFunds= commonRepository.findAll("STATE_PLAN_FUNDS", parameter);
		_userPreference.setStatePlanComponentsFunds(componentsFunds);
		return _userPreference;
	}

	@Override
	public List<IsFreezeStatusDto> fetchFormsIsFreezeStatus(Integer stateCode) {
		Map<String, Object> parameter = new HashMap<String, Object>();
		if(stateCode == null) {
			parameter.put("stateCode", userPreference.getStateCode());
		}else {
			parameter.put("stateCode", stateCode);
		}
		parameter.put("yearId", userPreference.getFinYearId());
		return commonRepository.findAll("FETCH_FORMS_FREEZE_STATUS", parameter);
	}

	@Override
	public boolean revertPlan(Integer stateCode) {
		Map<String, Object> parameter = new HashMap<String, Object>();
		parameter.put("state_code", stateCode);
		parameter.put("year_id", userPreference.getFinYearId());
		return dao.findByNativeQuery("select * from rgsa.revert_func_no_deletion(:state_code,:year_id)", parameter);
	}
	
}
