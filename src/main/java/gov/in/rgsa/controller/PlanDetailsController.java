package gov.in.rgsa.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import gov.in.rgsa.dao.CommonRepository;
import gov.in.rgsa.dto.CheckAllComponentforForwardPlan;
import gov.in.rgsa.entity.Plan;
import gov.in.rgsa.entity.State;
import gov.in.rgsa.model.FacadeModel;
import gov.in.rgsa.service.EEnablementOfPanchayatService;
import gov.in.rgsa.service.EGovernanceSupportService;
import gov.in.rgsa.service.FacadeService;
import gov.in.rgsa.service.IecService;
import gov.in.rgsa.service.InnovativeActivityService;
import gov.in.rgsa.service.PlanAllocationService;
import gov.in.rgsa.service.PlanDetailsService;
import gov.in.rgsa.service.SatcomFacilityService;
import gov.in.rgsa.service.TrainingActivityService;
import gov.in.rgsa.service.TrainingInstitutionService;
import gov.in.rgsa.serviceImpl.FacadeServiceImpl;
import gov.in.rgsa.user.preference.UserPreference;

@Controller
public class PlanDetailsController {
	
	@Autowired
	PlanDetailsService detailsService;
	
	@Autowired
	UserPreference userPreference;
	
	@Autowired
	private CommonRepository commonRepository;
	
	@Autowired
	private EEnablementOfPanchayatService enablementOfPanchayatService;
	
	@Autowired
	TrainingActivityService trainingActivityService;
	
	@Autowired
	public EGovernanceSupportService eGovernanceSupportService;
	
	@Autowired
	private SatcomFacilityService satcomFacilityService;
	
	@Autowired
	InnovativeActivityService innovativeActivityService;
	
	@Autowired
	private IecService iecService;
	
	@Autowired
	private PlanAllocationService allocationService;
	
	@Autowired
	TrainingInstitutionService trainigInstitutionService;
	
	@Autowired
	FacadeService facadeService;
	
	public static final String MOPR_PLAN_DETAILS = "planSubmittedByStates";
	public static final String MOPR_PLAN_DETAILS_BY_STATE = "viewPlanDetailsByStates";
	public static final String CEC_PLAN_DETAILS = "viewPlanDetailsForCEC";
	public static final String RDIRECT_CEC_PLAN_DETAILS = "redirect:viewPlanDetailsForCEC.html";
	
	public static final String APPROVE_PLANLIST_DETAILS = "approvePlanList";
	
	@RequestMapping(value = "submitedPlanByState", method = RequestMethod.GET)
	public String viewPlanList(@ModelAttribute("FACADE_MODEL") FacadeModel form, Model model, RedirectAttributes re) {
		return MOPR_PLAN_DETAILS;
	}
	
	@ResponseBody
	@RequestMapping(value="getAllSubmittedPlanByState",method=RequestMethod.GET)
	public List<Plan> getAllSubmittedPlanByState(){
		return detailsService.getAllSubmittedPlan();
	}
	
	@RequestMapping(value = "viewPlanDetails", method = RequestMethod.GET)
	public String planDetailsByState(@ModelAttribute("FACADE_MODEL") FacadeModel form,@RequestParam(value = "stateCode") Integer stateCode , Model model) {
		/***sdfs**/
		String userPage = null;
		if(userPreference.getUserType().equalsIgnoreCase("m")){
			userPage = fetchDataForMOPRLogin(stateCode,model);
			userPreference.setStateCode(stateCode);
		}else{
			userPage = fetchDataForCECLogin(stateCode,model);
			userPreference.setStateCode(stateCode);
		}
		model.addAttribute("PLAN_ALLOCATION_LIST", allocationService.getPlanComponents());
		List<Plan> plan = allocationService.showHidePlanStatus(stateCode);
		
		Map<String, Object> data=facadeService.checkAllComponentforPlanForward(userPreference.getStateCode(), userPreference.getFinYearId(), userPreference.getUserType().charAt(0));
		Boolean isallCompVerify=(Boolean)data.get("isallCompVerify");
		model.addAttribute("isallCompVerify", isallCompVerify);
		List<CheckAllComponentforForwardPlan> checkAllComponentforForwardPlanList=(List<CheckAllComponentforForwardPlan>)data.get("checkAllComponentforForwardPlanList");
		model.addAttribute("checkAllComponentforForwardPlanList", checkAllComponentforForwardPlanList);
		Boolean isShowForwardButton=(Boolean)data.get("isShowForwardButton");
		model.addAttribute("isShowForwardButton", isShowForwardButton);
		
		userPreference.setPlanCode(plan.get(0).getPlanCode());
		userPreference.setPlanStatus(plan.get(0).getPlanStatusId());
		userPreference.setPlanVersion(plan.get(0).getPlanVersion());
		
		Map<String, Object> parameter = new HashMap<String, Object>();
		parameter.put("stateCode", stateCode);
		parameter.put("yearId", userPreference.getFinYearId());
		
			 parameter.put("userType", userPreference.getUserType());
		
		model.addAttribute("IS_FREEZE_STATUS_LIST", facadeService.fetchFormsIsFreezeStatus(stateCode));
		model.addAttribute("planComponentsFunds", facadeService.fetchFundDetailsByUserType(parameter));
		return userPage;
	}
	
