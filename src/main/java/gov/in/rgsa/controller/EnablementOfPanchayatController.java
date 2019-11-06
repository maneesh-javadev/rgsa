package gov.in.rgsa.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.collections.CollectionUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import gov.in.rgsa.entity.CapacityBuildingActivityGPs;
import gov.in.rgsa.entity.EEnablemenEntity;
import gov.in.rgsa.entity.EEnablement;
import gov.in.rgsa.entity.EEnablementDetails;
import gov.in.rgsa.entity.EEnablementGPs;
import gov.in.rgsa.model.EnablementOfPanchayatModel;
import gov.in.rgsa.model.Response;
import gov.in.rgsa.service.BasicInfoService;
import gov.in.rgsa.service.EEnablementOfPanchayatService;
import gov.in.rgsa.user.preference.UserPreference;
import gov.in.rgsa.utils.Message;

@Controller
public class EnablementOfPanchayatController {

	@Autowired
	private EEnablementOfPanchayatService enablementOfPanchayatService;
	@Autowired
	BasicInfoService basicInfoService;
	
	@Autowired
	private UserPreference userPreference;

	private static final String ENABLE_PANCHAYAT = "enablePanchayat";
	private static final String REDIRECT_ENABLE_PANCHAYAT = "redirect:enablepanchayat.html";
	private static final String ENABLE_PANCHAYAT_GPs = "enablePanchayatGPs";
	public static final String REDIRECT_BAISC_INFO_DETAILS = "redirect:basicinfo.add.html";
	public static final String REDIRECT_MODIFY_BAISC_INFO_DETAILS = "redirect:managebasicInfoDetails.html";
          private static final String ENABLEMENT_CEC = "enablementCEC";




 

	@RequestMapping(value = "enablepanchayat", method = RequestMethod.GET)
	private String eEnablementGet(@ModelAttribute("ENABLEMENT_OF_PANCHAYAT_MODEL") EnablementOfPanchayatModel form ,Model model,RedirectAttributes redirectAttributes) {
		
		String status = basicInfoService.fillFirstBasicInfo();
		if(status.equals("create")) {
			redirectAttributes.addFlashAttribute(Message.EXCEPTION_KEY, "Please fill the Basic Info Details first");
			return REDIRECT_BAISC_INFO_DETAILS;
		}
		else if(status.equals("modify")) {
			redirectAttributes.addFlashAttribute(Message.EXCEPTION_KEY, "Please fill the Required Basic Info Details");
			return REDIRECT_MODIFY_BAISC_INFO_DETAILS;
		}
		
		
		model.addAttribute("INFRA_RESOURCE_LIST", enablementOfPanchayatService.fetchEEnablementMaster());
		model.addAttribute("user_type",userPreference.getUserType().charAt(0));
		
		List<EEnablement> enablement=enablementOfPanchayatService.fetchEnablement(userPreference.getUserType().charAt(0));
		List<EEnablementDetails> enablementDetails = new ArrayList<EEnablementDetails>();
		
		if(enablement!=null){
			List<EEnablementDetails> details=enablement.get(0).geteEnablementDetails();
			enablement.get(0).seteEnablementDetails(null);
	        model.addAttribute("details", details);
			model.addAttribute("enablement", enablement);
		}
		
		if(!CollectionUtils.isEmpty(enablement)){
			model.addAttribute("enablement", enablement.get(0));
			enablementDetails = enablementOfPanchayatService.fetchEnablementDetails(enablement.get(0).geteEnablementId());
			form.seteEnablementDetails(enablementDetails);
			Map<String, List<List<String>>> map = basicInfoService.fetchStateAndMoprPreComments(enablementDetails.size(),5);
			model.addAttribute("STATE_PRE_COMMENTS", map.get("statePreviousComments"));
			model.addAttribute("MOPR_PRE_COMMENTS", map.get("moprPreviousComments"));
			form.setAdditionalRequirement(enablement.get(0).getAdditionalRequirement());
			model.addAttribute("INITIAL_FLAG", false);
		}else{
			model.addAttribute("INITIAL_FLAG", true);
		}

  
		model.addAttribute("STATE_CODE", userPreference.getStateCode());
		if(userPreference.getUserType().equalsIgnoreCase("C")){
		List<EEnablement> enablementForState=enablementOfPanchayatService.fetchEnablement('S');
		List<EEnablement> enablementForMOPR=enablementOfPanchayatService.fetchEnablement('M');
		List<EEnablementDetails> enablementDetailsForState=enablementOfPanchayatService.fetchEnablementDetails(enablementForState.get(0).geteEnablementId());
		List<EEnablementDetails> enablementDetailsForMOPR=enablementOfPanchayatService.fetchEnablementDetails(enablementForMOPR.get(0).geteEnablementId());
		model.addAttribute("enablementDetailsForState", enablementDetailsForState);
		model.addAttribute("enablementDetailsForMOPR", enablementDetailsForMOPR);
		form.setAdditionalRequirementForState(enablementForState.get(0).getAdditionalRequirement());
	          form.setAdditionalRequirementForMopr(enablementForMOPR.get(0).getAdditionalRequirement());	
		return ENABLEMENT_CEC;
		}else{
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
		return ENABLE_PANCHAYAT;
		}
	}	
	
