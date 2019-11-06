package gov.in.rgsa.controller;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.collections.CollectionUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.web.servlet.support.RequestContextUtils;

import gov.in.rgsa.entity.District;
import gov.in.rgsa.entity.Domains;
import gov.in.rgsa.entity.InstitueInfraHrActivity;
import gov.in.rgsa.entity.InstitueInfraHrActivityDetails;
import gov.in.rgsa.entity.InstituteInfraHrActivityType;
import gov.in.rgsa.entity.TIWiseProposedDomainExperts;
import gov.in.rgsa.entity.TrainingInstituteCurrentStatusDetails;
import gov.in.rgsa.model.AdditionalFactultyAndMaintModel;
import gov.in.rgsa.service.AdditionalFacultyAndMainService;
import gov.in.rgsa.service.BasicInfoService;
import gov.in.rgsa.service.LGDService;
import gov.in.rgsa.user.preference.UserPreference;
import gov.in.rgsa.utils.Message;

@Controller
public class AdditionalfacultyAndMaintHrBudgetController {
	
	@Autowired
	private AdditionalFacultyAndMainService additionalFacultyAndMainService;
	
	@Autowired
	private UserPreference userPreference;
	
	@Autowired
	private LGDService lgdService;
	
	@Autowired
	BasicInfoService basicInfoService;
	
	public static final String ADD_FACULTY_MAINTENANCE = "addFacultyAndMaintenanceHrBudget";
	public static final String ADD_FACULTY_MAINTENANCE_CEC = "addFacultyAndMaintenanceHrBudgetCEC";
	private static final String REDIRECT_ADD_FACULTY_MAINTENANCE = "redirect:addFacultyAndMaintenanceHrBudget.html";
	public static final String REDIRECT_BAISC_INFO_DETAILS = "redirect:basicinfo.add.html";
	public static final String REDIRECT_MODIFY_BAISC_INFO_DETAILS = "redirect:managebasicInfoDetails.html";
	
	
	
