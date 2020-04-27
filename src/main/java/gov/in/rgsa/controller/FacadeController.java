package gov.in.rgsa.controller;

import java.util.HashMap;
import java.util.Map;

import javax.persistence.NoResultException;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import gov.in.rgsa.dto.CustomError;
import gov.in.rgsa.entity.NodalOfficerDetails;
import gov.in.rgsa.entity.StatewiseEntitiesCount;
import gov.in.rgsa.exception.RGSAException;
import gov.in.rgsa.model.BasicInfoModel;
import gov.in.rgsa.model.FacadeModel;
import gov.in.rgsa.service.EGovernanceSupportService;
import gov.in.rgsa.service.FacadeService;
import gov.in.rgsa.service.FileUploadService;
import gov.in.rgsa.service.NodalOfficerService;
import gov.in.rgsa.service.PlanAllocationService;
import gov.in.rgsa.service.PlanDetailsService;
import gov.in.rgsa.serviceImpl.FacadeServiceImpl;
import gov.in.rgsa.serviceImpl.PlanDetailsServiceImpl;
import gov.in.rgsa.user.preference.UserPreference;
import gov.in.rgsa.utils.Message;
import gov.in.rgsa.validater.CaptchaValidator;
/**
 *
 * @author ANJIT
 */
@Controller
public class FacadeController {

	public static final String INDEX_VIEW = "page.public";
	public static final String HOME_VIEW = "page.home";
	public static final String FIN_YEAR_VIEW = "page.fin.year";
	public static final String REDIRECT_INDEX_VIEW = "redirect:index.html";
	public static final String REDIRECT_HOME_VIEW = "redirect:home.html";
	private static final String REDIRECT_NODAL_OFFICER = "redirect:nodalOfficer.html";
	public static final String APPROVE_PLAN_BY_CEC = "ApprovePlanByCec";
	public static final String REDIRECT_LOGIN = "planSubmittedByStates";
	@Autowired
	private UserPreference _userPreference;

	@Autowired
	private FacadeService service;
	
	@Autowired
	private NodalOfficerService officerService;
	
	@Autowired
	private FacadeServiceImpl facadeServiceImpl;

	@Autowired
	private PlanAllocationService planAllocationService; 
	
	@Autowired
	private PlanDetailsService planDetailsService;

	@Autowired
	EGovernanceSupportService eGovernanceSupportService;
	
	@Autowired
	private FileUploadService fileUploadService;

	@Value("${rgsa.captcha.enabled}")
	private Boolean isCaptcha;


	/*
	 * @Autowired private CommonService commonService;
	 */

	@RequestMapping(value = "index", method = RequestMethod.GET)
	public String welcome(Model model, RedirectAttributes re) {
		// model.addAttribute("FIN_YEARS", commonService.findAllFinYear());
		 model.addAttribute("FACADE_MODEL", new FacadeModel()); 
		 model.addAttribute("visitorCount",service.findVisitorCount()); 
		 return INDEX_VIEW;
	}

	@RequestMapping(value = "home", method = RequestMethod.GET)
	public String home(@ModelAttribute("FACADE_MODEL") FacadeModel form, Model model, RedirectAttributes re) {
		Map<String, Object> parameter = new HashMap<String, Object>();
		parameter.put("yearId",_userPreference.getFinYearId());
		parameter.put("stateCode", _userPreference.getStateCode());
		model.addAttribute("statePlanComponentsFunds", facadeServiceImpl.getPlanSubComponents());
		_userPreference.setIsFreezeStatusList(facadeServiceImpl.fetchFormsIsFreezeStatus(null));
		Boolean plansAreFreezed = facadeServiceImpl.checkForFreezeStatus(parameter);
		_userPreference.setPlansAreFreezed(plansAreFreezed);
		NodalOfficerDetails nodalOfficerDetails = null;
		nodalOfficerDetails =officerService.getNodalOfficerDetails();
		if(nodalOfficerDetails==null && _userPreference.getUserType().equalsIgnoreCase("S")){
			model.addAttribute("PlanStatusName", "Not Started");
		}else
			model.addAttribute("PlanStatusName", facadeServiceImpl.getPlanStatusName());
		
		return HOME_VIEW;
	}

