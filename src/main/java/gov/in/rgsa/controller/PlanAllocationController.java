package gov.in.rgsa.controller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import gov.in.rgsa.model.StateAllocationModal;
import gov.in.rgsa.service.FacadeService;
import gov.in.rgsa.service.PlanAllocationService;
import gov.in.rgsa.user.preference.UserPreference;
import gov.in.rgsa.utils.Message;
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
		Map<String, Object> parameter = new HashMap<String, Object>();
		parameter.put("stateCode", userPreference.getStateCode());
		parameter.put("yearId", userPreference.getFinYearId());
		parameter.put("userType", "A");
		model.addAttribute("PLAN_ALLOCATION_LIST", facadeService.fetchFundDetailsByUserType(parameter));
		stateAllocationModal =allocationService.getBasicDetailofPlanAllocation(stateAllocationModal);
		return PLAN_ALLOCATION;
	}
	
	@RequestMapping(value = "planAllocationQPR", method = RequestMethod.GET)
	private String planAllocationQPR(@ModelAttribute("PLAN_ALLOCATION") StateAllocationModal stateAllocationModal, Model model) {
		model.addAttribute("PLAN_ALLOCATION_LIST", allocationService.getPlanComponents());
		stateAllocationModal =allocationService.getBasicDetailofPlanAllocation(stateAllocationModal);
		model.addAttribute("isPlanAllocationNotExist",Boolean.TRUE);
		return PLAN_ALLOCATION;
	}
	
	@RequestMapping(value = "savePlanAllocation", method = RequestMethod.POST)
	private String savePlanAllocation(@ModelAttribute("PLAN_ALLOCATION") StateAllocationModal stateAllocationModal, Model model,RedirectAttributes re,BindingResult result) {
		
		planAllocationValidator.validate(stateAllocationModal, result);
		if (result.hasErrors()) {
			return PLAN_ALLOCATION;	
		}
		
		boolean isSaved=allocationService.savePlanAllocation(stateAllocationModal);
		if(isSaved && stateAllocationModal.getStatus()!=null) {
			switch(stateAllocationModal.getStatus().charAt(0)) {
			case 'S':
				re.addFlashAttribute(Message.SUCCESS_KEY, Message.SAVE_SUCCESS);
				break;
			case 'F':
				re.addFlashAttribute(Message.UPDATE_KEY, Message.FRIZEE_SUCESS);
				break;
			case 'U':
				re.addFlashAttribute(Message.UPDATE_KEY, Message.UNFRIZEE_SUCESS);
				break;	
				
			case 'M':
				re.addFlashAttribute(Message.UPDATE_KEY, Message.UPDATE_SUCCESS);
				break;	
			}
		}else {
			re.addFlashAttribute(Message.ERROR_KEY, Message.ERROR_SUCCESS);
		}
		return REDIRECT_PLAN_ALLOCATION;
	}
	
}
