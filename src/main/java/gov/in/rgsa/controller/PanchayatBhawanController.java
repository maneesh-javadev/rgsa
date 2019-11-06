package gov.in.rgsa.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import gov.in.rgsa.entity.GramPanchayat;
import gov.in.rgsa.entity.PanchatayBhawanActivity;
import gov.in.rgsa.entity.PanchayatBhawanProposedInfo;
import gov.in.rgsa.entity.PanchyatBhawanCurrentStatus;
import gov.in.rgsa.model.Response;
import gov.in.rgsa.service.BasicInfoService;
import gov.in.rgsa.service.LGDService;
import gov.in.rgsa.service.PanchayatBhawanService;
import gov.in.rgsa.user.preference.UserPreference;
import gov.in.rgsa.utils.Message;

@Controller
public class PanchayatBhawanController {

	private static final String PANCHAYAT_BHAWAN = "panchayatBhawan";
	private static final String PANCHAYAT_BHAWAN_CURR_STATUS = "panchayatBhawanCurrStatus";
	private static final String FINALIZE_WORK_LOCATION = "finalizeWorkLocation";
	public static final String REDIRECT_BAISC_INFO_DETAILS = "redirect:basicinfo.add.html";
	public static final String REDIRECT_MODIFY_BAISC_INFO_DETAILS = "redirect:managebasicInfoDetails.html";
	private static final String PANCHAYAT_BHAWAN_CEC = "panchayatBhawanCec";
	private static final String CEC_USER_TYPE="C";
	@Autowired
	private PanchayatBhawanService panchayatBhawanService;
	
	@Autowired
	private LGDService lgdService;
	
	@Autowired
	UserPreference userPreference;
	
	@Autowired
	BasicInfoService basicInfoService;

	@RequestMapping(value="panchayatbhawan",method = RequestMethod.GET)
	public String panchayatBhawanGet(RedirectAttributes redirectAttributes,Model model)
	{
		System.out.println("panchayatbhawan...>!");
		/*
		 * userPreference.setMenuId(menuId); @RequestParam(value = "menuId") int menuId
		 * , this line is commented for forward plan button as menu id in side bar jsp is used but we dont want it
		 */
		model.addAttribute("STATE_CODE", userPreference.getStateCode());
		if(userPreference.getUserType().equalsIgnoreCase("C")){
		return PANCHAYAT_BHAWAN_CEC;
		}else{
		String status = basicInfoService.fillFirstBasicInfo();
		if(status.equals("dataFound")) {
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
			return PANCHAYAT_BHAWAN;
		}
		else if(status.equals("create")) {
			redirectAttributes.addFlashAttribute(Message.EXCEPTION_KEY, "Please fill the Basic Info Details first");
			return REDIRECT_BAISC_INFO_DETAILS;
		}
		else if(status.equals("modify")) {
			redirectAttributes.addFlashAttribute(Message.EXCEPTION_KEY, "Please fill the Required Basic Info Details");
			return REDIRECT_MODIFY_BAISC_INFO_DETAILS;
		}
		}
		return null;
	}
	
	@RequestMapping(value="panchayatbhawanCurrStatus",method = RequestMethod.GET)
	public String panchayatBhawanCurrentStatus()
	{
		return PANCHAYAT_BHAWAN_CURR_STATUS;
	}
	
	@ResponseBody
	@RequestMapping(value="getPanchayatBhawanActivity", method = RequestMethod.GET, produces=MediaType.APPLICATION_JSON_VALUE)
	private Map<String, Object> getPanchayatBhawanActivity() {
		Map<String, Object> map=new HashMap<>();
		map.put("PANCHAYAT_ACTIVITY", panchayatBhawanService.fetchPanchayatBhawanActivity());
		map.put("DISTRICT_LIST", lgdService.getAllDistrictBasedOnState(userPreference.getStateCode()));
		PanchatayBhawanActivity activity= panchayatBhawanService.getPanchatayBhawanActivity(userPreference.getUserType());
		map.put("PANCHAYAT_BHAWAN_ACTIVITY", activity);
		Map<String, List<List<String>>> mapComments = basicInfoService.fetchStateAndMoprPreComments(activity.getPanchatayBhawanActivityDetails().size(),3);
		map.put("STATE_PRE_COMMENTS", mapComments.get("statePreviousComments"));
		map.put("MOPR_PRE_COMMENTS", mapComments.get("moprPreviousComments"));
		map.put("panchayatWithBhawan", panchayatBhawanService.fetchBasicInfoKeyValue(userPreference.getStateCode(),"27_gp"));
		map.put("panchayatWithoutBhawan", panchayatBhawanService.findNumberOfPnchayatWithOutBhawanByState(userPreference.getStateCode()).getDefinationValue());
		map.put("userType", userPreference.getUserType());
		if(userPreference.getUserType().equalsIgnoreCase("C")){
			map.put("PANCHAYAT_BHAWAN_ACTIVITY_STATE", panchayatBhawanService.getPanchatayBhawanActivity("S"));
			map.put("PANCHAYAT_BHAWAN_ACTIVITY_MOPR", panchayatBhawanService.getPanchatayBhawanActivity("M"));
		}
		return map;
	}
	
