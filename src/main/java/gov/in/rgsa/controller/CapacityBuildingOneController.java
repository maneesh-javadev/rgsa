package gov.in.rgsa.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import gov.in.rgsa.entity.CBMaster;
import gov.in.rgsa.entity.CapacityBuildingActivity;
import gov.in.rgsa.entity.CapacityBuildingActivityGPs;
import gov.in.rgsa.entity.District;
import gov.in.rgsa.entity.State;
import gov.in.rgsa.model.Response;
import gov.in.rgsa.service.BasicInfoService;
import gov.in.rgsa.service.CBMasterService;
import gov.in.rgsa.service.CapacityBuildingService;
import gov.in.rgsa.service.LGDService;
import gov.in.rgsa.user.preference.UserPreference;
import gov.in.rgsa.utils.Message;

@Controller
public class CapacityBuildingOneController {
	
	private static final String CAPACITY_BUILDING = "capacityBuildingOne";
	private static final String CB_ACTIVITY_GPs = "cbActivityGPs";
	public static final String REDIRECT_BAISC_INFO_DETAILS = "redirect:basicinfo.add.html";
	public static final String REDIRECT_MODIFY_BAISC_INFO_DETAILS = "redirect:managebasicInfoDetails.html";

	private static final String CAPACITY_BUILDING_CEC = "capacityBuildingCec";
	
	@Autowired
	private CBMasterService cbMasterService;
	
	@Autowired
	private UserPreference userPreference;
	
	@Autowired
	private LGDService lgdService;
	
	@Autowired
	private CapacityBuildingService capacityBuildingService;
	
	@Autowired
	BasicInfoService basicInfoService;
	
	@RequestMapping(value="capacitybuild",method=RequestMethod.GET)
	private String capacityBuildingGet(@RequestParam(value = "menuId") int menuId , Model model,RedirectAttributes redirectAttributes)
	{
		userPreference.setMenuId(menuId);
		
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
	      model.addAttribute("STATE_CODE", userPreference.getStateCode());
	      
	      
		if(userPreference.getUserType().equalsIgnoreCase("C")){
			
			return CAPACITY_BUILDING_CEC;
		}else{
			return CAPACITY_BUILDING;
		}
	}

	@ResponseBody
	@RequestMapping(value="fetchCBMastersAndCapacityBuildingData",method=RequestMethod.GET)
	private Map<String, Object> fetchCBMasters(){
		Map<String, Object> map=new HashMap<>();

		List<CBMaster> cbMasters = new ArrayList<CBMaster>();
		cbMasters = cbMasterService.fetchCBMasters();
		map.put("cbMasters", cbMasters);
		CapacityBuildingActivity capacityBuildingList = capacityBuildingService.fetchCapacityBuildingActivity(null);
		if(capacityBuildingList != null && capacityBuildingList.getUserType() == 'S' && userPreference.getUserType().charAt(0) =='M') {
			capacityBuildingList.setIsFreeze(false);
			}
		map.put("capacityBuildingDetails", capacityBuildingList);
		map.put("userType", userPreference.getUserType().charAt(0));
		map.put("capacityBuildingDetails", capacityBuildingService.fetchCapacityBuildingActivity(null));
		
		return map;
	}
	
	@RequestMapping(value="saveCapacityBuildingActivityAndDetails",method=RequestMethod.POST)
	private String saveCapacityBuildingActivityAndDetails(@RequestBody final CapacityBuildingActivity capacityBuildingActivity,RedirectAttributes re) {
		capacityBuildingService.saveCapacityBuildingActivityAndDetails(capacityBuildingActivity);
		re.addFlashAttribute(Message.SUCCESS_KEY, Message.SAVE_SUCCESS);
		if(userPreference.getUserType().equalsIgnoreCase("C")){
			return CAPACITY_BUILDING_CEC;
		}else{
			return CAPACITY_BUILDING;
		}
	}
	
	
	@RequestMapping(value="saveCapacityBuildingCEC",method=RequestMethod.POST)
	private @ResponseBody Response saveCapacityBuildingCEC(@RequestBody final CapacityBuildingActivity capacityBuildingActivity,HttpServletRequest request) {
		//capacityBuildingService.saveCapacityBuildingActivityAndDetails(capacityBuildingActivity);
		
		//re.addFlashAttribute(Message.SUCCESS_KEY, Message.SAVE_SUCCESS);
		capacityBuildingService.saveCapacityBuildingActivityAndDetails(capacityBuildingActivity);
		Response response = new Response();
		response.setResponseMessage(Message.SAVE_SUCCESS);
		response.setResponseCode(200);
		return response;
	}
	

	@ResponseBody
	@RequestMapping(value="getTrgActivityCecMoprData",method=RequestMethod.GET)
	private Map<String, Object> getTrgActivityCecMoprData(Model model){
		Map<String, Object> map=new HashMap<>();

		List<CBMaster> cbMasters = new ArrayList<CBMaster>();
		cbMasters = cbMasterService.fetchCBMasters();
		map.put("cbMasters", cbMasters);
		map.put("userType", userPreference.getUserType().charAt(0));
		model.addAttribute("STATE_CODE", userPreference.getStateCode());
		map.put("capacityBuildingDetails", capacityBuildingService.fetchCapacityBuildingActivity(null));
		map.put("trg_activity_state", capacityBuildingService.fetchCapacityBuildingActivity('S'));
		map.put("trg_activity_mopr", capacityBuildingService.fetchCapacityBuildingActivity('M'));
		return map;
	}

	@ResponseBody
	@RequestMapping(value="feezUnFreezCapacityBuilding", method=RequestMethod.POST)
	private CapacityBuildingActivity feezUnFreezPesaPlan(@RequestBody CapacityBuildingActivity capacityBuildingActivity) {
		return capacityBuildingService.feezUnFreezCapacityBuildingActivity(capacityBuildingActivity);
	}
	
	
	@RequestMapping(value="capacitybuildGPs",method=RequestMethod.GET)
	private String capacitybuildGPs()
	{
		
		return CB_ACTIVITY_GPs;
	}
	
	
	@RequestMapping(value="saveCapacitybuildGPs",method=RequestMethod.POST)
	public @ResponseBody Response capacitybuildGPs(@RequestBody final List<CapacityBuildingActivityGPs> capacityBuildingActivityGPsList,HttpServletRequest request, HttpServletResponse httpServletResponse) {
	return capacityBuildingService.saveCBFinalizeWorkLocaion(capacityBuildingActivityGPsList);
	}
	
	@RequestMapping(value = "fetchCapacityBuildingActivityGPs", method = RequestMethod.GET)
	private @ResponseBody List<CapacityBuildingActivityGPs> fetchCapacityBuildingActivityGPs(Integer capacityBuildingActivityDetailsId,Integer cbMasterId) {
		return capacityBuildingService.fetchCapacityBuildingActivityGPsList(capacityBuildingActivityDetailsId, cbMasterId);
	}
	
	@RequestMapping(value = "fetchDistrictsbyStateCode", method = RequestMethod.GET)
	private @ResponseBody List<District> fetchDistrictsbyStateCode(Integer stateCode) {
		return lgdService.getAllDistrictBasedOnState(stateCode);
	}
	
	@RequestMapping(value = "fetchAllState", method = RequestMethod.GET)
	private @ResponseBody List<State> fetchAllState() {
		return lgdService.getAllStateList();
	}
}