	@RequestMapping(value = "home", method = RequestMethod.POST)
	public String homePost(@ModelAttribute("FACADE_MODEL") FacadeModel form, Model model, RedirectAttributes re) {
		return REDIRECT_HOME_VIEW;
	}

	@RequestMapping(value = "login", method = RequestMethod.POST)
	public String login(@ModelAttribute("FACADE_MODEL") FacadeModel form, Model model,HttpSession httpSession, RedirectAttributes re) {
		try {
			CaptchaValidator captchaValidator = new CaptchaValidator();	
			boolean messageFlag = captchaValidator.validateCaptcha(httpSession, form.getCaptchaAnswer());
			if (isCaptcha  && !messageFlag ) { 
				re.addFlashAttribute(Message.CAPCHA_ERROR_KEY, "You Have Entered Wrong Captcha");
				return REDIRECT_INDEX_VIEW;
			} 
			setPreference(service.findUser(form));
			model.addAttribute("PlanStatusName", facadeServiceImpl.getPlanStatusName());
		
			/*
			 * model.addAttribute("FIN_YEARS", commonService.findAllFinYear());
			 * return FIN_YEAR_VIEW;
			 */
			NodalOfficerDetails nodalOfficerDetails = null;
			nodalOfficerDetails =officerService.getNodalOfficerDetails();
			if(nodalOfficerDetails==null && _userPreference.getUserType().equalsIgnoreCase("S")){
				return REDIRECT_NODAL_OFFICER;
			}else {
				_userPreference.setIsNodalFilled(true);
			}
			
			return HOME_VIEW;
		} catch (NoResultException e) {
			re.addFlashAttribute(Message.ERROR_KEY, "Invalid username or password");
			return REDIRECT_INDEX_VIEW;
		}
	}

	@RequestMapping(value = "login", method = RequestMethod.GET)
	public String loginPst(@ModelAttribute("FACADE_MODEL") FacadeModel form, Model model, RedirectAttributes re) {
		setPreference(service.findUser(form));
		return HOME_VIEW;
	}

	@RequestMapping(value = "logout", method = RequestMethod.GET)
	public String lgout(HttpSession session, RedirectAttributes re) {
		session.invalidate();
		re.addFlashAttribute(Message.SUCCESS_KEY, "Successfully logout");
		return REDIRECT_INDEX_VIEW;
	}

	@SuppressWarnings("unchecked")
	@RequestMapping(value = "authanticate", method = RequestMethod.POST, produces = MediaType.APPLICATION_JSON_VALUE)
	public <T> T authanticate(@RequestBody FacadeModel form) {
		try {
			setPreference(service.findUser(form));
			//return (T) new ResponseEntity<FacadeModel>(form, HttpStatus.UNAUTHORIZED);
			 return (T) REDIRECT_INDEX_VIEW;
		}catch (Exception e) {
			e.printStackTrace();
			return (T) error(e);
		}
	}
	private void setPreference(UserPreference userPreference) {
		_userPreference.setUserId(userPreference.getUserId());
		_userPreference.setUserName(userPreference.getUserName());
		_userPreference.setFinYear(userPreference.getFinYear());
		_userPreference.setUserType(userPreference.getUserType());
		_userPreference.setStateCode(userPreference.getStateCode());
		_userPreference.setDistrictcode(userPreference.getDistrictcode());
		_userPreference.setMenus(userPreference.getMenus());
		_userPreference.setFinYearId(userPreference.getFinYearId());
		//_userPreference.setFinYear(userPreference.getFinYear());
		_userPreference.setActivityPlanStatus(userPreference.getActivityPlanStatus());
		_userPreference.setPlanComponents((userPreference.getPlanComponents()));
		_userPreference.setIsFreezeStatusList(userPreference.getIsFreezeStatusList());
		_userPreference.setPlanCode(userPreference.getPlanCode());
		_userPreference.setPlanStatus(userPreference.getPlanStatus());
		_userPreference.setPlanVersion(userPreference.getPlanVersion());
		_userPreference.setFinYearList(userPreference.getFinYearList());
		_userPreference.setStatePlanComponentsFunds(userPreference.getStatePlanComponentsFunds());
		_userPreference.setPlansAreFreezed(userPreference.isPlansAreFreezed());
		_userPreference.setCountPlanSubmittedByState(userPreference.getCountPlanSubmittedByState());
		_userPreference.setCountPlanSubmittedByMOPR(userPreference.getCountPlanSubmittedByMOPR());
		_userPreference.setCountPlanApprovedByCec(userPreference.getCountPlanApprovedByCec());
		
	}
	