	@RequestMapping(value="savePanchayatBhawanActivity", method=RequestMethod.POST)
	@ResponseBody
	private void savePanchayatBhawanActivity(@RequestBody PanchatayBhawanActivity bhawanActivity,RedirectAttributes re) {
		panchayatBhawanService.savePanchayatBhawanActivity(bhawanActivity);
	}
	
	@RequestMapping(value="gramPanchayatList", method=RequestMethod.POST)
	@ResponseBody
	private List<GramPanchayat> fethGramPanchayatList(@RequestBody int districtCode) {
		List<GramPanchayat>  gramPanchayats= lgdService.getGramPanchayatList(districtCode);
		return gramPanchayats;
	}
	
	@RequestMapping(value="fetchPanchyatBhawanCurrentStatusBasedOnLocalBodySelected", method = RequestMethod.POST)
	@ResponseBody
	public List<PanchyatBhawanCurrentStatus> fetchPanchyatBhawanCurrentStatusBasedOnLocalBodySelected(@RequestBody final List<Long> localbodyList){
		List<PanchyatBhawanCurrentStatus> panchyatBhawanCurrentStatus = panchayatBhawanService.fetchPanchyatBhawanCurrentStatusBasedOnLocalBodySelected(localbodyList);
		return panchyatBhawanCurrentStatus;
	}
	
	@RequestMapping(value="fetchServicesProvided", method = RequestMethod.GET)
	@ResponseBody
	private Map<String, Object> fetchServicesProvided() {
		Map<String, Object> map=new HashMap<>();
		map.put("serviceProvided", panchayatBhawanService.fetchServicesProvided());
		return map;
	}
	
	@RequestMapping(value="gramPanchayatListBasedOnBlock", method=RequestMethod.POST)
	@ResponseBody
	private List<GramPanchayat> gramPanchayatListBasedOnBlock(@RequestBody int blockCode) {
		List<GramPanchayat>  gramPanchayats= lgdService.gramPanchayatListBasedOnBlock(blockCode);
		return gramPanchayats;
	}
	
	@RequestMapping(value="savePanchayatBhawanCsDetails", method=RequestMethod.POST)
	@ResponseBody
	private void savePanchayatBhawanCsDetails(@RequestBody PanchyatBhawanCurrentStatus bhawanStatus,RedirectAttributes re) {
		panchayatBhawanService.savePanchayatBhawanCsDetails(bhawanStatus);
	}
	
	
	@RequestMapping(value="finalizeWorkLocation",method = RequestMethod.GET)
	public String finalizeWorkLocation( Model model)
	{
		model.addAttribute("stateCode",userPreference.getStateCode());
		return FINALIZE_WORK_LOCATION;
	}
	
	@RequestMapping(value="savefFinalizeWorkLocation",method=RequestMethod.POST)
	public @ResponseBody Response performReactivationOfVillage(@RequestBody final List<PanchayatBhawanProposedInfo> panchayatBhawanProposedInfoList,HttpServletRequest request, HttpServletResponse httpServletResponse) {
		return panchayatBhawanService.savePanchayatBhwanFinalizeWorkLocaion(panchayatBhawanProposedInfoList);
	}
	
	@RequestMapping(value = "fetchFinalizeWorkLocationGPs", method = RequestMethod.GET)
	private @ResponseBody List<PanchayatBhawanProposedInfo> fetchFinalizeWorkLocationGPs(Integer activityDetailsId) {
		return panchayatBhawanService.fetchPanchayatBhawanProposedGPsList(activityDetailsId);
	}
	
	
	@ResponseBody
	@RequestMapping(value="getPanchayatBhawanActivityCEC", method = RequestMethod.GET, produces=MediaType.APPLICATION_JSON_VALUE)
	private Map<String, Object> getPanchayatBhawanActivityCEC() {
		Map<String, Object> map=new HashMap<>();
		map.put("PANCHAYAT_ACTIVITY", panchayatBhawanService.fetchPanchayatBhawanActivity());
		map.put("DISTRICT_LIST", lgdService.getAllDistrictBasedOnState(userPreference.getStateCode()));
		map.put("PANCHAYAT_BHAWAN_ACTIVITY", panchayatBhawanService.getPanchatayBhawanActivity(CEC_USER_TYPE));
		map.put("userType", CEC_USER_TYPE);
		
		return map;
	}
}

