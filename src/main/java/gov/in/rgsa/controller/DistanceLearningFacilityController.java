package gov.in.rgsa.controller;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.collections.CollectionUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import gov.in.rgsa.entity.AdministrativeTechnicalSupport;
import gov.in.rgsa.entity.SatcomActivity;
import gov.in.rgsa.entity.SatcomActivityDetails;
import gov.in.rgsa.service.ActionPlanService;
import gov.in.rgsa.service.BasicInfoService;
import gov.in.rgsa.service.SatcomFacilityService;
import gov.in.rgsa.user.preference.UserPreference;
import gov.in.rgsa.utils.Message;

@Controller
public class DistanceLearningFacilityController {
	
	private static final String DISTANCE_LEARNING = "distanceLearningFacility";
	public static final String REDIRECT_BAISC_INFO_DETAILS = "redirect:basicinfo.add.html";
	public static final String REDIRECT_MODIFY_BAISC_INFO_DETAILS = "redirect:managebasicInfoDetails.html";
	
	@Autowired
	private SatcomFacilityService satcomFacilityService;
	
	@Autowired
	private ActionPlanService actionPlanService;
	
	@Autowired
	private UserPreference userPreference;
	
	@Autowired
	BasicInfoService basicInfoService;
	
	public String userType=null;

	@RequestMapping(value="distancelearningfacility",method=RequestMethod.GET)
	private String distanceLearningGet(@RequestParam(value = "menuId") int menuId ,Model model,RedirectAttributes redirectAttributes)
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
		userPreference.setMenuId(menuId);
		this.userType ='S'+"";
		return DISTANCE_LEARNING;
	}
	
	@RequestMapping(value = "distanceLearningGetMOPR", method = RequestMethod.GET)
	private String distanceLearningGetForMOPR(@ModelAttribute("ADMIN_TECH_MODEL") AdministrativeTechnicalSupport support, Model model) {
		this.userType = 'M'+"";
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
	      model.addAttribute("STATE_CODE", userPreference.getStateCode());
		return DISTANCE_LEARNING;
	}
	
	@RequestMapping(value = "distanceLearningGetCEC", method = RequestMethod.GET)
	private String distanceLearningGetForCEC(@ModelAttribute("ADMIN_TECH_MODEL") AdministrativeTechnicalSupport support, Model model) {
		this.userType = 'C'+"";
		return DISTANCE_LEARNING;
	}
	
	@ResponseBody
	@RequestMapping(value="getOnLoadData", method = RequestMethod.GET, produces=MediaType.APPLICATION_JSON_VALUE)
	private Map<String, Object> getPanchayatBhawanActivity() {
		Map<String, Object> map=new HashMap<>();
		if(userPreference.getUserType().equalsIgnoreCase("C")){
			List<SatcomActivity> satcomActivityState=new ArrayList<>();
			List<SatcomActivity> satcomActivityMOPR=new ArrayList<>();
			satcomActivityState=satcomFacilityService.fetchSatcomActivities("S");
			satcomActivityMOPR=satcomFacilityService.fetchSatcomActivities("M");
			if(!CollectionUtils.isEmpty(satcomActivityState)){
				map.put("satcomActivityState", satcomActivityState.get(0));
			}
			if(!CollectionUtils.isEmpty(satcomActivityMOPR)){
				map.put("satcomActivityMOPR", satcomActivityMOPR.get(0));
			}
		}
		map.put("SATCOME_ACTIVITY", satcomFacilityService.getSatcomeActivityName());
		map.put("SATCOM_LEVEL", satcomFacilityService.getSatcomeLevel());
		List<SatcomActivity> activities= null;
		activities = satcomFacilityService.fetchSatcomActivities(userPreference.getUserType());
		if(activities != null && !activities.isEmpty())
		Collections.sort(activities.get(0).getActivityDetails(), Comparator.comparing(SatcomActivityDetails::getSatcomActivityDetailsId));
		
		if(!CollectionUtils.isEmpty(activities)){
			map.put("SATCOME_ACTIVITY_DETAILS", activities.get(0));
		}
		map.put("userType", userPreference.getUserType());
		return map;
	}
	
	@RequestMapping(value="saveSatcomFacility", method=RequestMethod.POST)
	@ResponseBody
	private Map<String, Object> saveSatcomFacility(@RequestBody SatcomActivity satcomActivity,RedirectAttributes re) {
		Map<String, Object> map=new HashMap<>();
		satcomFacilityService.saveSatcomeFacility(satcomActivity,userPreference.getUserType());
		//actionPlanService.actionPlanStatus();  PLAN INITIAL VALUE FROM BASCI INFO FORM 
		List<SatcomActivity> activities=satcomFacilityService.fetchSatcomActivities(userPreference.getUserType());
		if(!CollectionUtils.isEmpty(activities)){
			map.put("SATCOME_ACTIVITY_DETAILS", activities.get(0));
		}
		return map;
	}
	

}
