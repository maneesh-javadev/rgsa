package gov.in.rgsa.controller;
import java.util.ArrayList;
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
import gov.in.rgsa.entity.PesaPlan;
import gov.in.rgsa.entity.PesaPlanDetails;
import gov.in.rgsa.entity.PesaPost;
import gov.in.rgsa.model.BasicInfoModel;
import gov.in.rgsa.service.ActionPlanService;
import gov.in.rgsa.service.BasicInfoService;
import gov.in.rgsa.service.PesaPlanService;
import gov.in.rgsa.user.preference.UserPreference;
import gov.in.rgsa.utils.Message;

@Controller
public class PesaPlanController {

	public static final String PESA_PLAN = "pesaPlan";
	public static final String PESA_PLAN_CEC = "pesaPlanForCEC";
	public static final String REDIRECT_BAISC_INFO_DETAILS = "redirect:basicinfo.add.html";
	public static final String REDIRECT_MODIFY_BAISC_INFO_DETAILS = "redirect:managebasicInfoDetails.html";
	
	@Autowired
	private PesaPlanService pesaPlanService;
	@Autowired
	private UserPreference userPreference;
	@Autowired
	private BasicInfoService basicInfoService;

	public String userType=null;
	
	@Autowired
	private ActionPlanService actionPlanService;
	
	@RequestMapping(value = "pesaPlan", method = RequestMethod.GET)
	private String administrativeTechSupportStaff(@ModelAttribute("BASIC_INFO_MODEL") BasicInfoModel basicInfoModel, Model model,RedirectAttributes redirectAttributes) {
		/*
		 * userPreference.setMenuId(menuId); ,@RequestParam(value = "menuId") int
		 * menuId, this line commented for forward plan button
		 */
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
		return PESA_PLAN ;
	}
	
	@RequestMapping(value = "pesaPlanForMOPR", method = RequestMethod.GET)
	private String pesaPlanForMOPR(@ModelAttribute("ADMIN_TECH_MODEL") AdministrativeTechnicalSupport support, Model model) {
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
		return PESA_PLAN;
	}
	@RequestMapping(value = "pesaPlanForCEC", method = RequestMethod.GET)
	private String pesaPlanForCEC(@ModelAttribute("ADMIN_TECH_MODEL") AdministrativeTechnicalSupport support, Model model) {
		this.userType = 'C'+"";
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
		return PESA_PLAN_CEC;
	}
	
	@ResponseBody
	@RequestMapping(value="fetchPesaPost", method = RequestMethod.GET, produces=MediaType.APPLICATION_JSON_VALUE)
	private Map<String, Object> fetchPesaDetails() {
		List<PesaPlan> pesaPlan = new ArrayList<>();
		Map<String, Object> pesaPlanResponseMap = new HashMap<>();
		pesaPlan = pesaPlanService.fetchPesaPlan(userPreference.getUserType().charAt(0));
		if(userPreference.getUserType().equalsIgnoreCase("M") && pesaPlan.size() == 0){
			List<PesaPlan> pesaPlans =  pesaPlanService.fetchPesaPlan('S');
			PesaPlan plan=new PesaPlan();
			plan.setIsFreez(false);
			plan.setAdditionalRequirement(pesaPlans.get(0).getAdditionalRequirement());
			plan.setMenuId(pesaPlans.get(0).getMenuId());
			plan.setUserType(pesaPlans.get(0).getUserType());
			plan.setPesaPlanId(pesaPlans.get(0).getPesaPlanId());
			pesaPlan.add(plan);
		}
		List<PesaPost> pesaPosts = pesaPlanService.fetchPesaPost();
		List<PesaPlanDetails> pesaPlanDetails= new ArrayList<PesaPlanDetails>(); 
		if(!CollectionUtils.isEmpty(pesaPlan)){
			pesaPlanDetails = pesaPlanService.fetchPesaDetails(pesaPlan.get(0).getPesaPlanId());
		}
		
		
		if(pesaPlan!=null)
			pesaPlanResponseMap.put("pesaPlanResponseMap", pesaPlan.get(0));
		pesaPlanResponseMap.put("pesaPosts", pesaPosts);
		pesaPlanResponseMap.put("pesaPlanDetails", pesaPlanDetails);
		pesaPlanResponseMap.put("userType", userPreference.getUserType());
		if(!CollectionUtils.isEmpty(pesaPlanDetails)) {
			Map<String, List<List<String>>> commentMap = basicInfoService.fetchStateAndMoprPreComments(pesaPlanDetails.size(),6);
			pesaPlanResponseMap.put("STATE_PRE_COMMENTS", commentMap.get("statePreviousComments"));
			pesaPlanResponseMap.put("MOPR_PRE_COMMENTS", commentMap.get("moprPreviousComments"));
		}
		return pesaPlanResponseMap;
	}
	
