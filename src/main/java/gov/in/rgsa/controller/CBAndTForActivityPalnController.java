package gov.in.rgsa.controller;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.collections.CollectionUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import gov.in.rgsa.entity.AdministrativeTechnicalSupport;
import gov.in.rgsa.entity.Subjects;
import gov.in.rgsa.entity.TrainingActivity;
import gov.in.rgsa.entity.TrainingActivityDetails;
import gov.in.rgsa.entity.TrainingCategories;
import gov.in.rgsa.model.BasicInfoModel;
import gov.in.rgsa.service.BasicInfoService;
import gov.in.rgsa.service.EGovernanceSupportService;
import gov.in.rgsa.service.TrainingActivityService;
import gov.in.rgsa.user.preference.UserPreference;
import gov.in.rgsa.utils.Message;

@Controller
public class CBAndTForActivityPalnController {
	
	@Autowired
	TrainingActivityService trainingActivityService;
	@Autowired
	UserPreference userPreference;
	
	@Autowired
	public EGovernanceSupportService eGovernanceSupportService;
	
	@Autowired
	BasicInfoService basicInfoService;
	
	public String userType=null;
	
	public static final String CB_AND_TRAINING_FOR_ACTIVITY = "CBAndTForActivity.plan";
	public static final String CAPACITY_BUILDING_PLAN = "capacityBuilding.plan";
	public static final String ADD_TRAINING_DETAILS = "cbaddTrainingDetails";
	public static final String REDIRECT_CAPACITY_BUILDING_PLAN = "redirect:planForCapacityBuilding.html";
	public static final String REDIRECT_BAISC_INFO_DETAILS = "redirect:basicinfo.add.html";
	public static final String REDIRECT_MODIFY_BAISC_INFO_DETAILS = "redirect:managebasicInfoDetails.html";
	private static final String CAPACITY_BUILDING_PLAN_CEC = "capacityBuilding.planCEC";
	
	@RequestMapping(value = "capacityBuildingActivityPaln", method = RequestMethod.GET)
	private String basicInfoDetails(@ModelAttribute("BASIC_INFO_MODEL") BasicInfoModel basicInfoModel, Model model) {
		return CB_AND_TRAINING_FOR_ACTIVITY;

	}
	
	@RequestMapping(value = "planForCapacityBuilding", method = RequestMethod.GET)
	private String activityBuildingPan(@ModelAttribute("CBP_ADDTRAINING") TrainingActivity trainingActivity,@RequestParam(value = "menuId",defaultValue="20") int menuId, Model model,RedirectAttributes redirectAttributes,HttpSession session) {
		userPreference.setMenuId(menuId);
		
		List<TrainingActivity> trainingActivities = trainingActivityService.findAllTrainingActivity(null);
		
		String status = basicInfoService.fillFirstBasicInfo();
		if(status.equals("create")) {
			redirectAttributes.addFlashAttribute(Message.EXCEPTION_KEY, "Please fill the Basic Info Details first");
			return REDIRECT_BAISC_INFO_DETAILS;
		}
		else if(status.equals("modify")) {
			redirectAttributes.addFlashAttribute(Message.EXCEPTION_KEY, "Please fill the Required Basic Info Details");
			return REDIRECT_MODIFY_BAISC_INFO_DETAILS;
		}
		else if(status.equals("dataFound")) {
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
	      
		if(!trainingActivities.isEmpty()) {
			model.addAttribute("allTrainingActivity",trainingActivities.get(0));
			session.setAttribute("allTrainingActivity1", trainingActivities.get(0));
			TrainingActivity trainingAct= (TrainingActivity) session.getAttribute("allTrainingActivity1");
			System.out.println("trainingAct ="+trainingAct.getTrainingActivityId());
		} else {
			model.addAttribute("allTrainingActivity",trainingActivities);
		}
		model.addAttribute("modeOfTrainingList", trainingActivityService.fetchModeOfTraining());
		if (userPreference.getUserType().equalsIgnoreCase("C")) {
			List<TrainingActivity> trainingActivitiesState = trainingActivityService.findAllTrainingActivity('S');
			List<TrainingActivity> trainingActivitiesMopr = trainingActivityService.findAllTrainingActivity('M');
			if (CollectionUtils.isNotEmpty(trainingActivitiesState)) {
				model.addAttribute("trainingActivitiesState", trainingActivitiesState.get(0));
			}
			if (CollectionUtils.isNotEmpty(trainingActivitiesMopr)) {
				model.addAttribute("trainingActivitiesMopr", trainingActivitiesMopr.get(0));
			}
			return CAPACITY_BUILDING_PLAN_CEC;
		} else {
		return CAPACITY_BUILDING_PLAN;
		
	}
	}
		return null;
	}
	
