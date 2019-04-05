package gov.in.rgsa.controller;



import javax.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import antlr.collections.List;
import gov.in.rgsa.entity.IecActivity;
import gov.in.rgsa.entity.IecActivityDetails;
import gov.in.rgsa.model.IecModel;
import gov.in.rgsa.service.BasicInfoService;
import gov.in.rgsa.service.IecService;
import gov.in.rgsa.user.preference.UserPreference;
import gov.in.rgsa.utils.Message;

@Controller
public class IecController {
	
	private static final String IEC = "iec";
	public static final String REDIRECT_IEC_ACTIVITY = "redirect:iec.html";
	private static final String IEC_CEC = "iecCEC";	public static final String REDIRECT_BAISC_INFO_DETAILS = "redirect:basicinfo.add.html";
	public static final String REDIRECT_MODIFY_BAISC_INFO_DETAILS = "redirect:managebasicInfoDetails.html";
	
	@Autowired
	private IecService service;
	
	@Autowired
	BasicInfoService basicInfoService;
	
	@Autowired
	private UserPreference userPreference;

	@RequestMapping(value = "iec", method = RequestMethod.GET)
	private String IecGet(@ModelAttribute("IEC_ACTIVITY") IecModel iecModel, Model model ,HttpServletRequest request,@RequestParam(value = "iecId", required = false) Integer iecId,RedirectAttributes redirectAttributes) {
		
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
	      
		String status = basicInfoService.fillFirstBasicInfo();
		if(status.equals("create")) {
			redirectAttributes.addFlashAttribute(Message.EXCEPTION_KEY, "Please fill the Basic Info Details first");
			return REDIRECT_BAISC_INFO_DETAILS;
		}
		else if(status.equals("modify")) {
			redirectAttributes.addFlashAttribute(Message.EXCEPTION_KEY, "Please fill the Required Basic Info Details");
			return REDIRECT_MODIFY_BAISC_INFO_DETAILS;
		}
		
		model.addAttribute("NATURE_IEC_LIST", service.findAllActivityById());
			IecActivity iecActivity = service.fetchIecDetail(userPreference.getUserType());
			model.addAttribute("user_type",userPreference.getUserType().charAt(0));

			if (iecActivity != null) {
				/*iecModel.put("iecId", iecId);*/
				model.addAttribute("IEC_LIST",iecActivity);
				model.addAttribute("IEC_LIST_DETAILS",iecActivity.getIecActivityDetails());
			}
			
				if(userPreference.getUserType().equalsIgnoreCase("C"))
			{
					
					IecActivity iecActivityForState = service.fetchIecDetail("S");
					IecActivity iecActivityForMopr =service.fetchIecDetail("M");
					long totalAmount =0;
					java.util.List<IecActivityDetails> iecActivityDetails =iecActivityForState.getIecActivityDetails();
					for(int i=0; i<iecActivityDetails.size();i++)
					{
						totalAmount =totalAmount +iecActivityDetails.get(i).getTotalAmountProposed();	
						
					}
				 model.addAttribute("totalAmountProposedState",totalAmount);
					model.addAttribute("IEC_LIST_FOR_STATE", iecActivityForState.getIecActivityDetails());
					model.addAttribute("IEC_LIST_FOR_MOPR", iecActivityForMopr.getIecActivityDetails());
				
					return IEC_CEC;
					}
			
			return IEC;
		}

	@RequestMapping(value = "iec", method = RequestMethod.POST)
	private String saveIec(@ModelAttribute("IEC_ACTIVITY") IecModel iecModel, Model model ,  RedirectAttributes redirectAttributes)  {
		
		service.save(iecModel.getIecActivity());
		if(userPreference.getUserType().equalsIgnoreCase("S")) {
			
			if(iecModel!=null && iecModel.getIdToDeleteStr()!=null && iecModel.getIdToDeleteStr().length()>0)
			{
				String idArr[]=iecModel.getIdToDeleteStr().split(",");
				for(int i=0;i<idArr.length;i++) {
					service.delete(Integer.parseInt((idArr[i])));
				}
				
			}
		}
		
		redirectAttributes.addFlashAttribute(Message.SUCCESS_KEY, Message.SAVE_SUCCESS);
	

		return REDIRECT_IEC_ACTIVITY;

	}
	
	@RequestMapping(value="deleteIecActivity", method=RequestMethod.POST)
	public String deleteInnovactivityMethod(@ModelAttribute("IEC_ACTIVITY")  IecActivity iecActivity ,Model model,RedirectAttributes redirectAttributes) {
		if(iecActivity.getIdToDelete() != null || iecActivity.getIdToDelete() !=0) {
			int idMain = Integer.valueOf(iecActivity.getIdToDelete());
		service.delete(idMain);
			
		redirectAttributes.addFlashAttribute(Message.DELETE_KEY,Message.DELETE_SUCCESS);
		}
		model.addAttribute("iecActivity",service.fetchIecDetail(userPreference.getUserType()));
		
		
		return REDIRECT_IEC_ACTIVITY;
	}
	
	@RequestMapping(value="freezAndUnfreezIEC" , method=RequestMethod.POST) 
	public String freezeUnfreezemethod(@ModelAttribute("IEC_ACTIVITY")IecModel iecModel,Model model ,RedirectAttributes redirectAttributes) {
		service.freezeAndUnfreeze(iecModel.getIecActivity());
		if(iecModel.getIecActivity().getDbFileName().equals("freeze")) 
		{
			redirectAttributes.addFlashAttribute(Message.SUCCESS_KEY, "Freezed Successfully");
			}
		else {
			redirectAttributes.addFlashAttribute(Message.SUCCESS_KEY, "UnFreezed Successfully");
		}
		
		
		return  REDIRECT_IEC_ACTIVITY;
	}
}