	private ResponseEntity<CustomError> error(Exception e){
		CustomError error = new CustomError();
		if(e instanceof NoResultException){
			error.setMessage("Invalid username or password");
			return new ResponseEntity<CustomError>(error, HttpStatus.UNAUTHORIZED);
		}else if(e instanceof RGSAException){
			error.setMessage(e.getMessage());
			return new ResponseEntity<CustomError>(error, HttpStatus.UNAUTHORIZED);
		}else{
			error.setMessage("Some things went wrong.");
			return new ResponseEntity<CustomError>(error, HttpStatus.BAD_REQUEST);
		}
	}
	
	@ResponseBody
	@RequestMapping(value="/forwardPlans",method=RequestMethod.POST)
	private Map<String, Object> forwardPlans(RedirectAttributes re) {
		Map<String, Object> param=new HashMap<String, Object>();
		NodalOfficerDetails nodalDetails = officerService.getNodalOfficerDetails();
		if(nodalDetails != null) {
			String result=service.forwardPlans();
			param.put("result", result);
			re.addFlashAttribute(Message.SUCCESS_KEY, Message.SAVE_SUCCESS);
		}else {
			param.put("result", "N");
			re.addFlashAttribute(Message.ERROR_KEY,"Please fill the Nodal Officer's deatils first before forwarding plan.");
		}
		
		return param;
	}
	
	@ResponseBody
	@PostMapping(value = "revertPlan")
	private Map<String, Object> revertPlan(@RequestParam(name = "stateCode" ,required = false) Integer stateCode){
		Map<String, Object> param=new HashMap<String, Object>();
		boolean result = service.revertPlan(stateCode);
		_userPreference.setCountPlanSubmittedByState(planDetailsService.countPlanSubmittedByState("M", _userPreference.getFinYearId()));
		param.put("result", result);
		return param;
	}
	
	
	@RequestMapping(value = "ApprovePlanByCec", method = RequestMethod.GET)
	private String planForCec(@ModelAttribute("PLAN_ALLOCATION") BasicInfoModel basicInfoModel, Model model ,RedirectAttributes redirectAttributes) {
		//model.addAttribute("PLAN_ALLOCATION_LIST", allocationService.getPlanComponents());
		Boolean boolean1=planAllocationService.approveCecPlan();
		
		if(boolean1== true)
		{
			redirectAttributes.addFlashAttribute(Message.SUCCESS_KEY,"PLAN APPROVED SUCCESSFULLY");
		}
		else
		{
			redirectAttributes.addFlashAttribute(Message.SUCCESS_KEY,"ERROR OCCURE WHILE APPROVING PLAN");
		}
		model.addAttribute("msgApproved", boolean1);
		return REDIRECT_LOGIN;
	}
	
	@ResponseBody
	@RequestMapping(value="fetchStatewiseEntitiesCount", method=RequestMethod.GET)
	private StatewiseEntitiesCount fetchStatewiseEntitiesCount() {
		return fileUploadService.getDataFromJsonFile();
	}
	
	@RequestMapping(value="changeFinYear", method=RequestMethod.POST)
	private String changeFinYear(@RequestParam(value = "finYearId" ,required = false) String finYearId,@ModelAttribute("FACADE_MODEL") FacadeModel form, Model model, RedirectAttributes re) {
		System.out.println(">>>>>>>>i am in. " + _userPreference.getUserName() +" ");
		_userPreference=service.changeAccToNewFinYearId(_userPreference,finYearId);
		return home(form,model,re);
	}
	
}
