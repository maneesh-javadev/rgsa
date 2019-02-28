package gov.in.rgsa.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import gov.in.rgsa.entity.AdministrativeAndTechnicalStaffStatus;
import gov.in.rgsa.entity.AdministrativeAndTechnicalStaffStatusDetails;
import gov.in.rgsa.entity.AdministrativeTechnicalSupport;
import gov.in.rgsa.entity.AdministrativeTechnicalSupportDetails;
import gov.in.rgsa.entity.PostType;
import gov.in.rgsa.service.AdminAndTechStatusService;
import gov.in.rgsa.service.AdminTechSupportService;
import gov.in.rgsa.service.BasicInfoService;
import gov.in.rgsa.user.preference.UserPreference;
import gov.in.rgsa.utils.Message;

@Controller
public class StatusAdminAndStaffController {
	
	@Autowired
	private AdminTechSupportService supportService;
	
	@Autowired
	private AdminAndTechStatusService adminAndTechStatusService;
	
	@Autowired
	UserPreference userPreference;
	
	@Autowired
	BasicInfoService basicInfoService;
	
	public String userType=null;
	
	public static final String STATUS_ADMIN_STAFF = "adminAndStaff.status";
	public static final String SUPPORT_ADMIN_STAFF_CEC = "adminAndStaff.supportStaffForCEC";
	public static final String SUPPORT_ADMIN_STAFF = "adminAndStaff.supportStaff";
	
	public static final String REDIRECT_SUPPORT_ADMIN_STAFF_CEC = "redirect:adminTechSupportStaffCEC.html";
	
	public static final String REDIRECT_SUPPORT_ADMIN_STAFF = "redirect:adminTechsupportStaff.html";
	public static final String REDIRECT_BAISC_INFO_DETAILS = "redirect:basicinfo.add.html";
	public static final String REDIRECT_MODIFY_BAISC_INFO_DETAILS = "redirect:managebasicInfoDetails.html";
	
	@RequestMapping(value = "statusAdminTechStaff", method = RequestMethod.GET)
	private String statusAdminTechStaff(@ModelAttribute("ADMIN_TECH_MODEL") AdministrativeTechnicalSupport support, Model model) {
		model.addAttribute("POST_TYPE", supportService.getTypeOfPost());
		return STATUS_ADMIN_STAFF;
	}
	
	
	@RequestMapping(value = "adminTechsupportStaff", method = RequestMethod.GET)
	private String administrativeTechSupportStaff(@ModelAttribute("ADMIN_TECH_MODEL") AdministrativeTechnicalSupport support, Model model,RedirectAttributes redirectAttributes) {
		//model.addAttribute("POST_TYPE", supportService.getTypeOfPost());
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
		return SUPPORT_ADMIN_STAFF;
	}
	
	@RequestMapping(value = "adminTechsupportStaffForMOPR", method = RequestMethod.GET)
	private String administrativeTechSupportStaffForMOPR(@ModelAttribute("ADMIN_TECH_MODEL") AdministrativeTechnicalSupport support, Model model) {
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
		return SUPPORT_ADMIN_STAFF;
	}
	
	@RequestMapping(value = "adminTechsupportStaffForCEC", method = RequestMethod.GET)
	private String administrativeTechSupportStaffForCEC(@ModelAttribute("ADMIN_TECH_MODEL") AdministrativeTechnicalSupport support, Model model) {
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
		return SUPPORT_ADMIN_STAFF_CEC;
	}
	
