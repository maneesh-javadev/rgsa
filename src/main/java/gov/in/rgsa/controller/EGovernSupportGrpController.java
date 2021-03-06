package gov.in.rgsa.controller;


import java.util.ArrayList;
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

import gov.in.rgsa.entity.EGovSupportActivity;
import gov.in.rgsa.entity.EGovSupportActivityDetails;
import gov.in.rgsa.model.EGovernanceSupportModel;
import gov.in.rgsa.service.BasicInfoService;
import gov.in.rgsa.service.EGovernanceSupportService;
import gov.in.rgsa.service.LGDService;
import gov.in.rgsa.user.preference.UserPreference;
import gov.in.rgsa.utils.Message;

@Controller
public class EGovernSupportGrpController {
	
	@Autowired
	public EGovernanceSupportService eGovernanceSupportService;
	
	@Autowired
	private UserPreference userPreference;
	
	@Autowired
	BasicInfoService basicInfoService;

	@Autowired
	private LGDService lgdService;
	
	private static final String GOVERN_SUPPORT ="eGovernanceSupportGrp";
	private static final String GOVERN_SUPPORT_FOR_CEC ="egovernanceCEC";
	private static final String REDIRECT_GOVERN_SUPPORT = "redirect:egovernancesupportgroup.html";
	public static final String REDIRECT_BAISC_INFO_DETAILS = "redirect:basicinfo.add.html";
	public static final String REDIRECT_MODIFY_BAISC_INFO_DETAILS = "redirect:managebasicInfoDetails.html";

	@RequestMapping(value="egovernancesupportgroup", method=RequestMethod.GET)
	private String eGovernSupportGet(@ModelAttribute("EGOVERN_MODEL") EGovernanceSupportModel form ,Model model,HttpServletRequest request,RedirectAttributes redirectAttributes)
	{
		String status = basicInfoService.fillFirstBasicInfo();
		if(status.equals("create")) {
			redirectAttributes.addFlashAttribute(Message.EXCEPTION_KEY, "Please fill the Basic Info Details first");
			return REDIRECT_BAISC_INFO_DETAILS;
		}
		else if(status.equals("modify")) {
			redirectAttributes.addFlashAttribute(Message.EXCEPTION_KEY, "Please fill the Required Basic Info Details");
			return REDIRECT_MODIFY_BAISC_INFO_DETAILS;
		}
		
		model.addAttribute("LIST_OF_POST_LEVEL", eGovernanceSupportService.fetchPostLevel());
		model.addAttribute("USER_TYPE", userPreference.getUserType().charAt(0));
		model.addAttribute("STATE_CODE", userPreference.getStateCode());
		List<EGovSupportActivity> eGovActivity = new ArrayList<EGovSupportActivity>();
		List<EGovSupportActivityDetails> eGovActivityDetails = new ArrayList<EGovSupportActivityDetails>();
		eGovActivity=eGovernanceSupportService.fetchEGovActivity(userPreference.getUserType().charAt(0));
	   
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
		
		if(eGovActivity!=null){
			List<EGovSupportActivityDetails> details=eGovActivity.get(0).geteGovSupportActivityDetails();
			eGovActivity.get(0).seteGovSupportActivityDetails(null);
	        model.addAttribute("details", details);
			model.addAttribute("eGovActivity", eGovActivity);
		}
		if (!CollectionUtils.isEmpty(eGovActivity)) {
			model.addAttribute("eGovActivity", eGovActivity.get(0));
			eGovActivityDetails = eGovernanceSupportService
					.fetchEGovActivityDetails(eGovActivity.get(0).geteGovSupportActivityId());
			form.seteGovSupportActivityDetails(eGovActivityDetails);
			Map<String, List<List<String>>> map = basicInfoService.fetchStateAndMoprPreComments(eGovActivityDetails.size(),15);
			model.addAttribute("STATE_PRE_COMMENTS", map.get("statePreviousComments"));
			model.addAttribute("MOPR_PRE_COMMENTS", map.get("moprPreviousComments"));
			form.setAdditionalRequirementSpmu(eGovActivity.get(0).getAdditionalRequirementSpmu());
			form.setAdditionalRequirementDpmu(eGovActivity.get(0).getAdditionalRequirementDpmu());
			form.setNoOfDistrictSupported(eGovActivity.get(0).getNoOfDistrictSupported());
			model.addAttribute("initial_status", false);
		}else{
			model.addAttribute("initial_status", true);
		}
		model.addAttribute("DISTRICTS_IN_STATE", lgdService.getAllDistrictBasedOnState(userPreference.getStateCode()).size());
		if(userPreference.getUserType().equalsIgnoreCase("C")){
			List<EGovSupportActivity> eGovActivityForState=eGovernanceSupportService.fetchEGovActivity('S');
			List<EGovSupportActivity> eGovActivityForMOPR = eGovernanceSupportService.fetchEGovActivity('M');
			if(!CollectionUtils.isEmpty(eGovActivityForMOPR)){
				model.addAttribute("eGovActivityForMOPR", eGovActivityForMOPR.get(0));
			}
			if(CollectionUtils.isNotEmpty(eGovActivityForState)){
				eGovActivityForState.get(0).seteGovSupportActivityDetails(eGovernanceSupportService.fetchEGovActivityDetails(eGovActivityForState.get(0).geteGovSupportActivityId()));
				model.addAttribute("eGovActivityForState", eGovActivityForState.get(0));
			}
			Map<String, Object>	params =calTotalOfSpmuAndDpmu(eGovActivityForState);
			if(!params.isEmpty()) {
				model.addAttribute("SPMU_TOTAL_STATE", params.get("spmu_total"));//spmu total for state tab in cec
				model.addAttribute("DPMU_TOTAL_STATE", params.get("dpmu_total"));//dpmu total for state tab in cec
			}
			params.clear();//clear map after using it for state 
			
			params=calTotalOfSpmuAndDpmu(eGovActivityForMOPR);
			if(!params.isEmpty()) {
				model.addAttribute("SPMU_TOTAL_MOPR", params.get("spmu_total"));//spmu total for mopr tab in cec
				model.addAttribute("DPMU_TOTAL_MOPR", params.get("dpmu_total"));//dpmu total for mopr tab in cec
			}
			return GOVERN_SUPPORT_FOR_CEC;
		}else{
			return GOVERN_SUPPORT;
		}
	}
	
