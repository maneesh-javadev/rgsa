package gov.in.rgsa.controller;

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import gov.in.rgsa.entity.TrgDetailsOfHundredDaysProgram;
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
		TrgOfHundredDaysProgramCh1 trgOfHundredDaysProgramCh1=null;
		

		trgOfHundredDaysProgramCh1=hundredDayTrainingDetailsService.fetchTrgOfHundredDaysProgram();
		
		if(trgOfHundredDaysProgramCh1 != null) {
			//trgDetails=hundredDayTrainingDetailsService.fetchTrgDetailByTrgId(trgOfHundredDaysProgram.getTrgOfHundredDaysProgramId());
			//form.setTrgDetailsOfHundredDaysProgram(trgDetails);
	 
			String startarr[]=trgOfHundredDaysProgramCh1.getTrgStartDate().toString().substring(0,10).split("-");
			form.setDemoStartDate(startarr[2]+"-"+startarr[1]+"-"+startarr[0]);
			String endarr[]=trgOfHundredDaysProgramCh1.getTrgEndDate().toString().substring(0,10).split("-");
			form.setDemoEndDate(endarr[2]+"-"+endarr[1]+"-"+endarr[0]);
			//form.setDemoStartDate(String.valueOf(trgOfHundredDaysProgramCh1.getTrgEndDate()).substring(0, 10));
			form.setScParticipants(trgOfHundredDaysProgramCh1.getScParticipants());
			form.setStParticipants(trgOfHundredDaysProgramCh1.getStParticipants());
			form.setOthersParticipants(trgOfHundredDaysProgramCh1.getOthersParticipants());
			form.setWomenParticipants(trgOfHundredDaysProgramCh1.getWomenParticipants());
			form.setScAspirationalParticipants(trgOfHundredDaysProgramCh1.getScAspirationalParticipants());
			form.setStAspirationalParticipants(trgOfHundredDaysProgramCh1.getStAspirationalParticipants());
			form.setWomenAspirationalParticipants(trgOfHundredDaysProgramCh1.getWomenAspirationalParticipants());
			form.setOthersAspirationalParticipants(trgOfHundredDaysProgramCh1.getOthersAspirationalParticipants());
			form.setNoOfTrainingConducted(trgOfHundredDaysProgramCh1.getNoOfTrainingConducted());
			form.setTrgOfHundredDaysProgramChId(trgOfHundredDaysProgramCh1.getTrgOfHundredDaysProgramChId());
			form.setIsFreeze(trgOfHundredDaysProgramCh1.getIsFreeze());
			model.addAttribute("UPDATE_OR_SAVE", "update"); 
		}else {
			form=new HundredDayTrainingDetailModel();
			model.addAttribute("UPDATE_OR_SAVE", "save"); 
		}
		return  HUNDRED_DAY_DETAIL;
	}
	
	@PostMapping(value = "trainingDetailHundredDay")
	private String postHundredDayTrainingDetails(@ModelAttribute("HUN_DAY_TRAINING") TrgOfHundredDaysProgramCh1 entity , RedirectAttributes redirect,Model model) {
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
	
	@PostMapping(value = "fetchTrainingDetails")
	private String fetchTrainingDetails(@ModelAttribute("HUN_DAY_TRAINING") TrgOfHundredDaysProgramCh1 entity,Model model) {
		TrgOfHundredDaysProgramCh1 trgOfHundredDaysProgramCh1 = new TrgOfHundredDaysProgramCh1();
		DateFormat date= new SimpleDateFormat("dd-MM-yyyy");
		Date sdate=null ,edate=null;
		String demoStart=entity.getDemoStartDate() , demoEnd=entity.getDemoEndDate();
		try {
			sdate = date.parse(entity.getDemoStartDate());
			edate=date.parse(entity.getDemoEndDate());
		}catch(ParseException e) {
			e.printStackTrace();
		}
		entity.setTrgStartDate(sdate);
		entity.setTrgEndDate(edate);
		trgOfHundredDaysProgramCh1 = hundredDayTrainingDetailsService.fetchTrgOfHundredDaysProgramByDate(entity);
		if(trgOfHundredDaysProgramCh1 != null) {
			entity.setNoOfTrainingConducted(trgOfHundredDaysProgramCh1.getNoOfTrainingConducted());
			entity.setScParticipants(trgOfHundredDaysProgramCh1.getScParticipants());
			entity.setScAspirationalParticipants(trgOfHundredDaysProgramCh1.getScAspirationalParticipants());
			entity.setStParticipants(trgOfHundredDaysProgramCh1.getStParticipants());
			entity.setStAspirationalParticipants(trgOfHundredDaysProgramCh1.getStAspirationalParticipants());
			entity.setWomenParticipants(trgOfHundredDaysProgramCh1.getWomenParticipants());
			entity.setWomenAspirationalParticipants(trgOfHundredDaysProgramCh1.getWomenAspirationalParticipants());
			entity.setOthersParticipants(trgOfHundredDaysProgramCh1.getOthersParticipants());
			entity.setOthersAspirationalParticipants(trgOfHundredDaysProgramCh1.getOthersAspirationalParticipants());
			entity.setTrgOfHundredDaysProgramChId(trgOfHundredDaysProgramCh1.getTrgOfHundredDaysProgramChId());
			String startarr[]=trgOfHundredDaysProgramCh1.getTrgStartDate().toString().substring(0,10).split("-");
			entity.setDemoStartDate(startarr[2]+"-"+startarr[1]+"-"+startarr[0]);
			String endarr[]=trgOfHundredDaysProgramCh1.getTrgEndDate().toString().substring(0,10).split("-");
			entity.setDemoEndDate(endarr[2]+"-"+endarr[1]+"-"+endarr[0]);
			model.addAttribute("UPDATE_OR_SAVE", "update");
		}else {
			//entity = new TrgOfHundredDaysProgramCh1();
			entity.setDemoStartDate(demoStart);
			entity.setDemoEndDate(demoEnd);
			entity.setTrgOfHundredDaysProgramChId(null);
			entity.setNoOfTrainingConducted(null);
			entity.setScParticipants(null);
			entity.setScAspirationalParticipants(null);
			entity.setStParticipants(null);
			entity.setStAspirationalParticipants(null);
			entity.setWomenParticipants(null);
			entity.setWomenAspirationalParticipants(null);
			entity.setOthersParticipants(null);
			entity.setOthersAspirationalParticipants(null);
			model.addAttribute("UPDATE_OR_SAVE", "save"); 
		}
		return  HUNDRED_DAY_DETAIL;
	}
}