	@ResponseBody
	@RequestMapping(value="fetchPostTypeMaster", method = RequestMethod.GET, produces=MediaType.APPLICATION_JSON_VALUE)
	private Map<String, Object> fetchPostType() {
		Map<String, Object> object=new HashMap<>();
		List<PostType> postType =supportService.getTypeOfPost();
		object.put("postType", postType);
		object.put("level", supportService.fetchAdministrativeLevel());
		object.put("userType", userPreference.getUserType());
		AdministrativeTechnicalSupport technicalSupport= supportService.fetchAdministrativeTechnicalSupport(userPreference.getUserType());
		if(userPreference.getUserType().equalsIgnoreCase("M") && technicalSupport == null){
			
			technicalSupport= supportService.fetchAdministrativeTechnicalSupport("S");
			technicalSupport.setStatus("U");
		}
		if(technicalSupport!=null){
			List<AdministrativeTechnicalSupportDetails> details=technicalSupport.getSupportDetails();
			technicalSupport.setSupportDetails(null);
			object.put("details", details);
			object.put("technicalSupport", technicalSupport);
		}
		return object;
	}
	
	@RequestMapping(value = "adminTechSupportStaffCEC", method = RequestMethod.GET)
	private String fetchAdminTechSupportStaffForMOPRAndState(@ModelAttribute("ADMIN_TECH_SUPPORT_STAFFCEC") AdministrativeTechnicalSupport administrativeTechnicalSupport ,Model model) {
		
		List<PostType> postType =supportService.getTypeOfPost();
		model.addAttribute("postType", postType);
		model.addAttribute("level", supportService.fetchAdministrativeLevel());
		
		
			if(userPreference.getUserType().equalsIgnoreCase("C")){
		AdministrativeTechnicalSupport technicalSupportForState= supportService.fetchAdministrativeTechnicalSupport("S");
				AdministrativeTechnicalSupport technicalSupportForMOPR= supportService.fetchAdministrativeTechnicalSupport("M");
				  long totalCostWithoutAddit= 0;
		if(technicalSupportForState!=null){
					List<AdministrativeTechnicalSupportDetails> technicalSupportForStateDetails=technicalSupportForState.getSupportDetails();
					
						for(int i=0; i<technicalSupportForStateDetails.size();i++)
						{
							totalCostWithoutAddit =totalCostWithoutAddit+technicalSupportForStateDetails.get(i).getFunds();
						}
						model.addAttribute("TotalStateFund", totalCostWithoutAddit);
						
					model.addAttribute("detailsForState", technicalSupportForStateDetails);
					model.addAttribute("technicalSupportForState", technicalSupportForState);
				}
		
		if(technicalSupportForMOPR!=null){
					List<AdministrativeTechnicalSupportDetails> technicalSupportForMOPRDetails=technicalSupportForMOPR.getSupportDetails();
                      
					for(int i=0; i<technicalSupportForMOPRDetails.size();i++)
					{
						totalCostWithoutAddit =totalCostWithoutAddit+technicalSupportForMOPRDetails.get(i).getFunds();
					}
					model.addAttribute("TotalMoprFund", totalCostWithoutAddit);
					
					model.addAttribute("detailsForMOPR", technicalSupportForMOPRDetails);
					model.addAttribute("technicalSupportForMOPR", technicalSupportForState);
				}
			
				
		}
			AdministrativeTechnicalSupport technicalSupport= supportService.fetchAdministrativeTechnicalSupport("C");

			if(technicalSupport!=null){
				List<AdministrativeTechnicalSupportDetails> details=technicalSupport.getSupportDetails();
				
				model.addAttribute("details", details);
				model.addAttribute("technicalSupport", technicalSupport);
				model.addAttribute("user_type",userPreference.getUserType() );
				model.addAttribute("ISFREEZE", technicalSupport.getStatus());
			}
			return SUPPORT_ADMIN_STAFF_CEC;
	}
	
	
	@RequestMapping(value="adminTechSupportStaffCEC" ,method =RequestMethod.POST)
	public String saveAdminTechStaff(@ModelAttribute("ADMIN_TECH_SUPPORT_STAFFCEC") AdministrativeTechnicalSupport administrativeTechnicalSupport ,Model model,RedirectAttributes re)
	{
         supportService.saveAdminTechSupportDetails(administrativeTechnicalSupport);
			re.addFlashAttribute(Message.SUCCESS_KEY, Message.SAVE_SUCCESS);
		return REDIRECT_SUPPORT_ADMIN_STAFF_CEC;
	}
	
	
	
	
	
