package gov.in.rgsa.controller;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.directwebremoting.guice.RequestParameters;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
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
import gov.in.rgsa.entity.FocusArea;
import gov.in.rgsa.model.BasicInfoModel;
import gov.in.rgsa.service.BasicInfoService;
import gov.in.rgsa.user.preference.UserPreference;
import gov.in.rgsa.utils.Message;

@Controller
public class BasicInfoController {

	static Logger logger = LoggerFactory.getLogger(BasicInfoController.class);
	public static final String BASIC_INFO_DETAILS = "basicinfo.add";
	public static final String MANAGE_BASIC_INFO_DETAILS = "basicinfo.manage";
	public static final String VIEW_BASIC_INFO_DETAILS = "basicinfo.view";
	public static final String MODIFY_BASIC_INFO_DETAILS = "basicinfo.update";
	public static final String REDIRECT_BASIC_INFO = "redirect:managebasicInfoDetails.html";

	public static final String REDIRECT_VIEW_BASIC_INFO_DETAILS = "redirect:basicinfo.view";
	
	@Autowired
	private UserPreference userPreference; 

	@Autowired
	private BasicInfoService basicInfoService;
	
	
	

	@RequestMapping(value = "basicinfo", method = RequestMethod.GET)
	private String basicInfoDetails(@ModelAttribute("BASIC_INFO_MODEL") BasicInfoModel basicInfoModel, Model model) {
		try {
		BasicInfoDefination basicInfoDefination = basicInfoService.getBasicInfoDefinationDetails(userPreference.getFinYearId(),"BI");
		List<FocusArea> focusAreas=basicInfoService.fetchFocusAreas();
		model.addAttribute("STATE_CODE", userPreference.getStateCode());
		model.addAttribute("BESIC_DEFINATION", basicInfoDefination);
		model.addAttribute("FOCUS_AREAS_LIST", focusAreas);
		model.addAttribute("isPesaState",isPesaEnabled(userPreference.getStateCode()));
		}catch(Exception e) {
			 e.printStackTrace();
			logger.error("Error found in class=BasicInfoController , @basicinfo and method is basicInfoDetails ==of date "+new Date()+ "=" +e);
		}
		return BASIC_INFO_DETAILS;

	}
	
	private void addCommonData(BasicInfoModel basicInfoModel,Model model) {
		try {
		BasicInfoDefination basicInfoDefination = basicInfoService.getBasicInfoDefinationDetails(userPreference.getFinYearId(),"BI");
		BasicInfo basicInfo = basicInfoService.getBasicInfoDetails(userPreference.getFinYearId(), userPreference.getStateCode(),basicInfoDefination.getBasicInfoDefinationId());
		List<FocusArea> focusAreas=basicInfoService.fetchFocusAreas();
		if(basicInfo!=null) {
			
			List<BasicInfoDetails> basicInfoDetails=basicInfo.getBasicInfoDetails();
			Map<String, List<String>> map=new HashMap<String, List<String>>();
			for (BasicInfoDetails basicInfoDetail : basicInfoDetails) {
				if (!map.containsKey(basicInfoDetail.getDefinationKey())) {
					map.put(basicInfoDetail.getDefinationKey(), new ArrayList<String>());
		        }
				if(basicInfoDetail.getDefinationValue()!=null && !basicInfoDetail.getDefinationValue().isEmpty()) {
					map.get(basicInfoDetail.getDefinationKey()).add(basicInfoDetail.getDefinationValue());
				}
				
			}
			basicInfoModel.setData(map);
			model.addAttribute("basicinfoId", basicInfo.getBasicInfoId());
			model.addAttribute("status", basicInfo.getStatus());
		}
		model.addAttribute("BESIC_DEFINATION", basicInfoDefination);
		model.addAttribute("FOCUS_AREAS_LIST", focusAreas);
		}catch(Exception e) {
			 e.printStackTrace();
			logger.error("Error found in class=BasicInfoController , method is addCommonData ==of date "+new Date()+ "=" +e);
		}
	}
	

	@RequestMapping(value = "basicinfo", method = RequestMethod.POST)
	private String basicInfoDetailsPost(@ModelAttribute("BASIC_INFO_MODEL") BasicInfoModel basicInfoModel, Model model, RedirectAttributes re)
	{
		try
		{
			setPreference(basicInfoService.save(basicInfoModel));

			re.addFlashAttribute(Message.SUCCESS_KEY, Message.SAVE_SUCCESS);
			if (basicInfoModel.getStatus() != null && basicInfoModel.getStatus().charAt(0) == 'F')
			{
				re.addFlashAttribute(Message.UPDATE_KEY, Message.FRIZEE_SUCESS);
			}
		} catch (Exception e)
		{
			 e.printStackTrace();
			logger.error("Error found in class=BasicInfoController , @basicinfo and method is basicInfoDetailsPost ==of date " + new Date() + "=" + e);
		}
		return REDIRECT_BASIC_INFO;

	}
	
	private  static boolean isPesaEnabled(Integer stateCode) {
	List<Integer> pesaState=new ArrayList<Integer>();
	pesaState.add(2);
	pesaState.add(8);
	pesaState.add(21);
	pesaState.add(23);
	pesaState.add(24);
	pesaState.add(27);
	pesaState.add(28);
	pesaState.add(20);
	pesaState.add(22);
	pesaState.add(36);
	
	return pesaState.contains(stateCode);
	}
	
	
	@RequestMapping(value = "managebasicInfoDetails", method = RequestMethod.GET)
	private String manageBasicInfoDetails(@ModelAttribute("BASIC_INFO_MODEL") BasicInfoModel basicInfoModel, Model model) {
		try {
		BasicInfoDefination basicInfoDefination = basicInfoService.getBasicInfoDefinationDetails(userPreference.getFinYearId(),"BI");
		model.addAttribute("BASIC_INFO", basicInfoService.findBesicInfo(userPreference.getFinYearId(), userPreference.getStateCode(),basicInfoDefination.getBasicInfoDefinationId()));
		}catch(Exception e) {
			 e.printStackTrace();
			logger.error("Error found in class=BasicInfoController , @managebasicInfoDetails and method is manageBasicInfoDetails ==of date "+new Date()+ "=" +e);
		}
		return MANAGE_BASIC_INFO_DETAILS;
	}
	