	@RequestMapping(value = "addFacultyAndMaintenanceHrBudget", method = RequestMethod.GET)
	private String adminFacultyAndMaintenanceGet(@ModelAttribute("ADDITIONAL_FACULTY_MAINT_MODEL") AdditionalFactultyAndMaintModel additionalFactultyAndMaintModel,Model model,HttpServletRequest request,RedirectAttributes redirectAttributes) throws InstantiationException, IllegalAccessException{
	
		String status = basicInfoService.fillFirstBasicInfo();
		if(status.equals("create")) {
			redirectAttributes.addFlashAttribute(Message.EXCEPTION_KEY, "Please fill the Basic Info Details first");
			return REDIRECT_BAISC_INFO_DETAILS;
		}
		else if(status.equals("modify")) {
			redirectAttributes.addFlashAttribute(Message.EXCEPTION_KEY, "Please fill the Required Basic Info Details");
			return REDIRECT_MODIFY_BAISC_INFO_DETAILS;
		}
		
		Integer total_fund = 0;
		List<InstituteInfraHrActivityType> params=new ArrayList<>();
		List<TrainingInstituteCurrentStatusDetails> trainingInstituteCurrentStatusDetails=new ArrayList<>();
		List<Domains> domains=new ArrayList<>();
		List<InstitueInfraHrActivity> institueInfraHrActivity=new ArrayList<>();
		List<InstitueInfraHrActivityDetails> institueInfraHrActivityDetails=new ArrayList<>();
		List<TIWiseProposedDomainExperts> tIWiseProposedDomainExperts=new ArrayList<>();
		List<District> districtName=new ArrayList<>();
		params=additionalFacultyAndMainService.fetchHrActvityType();
		model.addAttribute("LIST_OF_ACTIVITY_HR_TYPE", params);
		domains=additionalFacultyAndMainService.fetchDomains();
		model.addAttribute("LIST_OF_DOMAINS", domains);
	    trainingInstituteCurrentStatusDetails=additionalFacultyAndMainService.fetchTiLocation(domains.get(3).getTrainingInstitueType().getTrainingInstitueTypeId());
	    model.addAttribute("LIST_OF_TRAINING_CURRENT_STATUS_DETAILS", trainingInstituteCurrentStatusDetails);
	    districtName=lgdService.getAllDistrictBasedOnState(userPreference.getStateCode());
	    model.addAttribute("LIST_OF_DISTRICT", districtName);
	    model.addAttribute("STATE_CODE", userPreference.getStateCode());
		
	    institueInfraHrActivity=additionalFacultyAndMainService.fetchInstituteHrActivity(null);
		if(!institueInfraHrActivity.isEmpty())
		{
		 	tIWiseProposedDomainExperts=additionalFacultyAndMainService.fetchTiWiseDomainExpertById(institueInfraHrActivity.get(0).getInstituteInfraHrActivityId());
		 	Collections.sort(tIWiseProposedDomainExperts, (o1, o2) -> o1.getTiWiseProposedDomainExpertsId() - o2.getTiWiseProposedDomainExpertsId());
			//additionalFactultyAndMaintModel.setDistrictCode(tIWiseProposedDomainExperts.get(3).getDistrictCode());
			additionalFactultyAndMaintModel.settIWiseProposedDomainExperts(tIWiseProposedDomainExperts);
			model.addAttribute("institueInfraHrActivity", institueInfraHrActivity.get(0));
			institueInfraHrActivityDetails=additionalFacultyAndMainService.fetchInstituteHrActivityDetails(institueInfraHrActivity.get(0).getInstituteInfraHrActivityId());
			additionalFactultyAndMaintModel.setAdditionalRequirementSprc(institueInfraHrActivity.get(0).getAdditionalRequirementSprc());
			additionalFactultyAndMaintModel.setAdditionalRequirementDprc(institueInfraHrActivity.get(0).getAdditionalRequirementDprc());
			Map<String, List<List<String>>> map = basicInfoService.fetchStateAndMoprPreComments(institueInfraHrActivityDetails.size(),14);
			model.addAttribute("STATE_PRE_COMMENTS", map.get("statePreviousComments"));
			model.addAttribute("MOPR_PRE_COMMENTS", map.get("moprPreviousComments"));
			/*
			 * total_fund=calTotalFund(institueInfraHrActivityDetails); for
			 * (InstitueInfraHrActivityDetails details : institueInfraHrActivityDetails) {
			 * if(details.getFund() !=null ){ details.setTotalFund(details.getFund());
			 * total_fund += details.getTotalFund(); } }
			 * additionalFactultyAndMaintModel.setTotal(total_fund);
			 */
			/*
			 * additionalFactultyAndMaintModel.setAdditionalRequirement(
			 * institueInfraHrActivity.get(0).getAdditionalRequirement());
			 */
			/*
			 * if(additionalFactultyAndMaintModel.getAdditionalRequirement() !=null &&
			 * additionalFactultyAndMaintModel.getTotal() != null){
			 * additionalFactultyAndMaintModel.setGrand_total(
			 * additionalFactultyAndMaintModel.getAdditionalRequirement()+
			 * additionalFactultyAndMaintModel.getTotal()); }
			 */
			additionalFactultyAndMaintModel.setInstitueInfraHrActivityDetails(institueInfraHrActivityDetails);
			additionalFactultyAndMaintModel.setDistrictsSupported(institueInfraHrActivity.get(0).getDistrictsSupported());
			model.addAttribute("ISFREEZE", institueInfraHrActivity.get(0).getIsFreeze());
			model.addAttribute("PREVIOUS_RECORD_USER_TYPE", institueInfraHrActivity.get(0).getUserType());
			model.addAttribute("initial_status", false);
		}else{
			model.addAttribute("initial_status", true);
			model.addAttribute("ISFREEZE", false);
		}
		Map<String, ?> param = RequestContextUtils.getInputFlashMap(request);
		if (param != null) {
			
			if ((String) param.get("message") != null && !((String) param.get("message").toString()).isEmpty()) {
				
				if ((String) param.get("message") == "freezed") {
					model.addAttribute("readOnlyEnabled", new Boolean(true));
				} else {
					model.addAttribute("readOnlyEnabled", new Boolean(false));
				}

			}
		}
		
		Integer planStatus=userPreference.getPlanStatus();	
	    Boolean flag= false;
        if(planStatus!=null && planStatus==1 && userPreference.getUserType().equalsIgnoreCase("S")) {
        	flag = true;
		}else if(planStatus!=null && planStatus==2 && userPreference.getUserType().equalsIgnoreCase("M")) {
			flag = true;
		}
      	else {
      		flag= false;
      	}
	    
        model.addAttribute("Plan_Status", flag);
		model.addAttribute("USER_TYPE", userPreference.getUserType());
		model.addAttribute("DISTRICTS_IN_STATE", lgdService.getAllDistrictBasedOnState(userPreference.getStateCode()).size());
//---------------------------------- code for cec ----------------------------------------------	
		if(userPreference.getUserType().equalsIgnoreCase("C")){
			List<InstitueInfraHrActivity> institueInfraHrActivityState=new ArrayList<>();
			List<InstitueInfraHrActivity> institueInfraHrActivityMopr=new ArrayList<>();
			List<InstitueInfraHrActivityDetails> institueInfraHrActivityDetailsState=new ArrayList<>();
			List<InstitueInfraHrActivityDetails> institueInfraHrActivityDetailsMopr=new ArrayList<>();
			List<TIWiseProposedDomainExperts> tIWiseProposedDomainExpertsState=new ArrayList<>();
			List<TIWiseProposedDomainExperts> tIWiseProposedDomainExpertsMopr=new ArrayList<>();
			institueInfraHrActivityState=additionalFacultyAndMainService.fetchInstituteHrActivity("S");
			institueInfraHrActivityMopr=additionalFacultyAndMainService.fetchInstituteHrActivity("M");
			institueInfraHrActivityDetailsState=additionalFacultyAndMainService.fetchInstituteHrActivityDetails(institueInfraHrActivityState.get(0).getInstituteInfraHrActivityId());
			institueInfraHrActivityDetailsMopr=additionalFacultyAndMainService.fetchInstituteHrActivityDetails(institueInfraHrActivityMopr.get(0).getInstituteInfraHrActivityId());
			Collections.sort(institueInfraHrActivityState.get(0).gettIWiseProposedDomainExperts(), (o1,o2)-> o1.getTiWiseProposedDomainExpertsId() - o2.getTiWiseProposedDomainExpertsId());
			Collections.sort(institueInfraHrActivityMopr.get(0).gettIWiseProposedDomainExperts(), (o1,o2)-> o1.getTiWiseProposedDomainExpertsId() - o2.getTiWiseProposedDomainExpertsId());
			tIWiseProposedDomainExpertsState=institueInfraHrActivityState.get(0).gettIWiseProposedDomainExperts();
			tIWiseProposedDomainExpertsMopr=institueInfraHrActivityMopr.get(0).gettIWiseProposedDomainExperts();
			model.addAttribute("institueInfraHrActivityDetailsState", institueInfraHrActivityDetailsState);
			model.addAttribute("institueInfraHrActivityDetailsMopr", institueInfraHrActivityDetailsMopr);
			model.addAttribute("institueInfraHrActivityState", institueInfraHrActivityState.get(0));
			model.addAttribute("institueInfraHrActivityMopr", institueInfraHrActivityMopr.get(0));
			model.addAttribute("tIWiseProposedDomainExpertsState", tIWiseProposedDomainExpertsState);
			model.addAttribute("tIWiseProposedDomainExpertsMopr", tIWiseProposedDomainExpertsMopr);
			model.addAttribute("SELECTED_DISTRICT_IN_STATE", lgdService.getDistrictDetails(userPreference.getStateCode(), tIWiseProposedDomainExpertsState.get(3).getDistrictCode()));
			model.addAttribute("SELECTED_DISTRICT_IN_MOPR", lgdService.getDistrictDetails(userPreference.getStateCode(), tIWiseProposedDomainExpertsMopr.get(3).getDistrictCode()));
			Map<String, Object>	scarL =calTotalOfSpmuAndDpmu(institueInfraHrActivityDetailsState);
			if(!params.isEmpty()) {
				model.addAttribute("SPRC_TOTAL_STATE", scarL.get("spmu_total"));//sprc total for state tab in cec
				model.addAttribute("DPRC_TOTAL_STATE", scarL.get("dpmu_total"));//dprc total for state tab in cec
			}
			scarL.clear();//clear map after using it for state 
			
			scarL=calTotalOfSpmuAndDpmu(institueInfraHrActivityDetailsMopr);
			if(!params.isEmpty()) {
				model.addAttribute("SPRC_TOTAL_MOPR", scarL.get("spmu_total"));//sprc total for mopr tab in cec
				model.addAttribute("DPRC_TOTAL_MOPR", scarL.get("dpmu_total"));//dprc total for mopr tab in cec
			}
			
			return ADD_FACULTY_MAINTENANCE_CEC;
		}else{
			
		return ADD_FACULTY_MAINTENANCE;
		}
	}