	@RequestMapping(value = "planForCapacityBuildingForMOPR", method = RequestMethod.GET)
	private String activityBuildingPanForMOPR(@ModelAttribute("CBP_ADDTRAINING") TrainingActivity trainingActivity,@RequestParam(value = "menuId",defaultValue="20") int menuId, Model model) {
		userPreference.setMenuId(menuId);
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
		
		this.userType = 'M'+"";
		List<TrainingActivity> trainingActivities = trainingActivityService.findAllTrainingActivity(this.userType.charAt(0));
		if(!trainingActivities.isEmpty()) {
			if(trainingActivities.get(0).getUserType()=='S') {
			trainingActivities.get(0).setIsFreeze(false);}
			model.addAttribute("allTrainingActivity",trainingActivities.get(0));
			}
		else {
			model.addAttribute("allTrainingActivity",trainingActivities);
		}
		model.addAttribute("modeOfTrainingList", trainingActivityService.fetchModeOfTraining());
		return CAPACITY_BUILDING_PLAN;
	}
	
	@RequestMapping(value="/addTrainings" , method = RequestMethod.GET)
	public String showAddTrainingPage(@ModelAttribute("CBP_ADDTRAINING")TrainingActivity trainingActivity ,Model model) {
		
		model.addAttribute("targetGrpMstrList",trainingActivityService.targetGroupMastersList());
		model.addAttribute("trainingCatgryList",trainingActivityService.trainingCategoriesList());
		model.addAttribute("trngVenueList",trainingActivityService.trainingVenueLevelsList());
		if(!trainingActivityService.findTrainingActivity().isEmpty()) {
		model.addAttribute("allTrainingActivity",trainingActivityService.findTrainingActivity().get(0));
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
	      
			model.addAttribute("modeOfTrainingList", trainingActivityService.fetchModeOfTraining());
		model.addAttribute("CBP_ADDTRAINING", trainingActivity);
		return ADD_TRAINING_DETAILS;
	}
	
	@RequestMapping(value="cpbaddtraining", method= RequestMethod.POST)
	public String saveaddtrainingmethod(@ModelAttribute("CBP_ADDTRAINING")TrainingActivity trainingActivity ,Model model,RedirectAttributes redirectAttributes) {
		/* int trainingCategoryId =trainingActivity.getTrainingActivityDetailsList().get(0).getTrainingCategoryId().getTrainingCategoryId();
         trainingActivityService.populateStateFunds(trainingCategoryId);*/

		trainingActivityService.save(trainingActivity);
		redirectAttributes.addAttribute(Message.SUCCESS_KEY, Message.SAVE_SUCCESS);
		
		return REDIRECT_CAPACITY_BUILDING_PLAN;
	}
	
	@RequestMapping(value="deleteTrainingActivity" ,method= RequestMethod.POST)
	private String deleteTrainingActivityMethod(@ModelAttribute("CBP_ADDTRAINING")TrainingActivity trainingActivity ,Model model,RedirectAttributes redirectAttributes) {
		
		int id = trainingActivity.getIdToEdit();
		trainingActivityService.delete(id);
		redirectAttributes.addAttribute(Message.DELETE_KEY, Message.DELETE_SUCCESS);
		return REDIRECT_CAPACITY_BUILDING_PLAN;
	}
	
	@RequestMapping(value="saveCapctyBuldngPln",method= RequestMethod.POST)
	private String saveCapctyBuldngPlnMethod(@ModelAttribute("CBP_ADDTRAINING")TrainingActivity trainingActivity ,Model model,RedirectAttributes redirectAttributes, HttpSession session) {
		
		if(userPreference.getUserType().equalsIgnoreCase("M") && trainingActivity.getUserType().equals("S".charAt(0))) {
			 trainingActivity.setTrainingActivityId(null);
			 trainingActivityService.saveAndUpdateMopr(trainingActivity);
		 }
		 else if(userPreference.getUserType().equalsIgnoreCase("M") && trainingActivity.getUserType().equals("M".charAt(0))) {
			 trainingActivityService.saveAndUpdateMopr(trainingActivity);
		 }
		 else if(userPreference.getUserType().equalsIgnoreCase("C")) {
				TrainingActivity trainingActSession = (TrainingActivity) session.getAttribute("allTrainingActivity1");
				List<TrainingActivityDetails> detailMain = trainingActivity.getTrainingActivityDetailsList();
				List<TrainingActivityDetails> detailSession = trainingActSession.getTrainingActivityDetailsList();
				for (int i = 0; i < detailMain.size(); i++) {
					detailMain.get(i).setTrainingSubjectsList(detailSession.get(i).getTrainingSubjectsList());
					detailMain.get(i).setTrainingTargetGroupsList(detailSession.get(i).getTrainingTargetGroupsList());
				}
			 trainingActivityService.saveAndUpdateCEC(trainingActivity);
		 }
		 else
		trainingActivityService.update(trainingActivity);
		 
		redirectAttributes.addAttribute(Message.SUCCESS_KEY, Message.SAVE_SUCCESS);
		return REDIRECT_CAPACITY_BUILDING_PLAN;
	}
	
	@RequestMapping(value="frzUnfrzTrainingActivity", method=RequestMethod.POST)
	private String frzUnfrzTrainingActivityMethod(@ModelAttribute("CBP_ADDTRAINING")TrainingActivity trainingActivity ,Model model,RedirectAttributes redirectAttributes) {
		trainingActivityService.freezeUnfreeze(trainingActivity);
		if(trainingActivity.getIsFreeze() == false) {
			redirectAttributes.addFlashAttribute(Message.SUCCESS_KEY, "Freeze Successfully");
		}else {
			redirectAttributes.addFlashAttribute(Message.SUCCESS_KEY, "UnFreeze Successfully");
		}
		return REDIRECT_CAPACITY_BUILDING_PLAN;
	}
	
	@RequestMapping(value="modifyTrainingActivity" , method=RequestMethod.POST)
	public String modifyTrainingActivityMethod(@ModelAttribute("CBP_ADDTRAINING")TrainingActivity trainingActivity ,Model model,RedirectAttributes redirectAttributes) {
		
		List<TrainingActivity> trngActvty = trainingActivityService.findTrainingActivity();
		TrainingCategories trainingCategories = null;
		
		if(trainingActivity.getCatgryId() != null) {
			List<Subjects> sbjctToShow = new ArrayList<>();
			for(int j = 0;j<trainingActivityService.subjectsList().size();j++) {
				if(trainingActivityService.subjectsList().get(j).getTrainingCtgId().getTrainingCategoryId() == trainingActivity.getCatgryId()) {
					trainingCategories = new TrainingCategories();
					trainingCategories.setTrainingCategoryId(trainingActivity.getCatgryId());
				sbjctToShow.add(trainingActivityService.subjectsList().get(j));
			}
		}
			model.addAttribute("subjectsList",sbjctToShow);
			if(!trngActvty.isEmpty()) {
			for(int i=0 ; i<trngActvty.get(0).getTrainingActivityDetailsList().size();i++) {
				if(trngActvty.get(0).getTrainingActivityDetailsList().get(i).getTrainingActivityDetailsId() == trainingActivity.getIdToEdit()) {
					trngActvty.get(0).getTrainingActivityDetailsList().get(i).setTrainingCategoryId(trainingCategories);
					model.addAttribute("showTrainingActivity",trngActvty.get(0).getTrainingActivityDetailsList().get(i));
				}
				
			}
		}
		}	else {
		model.addAttribute("subjectsList",trainingActivityService.subjectsList()); 	
			}
		if(!trngActvty.isEmpty()) {
		if(trainingActivity.getCatgryId() == null) {
		for(int i=0 ; i<trngActvty.get(0).getTrainingActivityDetailsList().size();i++) {
			int trainingActivityDetailsId=trngActvty.get(0).getTrainingActivityDetailsList().get(i).getTrainingActivityDetailsId();
			int editId=trainingActivity.getIdToEdit();
				if(trainingActivityDetailsId == editId) {
					model.addAttribute("showTrainingActivity",trngActvty.get(0).getTrainingActivityDetailsList().get(i));
				}
			}
		}
		else if(trainingActivity.getIdToEdit() == null) {
			trainingActivity.getTrainingActivityDetailsList().get(0).setTrainingCategoryId(trainingCategories);
			model.addAttribute("setCatgryId", trainingActivity.getTrainingActivityDetailsList().get(0).getTrainingCategoryId().getTrainingCategoryId());
			model.addAttribute("setTrainingActivity",trainingActivity.getTrainingActivityId());
			model.addAttribute("setAddtnlReqrmnt", trngActvty.get(0).getAdditionalRequirement());
		}
	}else {
		trainingActivity.getTrainingActivityDetailsList().get(0).setTrainingCategoryId(trainingCategories);
		model.addAttribute("setCatgryId", trainingActivity.getTrainingActivityDetailsList().get(0).getTrainingCategoryId().getTrainingCategoryId());
		model.addAttribute("setTrainingActivity",trainingActivity.getTrainingActivityId());
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
		
				model.addAttribute("trainingCatgryList",trainingActivityService.trainingCategoriesList());
				model.addAttribute("trngVenueList",trainingActivityService.trainingVenueLevelsList());
				model.addAttribute("targetGrpMstrList",trainingActivityService.targetGroupMastersList());
				model.addAttribute("modeOfTrainingList", trainingActivityService.fetchModeOfTraining());
		return ADD_TRAINING_DETAILS;
	}
	
}