	@RequestMapping(value = "viewBasicInfoDetails", method = RequestMethod.GET)
	private String viewBasicInfoDetails(@ModelAttribute("BASIC_INFO_MODEL") BasicInfoModel basicInfoModel, Model model) {
		addCommonData(basicInfoModel, model);
		return VIEW_BASIC_INFO_DETAILS;
	}
	
	@RequestMapping(value = "updateBasicInfoDetails", method = RequestMethod.GET)
	private String changeBasicInfoDetails(@ModelAttribute("BASIC_INFO_MODEL") BasicInfoModel basicInfoModel, Model model)
	{
		try
		{
			BasicInfoDefination basicInfoDefination = basicInfoService.getBasicInfoDefinationDetails(userPreference.getFinYearId(), "BI");
			List<FocusArea> focusAreas = basicInfoService.fetchFocusAreas();
			model.addAttribute("BESIC_DEFINATION", basicInfoDefination);
			model.addAttribute("isPesaState", isPesaEnabled(userPreference.getStateCode()));
			model.addAttribute("FOCUS_AREAS_LIST", focusAreas);
			model.addAttribute("STATE_CODE", userPreference.getStateCode());
			addCommonData(basicInfoModel, model);
		} catch (Exception e)
		{
			 e.printStackTrace();
			logger.error("Error found in class=BasicInfoController , @updateBasicInfoDetails and method is changeBasicInfoDetails ==of date " + new Date() + "=" + e);
		}
		return MODIFY_BASIC_INFO_DETAILS;
	}
	
	@RequestMapping(value = "updateBasicInfoDetails", method = RequestMethod.POST)
	private String updateBasicInfoDetails(@ModelAttribute("BASIC_INFO_MODEL") BasicInfoModel basicInfoModel, Model model,RedirectAttributes re) {
		try {
		basicInfoService.delete(basicInfoModel);
		re.addFlashAttribute(Message.UPDATE_KEY, Message.UPDATE_SUCCESS);
		if(basicInfoModel.getStatus().charAt(0)=='F'){
			re.addFlashAttribute(Message.UPDATE_KEY, Message.FRIZEE_SUCESS);
		}else if(basicInfoModel.getStatus().charAt(0)=='U'){
			re.addFlashAttribute(Message.UPDATE_KEY, Message.UNFRIZEE_SUCESS);
		}
		model.addAttribute("STATE_CODE", userPreference.getStateCode());
		model.addAttribute("isPesaState",isPesaEnabled(userPreference.getStateCode()));
		} catch (Exception e)
		{
			 e.printStackTrace();
			logger.error("Error found in class=BasicInfoController , @updateBasicInfoDetails and method is updateBasicInfoDetails ==of date " + new Date() + "=" + e);
		}
		return REDIRECT_BASIC_INFO;
		
	}
	@RequestMapping(value = "freezeBasicInfoDetails", method = RequestMethod.GET)
	private String freezeBasicInfoDetails(@ModelAttribute("BASIC_INFO_MODEL") BasicInfoModel basicInfoModel, Model model,@ RequestParameters int basicInfoId,RedirectAttributes re) {
		try {
		basicInfoService.freezeBasicInfoDetails(basicInfoId);
		re.addFlashAttribute(Message.UPDATE_KEY, Message.UPDATE_SUCCESS);
		}catch (Exception e)
		{
			 e.printStackTrace();
			logger.error("Error found in class=BasicInfoController , @freezeBasicInfoDetails and method is freezeBasicInfoDetails ==of date " + new Date() + "=" + e);
		}
		return REDIRECT_VIEW_BASIC_INFO_DETAILS;
		
	}
	
	private void setPreference(UserPreference _userPreference) {
		userPreference.setUserId(_userPreference.getUserId());
		userPreference.setUserName(_userPreference.getUserName());
		userPreference.setFinYear(_userPreference.getFinYear());
		userPreference.setUserType(_userPreference.getUserType());
		userPreference.setStateCode(_userPreference.getStateCode());
		userPreference.setDistrictcode(_userPreference.getDistrictcode());
		userPreference.setMenus(_userPreference.getMenus());
		userPreference.setFinYearId(_userPreference.getFinYearId());	
		userPreference.setFinYear(_userPreference.getFinYear());
		userPreference.setActivityPlanStatus(_userPreference.getActivityPlanStatus());
		userPreference.setPlanComponents((_userPreference.getPlanComponents()));
		System.out.println("after save basic info set plan code:"+userPreference.getPlanCode()+" into session");
		userPreference.setPlanCode(_userPreference.getPlanCode());
		userPreference.setPlanStatus(_userPreference.getPlanStatus());
		userPreference.setPlanVersion(_userPreference.getPlanVersion());
		
		userPreference.setStatePlanComponentsFunds(_userPreference.getStatePlanComponentsFunds());
		userPreference.setPlansAreFreezed(_userPreference.isPlansAreFreezed());
		userPreference.setCountPlanSubmittedByState(_userPreference.getCountPlanSubmittedByState());
		userPreference.setCountPlanSubmittedByMOPR(_userPreference.getCountPlanSubmittedByMOPR());
	}
	
}
