package gov.in.rgsa.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import gov.in.rgsa.entity.TrgDetailsOfHundredDaysProgram;
import gov.in.rgsa.model.HundredDayTrainingDetailModel;
import gov.in.rgsa.service.HundredDayTrainingDetailsService;
import gov.in.rgsa.utils.Message;

@Controller
public class HundredDayTrainingDetailsController {

	public static final String HUNDRED_DAY_DETAIL="hundredDayTrainingDetail";
	private static final String REDIRECT_HUNDRED_DAY_DETAIL = "redirect:trainingDetailHundredDay.html"; 
	
	@Autowired
	private HundredDayTrainingDetailsService hundredDayTrainingDetailsService; 
	
	@GetMapping(value = "trainingDetailHundredDay")
	private String getHundredDayTrainingDetails(@ModelAttribute("HUN_DAY_TRAINING_DETAIL") HundredDayTrainingDetailModel form , Model model) {
		System.err.println(".................i am in get controller brother......");
		TrgDetailsOfHundredDaysProgram detailProgram= hundredDayTrainingDetailsService.fetchDetails();
		if(detailProgram != null) {
			form.setNoOfTrainingsConducted(detailProgram.getNoOfTrainingsConducted());
			form.setNoOfParticipantsSC(detailProgram.getNoOfParticipantsSC());
			form.setNoOfParticipantsST(detailProgram.getNoOfParticipantsST());
			form.setNoOfParticipantsWomen(detailProgram.getNoOfParticipantsWomen());
			form.setNoOfParticipantsOthers(detailProgram.getNoOfParticipantsOthers());
			form.setIsFreeze(detailProgram.getIsFreeze());
			model.addAttribute("ID", detailProgram.getId());
			model.addAttribute("UPDATE_OR_SAVE", "update"); 
		}else {
			model.addAttribute("UPDATE_OR_SAVE", "save"); 
		}
		return  HUNDRED_DAY_DETAIL;
	}
	
	@PostMapping(value = "trainingDetailHundredDay")
	private String postHundredDayTrainingDetails(@ModelAttribute("HUN_DAY_TRAINING_DETAIL") TrgDetailsOfHundredDaysProgram entity , RedirectAttributes redirect) {
		System.err.println(".................i am in post controller brother......");
		hundredDayTrainingDetailsService.saveDeatils(entity);
		switch (entity.getMsg()) {
		case "freeze":
			redirect.addFlashAttribute(Message.SUCCESS_KEY, Message.FRIZEE_SUCESS);
			break;
			
		case "unfreeze":
			redirect.addFlashAttribute(Message.SUCCESS_KEY, Message.UNFRIZEE_SUCESS);
			break;	

		default:
			redirect.addFlashAttribute(Message.SUCCESS_KEY, Message.SAVE_SUCCESS);
			break;
		}
		
		return  REDIRECT_HUNDRED_DAY_DETAIL;
	}
}
