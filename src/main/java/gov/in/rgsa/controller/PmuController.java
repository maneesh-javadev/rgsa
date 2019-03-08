package gov.in.rgsa.controller;

import java.util.Collections;
import java.util.Comparator;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.collections.CollectionUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import gov.in.rgsa.entity.PmuActivity;
import gov.in.rgsa.entity.PmuWiseProposedDomainExperts;
import gov.in.rgsa.service.LGDService;
import gov.in.rgsa.service.BasicInfoService;
import gov.in.rgsa.service.PmuActivityService;
import gov.in.rgsa.user.preference.UserPreference;
import gov.in.rgsa.utils.Message;


/**
 * @author MOhammad Ayaz 04/10/2018
 *
 */
@Controller
public class PmuController {
	
	@Autowired
	private PmuActivityService activityService;
	
	@Autowired
	private UserPreference userPreference;
	@Autowired
	BasicInfoService basicInfoService;
	
	@Autowired
	private LGDService lgdservice;
	
	private static final String PMU = "pmu";
	private static final String REDIRECT_PMU = "redirect:pmu.html";
	public static final String REDIRECT_BAISC_INFO_DETAILS = "redirect:basicinfo.add.html";
	public static final String REDIRECT_MODIFY_BAISC_INFO_DETAILS = "redirect:managebasicInfoDetails.html";

	private static final String PMU_CEC = "pmuCEC";

	@RequestMapping(value="pmu",method=RequestMethod.GET)
	private String managePmuActivityMethod(@ModelAttribute("PMU_ACTIVITY") PmuActivity pmuActivity,Model model,HttpServletRequest request,RedirectAttributes redirectAttributes)
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
		model.addAttribute("LIST_OF_ACTIVITY_PMU_TYPE", activityService.fetchPmuActvityType());
		model.addAttribute("LIST_OF_PMU_DOMAINS", activityService.fetchPmuDomains());
		model.addAttribute("LIST_OF_DISTRICT", activityService.fetchDistrictName());
		model.addAttribute("user_type",userPreference.getUserType().charAt(0));
		List<PmuActivity> pmuActivitiesList = activityService.fetchPmuActivity(userPreference.getUserType().charAt(0));
		if(!CollectionUtils.isEmpty(pmuActivitiesList)) {
			/*List<PmuWiseProposedDomainExperts> proposedDomainExpertsList = activityService.fetchPmuWiseDomainExpert();*/
			List<PmuWiseProposedDomainExperts> proposedDomainExpertsList = pmuActivitiesList.get(0).getPmuWiseProposedDomainExperts();
			if(proposedDomainExpertsList != null && !proposedDomainExpertsList.isEmpty())
			Collections.sort(proposedDomainExpertsList, Comparator.comparing(PmuWiseProposedDomainExperts::getPmuWiseProposedDomainExpertsId));
			/*pmuActivitiesList.get(0).setSetDistrictIdPmuWise(proposedDomainExpertsList.get(0).getDistrictId());*/
			pmuActivitiesList.get(0).setSetDistrictIdPmuWise(proposedDomainExpertsList.get(3).getDistrictId());
		model.addAttribute("pmuActivity", pmuActivitiesList.get(0));
		model.addAttribute("pmuWiseDomainList", proposedDomainExpertsList);
		model.addAttribute("initial_status", false);
		
		}else{
			model.addAttribute("initial_status", true);
		}
		model.addAttribute("STATE_CODE", userPreference.getStateCode());
		if(userPreference.getUserType().equalsIgnoreCase("C")){
			List<PmuActivity> pmuActivityState=activityService.fetchPmuActivity('S');
			List<PmuActivity> pmuActivityMOPR=activityService.fetchPmuActivity('M');
			model.addAttribute("pmuActivityState", pmuActivityState.get(0));
			model.addAttribute("pmuActivityMOPR", pmuActivityMOPR.get(0));
			model.addAttribute("pmuWiseDomainListState", pmuActivityState.get(0).getPmuWiseProposedDomainExperts());
			model.addAttribute("pmuWiseDomainListMOPR", pmuActivityMOPR.get(0).getPmuWiseProposedDomainExperts());
			model.addAttribute("DISTRICT_DETAILS_STATE", lgdservice.getDistrictDetails(userPreference.getStateCode(), pmuActivityState.get(0).getPmuWiseProposedDomainExperts().get(3).getDistrictId()) );
			model.addAttribute("DISTRICT_DETAILS_MOPR",lgdservice.getDistrictDetails(userPreference.getStateCode(), pmuActivityMOPR.get(0).getPmuWiseProposedDomainExperts().get(3).getDistrictId()));
			return PMU_CEC;
		}else{
			return PMU;
		}
	}
	
	@RequestMapping(value="addUpdatePmu",method=RequestMethod.POST)
	private String addUpdateMethod(@ModelAttribute("PMU_ACTIVITY") PmuActivity pmuActivity,Model model,HttpServletRequest request,RedirectAttributes redirectAttributes) {
		activityService.saveAndUpdate(pmuActivity);
		redirectAttributes.addFlashAttribute(Message.SUCCESS_KEY, Message.SAVE_SUCCESS);
		return REDIRECT_PMU;
	}
	
	@RequestMapping(value="pmuFreezUnfreez",method=RequestMethod.POST)
	private String pmuFreezUnfreez(@ModelAttribute("PMU_ACTIVITY")PmuActivity pmuActivity,RedirectAttributes redirectAttributes) {
			activityService.pmuFreezUnfreeze(pmuActivity);
			if(pmuActivity.getIsFreeze() == true) {
			redirectAttributes.addFlashAttribute(Message.UPDATE_KEY, "UnFreezed Successfully");}
			else {
				redirectAttributes.addFlashAttribute(Message.UPDATE_KEY, "Freezed Successfully");}
		return REDIRECT_PMU;
	}
	
}