	@RequestMapping(value="enablepanchayat",method = RequestMethod.POST)
	private String eEnablementPost(@ModelAttribute("ENABLEMENT_OF_PANCHAYAT_MODEL") EEnablement enablement ,RedirectAttributes re)
	{
		enablementOfPanchayatService.saveEEnablement(enablement);
		if(enablement.getStatus().equals("f")){
			re.addFlashAttribute(Message.SUCCESS_KEY,Message.FRIZEE_SUCESS);	
		}else if(enablement.getStatus().equals("s")){
			re.addFlashAttribute(Message.SUCCESS_KEY, Message.SAVE_SUCCESS);
		}else{
			re.addFlashAttribute(Message.SUCCESS_KEY, Message.UNFRIZEE_SUCESS);
		}
		return REDIRECT_ENABLE_PANCHAYAT;
	}
	
	@RequestMapping(value = "fetchEEnablementList", method = RequestMethod.GET)
	private @ResponseBody List<EEnablementDetails> fetchEEnablementList(Integer eEnablementId) {
		  return enablementOfPanchayatService.fetchEnablementDetails(eEnablementId);
	}
	
	@RequestMapping(value="enablepanchayatfinalizeWorkLocation",method=RequestMethod.GET)
	private String epanchayatfinalizeWorkLocation()
	{
		return ENABLE_PANCHAYAT_GPs;
	}
	
	@RequestMapping(value = "fetchEEnablemenEntityList", method = RequestMethod.GET)
	private @ResponseBody List<EEnablemenEntity> fetchEEnablemenEntityList() {
		  return enablementOfPanchayatService.fetchEEnablemenEntityDetails();
	}
	
	@RequestMapping(value="saveEnablemenGPs",method=RequestMethod.POST)
	public @ResponseBody Response saveEnablemenGPs(@RequestBody final List<EEnablementGPs> eEnablementGPsList,HttpServletRequest request, HttpServletResponse httpServletResponse) {
	return enablementOfPanchayatService.saveEnablemenGPs(eEnablementGPsList);
	}
	
	@RequestMapping(value = "fetchEEnablementGPs", method = RequestMethod.GET)
	private @ResponseBody List<EEnablementGPs> fetchEEnablementGPs(Integer eEnablementDetailsId) {
		return enablementOfPanchayatService.fetchCapacityBuildingActivityGPsList(eEnablementDetailsId);
	}
	
	@RequestMapping(value = "fetchEEnablemenEntityListCEC", method = RequestMethod.GET)
	private @ResponseBody List<EEnablemenEntity> fetchEEnablemenEntityListCEC() {
		  return enablementOfPanchayatService.fetchEEnablemenEntityDetailsCEC();
	}
	
}

