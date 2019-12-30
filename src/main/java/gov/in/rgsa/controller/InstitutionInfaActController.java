package gov.in.rgsa.controller;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

import org.apache.commons.collections.CollectionUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import gov.in.rgsa.entity.InstitutionalInfraActivityPlan;
import gov.in.rgsa.entity.InstitutionalInfraActivityPlanDetails;
import gov.in.rgsa.entity.Plan;
import gov.in.rgsa.entity.TrainingInstitueType;
import gov.in.rgsa.service.BasicInfoService;
import gov.in.rgsa.service.InstitutionalInfraActivityPlanService;
import gov.in.rgsa.service.LGDService;
import gov.in.rgsa.service.PlanAllocationService;
import gov.in.rgsa.user.preference.UserPreference;
import gov.in.rgsa.utils.Message;

@Controller
public class InstitutionInfaActController {


	@Autowired
	private InstitutionalInfraActivityPlanService institutionalInfraActivityPlanService; 
	@Autowired
	BasicInfoService basicInfoService;
	@Autowired
	private UserPreference userPreference;
	
	@Autowired
	private PlanAllocationService planAllocationService;
	
@Autowired
	private LGDService lgdservice;
	public static final String INSTITUTION_INFRA_ACT = "institutionalInfraActivityPlan";
	public static final String REDIRECT_BAISC_INFO_DETAILS = "redirect:basicinfo.add.html";
	public static final String REDIRECT_MODIFY_BAISC_INFO_DETAILS = "redirect:managebasicInfoDetails.html";
	private static final String INSTITUTION_INFRA_ACT_CEC = "institutionalInfraActivityPlanCec";
	public static final String INSTITUTION_INFRA_ACT_MOPR = "institutionalInfraActivityPlanMopr";
	

	@RequestMapping(value = "institutionalInfraActivityPlan", method = RequestMethod.GET)
	private String institutionInfaActivityGet(Model model, RedirectAttributes redirectAttributes)
	{

		model.addAttribute("STATE_CODE", userPreference.getStateCode());
		if (userPreference.getUserType().equalsIgnoreCase("C"))
		{
			return INSTITUTION_INFRA_ACT_CEC;
		} else
		{
			String status = basicInfoService.fillFirstBasicInfo();
			if (status.equals("create"))
			{
				redirectAttributes.addFlashAttribute(Message.EXCEPTION_KEY, "Please fill the Basic Info Details first");
				return REDIRECT_BAISC_INFO_DETAILS;
			} else if (status.equals("modify"))
			{
				redirectAttributes.addFlashAttribute(Message.EXCEPTION_KEY, "Please fill the Required Basic Info Details");
				return REDIRECT_MODIFY_BAISC_INFO_DETAILS;
			}

			Integer planStatus = 0;
			List<Plan> planList = planAllocationService.showHidePlanStatus(userPreference.getStateCode());
			if (planList != null && !planList.isEmpty())
			{
				planStatus = planList.get(0).getPlanStatusId();
			}
			model.addAttribute("Plan_Status", planStatus == 1);
			//model.addAttribute("Plan_Status", planStatus);
			return INSTITUTION_INFRA_ACT;
		}
	}
	
	@ResponseBody
	@RequestMapping(value="saveInstitutionalInfraActivityPlanDetails", method=RequestMethod.POST)
	private InstitutionalInfraActivityPlan saveInstitutionalInfraActivityPlanDetails(@RequestBody final InstitutionalInfraActivityPlan institutionalInfraActivityPlan,@RequestParam(value="updateStatus" ,required=false) String updateStatus,RedirectAttributes re) {
		institutionalInfraActivityPlanService.saveInstitutionalInfra(institutionalInfraActivityPlan,updateStatus);
		 return institutionalInfraActivityPlan;
	}
	
	@ResponseBody
	@RequestMapping(value="deleteRecord", method=RequestMethod.POST)
	private Map<String, Object> deleteRecord(@RequestParam(value="detailId" ,required=false) Integer detailId,RedirectAttributes re) {
		Map<String, Object> institutionaInfraResponseMap = new HashMap<>();
		institutionalInfraActivityPlanService.deleteRecord(detailId);
		institutionaInfraResponseMap.put("message", Message.SUCCESS_KEY);
		 return institutionaInfraResponseMap;
	}
	@ResponseBody
	@RequestMapping(value = "saveInstitutionalInfraActivityCEC", method = RequestMethod.POST)
	private InstitutionalInfraActivityPlan saveInstitutionalInfraActivityCEC(@RequestBody InstitutionalInfraActivityPlan institutionalInfraActivityPlan, RedirectAttributes re) {
		institutionalInfraActivityPlan=institutionalInfraActivityPlanService.saveCecData(institutionalInfraActivityPlan);
		return institutionalInfraActivityPlan;
	}
	