	private String fetchDataForMOPRLogin(int stateCode,Model model){
		userPreference.setStateCode(stateCode);
		/*preference.setUserType("S");*/
		/*List<TrainingActivity> trainingActivities = trainingActivityService.findAllTrainingActivity(null);
		System.out.println("List"+ trainingActivities.isEmpty());
		if(!trainingActivities.isEmpty()) {
			model.addAttribute("allTrainingActivity",trainingActivities.get(0));
			}
		else {
			model.addAttribute("allTrainingActivity",trainingActivities);
		}*/
		/*sdfsdf*/
		/*List<EEnablement> enablement=new ArrayList<EEnablement>();
		List<EEnablementDetails> enablementDetails = new ArrayList<EEnablementDetails>();
		enablement = enablementOfPanchayatService.fetchEnablement(null);
		if(!CollectionUtils.isEmpty(enablement)){
			enablementDetails = enablementOfPanchayatService.fetchEnablementDetails(enablement.get(0).geteEnablementId());
			model.addAttribute("enablementFund", enablementDetails.get(0).getFund());
		}*/
		/**sdfsdf*/
		/*List<EGovSupportActivity> eGovActivity = new ArrayList<EGovSupportActivity>();
		List<EGovSupportActivityDetails> eGovActivityDetails = new ArrayList<EGovSupportActivityDetails>();
		eGovActivity=eGovernanceSupportService.fetchEGovActivity(null);
		if(!CollectionUtils.isEmpty(eGovActivity))
		{
			eGovActivityDetails=eGovernanceSupportService.fetchEGovActivityDetails(eGovActivity.get(0).geteGovSupportActivityId());
			model.addAttribute("eGovActivityDetails", eGovActivityDetails.get(0).getFunds());
		}*/
		/**/
		/*List<InnovativeActivity> innovativeAcitivityList = innovativeActivityService.findAllActivity(null);
		if(!CollectionUtils.isEmpty(innovativeAcitivityList)) {
			Integer totalFund = 0;
			List<InnovativeActivityDetails> innovativeActivityDetails = innovativeAcitivityList.get(0).getInnovativeActivityDetails();
		for(int i =0; i<innovativeActivityDetails.size();i++) {
			Integer fund = innovativeActivityDetails.get(i).getFundsName();
			totalFund +=fund;
		}
			totalFund = totalFund + innovativeAcitivityList.get(0).getAdditioinalRequirements();
			model.addAttribute("innovativeAcitivityTotalFund",totalFund);
		}*/
		
		/*List<SatcomActivity> activities=satcomFacilityService.fetchSatcomActivities(userPreference.getUserType());
		if(!CollectionUtils.isEmpty(activities)){
			int totalFund=0;
			List<SatcomActivityDetails> activityDetails =null;
			activityDetails=activities.get(0).getActivityDetails();
			for (SatcomActivityDetails satcomActivityDetails : activityDetails) {
				totalFund=totalFund+satcomActivityDetails.getFunds();
			}
			model.addAttribute("SATCOM_FUND_TOTAL",totalFund);
		}*/
		
		/*IecActivity iecActivity = iecService.fetchIecDetail(null);
		if (iecActivity != null) {
			int iecTotalFund=0;
			List<IecActivityDetails> activityDetails=null; 
			activityDetails=iecActivity.getIecActivityDetails();
			for (IecActivityDetails iecActivityDetails : activityDetails) {
				iecTotalFund=iecTotalFund + iecActivityDetails.getTotalAmountProposed();
			}
			model.addAttribute("IEC_FUND_TOTAL",iecTotalFund);
		}*/
		
		List<State> states =  allocationService.states(userPreference.getStateCode());
		model.addAttribute("stateName", states.get(0).getStateNameEnglish());
		model.addAttribute("stateCode", states.get(0).getStateCode());
		
		return MOPR_PLAN_DETAILS_BY_STATE;
	}
	
	private String fetchDataForCECLogin(int stateCode,Model model){
		userPreference.setStateCode(stateCode);
		
		List<State> states =  allocationService.states(userPreference.getStateCode());
		model.addAttribute("stateName", states.get(0).getStateNameEnglish());
		
		return CEC_PLAN_DETAILS;
	}
	

	@RequestMapping(value="getAllSubmittedPlanByStatebyStatus",method=RequestMethod.GET)
	private @ResponseBody List<Plan> getAllSubmittedPlanByStatebyStatus(Integer statusId){
		return detailsService.getAllSubmittedPlanbyStatus(statusId);
	}
	
	
	
	@RequestMapping(value = "statuswisePlanDetails", method = RequestMethod.GET)
	public String statuswisePlanDetails(@RequestParam("statusId") Integer statusId, Model model, RedirectAttributes re) {
		model.addAttribute("statusId",statusId);
		return MOPR_PLAN_DETAILS;
	}
	
	@RequestMapping(value = "approvePlanList", method = RequestMethod.GET)
	public String approvePlanList(@RequestParam("statusId") Integer statusId, Model model, RedirectAttributes re) {
		model.addAttribute("statusId",statusId);
		return APPROVE_PLANLIST_DETAILS;
	}
}