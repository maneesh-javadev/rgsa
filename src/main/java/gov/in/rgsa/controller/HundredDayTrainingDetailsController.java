package gov.in.rgsa.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import gov.in.rgsa.entity.TrgOfHundredDaysProgram;
import gov.in.rgsa.entity.TrgOfHundredDaysProgramCh1;
import gov.in.rgsa.model.HundredDayTrainingDetailModel;
import gov.in.rgsa.service.HundredDayTrainingDetailsService;
import gov.in.rgsa.service.TrainingActivityService;
import gov.in.rgsa.utils.Message;

@Controller
public class HundredDayTrainingDetailsController {

	public static final String HUNDRED_DAY_DETAIL="hundredDayTrainingDetail";
	private static final String REDIRECT_HUNDRED_DAY_DETAIL = "redirect:trainingDetailHundredDay.html"; 
	
	@Autowired
	private HundredDayTrainingDetailsService hundredDayTrainingDetailsService; 
	
	@Autowired
	private TrainingActivityService trainingActivityService ; 
	
	@GetMapping(value = "trainingDetailHundredDay")
	private String getHundredDayTrainingDetails(@ModelAttribute("HUN_DAY_TRAINING") HundredDayTrainingDetailModel form , Model model) {
		System.err.println(".................i am in get controller brother......");
		//List<TargetGroupMaster> targetGroupMaster=new ArrayList<TargetGroupMaster>();
		//List<TrgDetailsOfHundredDaysProgram> trgDetails=new ArrayList<TrgDetailsOfHundredDaysProgram>();
		TrgOfHundredDaysProgramCh1 trgOfHundredDaysProgramCh1=hundredDayTrainingDetailsService.fetchTrgOfHundredDaysProgram();
		if(trgOfHundredDaysProgramCh1 != null) {
			//trgDetails=hundredDayTrainingDetailsService.fetchTrgDetailByTrgId(trgOfHundredDaysProgram.getTrgOfHundredDaysProgramId());
			//form.setTrgDetailsOfHundredDaysProgram(trgDetails);
			form.setNoOfTrainingConducted(trgOfHundredDaysProgramCh1.getNoOfTrainingConducted());
			form.setTrgOfHundredDaysProgramChId(trgOfHundredDaysProgramCh1.getTrgOfHundredDaysProgramChId());
			form.setIsFreeze(trgOfHundredDaysProgramCh1.getIsFreeze());
			model.addAttribute("UPDATE_OR_SAVE", "update"); 
		}else {
			model.addAttribute("UPDATE_OR_SAVE", "save"); 
		}
		//targetGroupMaster = trainingActivityService.targetGroupMastersList();
		//model.addAttribute("TARGET_GROUP_MASTER", targetGroupMaster);
		return  HUNDRED_DAY_DETAIL;
	}
	
	@PostMapping(value = "trainingDetailHundredDay")
	private String postHundredDayTrainingDetails(@ModelAttribute("HUN_DAY_TRAINING") TrgOfHundredDaysProgramCh1 entity , RedirectAttributes redirect) {
		System.err.println(".................i am in post controller brother......");
		hundredDayTrainingDetailsService.saveDeatils(entity);
		
		  switch (entity.getMsg()) { 
		  case "freeze": redirect.addFlashAttribute(Message.SUCCESS_KEY, Message.FRIZEE_SUCESS);
			  		break;
		  
		  case "unfreeze": redirect.addFlashAttribute(Message.SUCCESS_KEY,Message.UNFRIZEE_SUCESS); 
		  			break;
		  
		  default: redirect.addFlashAttribute(Message.SUCCESS_KEY,Message.SAVE_SUCCESS);
		  			break; }
		 
		
		return  REDIRECT_HUNDRED_DAY_DETAIL;
	}
}