	@ResponseBody
	@RequestMapping(value="fetchTrainingInstituteType", method=RequestMethod.GET)
	private Map<String, Object> fetchTrainingInstituteType() {
		Map<String, Object> institutionaInfraResponseMap = new HashMap<>();
		List<InstitutionalInfraActivityPlan> institutionalInfraActivityPlanState = institutionalInfraActivityPlanService
				.fetchInstitutionalInfraActivity("S");
		List<InstitutionalInfraActivityPlan> institutionalInfraActivityPlanMopr = institutionalInfraActivityPlanService
				.fetchInstitutionalInfraActivity("M");
		institutionaInfraResponseMap.put("userType", userPreference.getUserType());
		institutionaInfraResponseMap.put("TrainingInstituteType",
				institutionalInfraActivityPlanService.fetchTrainingInstituteType());
		if (userPreference.getUserType().equalsIgnoreCase("C")) {
			institutionaInfraResponseMap.put("institutionalInfraActivityPlanState",
					putDistrictNameInDetails(institutionalInfraActivityPlanState.get(0)));
			institutionaInfraResponseMap.put("institutionalInfraActivityPlanMopr",
					putDistrictNameInDetails(institutionalInfraActivityPlanMopr.get(0)));
			List<InstitutionalInfraActivityPlan> institutionalInfraActivityPlanCec=institutionalInfraActivityPlanService.fetchInstitutionalInfraActivity("C");
			if(CollectionUtils.isNotEmpty(institutionalInfraActivityPlanCec)){
				List<InstitutionalInfraActivityPlanDetails> details=institutionalInfraActivityPlanService.fetchAllDetails(institutionalInfraActivityPlanCec.get(0).getInstitutionalInfraActivityId());
				institutionalInfraActivityPlanCec.get(0).setInstitutionalInfraActivityPlanDetails(details);
				institutionaInfraResponseMap.put("institutionalInfraActivityPlanCEC", putDistrictNameInDetails(institutionalInfraActivityPlanCec.get(0)));
				institutionaInfraResponseMap.put("initial_status", false);
			}else{
				institutionaInfraResponseMap.put("initial_status", true);
			}
			
		}
		return institutionaInfraResponseMap;
	}
	
	private InstitutionalInfraActivityPlan putDistrictNameInDetails(
			InstitutionalInfraActivityPlan institutionalInfraActivity) {
		List<InstitutionalInfraActivityPlanDetails> details = institutionalInfraActivity
				.getInstitutionalInfraActivityPlanDetails();
		for (InstitutionalInfraActivityPlanDetails institutionalInfraActivityPlanDetail : details) {
			institutionalInfraActivityPlanDetail.setDistrictName(lgdservice
					.getDistrictDetails(userPreference.getStateCode(),
							institutionalInfraActivityPlanDetail.getInstitutionalInfraLocation())
					.getDistrictNameEnglish());
		}
		return institutionalInfraActivity;
	}
	
	@ResponseBody
	@RequestMapping(value="fetchInstitutionalInfraDataForStateAndMOPR", method = RequestMethod.GET)
	private Map<String, Object> fetchPesaPlanDetailsForStateAndMOPR(@RequestParam(value="instituteType", required= false) Integer instituteType){
		Map<String, Object> institutionaInfraResponseMap = new HashMap<>();
		List<InstitutionalInfraActivityPlan> institutionalInfraActivityPlan=new ArrayList<>();
		List<InstitutionalInfraActivityPlanDetails> institutionalInfraActivityPlanDetails=new ArrayList<>();
		institutionalInfraActivityPlan = institutionalInfraActivityPlanService.fetchInstitutionalInfraActivity(null);
		if(!CollectionUtils.isEmpty(institutionalInfraActivityPlan)){
			institutionalInfraActivityPlanService.fetchAllDetails(institutionalInfraActivityPlan.get(0).getInstitutionalInfraActivityId());
			
			
			
			institutionalInfraActivityPlanDetails= institutionalInfraActivityPlanService.fetchInstitutionalInfraActivityDetails(institutionalInfraActivityPlan.get(0),institutionalInfraActivityPlan.get(0).getInstitutionalInfraActivityId(),instituteType);
				
				List<String> locationNB=new ArrayList<String>();
				List<String> locationCF=new ArrayList<String>();
				/*String[] locationNB=new String[institutionalInfraActivityPlanDetails.size()];
				String[] locationCF=new String[institutionalInfraActivityPlanDetails.size()];*/
				for(int i=0;i<institutionalInfraActivityPlanDetails.size();i++){
					if(institutionalInfraActivityPlanDetails.get(i).getWorkType()=='N') {
						locationNB.add(String.valueOf(institutionalInfraActivityPlanDetails.get(i).getInstitutionalInfraLocation()));
					}else if(institutionalInfraActivityPlanDetails.get(i).getWorkType()=='C') {
						locationCF.add(String.valueOf(institutionalInfraActivityPlanDetails.get(i).getInstitutionalInfraLocation()));
					}
						
				}
				for (InstitutionalInfraActivityPlanDetails details : institutionalInfraActivityPlanDetails) {
					if(details.getWorkType()=='N' && locationNB.size()>0) {
						details.setLocationName(locationNB.toArray(new String[0]));
					}else if(details.getWorkType()=='C'  && locationCF.size()>0) {
						details.setLocationName(locationCF.toArray(new String[0]));
					}
					
				}
			institutionalInfraActivityPlan.get(0).setDetailsListLength(institutionalInfraActivityPlanDetails.size());
			institutionaInfraResponseMap.put("institutionalInfraActivityPlan", institutionalInfraActivityPlan.get(0));
		}
		if(!CollectionUtils.isEmpty(institutionalInfraActivityPlanDetails)){
			institutionaInfraResponseMap.put("update_Status","updating");
		}else{
			institutionaInfraResponseMap.put("update_Status","saving");
		}
		institutionaInfraResponseMap.put("institutionalInfraActivityPlanDetails", institutionalInfraActivityPlanDetails);
		institutionaInfraResponseMap.put("userType",userPreference.getUserType());
		return institutionaInfraResponseMap;
	}
	