	@RequestMapping(value="saveAdminTechStaff", method=RequestMethod.POST)
	@ResponseBody
	private void saveAdminTechStaff(@RequestBody AdministrativeTechnicalSupport administrativeTechnicalSupport,RedirectAttributes re) {
		supportService.saveAdminTechSupportDetails(administrativeTechnicalSupport);
		re.addFlashAttribute(Message.SUCCESS_KEY, Message.SAVE_SUCCESS);
	}
	
	@RequestMapping(value="freezAndUnfreezForCec" , method=RequestMethod.POST) 
	public String freezeUnfreezemethodForCec(@ModelAttribute("ADMIN_TECH_SUPPORT_STAFFCEC") AdministrativeTechnicalSupport administrativeTechnicalSupport ,Model model,RedirectAttributes re) {
		supportService.freezeAndUnfreeze(administrativeTechnicalSupport);
		if(administrativeTechnicalSupport.getDbFileName().equals("F")) {
		re.addFlashAttribute(Message.SUCCESS_KEY,Message.FRIZEE_SUCESS);}
		else {
		re.addFlashAttribute(Message.SUCCESS_KEY, Message.UNFRIZEE_SUCESS);}
		return  REDIRECT_SUPPORT_ADMIN_STAFF_CEC;
	}
	
	@ResponseBody
	@RequestMapping(value="fetchPostForAdminsAndTechStatus", method = RequestMethod.GET, produces=MediaType.APPLICATION_JSON_VALUE)
	private Map<String, Object> fetchPost() {
		Map<String, Object> object= new HashMap<>();
		object=fetchPostTypeAndLevel();
		AdministrativeAndTechnicalStaffStatus adminAndTechnicalStatus = adminAndTechStatusService.fetchAdministrativeTechnicalSupport();
		if(adminAndTechnicalStatus!=null){
			List<AdministrativeAndTechnicalStaffStatusDetails> details=adminAndTechnicalStatus.getAdministrativeAndTechnicalStaffStatusDetails();
			adminAndTechnicalStatus.setAdministrativeAndTechnicalStaffStatusDetails(null);
			object.put("details", details);
			object.put("technicalSupport", adminAndTechnicalStatus);
		}
		return object;
	}

	public Map<String, Object> fetchPostTypeAndLevel(){
		Map<String, Object> object=new HashMap<>();
		List<PostType> postType =supportService.getTypeOfPost();
		object.put("postType", postType);
		object.put("level", supportService.fetchAdministrativeLevel());
		return object;
	}
	
	@RequestMapping(value="saveAdminsAndTechStatus", method=RequestMethod.POST)
	private String saveCurrentStatus(@RequestBody AdministrativeAndTechnicalStaffStatus administrativeAndTechnicalStaffStatus,RedirectAttributes re) {
		System.out.println(administrativeAndTechnicalStaffStatus);
		adminAndTechStatusService.saveAdminAndTechnicalStaffStatusAndDetails(administrativeAndTechnicalStaffStatus);
		re.addFlashAttribute(Message.SUCCESS_KEY, Message.SAVE_SUCCESS);
		return STATUS_ADMIN_STAFF;
	}
	
	@ResponseBody
	@RequestMapping(value="freezUnFreezAdminAndTechStaffStatus", method=RequestMethod.POST)
	private AdministrativeAndTechnicalStaffStatus freezUnFreezAdminAndTechStaffStatus(@RequestBody AdministrativeAndTechnicalStaffStatus administrativeAndTechnicalStaffStatus) {
		return adminAndTechStatusService.freezUnFreezAdminAndTechStaffStatus(administrativeAndTechnicalStaffStatus);
	}
}
