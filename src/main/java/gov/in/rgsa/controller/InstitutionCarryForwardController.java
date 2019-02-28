package gov.in.rgsa.controller;


import java.util.HashMap;
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

import gov.in.rgsa.entity.TrainingInstituteCarryForward;
import gov.in.rgsa.model.BasicInfoModel;
import gov.in.rgsa.service.TrainingInstitutionService;

@Controller
public class InstitutionCarryForwardController {

	
	
	public static final String  INSTRITUTIONAL_INFRA_CARRY_FOR = "institutionalInfraAndCarryForward";
	
	@Autowired
	TrainingInstitutionService trainingInstitutionService;
	
	
	@RequestMapping(value = "institutionalInfraAndCarryForward", method = RequestMethod.GET)
	private String administrativeTechSupportStaff(@ModelAttribute("BASIC_INFO_MODEL") BasicInfoModel basicInfoModel, Model model) {
		return  INSTRITUTIONAL_INFRA_CARRY_FOR;
	}
	
	@ResponseBody
	@RequestMapping(value="getTrainingIstitutionLevel", method = RequestMethod.GET, produces=MediaType.APPLICATION_JSON_VALUE)
	private Map<String, Object> getPanchayatBhawanActivity() {
		Map<String, Object> map=new HashMap<>();
		map.put("TRAINING_ACTIVITY_TYPE",trainingInstitutionService.fetchTypesOfTrainingInstitue());
		map.put("TRAINING_INSTITUTION_CF_DETAILS",trainingInstitutionService.getDetailsOfTrainingInstituetionCF());
		return map;
	}
	
	@ResponseBody
	@RequestMapping(value="saveTrainingInstitutionCF", method = RequestMethod.POST)
	private Map<String, Object> savePanchayatBhawanActivity(@RequestBody TrainingInstituteCarryForward carryForward,RedirectAttributes re) {
		trainingInstitutionService.saveTrainingInstituetionCF(carryForward);
		Map<String, Object> map=new HashMap<>();
		map.put("TRAINING_INSTITUTION_CF_DETAILS",trainingInstitutionService.getDetailsOfTrainingInstituetionCF());
		return map;
	}
	
}
