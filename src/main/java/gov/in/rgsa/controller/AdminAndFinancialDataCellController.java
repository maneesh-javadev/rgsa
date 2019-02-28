package gov.in.rgsa.controller;

import java.util.ArrayList;
import java.util.List;

import org.apache.commons.collections.CollectionUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import gov.in.rgsa.entity.AdminAndFinancialDataActivity;
import gov.in.rgsa.entity.AdminFinancialDataCellActivityDetails;
import gov.in.rgsa.entity.PmuActivityType;
import gov.in.rgsa.model.AdminAndFinancialDataCellModel;
import gov.in.rgsa.service.AdminAndFinancialDataCellService;
import gov.in.rgsa.service.BasicInfoService;
import gov.in.rgsa.service.PmuActivityService;
import gov.in.rgsa.user.preference.UserPreference;
import gov.in.rgsa.utils.Message;

@Controller
public class AdminAndFinancialDataCellController {
	
	@Autowired
	private PmuActivityService pmuActivityService;
	
	@Autowired
	private UserPreference userPreference;
	
	@Autowired
	BasicInfoService basicInfoService;
	
	@Autowired
	private AdminAndFinancialDataCellService adminAndFinancialDataCellService;
	
	private static final String ADMIN_AND_FINANCIAL = "adminAndFinancialDataCell";
	private static final String  ADMIN_AND_FINANCIAL_FOR_CEC ="adminAndFinancialDataCellForCec";
	private static final String REDIRECT_ADMIN_AND_FINANCIAL = "redirect:adminAndFinancialDataCell.html";
	public static final String REDIRECT_BAISC_INFO_DETAILS = "redirect:basicinfo.add.html";
	public static final String REDIRECT_MODIFY_BAISC_INFO_DETAILS = "redirect:managebasicInfoDetails.html";