	@ResponseBody
	@RequestMapping(value="feezUnFreezInstitutionalInfraActivityPlan", method=RequestMethod.POST)
	private InstitutionalInfraActivityPlan feezUnFreezInstitutionalInfraActivityPlan(@RequestBody InstitutionalInfraActivityPlan institutionalInfraActivityPlan) {
		 institutionalInfraActivityPlanService.feezUnFreezInstitutionalInfraActivityPlan(institutionalInfraActivityPlan);
	 return institutionalInfraActivityPlan;
	}
	
	@ResponseBody
	@RequestMapping(value="fetchInstitutionalInfraDataForStateAndMOPRNew", method = RequestMethod.GET)
	private InstitutionalInfraActivityPlan fetchInstitutionalInfraDataForStateAndMOPRNew(){
		//Map<String, Object> institutionaInfraResponseMap = new HashMap<>();
		InstitutionalInfraActivityPlan institutionalInfraActivityPlan=null;
		List<InstitutionalInfraActivityPlan> institutionalInfraActivityPlanList=institutionalInfraActivityPlanService.fetchInstitutionalInfraActivity(null);
		if(institutionalInfraActivityPlanList!=null && !institutionalInfraActivityPlanList.isEmpty()) {
			institutionalInfraActivityPlan=institutionalInfraActivityPlanList.get(0);
			/*List<InstitutionalInfraActivityPlanDetails> institutionalInfraActivityPlanDetails=institutionalInfraActivityPlanService.fetchAllDetails(institutionalInfraActivityPlan.getInstitutionalInfraActivityId());
			institutionalInfraActivityPlan.setInstitutionalInfraActivityPlanDetails(institutionalInfraActivityPlanDetails);*/
			//institutionaInfraResponseMap.put("institutionalInfraActivityPlan", institutionalInfraActivityPlan);
			/*
			 * if(userPreference.getPlanVersion() > 1) {
			 * List<InstitutionalInfraActivityPlanDetails> commentDetailsList =
			 * institutionalInfraActivityPlanService.fetchAllDetailsExceptCurrentVersion();
			 * institutionalInfraActivityPlan =
			 * settingCommentsInActivity(institutionalInfraActivityPlan,commentDetailsList);
			 * }
			 */
			//institutionalInfraActivityPlan.setStatePreviousComments( map.get("statePreviousComments"));
			//institutionalInfraActivityPlan.setMoprPreviousComments( map.get("moprPreviousComments"));
			
		}
		return institutionalInfraActivityPlan;
		
	}
	
