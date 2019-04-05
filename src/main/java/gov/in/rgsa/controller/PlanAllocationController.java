package gov.in.rgsa.controller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import gov.in.rgsa.model.Response;
import gov.in.rgsa.model.StateAllocationModal;
import gov.in.rgsa.service.FacadeService;
import gov.in.rgsa.service.PlanAllocationService;
import gov.in.rgsa.user.preference.UserPreference;
import gov.in.rgsa.validater.PlanAllocationValidator;

@Controller
public class PlanAllocationController {
	
	@Autowired
	private PlanAllocationService allocationService;
	
	@Autowired
	private PlanAllocationValidator planAllocationValidator;
	
	@Autowired
	 private UserPreference userPreference;
	
	@Autowired
	private FacadeService facadeService;
	
	public static final String PLAN_ALLOCATION = "planAllocation.add";
	
	public static final String REDIRECT_PLAN_ALLOCATION = "redirect:planAllocation.html";
	

	@RequestMapping(value = "planAllocation", method = RequestMethod.GET)
	private String planAllocation(@ModelAttribute("PLAN_ALLOCATION") StateAllocationModal stateAllocationModal, Model model) {
		
		return PLAN_ALLOCATION;
	}
	
	@ResponseBody
	@RequestMapping(value="fetchPlanAllocation",method=RequestMethod.GET)
	private Map<String, Object> fetchPlanAllocation(){
		Map<String, Object> map=new HashMap<>();
		Map<String, Object> parameter = new HashMap<String, Object>();
		parameter.put("stateCode", userPreference.getStateCode());
		parameter.put("yearId", userPreference.getFinYearId());
		parameter.put("userType", "A");
		map.put("PLAN_ALLOCATION_LIST", facadeService.fetchFundDetailsByUserType(parameter));
		StateAllocationModal stateAllocationModal=new StateAllocationModal();
		map.put("stateAllocationModal", allocationService.getBasicDetailofPlanAllocation(stateAllocationModal));
		return map;
	}
	
	
	
	@RequestMapping(value = "planAllocationQPR", method = RequestMethod.GET)
	private String planAllocationQPR(@ModelAttribute("PLAN_ALLOCATION") StateAllocationModal stateAllocationModal, Model model) {
		stateAllocationModal.setPlanAllocationNotExist(Boolean.TRUE);
		model.addAttribute("isPlanAllocationNotExist",Boolean.TRUE);
		return PLAN_ALLOCATION;
	}
	
	@RequestMapping(value = "savePlanAllocation", method = RequestMethod.POST)
	public @ResponseBody Response savePlanAllocation(@RequestBody StateAllocationModal stateAllocationModal, Model model,RedirectAttributes re,BindingResult result) {
		Response response = new Response();
		/*planAllocationValidator.validate(stateAllocationModal, result);
		if (result.hasErrors()) {
			return PLAN_ALLOCATION;	
		}*/
		if(stateAllocationModal.getStatus()!=null && stateAllocationModal.getStatus().length()>0) {
			if(stateAllocationModal.getStatus().charAt(0)=='U') {
				response=allocationService.unfreezePlanAllocation(stateAllocationModal);
			}else {
				response=allocationService.savePlanAllocation(stateAllocationModal);
			}
		}else {
			response.setResponseMessage("Something is wrong");
			response.setResponseCode(500);
		}
		return response;
		
	}
	
}
