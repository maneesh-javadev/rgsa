package gov.in.rgsa.serviceImpl;

import java.math.BigInteger;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.collections.CollectionUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import gov.in.rgsa.dao.CommonRepository;
import gov.in.rgsa.dto.PopulateSummaryStateFunds;
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

	@Override
	public UserPreference findUser(FacadeModel model) {

		Map<String, Object> params = new HashMap<String, Object>();
		params.put("userName", model.getLoginId());
		params.put("password", model.getPassword());

		Users user = dao.find("USER_AUTHENTICATE", params);
		if(user.getIsLocked()==null || !user.getIsLocked()){
			throw new RGSAException("Your login Id has been deactivated");
		}
		

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
		
		
		Boolean plansAreFreezed = checkForFreezeStatus(parameter);
		
		
		List<PlanComponents> components= commonRepository.findAll("PLAN_COMPONENTS_LIST", null);
		
		parameter.put("userType", user.getUserType());
		List<StatePlanComponentsFunds> componentsFunds= commonRepository.findAll("STATE_PLAN_FUNDS", parameter);
		for(StatePlanComponentsFunds obj : componentsFunds) {
			System.out.print("component id-->"+obj.getComponentsId()+" ");
			System.out.print("sub component id-->"+obj.getSubcomponentsId()+" ");
			System.out.print("fund -->"+obj.getAmountProposed()+" ");
			System.out.println();
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
		
		UserPreference _preference = new UserPreference();
		_preference.setUserId(user.getUserId());
		_preference.setUserName(user.getUserName());
		_preference.setUserType(user.getUserType());
		_preference.setStateCode(user.getStateId());
		_preference.setDistrictcode(user.getDistrictcode());
		_preference.setMenus(menus);
		_preference.setFinYearId(finYear.getYearId());
		_preference.setFinYear(finYear.getFinYear());
//		_preference.setActivityPlanStatus(activityPlanStatus);
		_preference.setPlanComponents(components);
		_preference.setStatePlanComponentsFunds(componentsFunds);
		_preference.setPlansAreFreezed(plansAreFreezed);
		if(!CollectionUtils.isEmpty(planList)) {
		_preference.setPlanCode(planList.get(0).getPlanCode());
		_preference.setPlanStatus(planList.get(0).getPlanStatusId());
		_preference.setPlanVersion(planList.get(0).getPlanVersion());
		}
		_preference.setCountPlanSubmittedByState(planDetailsService.countPlanSubmittedByState("M"));
		_preference.setCountPlanSubmittedByMOPR(planDetailsService.countPlanSubmittedByState("C"));
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
	public void forwardPlans() {
		Map<String, Object> params = new HashMap<>();
		if(userPreference.getUserType().equalsIgnoreCase("s"))
			params.put("plan_status_id", 2);
		else if(userPreference.getUserType().equalsIgnoreCase("m")){
			params.put("plan_status_id", 4);
		}
		params.put("stateCode", userPreference.getStateCode());
		params.put("yearId", userPreference.getFinYearId());
		BigInteger count = commonRepository.find("PLAN_FORWARDED_OR_NOT", params);
		if(count.intValue() > 0){
			return;
		}else if(userPreference.getUserType().equalsIgnoreCase("s")){
			handelDataForState();
		}else if (userPreference.getUserType().equalsIgnoreCase("m")){
			handelDataForMOPR();
		}
	}
	
	private void handelDataForMOPR(){
		Map<String, Object> parameter = new HashMap<String, Object>();
		parameter.put("planStatusId",2);
		parameter.put("stateCode", userPreference.getStateCode());
		parameter.put("yearId", userPreference.getFinYearId());
		List<Plan> planForwardedByState=dao.findAll("PLAN_STATUS", parameter);
		if(!CollectionUtils.isEmpty(planForwardedByState)) {
			Plan planold = planForwardedByState.get(0);
			planold.setIsactive(false);
			dao.update(planold);
			
			
			Plan status=new Plan();
			PlanPK planPK=new PlanPK();
			planPK.setPlanCode(planold.getPlanCode());
			planPK.setPlanVersion(1);
			planPK.setPlanStatusId(PLAN_STATUS_FORWARD_TO_CEC);
			status.setPlanPK(planPK);
			status.setStateCode(planold.getStateCode());
			status.setYearId(planold.getYearId());
			status.setIsactive(true);
			status.setCreatedBy(userPreference.getUserId());
			commonRepository.save(status);
		}
	}
	
	
	private void handelDataForState(){
		Map<String, Object> parameter = new HashMap<String, Object>();
		parameter.put("planStatusId",1);
		parameter.put("stateCode", userPreference.getStateCode());
		parameter.put("yearId", userPreference.getFinYearId());
		List<Plan> planInDraftMode=dao.findAll("PLAN_STATUS", parameter);
		if(!CollectionUtils.isEmpty(planInDraftMode)) {
			Plan planold = planInDraftMode.get(0);
			planold.setIsactive(false);
			dao.update(planold);
			
			Plan status=new Plan();
			PlanPK planPK=new PlanPK();
			planPK.setPlanCode(planold.getPlanCode());
			planPK.setPlanVersion(1);
			planPK.setPlanStatusId(PLAN_STATUS_SUBMITTED_TO_PD);
			status.setPlanPK(planPK);
			status.setStateCode(planold.getStateCode());
			status.setYearId(planold.getYearId());
			status.setIsactive(true);
			status.setCreatedBy(userPreference.getUserId());
			
			commonRepository.save(status);
		}
		
		
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
	public void populateStateFunds(String componentIds){
		if(userPreference.getUserType()!=null && userPreference.getUserType().length()>0 && componentIds!=null && componentIds.length()>0)
		{
			if(userPreference.getUserType().charAt(0)!='S' && componentIds!=null) {
				populateFundbyUserType(Integer.parseInt(componentIds));
			}else {
				Map<String, Object> parameter = new HashMap<String, Object>();
				parameter.put("componentIds",componentIds);
				parameter.put("stateCode", userPreference.getStateCode());
				parameter.put("yearId", userPreference.getFinYearId());
				
				System.out.println("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
				System.out.println("populate value for component id->"+componentIds+" stateCode->"
				+userPreference.getStateCode()+	"  yearId->"+userPreference.getFinYearId());
				List<PopulateSummaryStateFunds> planForwardedByState=commonRepository.findAll("POPULATE_SUMMARY_STATE_FUNDS", parameter);
				if(planForwardedByState!=null && !planForwardedByState.isEmpty()) {
					parameter = new HashMap<String, Object>();
					parameter.put("stateCode", userPreference.getStateCode());
					parameter.put("yearId", userPreference.getFinYearId());
					parameter.put("userType", userPreference.getUserType());
					List<StatePlanComponentsFunds> statePlanComponentsFundsList=commonRepository.findAll("STATE_PLAN_FUNDS", parameter);
					if(statePlanComponentsFundsList!=null && !statePlanComponentsFundsList.isEmpty()) {
						userPreference.setStatePlanComponentsFunds(statePlanComponentsFundsList);
						System.out.println("########################## set user preference  ###########");
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
	public List<PopulateSummaryStateFunds> populateFundbyUserType(Integer componentIds){
		Map<String, Object> parameter = new HashMap<String, Object>();
		parameter.put("componentIds",componentIds);
		parameter.put("stateCode", userPreference.getStateCode());
		parameter.put("yearId", userPreference.getFinYearId());
		System.out.println("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
		System.out.println("populate value for component id->"+componentIds+" stateCode->"
		+userPreference.getStateCode()+	"  yearId->"+userPreference.getFinYearId()+" userType->"+userPreference.getUserType());
		if(userPreference.getUserType()!=null && userPreference.getUserType().length()>0) {
			if( userPreference.getUserType().charAt(0)=='M') {
				return commonRepository.findAll("POPULATE_SUMMARY_MINISTRY_FUNDS", parameter); 
			}else if( userPreference.getUserType().charAt(0)=='C') {
				return commonRepository.findAll("POPULATE_SUMMARY_CEC_FUNDS", parameter);
			}
		}
		return null;
	}

	@Override
	public List<StatePlanComponentsFunds> fetchFundDetailsByUserType(Map<String, Object> parameter ){
		return commonRepository.findAll("STATE_PLAN_FUNDS", parameter);
	}
	
}