	@RequestMapping(value="adminAndFinancialDataCell",method=RequestMethod.GET)
	private String adminAndFinancialGet(@ModelAttribute("ADMIN_FIN_DATA_CELL") AdminAndFinancialDataCellModel form ,Model model,RedirectAttributes redirectAttributes){
		
		String status = basicInfoService.fillFirstBasicInfo();
		if(status.equals("create")) {
			redirectAttributes.addFlashAttribute(Message.EXCEPTION_KEY, "Please fill the Basic Info Details first");
			return REDIRECT_BAISC_INFO_DETAILS;
		}
		else if(status.equals("modify")) {
			redirectAttributes.addFlashAttribute(Message.EXCEPTION_KEY, "Please fill the Required Basic Info Details");
			return REDIRECT_MODIFY_BAISC_INFO_DETAILS;
		}
		
		List<PmuActivityType> pmuActivityType=new ArrayList<>();
		List<AdminAndFinancialDataActivity> adminAndFinancialDataActivity=new ArrayList<>();
		List<AdminFinancialDataCellActivityDetails> adminFinancialDataCellActivityDetails=new ArrayList<>();
		pmuActivityType=pmuActivityService.fetchPmuActvityType();
		model.addAttribute("ACTIVITY_TYPE", pmuActivityType);
		adminAndFinancialDataActivity = adminAndFinancialDataCellService.fetchAdminAndFinancialActivity(userPreference.getUserType());
		if(!CollectionUtils.isEmpty(adminAndFinancialDataActivity)){
			adminFinancialDataCellActivityDetails=adminAndFinancialDataCellService.fetchAdminAndFinancialDetails(adminAndFinancialDataActivity.get(0).getAdminFinancialDataActivityId());
		for (AdminFinancialDataCellActivityDetails adminFinancialDataCellActivityDetails2 : adminFinancialDataCellActivityDetails) {
			if(adminFinancialDataCellActivityDetails2.getFunds() != null){
				adminFinancialDataCellActivityDetails2.setSubTotal(adminFinancialDataCellActivityDetails2.getFunds());
			}
		}
		form.setAdminFinancialDataCellActivityDetails(adminFinancialDataCellActivityDetails);
		form.setAdditionalRequirement(adminAndFinancialDataActivity.get(0).getAdditionalRequirement());
		model.addAttribute("IS_FREEZE", adminAndFinancialDataActivity.get(0).getIsFreeze());
		model.addAttribute("USER_TYPE_OF_PREVIOUS_ACTIVITY", adminAndFinancialDataActivity.get(0).getUserType());
		model.addAttribute("DISABLE_FREEZE_INTIALLY", false);
		model.addAttribute("adminFinancialDataActivityId", adminAndFinancialDataActivity.get(0).getAdminFinancialDataActivityId());
		}else{
			model.addAttribute("DISABLE_FREEZE_INTIALLY", true);
		}
		
		if(userPreference.getUserType().equalsIgnoreCase("C"))
		{
			List<AdminAndFinancialDataActivity> andFinancialDataActivityForState = adminAndFinancialDataCellService.fetchAdminAndFinancialActivity("S");
			 model.addAttribute("activityForState", andFinancialDataActivityForState.get(0));
			 List<AdminFinancialDataCellActivityDetails> activityDetailsForState=  andFinancialDataActivityForState.get(0).getAdminFinancialDataCellActivityDetails();
			model.addAttribute("activityDetailsForState", activityDetailsForState);
			List<AdminAndFinancialDataActivity> andFinancialDataActivityForMopr = adminAndFinancialDataCellService.fetchAdminAndFinancialActivity("M");
			 List<AdminFinancialDataCellActivityDetails> activityDetailsForMopr=  andFinancialDataActivityForMopr.get(0).getAdminFinancialDataCellActivityDetails();
			 model.addAttribute("activityDetailsForMopr", activityDetailsForMopr);
			long totalUnitCost =0;
			long totalOfFund =0;
			for(int i= 0 ; i<activityDetailsForState.size(); i++)
			 {
				totalOfFund = totalOfFund + activityDetailsForState.get(i).getFunds();
				 
				
			 }
		 long totalOfFundWithAdditionalRequirement = totalOfFund + andFinancialDataActivityForState.get(0).getAdditionalRequirement();
				
			 for(int i= 0 ; i<activityDetailsForMopr.size(); i++)
			 {
				 totalUnitCost = totalUnitCost + activityDetailsForMopr.get(i).getFunds();
				 
				
			 }
			 model.addAttribute("totalUnitCostForMopr", totalUnitCost);
			 model.addAttribute("totalUnitCostForState", totalOfFund);
			 model.addAttribute("TOTAL_WITH_ADDITIONAL", totalOfFundWithAdditionalRequirement);
				
			 return ADMIN_AND_FINANCIAL_FOR_CEC;
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
		model.addAttribute("USER_TYPE",userPreference.getUserType());
		model.addAttribute("STATE_CODE", userPreference.getStateCode());
		return ADMIN_AND_FINANCIAL;
	}
	
	@RequestMapping(value="adminAndFinancialDataCell",method=RequestMethod.POST)
	private String adminAndFinancialPost(@ModelAttribute("ADMIN_FIN_DATA_CELL") AdminAndFinancialDataActivity adminAndFinancialDataActivity,RedirectAttributes redirectAttributes){
		adminAndFinancialDataCellService.saveData(adminAndFinancialDataActivity);
		if(adminAndFinancialDataActivity.getIsFreeze() == null){
			redirectAttributes.addFlashAttribute(Message.SUCCESS_KEY, Message.SAVE_SUCCESS);
		}else if(adminAndFinancialDataActivity.getIsFreeze() == true){
			redirectAttributes.addFlashAttribute(Message.SUCCESS_KEY,Message.FRIZEE_SUCESS);
		}else{
			redirectAttributes.addFlashAttribute(Message.SUCCESS_KEY, Message.UNFRIZEE_SUCESS);
		}
		return REDIRECT_ADMIN_AND_FINANCIAL;
	}

}
