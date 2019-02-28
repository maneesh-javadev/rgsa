package gov.in.rgsa.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.collections.CollectionUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import gov.in.rgsa.entity.SatcomCurrentStatus;
import gov.in.rgsa.service.SatcomFacilityService;
import gov.in.rgsa.user.preference.UserPreference;
import gov.in.rgsa.utils.Message;

@Controller
public class CurrentUsageSatComController {
	
	private static final String CURRENT_SATCOM = "currentUsageSatcom";
	
	@Autowired
	private SatcomFacilityService satcomFacilityService;
	
	@Autowired
	private UserPreference userPreference;

	@RequestMapping(value="currentusagesatcom",method=RequestMethod.GET)
	private String currentUsageSatcomGet(Model model)
	{
		Integer planStatus=userPreference.getPlanStatus();	
	    Boolean flag= false;
        if(planStatus!=null && planStatus==1) {
        	flag = true;
		}else if(planStatus!=null && planStatus==2)
        flag = true;
         
		else
			flag= false;
        model.addAttribute("Plan_Status", flag);
	
		return CURRENT_SATCOM;
	}

	@ResponseBody
	@RequestMapping(value="fetchSatcomMastersAndSatcomStatus", method = RequestMethod.GET)
	private Map<String, Object> fetchSatcomMastersAndSatcomStatus(){
		Map<String, Object> object = new HashMap<String, Object>();
		object.put("satcomActivity", satcomFacilityService.getSatcomeActivityName());
		object.put("schemeMaster", satcomFacilityService.fetchSchemeMaster());
		List<SatcomCurrentStatus> satcomCurrentStatusList = satcomFacilityService.fetchSatcomStatus();
		if(!CollectionUtils.isEmpty(satcomCurrentStatusList)){
			
			object.put("satcomCurrentStatus", satcomCurrentStatusList.get(0));
		}
			return object;
	}
	
	@RequestMapping(value="saveSatcomCurrentStatus", method=RequestMethod.POST)
	private String saveSatcomCurrentStatus(@RequestBody final SatcomCurrentStatus satcomCurrentStatus, RedirectAttributes redirectAttributes) {
		satcomFacilityService.saveSatcomCurrentStatus(satcomCurrentStatus);
		redirectAttributes.addFlashAttribute(Message.SUCCESS_KEY, Message.SAVE_SUCCESS);
		return CURRENT_SATCOM;
	}
	
}
