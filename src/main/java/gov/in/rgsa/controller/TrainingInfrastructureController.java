package gov.in.rgsa.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import gov.in.rgsa.entity.Block;
import gov.in.rgsa.entity.District;
import gov.in.rgsa.entity.SchemeMaster;
import gov.in.rgsa.entity.TrainingInstitueType;
import gov.in.rgsa.entity.TrainingInstituteCurrentStatus;
import gov.in.rgsa.model.ChangePasswordModel;
import gov.in.rgsa.service.BasicInfoService;
import gov.in.rgsa.service.LGDService;
import gov.in.rgsa.service.TrainingInstitutionService;
import gov.in.rgsa.user.preference.UserPreference;
import gov.in.rgsa.utils.Message;

@Controller
public class TrainingInfrastructureController {
	
	private static final String TAINING_INFRA = "trainingInfra";
	public static final String REDIRECT_BAISC_INFO_DETAILS = "redirect:basicinfo.add.html";
	public static final String REDIRECT_MODIFY_BAISC_INFO_DETAILS = "redirect:managebasicInfoDetails.html";
	
	@Autowired
	private LGDService lgdService;
	@Autowired
	private TrainingInstitutionService trainingInstitutionService;
	@Autowired
	private UserPreference userPreference;
	@Autowired
	BasicInfoService basicInfoService;

	@RequestMapping(value = "traininginfrastructure", method = RequestMethod.GET)
	public String masterTrainerGet(@ModelAttribute() ChangePasswordModel form, Model model,RedirectAttributes redirectAttributes)
	{
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
		return TAINING_INFRA;
	}

	@RequestMapping(value = "fetchTrainingInstituteBasedOnFinYearAndStateCode", method = RequestMethod.GET)
	private @ResponseBody TrainingInstituteCurrentStatus fetchTrainingInstituteBasedOnFinYearAndStateCode() {
		TrainingInstituteCurrentStatus trainingInstituteCurrentStatus = new TrainingInstituteCurrentStatus();
		trainingInstituteCurrentStatus = trainingInstitutionService.fetchTrainingInstituteBasedOnFinYearAndStateCode();
		return trainingInstituteCurrentStatus;
	}
	
	@RequestMapping(value = "fetchDistrictsBasedOnStateCode", method = RequestMethod.GET)
	private @ResponseBody List<District> fetchDistrictListBasedOnState() {
		return lgdService.getAllDistrictBasedOnState(userPreference.getStateCode());
	}
	
	@RequestMapping(value="fetchBlocksBasedOnDistrictCode",method=RequestMethod.POST)
	private @ResponseBody List<Block> fetchBlockListBasedOnDistrict(@RequestBody final Integer districtCode){
		return lgdService.getAllBlockBasedOnDistrict(districtCode);
	}

	@RequestMapping(value="fetchInstituteTypes",method=RequestMethod.POST)
	private @ResponseBody List<TrainingInstitueType> fetchInstituteTypes(@RequestBody final Integer selectedLevel){
		return trainingInstitutionService.fetchInstituteTypes(selectedLevel);
	}

	@RequestMapping(value="fetchScheme",method=RequestMethod.GET)
	private @ResponseBody List<SchemeMaster> fetchScheme(){
		return trainingInstitutionService.fetchScheme();
	}

	@RequestMapping(value="fetchTrainingInstituteDetails",method=RequestMethod.POST)
	private @ResponseBody TrainingInstituteCurrentStatus fetchTrainingInstituteDetails(@RequestBody(required=false) Integer locationId,@RequestParam("levelId") Integer levelId ){
		if(locationId == null) {
			locationId = userPreference.getStateCode();
		}
		TrainingInstituteCurrentStatus trainingInstituteCurrentStatus = trainingInstitutionService.fetchTrainingInstituteDetails(locationId,levelId);
		return trainingInstituteCurrentStatus;
	}

	@RequestMapping(value="saveInfrastructureDetails",method=RequestMethod.POST)
	private @ResponseBody String saveInfrastructureDetails(@RequestBody TrainingInstituteCurrentStatus trainingInstituteCurrentStatus,RedirectAttributes re){
		trainingInstitutionService.saveInfrastructureDetails(trainingInstituteCurrentStatus);
		re.addFlashAttribute(Message.SUCCESS_KEY, Message.SAVE_SUCCESS);
		return TAINING_INFRA;
	}

	@RequestMapping(value="deleteTrainingInfrastructureDetails",method=RequestMethod.POST)
	private void deleteTrainingInfrastructureDetails(@RequestBody Integer infractureDetailsObjToDelete){
		trainingInstitutionService.deleteTrainingInfrastructureDetails(infractureDetailsObjToDelete);
	}
	
}