	private Map<String, Object> calTotalOfSpmuAndDpmu(List<InstitueInfraHrActivityDetails> institueInfraHrActivityDetails) {
		Map<String, Object> map = new HashMap<String, Object>();
		int spmu_total = 0, dpmu_total = 0;
		if (CollectionUtils.isNotEmpty(institueInfraHrActivityDetails)) {
			for (InstitueInfraHrActivityDetails detail : institueInfraHrActivityDetails) {
				if (detail.getInstituteInfraHrActivityType().getInstituteInfraHrActivityTypeId() < 4) {
					if (detail.getFund() != null)
						spmu_total += detail.getFund();
				} else {
					if (detail.getFund() != null)
						dpmu_total += detail.getFund();
				}
			}
			map.put("spmu_total", spmu_total);
			map.put("dpmu_total", dpmu_total);
			
		} 
		return map;
	}

	@RequestMapping(value="addFacultyAndMaintenanceHrBudget",method = RequestMethod.POST)
	private String adminFacultyAndMaintenancePost(@ModelAttribute("ADDITIONAL_FACULTY_MAINT_MODEL") AdditionalFactultyAndMaintModel additionalFactultyAndMaintModel,Model model,RedirectAttributes redirectAttributes)
	{
		additionalFacultyAndMainService.saveAddFacAndMain(additionalFactultyAndMaintModel);
		if(additionalFactultyAndMaintModel.getDbFileName().equals("freeze"))
		{
			redirectAttributes.addFlashAttribute("message", "freezed");
			redirectAttributes.addFlashAttribute(Message.SUCCESS_KEY,Message.FRIZEE_SUCESS);
		}
		else if(additionalFactultyAndMaintModel.getDbFileName().equals("unfreeze"))
		{
			redirectAttributes.addFlashAttribute("message", "unfreezed");
			redirectAttributes.addFlashAttribute(Message.SUCCESS_KEY, Message.UNFRIZEE_SUCESS);
		}else{
		redirectAttributes.addFlashAttribute(Message.SUCCESS_KEY, Message.SAVE_SUCCESS);}
		return REDIRECT_ADD_FACULTY_MAINTENANCE ;
      }
}

