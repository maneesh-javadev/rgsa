package gov.in.rgsa.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import gov.in.rgsa.model.StatewisePlanDetails;
import gov.in.rgsa.model.StatewisePlanStatus;
import gov.in.rgsa.service.PlanDetailsService;


@Controller
public class DashboardController {
	
	@Autowired
	PlanDetailsService planDetailsService;
	
	public static final String STATE_WISE_PLAN_STATUS = "Dashboard/statewisePlanStatus";
	
	public static final String STATE_WISE_PLAN_DETAILS = "Dashboard/statewisePlanDetails";
	
	@RequestMapping(value = "showGISStatewisePlanStatus", method = RequestMethod.GET)
	public String showGISStatewisePlanStatus( Model model, RedirectAttributes re) {
	return STATE_WISE_PLAN_STATUS;
	}
	
	@ResponseBody
	@RequestMapping(value="getStatewisePlanStatus",method=RequestMethod.GET)
	public List<StatewisePlanStatus>  getAllSubmittedPlanByState(){
		return planDetailsService.getStatewisePlanStatus();
	}
	
	
	@RequestMapping(value = "showGISStatewisePlanDetails")
	public String showGISStatewisePlanDetails(HttpServletRequest request, HttpServletResponse response,Model model
		,@RequestParam("compId")Integer compId,	@RequestParam("stateCode")Integer stateCode,@RequestParam("yearId")Integer yearId) {
		List<StatewisePlanDetails> statewisePlanDetailList=	planDetailsService.getStatewisePlanDetails(compId, stateCode, yearId);
		model.addAttribute("statewisePlanDetailList",statewisePlanDetailList);
	return STATE_WISE_PLAN_DETAILS;
	}

}