	@ResponseBody
	@RequestMapping(value="fetchPesaPlanDetailsForStateAndMOPR", method = RequestMethod.GET)
	private Map<String, Object> fetchPesaPlanDetailsForStateAndMOPR(){
		Map<String, Object> pesaPlanResponseMap = new HashMap<>();
		List<PesaPost> pesaPosts = pesaPlanService.fetchPesaPost();
		pesaPlanResponseMap.put("pesaPosts", pesaPosts);
		
		List<PesaPlan> pesaPlanForState = pesaPlanService.fetchPesaPlan('S');
		List<PesaPlanDetails> pesaPlanDetailsForState= new ArrayList<PesaPlanDetails>();
		if(!CollectionUtils.isEmpty(pesaPlanForState)){
			pesaPlanDetailsForState = pesaPlanService.fetchPesaDetails(pesaPlanForState.get(0).getPesaPlanId());
		}
		
		List<PesaPlan> pesaPlanForMOPR = pesaPlanService.fetchPesaPlan('M');
		List<PesaPlanDetails> pesaPlanDetailsForMOPR= new ArrayList<PesaPlanDetails>();
		if(!CollectionUtils.isEmpty(pesaPlanForMOPR)){
			pesaPlanDetailsForMOPR = pesaPlanService.fetchPesaDetails(pesaPlanForMOPR.get(0).getPesaPlanId());
		}
		
		List<PesaPlan> pesaPlanForCEC = pesaPlanService.fetchPesaPlan('C');
		List<PesaPlanDetails> pesaPlanDetailsForCEC= new ArrayList<PesaPlanDetails>();
		if(!CollectionUtils.isEmpty(pesaPlanForCEC)){
			pesaPlanDetailsForCEC = pesaPlanService.fetchPesaDetails(pesaPlanForCEC.get(0).getPesaPlanId());
		}
		
		if(!CollectionUtils.isEmpty(pesaPlanForState))
		pesaPlanResponseMap.put("pesaPlanForState", pesaPlanForState.get(0));
		pesaPlanResponseMap.put("pesaPlanDetailsForState", pesaPlanDetailsForState);
		
		if(!CollectionUtils.isEmpty(pesaPlanForMOPR))
		pesaPlanResponseMap.put("pesaPlanForMOPR", pesaPlanForMOPR.get(0));		
		pesaPlanResponseMap.put("pesaPlanDetailsForMOPR", pesaPlanDetailsForMOPR);
		
		if(!CollectionUtils.isEmpty(pesaPlanForCEC))
		pesaPlanResponseMap.put("pesaPlanForCEC", pesaPlanForCEC.get(0));
		pesaPlanResponseMap.put("pesaPlanDetailsForCEC", pesaPlanDetailsForCEC);
		return pesaPlanResponseMap;
	}
	
	@RequestMapping(value="savePesaPlan", method=RequestMethod.POST,consumes=MediaType.APPLICATION_JSON_VALUE)
	private String savePesaPlan(@RequestBody PesaPlan pesaPlan,RedirectAttributes re) {
		pesaPlanService.savePesaPlan(pesaPlan);
		actionPlanService.actionPlanStatus();
		re.addFlashAttribute(Message.SUCCESS_KEY, Message.SAVE_SUCCESS);
		return PESA_PLAN;
	}

	@RequestMapping(value="savePesaPlanForCEC", method=RequestMethod.POST,consumes=MediaType.APPLICATION_JSON_VALUE)
	private String savePesaPlanForCEC(@RequestBody PesaPlan pesaPlan,RedirectAttributes re) {
		pesaPlanService.savePesaPlanForCEC(pesaPlan);
		re.addFlashAttribute(Message.SUCCESS_KEY, Message.SAVE_SUCCESS);
		return PESA_PLAN;
	}
	
	@ResponseBody
	@RequestMapping(value="feezUnFreezPesaPlan", method=RequestMethod.POST)
	private PesaPlan feezUnFreezPesaPlan(@RequestBody PesaPlan pesaPlan) {
		return pesaPlanService.feezUnFreezPesaPlan(pesaPlan);
	}
}