	private InstitutionalInfraActivityPlan settingCommentsInActivity(InstitutionalInfraActivityPlan activity,List<InstitutionalInfraActivityPlanDetails> commentList) {
		int counterState=0,counterMopr=0;
		List<String> moprSprcRemarks = new LinkedList<String>();
		List<String> stateSprcRemarks = new LinkedList<String>();
		List<List<String>> stateDprcRemarks = new LinkedList<List<String>>();
		List<List<String>> moprDprcRemarks = new LinkedList<List<String>>();
		for (InstitutionalInfraActivityPlanDetails detail : commentList) {
			if(detail.getInstitutionalInfraActivityPlan().getUserType().equalsIgnoreCase("s") && detail.getTrainingInstitueType().getTrainingInstitueTypeId() == 4 && detail.getInstitutionalInfraActivityPlan().getVersionNumber() == userPreference.getPlanVersion() - 1) {
				stateDprcRemarks.add(new LinkedList<String>());
				moprDprcRemarks.add(new LinkedList<String>());
			}
		}
		for(InstitutionalInfraActivityPlanDetails detail : commentList) {
			if(counterState == stateDprcRemarks.size()) {
				counterState = 0;
			}else if(counterMopr == moprDprcRemarks.size()) {
				counterMopr = 0;
			}
			
			if(detail.getInstitutionalInfraActivityPlan().getUserType().equalsIgnoreCase("s") && detail.getTrainingInstitueType().getTrainingInstitueTypeId() == 2) {
				stateSprcRemarks.add(detail.getRemarks());
			}else if(detail.getInstitutionalInfraActivityPlan().getUserType().equalsIgnoreCase("s") && detail.getTrainingInstitueType().getTrainingInstitueTypeId() == 4) {
				stateDprcRemarks.get(counterState).add(detail.getRemarks());
				counterState++;
			}else if(detail.getInstitutionalInfraActivityPlan().getUserType().equalsIgnoreCase("m") && detail.getTrainingInstitueType().getTrainingInstitueTypeId() == 2) {
				moprSprcRemarks.add(detail.getRemarks());
			}else if(detail.getInstitutionalInfraActivityPlan().getUserType().equalsIgnoreCase("m") && detail.getTrainingInstitueType().getTrainingInstitueTypeId() == 4) {
				moprDprcRemarks.get(counterMopr).add(detail.getRemarks());
				counterMopr++;
			}
		}
		
		activity.setDetailsForStateSprcComments(stateSprcRemarks);
		activity.setDetailsForMoprSprcComments(moprSprcRemarks);
		activity.setDetailsForStateDprcComments(stateDprcRemarks);
		activity.setDetailsForMoprDprcComments(moprDprcRemarks);
		return activity;
	}
	
	@RequestMapping(value = "institutionalInfraActivityPlanMOPR", method = RequestMethod.GET)
	private String institutionalInfraActivityPlanMOPR(Model model,RedirectAttributes redirectAttributes) {
	model.addAttribute("STATE_CODE",userPreference.getStateCode());	
	return INSTITUTION_INFRA_ACT_MOPR ;
	}
	
	@ResponseBody
	@RequestMapping(value="saveInstitutionalInfraActivityPlanDetailsMOPRCEC", method=RequestMethod.POST)
	private InstitutionalInfraActivityPlan saveInstitutionalInfraActivityPlanDetailsMOPRCEC(@RequestBody final InstitutionalInfraActivityPlan institutionalInfraActivityPlan,RedirectAttributes re) {
		institutionalInfraActivityPlanService.saveInstitutionalInfraMOPRCEC(institutionalInfraActivityPlan);
		 return institutionalInfraActivityPlan;
	}
	
	@ResponseBody
	@RequestMapping(value="fetchInstitutionalInfraDataForCECNew", method = RequestMethod.GET)
	private Map<String, Object> fetchInstitutionalInfraDataForCECNew(){
		Map<String, Object> institutionaInfraResponseMap = new HashMap<>();
		InstitutionalInfraActivityPlan institutionalInfraActivityPlan=null;
		List<InstitutionalInfraActivityPlan> institutionalInfraActivityPlanList=institutionalInfraActivityPlanService.fetchInstitutionalInfraActivity(null);
		if(institutionalInfraActivityPlanList!=null && !institutionalInfraActivityPlanList.isEmpty()) {
			institutionalInfraActivityPlan=institutionalInfraActivityPlanList.get(0);
			institutionaInfraResponseMap.put("institutionalInfraActivityPlanCEC", institutionalInfraActivityPlan);
		}
		
		institutionalInfraActivityPlan=null;
		institutionalInfraActivityPlanList=institutionalInfraActivityPlanService.fetchInstitutionalInfraActivity("M");
		if(institutionalInfraActivityPlanList!=null && !institutionalInfraActivityPlanList.isEmpty()) {
			institutionalInfraActivityPlan=institutionalInfraActivityPlanList.get(0);
			institutionaInfraResponseMap.put("institutionalInfraActivityPlanMOPR", institutionalInfraActivityPlan);
		}
		
		institutionalInfraActivityPlan=null;
		institutionalInfraActivityPlanList=institutionalInfraActivityPlanService.fetchInstitutionalInfraActivity("S");
		if(institutionalInfraActivityPlanList!=null && !institutionalInfraActivityPlanList.isEmpty()) {
			institutionalInfraActivityPlan=institutionalInfraActivityPlanList.get(0);
			institutionaInfraResponseMap.put("institutionalInfraActivityPlanState", institutionalInfraActivityPlan);
		}
		return institutionaInfraResponseMap;
		
	}

}