	private Map<String, Object> calTotalOfSpmuAndDpmu(List<EGovSupportActivity> eGovActivityForState) {
		Map<String, Object> map = new HashMap<String, Object>();
		int spmu_total = 0, dpmu_total = 0;
		if (CollectionUtils.isNotEmpty(eGovActivityForState)) {
			for (EGovSupportActivityDetails detail : eGovActivityForState.get(0).geteGovSupportActivityDetails()) {
				if (detail.geteGovPostId() < 5) {
					if (detail.getFunds() != null)
						spmu_total += detail.getFunds();
				} else {
					if (detail.getFunds() != null)
						dpmu_total += detail.getFunds();
				}
			}
			map.put("spmu_total", spmu_total);
			map.put("dpmu_total", dpmu_total);
			
		} 
		return map;
	}

	/*
	 * private int calTotal(List<EGovSupportActivity> activity){ int total_fund=0;
	 * if (activity != null) { List<EGovSupportActivityDetails> details =
	 * activity.get(0).geteGovSupportActivityDetails();
	 * if(!CollectionUtils.isEmpty(details)){ for (EGovSupportActivityDetails
	 * eGovSupportActivityDetails : details) { if
	 * (eGovSupportActivityDetails.getFunds() != null) { total_fund +=
	 * eGovSupportActivityDetails.getFunds(); } }
	 * 
	 * } } return total_fund; }
	 */
	
	@RequestMapping(value="egovernancesupportgroup",method=RequestMethod.POST)
	private String eGovernSupportPost( @ModelAttribute("EGOVERN_MODEL") EGovSupportActivity eGovSupportActivity ,RedirectAttributes re) {
		eGovernanceSupportService.saveEGovSupportActivity(eGovSupportActivity);
		re.addFlashAttribute(Message.SUCCESS_KEY, Message.SAVE_SUCCESS);
		return REDIRECT_GOVERN_SUPPORT;
	}
	
	@RequestMapping(value="freezAndUnfreez" , method=RequestMethod.POST) 
	public String freezeUnfreezemethod(@ModelAttribute("EGOVERN_MODEL") EGovernanceSupportModel form ,RedirectAttributes re) {
		eGovernanceSupportService.freezeAndUnfreeze(form);
		if(form.getDbFileName().equals("freeze")) {
		re.addFlashAttribute(Message.SUCCESS_KEY,Message.FRIZEE_SUCESS);}
		else {
		re.addFlashAttribute(Message.SUCCESS_KEY, Message.UNFRIZEE_SUCESS);}
		return  REDIRECT_GOVERN_SUPPORT;
    }

}

