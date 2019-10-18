package gov.in.rgsa.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import gov.in.rgsa.entity.FundReleasedDetails;
import gov.in.rgsa.entity.StateAllocation;
import gov.in.rgsa.model.Response;
import gov.in.rgsa.model.StateAllocationModal;
import gov.in.rgsa.service.FacadeService;
import gov.in.rgsa.service.FundReleasedService;
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
	
	@Autowired
	private FundReleasedService fundReleasedService;
	
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
	public @ResponseBody Response savePlanAllocation(@RequestBody StateAllocationModal stateAllocationModal,@RequestParam(value="installmentNo") Integer installmentNo, Model model,RedirectAttributes re,BindingResult result) {
		Response response = new Response();
		/*planAllocationValidator.validate(stateAllocationModal, result);
		if (result.hasErrors()) {
			return PLAN_ALLOCATION;	
		}*/
		if(stateAllocationModal.getStatus()!=null && stateAllocationModal.getStatus().length()>0) {
			if(stateAllocationModal.getStatus().charAt(0)=='U') {
				response=allocationService.unfreezePlanAllocation(stateAllocationModal,installmentNo);
			}else {
				response=allocationService.savePlanAllocation(stateAllocationModal);
			}
		}else {
			response.setResponseMessage("Something is wrong");
			response.setResponseCode(500);
		}
		return response;
		
	}
	
	/* new function created by aashish barua when the plan allocation changes due to new fund released form */
	
	@ResponseBody
	@RequestMapping(value="fetchFundReleased",method=RequestMethod.GET)
	private Map<String, Object> fetchFundReleased(@RequestParam(value="installmentNo", required = false) Integer installmentNo){
		Map<String, Object> map=new HashMap<>();
		FundReleasedDetails fundReleasedDetail = fundReleasedService.fetchFundReleasedDetailByInstallmentNo(installmentNo);
		Map<String, Object> parameter = new HashMap<String, Object>();
		parameter.put("stateCode", userPreference.getStateCode());
		parameter.put("yearId", userPreference.getFinYearId());
		parameter.put("userType", "A");
		map.put("planAllocationList", facadeService.fetchFundDetailsByUserType(parameter));
		if(fundReleasedDetail != null) {
			map.put("fundReleasedDetailId", fundReleasedDetail.getFundReleasedDetailsId());
			map.put("centralShare", fundReleasedDetail.getCentralShare() + fundReleasedDetail.getUnspentBalance()); // here central share is equal to the central share +  unspent balance in the fund released
			map.put("stateShare", fundReleasedDetail.getStateShare());
			map.put("planCode", fundReleasedDetail.getFundReleased().getPlanCode());
			map.put("message", "success");
		}else {
			map.put("message", "failure");
		}
		StateAllocationModal model=new StateAllocationModal();
		if(installmentNo.equals(2)){
			List<StateAllocation> installment1Allocation = allocationService.fetchStateAllocationList(userPreference.getPlanCode(), 1);
			if(!installment1Allocation.isEmpty()) {
				map.put("installment_one_exists", new Boolean(true));
				map.put("installment_one_data", installment1Allocation);
			}else {
				map.put("installment_one_exists", new Boolean(false));
			}
		}
		
		List<StateAllocation> stateAllocation= allocationService.fetchStateAllocationList(userPreference.getPlanCode(), installmentNo);
		model.setStateAllocationList(stateAllocation);
		map.put("model", model);
		if(stateAllocation.isEmpty()) {
			map.put("disableIsfreeze", true);
		}else {
			map.put("disableIsfreeze", false);
		}

		return map;
	}
}
