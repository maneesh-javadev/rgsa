package gov.in.rgsa.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.directwebremoting.guice.RequestParameters;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import gov.in.rgsa.entity.BasicInfo;
import gov.in.rgsa.entity.BasicInfoDefination;
import gov.in.rgsa.entity.BasicInfoDetails;
import gov.in.rgsa.model.BasicInfoModel;
import gov.in.rgsa.service.BasicInfoService;
import gov.in.rgsa.user.preference.UserPreference;
import gov.in.rgsa.utils.Message;

@Controller
public class EssentialConditionsController {
	
	public static final String SHOW_ESSENTIAL_CONDITIONS="essentialCondition.add";
	
	public static final String REDIRECT_ESSENTIAL_CONDITIONS = "redirect:manageEssentialConditions.html";
	public static final String MANAGE_ESSENTIAL_CONDITIONS = "essentialCondition.manage";
	
	public static final String VIEW_ESSENTIAL_CONDITIONS="viewEssentialConditions.add";
	public static final String MODIFY_ESSENTIAL_INFO_DETAILS="essentialCondition.update";
	
	@Autowired
	private UserPreference userPreference;

	@Autowired
	private BasicInfoService basicInfoService;
	
	@RequestMapping(value = "essentialConditions", method = RequestMethod.GET)
	private String basicInfoDetails(@ModelAttribute("BASIC_INFO_MODEL") BasicInfoModel basicInfoModel, Model model) {
		BasicInfoDefination basicInfoDefination = basicInfoService.getBasicInfoDefinationDetails(userPreference.getFinYearId(),"EC");
		model.addAttribute("BESIC_DEFINATION", basicInfoDefination);
		return SHOW_ESSENTIAL_CONDITIONS;
	}
	
	@RequestMapping(value = "essentialConditions", method = RequestMethod.POST)
	private String basicInfoDetailsPost(@ModelAttribute("BASIC_INFO_MODEL") BasicInfoModel basicInfoModel, Model model,
			RedirectAttributes re) {
		basicInfoService.save(basicInfoModel);
		re.addFlashAttribute(Message.SUCCESS_KEY, Message.SAVE_SUCCESS);
		return REDIRECT_ESSENTIAL_CONDITIONS;
	}
	
	@RequestMapping(value = "manageEssentialConditions", method = RequestMethod.GET)
	private String manageBasicInfoDetails(@ModelAttribute("BASIC_INFO_MODEL") BasicInfoModel basicInfoModel, Model model) {
		BasicInfoDefination basicInfoDefination = basicInfoService.getBasicInfoDefinationDetails(userPreference.getFinYearId(),"EC");
		model.addAttribute("BASIC_INFO", basicInfoService.findBesicInfo(userPreference.getFinYearId(), userPreference.getStateCode(),basicInfoDefination.getBasicInfoDefinationId()));
		return MANAGE_ESSENTIAL_CONDITIONS;
	}
	
	@RequestMapping(value = "viewEssentialConditions", method = RequestMethod.GET)
	private String viewEssentialConditions(@ModelAttribute("BASIC_INFO_MODEL") BasicInfoModel basicInfoModel, Model model) {
		addCommonData(basicInfoModel, model);
		return VIEW_ESSENTIAL_CONDITIONS;
	}
	
	@RequestMapping(value = "updateEssentialConditions", method = RequestMethod.GET)
	private String changeBasicInfoDetails(@ModelAttribute("BASIC_INFO_MODEL") BasicInfoModel basicInfoModel, Model model) {
		addCommonData(basicInfoModel, model);
		return MODIFY_ESSENTIAL_INFO_DETAILS;

	}
	
	@RequestMapping(value = "updateEssentialConditions", method = RequestMethod.POST)
	private String updateBasicInfoDetails(@ModelAttribute("BASIC_INFO_MODEL") BasicInfoModel basicInfoModel, Model model,RedirectAttributes re) {
		basicInfoService.delete(basicInfoModel);
		re.addFlashAttribute(Message.UPDATE_KEY, Message.UPDATE_SUCCESS);
		return REDIRECT_ESSENTIAL_CONDITIONS;
	}
	
	@RequestMapping(value = "freezeEssentialConditions", method = RequestMethod.GET)
	private String freezeEssentialConditions(@ModelAttribute("BASIC_INFO_MODEL") BasicInfoModel basicInfoModel, Model model,@ RequestParameters int basicInfoId,RedirectAttributes re) {
		basicInfoService.freezeBasicInfoDetails(basicInfoId);
		re.addFlashAttribute(Message.UPDATE_KEY, Message.UPDATE_SUCCESS);
		return REDIRECT_ESSENTIAL_CONDITIONS;
		
	}
	
	
	private void addCommonData(BasicInfoModel basicInfoModel,Model model) {
		BasicInfoDefination basicInfoDefination = basicInfoService.getBasicInfoDefinationDetails(userPreference.getFinYearId(),"EC");
		BasicInfo basicInfo = basicInfoService.getBasicInfoDetails(userPreference.getFinYearId(), userPreference.getStateCode(),basicInfoDefination.getBasicInfoDefinationId());
		if(basicInfo!=null) {
			List<BasicInfoDetails> basicInfoDetails=basicInfo.getBasicInfoDetails();
			Map<String, List<String>> map=new HashMap<String, List<String>>();
			for (BasicInfoDetails basicInfoDetail : basicInfoDetails) {
				if (!map.containsKey(basicInfoDetail.getDefinationKey())) {
					map.put(basicInfoDetail.getDefinationKey(), new ArrayList<String>());
		        }
				map.get(basicInfoDetail.getDefinationKey()).add(basicInfoDetail.getDefinationValue()==null?" ":basicInfoDetail.getDefinationValue());
			}
			basicInfoModel.setData(map);
			model.addAttribute("basicinfoId", basicInfo.getBasicInfoId());
		}
		model.addAttribute("BESIC_DEFINATION", basicInfoDefination);
	}

}
