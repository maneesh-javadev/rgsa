package gov.in.rgsa.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.collections.CollectionUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import gov.in.rgsa.entity.PmuActivity;
import gov.in.rgsa.entity.PmuActivityDetails;
import gov.in.rgsa.entity.PmuWiseProposedDomainExperts;
import gov.in.rgsa.model.Response;
import gov.in.rgsa.service.BasicInfoService;
import gov.in.rgsa.service.LGDService;
import gov.in.rgsa.service.PmuActivityService;
import gov.in.rgsa.user.preference.UserPreference;
import gov.in.rgsa.utils.Message;
import gov.in.rgsa.validater.CmsValidator;
import gov.in.rgsa.validater.PMUValidator;

/**
 * @author MOhammad Ayaz 04/10/2018
 *
 */
@Controller
public class PmuController {

	@Autowired
	private PmuActivityService activityService;

	@Autowired
	private UserPreference userPreference;
	@Autowired
	BasicInfoService basicInfoService;

	@Autowired
	private LGDService lgdservice;
	
	 @Autowired
	private PMUValidator pmuValidator;

	private static final String PMU = "pmu";
	private static final String REDIRECT_PMU = "redirect:pmu.html";
	public static final String REDIRECT_BAISC_INFO_DETAILS = "redirect:basicinfo.add.html";
	public static final String REDIRECT_MODIFY_BAISC_INFO_DETAILS = "redirect:managebasicInfoDetails.html";

	private static final String PMU_CEC = "pmuCEC";

	@RequestMapping(value = "pmu", method = RequestMethod.GET)
	private String managePmuActivityMethod(@ModelAttribute("PMU_ACTIVITY") PmuActivity pmuActivity, Model model,
			HttpServletRequest request, RedirectAttributes redirectAttributes) {
		String status = basicInfoService.fillFirstBasicInfo();
		if (status.equals("create")) {
			redirectAttributes.addFlashAttribute(Message.EXCEPTION_KEY, "Please fill the Basic Info Details first");
			return REDIRECT_BAISC_INFO_DETAILS;
		} else if (status.equals("modify")) {
			redirectAttributes.addFlashAttribute(Message.EXCEPTION_KEY, "Please fill the Required Basic Info Details");
			return REDIRECT_MODIFY_BAISC_INFO_DETAILS;
		}
		
		pmuActivity=setBasicAttributeofPMU(pmuActivity, model,false);
		if (userPreference.getUserType().equalsIgnoreCase("C")) {
			return PMU_CEC;
		}else {
			return PMU;
		}

	}
	
	private PmuActivity setBasicAttributeofPMU(PmuActivity pmuActivity, Model model,boolean isError) {
		Integer planStatus = userPreference.getPlanStatus();
		Boolean flag = false;
		if (planStatus != null && planStatus == 1 && userPreference.getUserType().equalsIgnoreCase("S")) {
			flag = true;
		} else if (planStatus != null && planStatus == 2 && userPreference.getUserType().equalsIgnoreCase("M")) {
			flag = true;
		} else {
			flag = false;
		}
		model.addAttribute("Plan_Status", flag);
		model.addAttribute("LIST_OF_ACTIVITY_PMU_TYPE", activityService.fetchPmuActvityType());
		model.addAttribute("LIST_OF_PMU_DOMAINS", activityService.fetchPmuDomains());
		model.addAttribute("LIST_OF_DISTRICT", activityService.fetchDistrictName());
		model.addAttribute("user_type", userPreference.getUserType().charAt(0));
		List<PmuActivity> pmuActivitiesList = activityService.fetchPmuActivity(userPreference.getUserType().charAt(0));
		if (!CollectionUtils.isEmpty(pmuActivitiesList)) {
			List<PmuWiseProposedDomainExperts> proposedDomainExpertsList = pmuActivitiesList.get(0)
					.getPmuWiseProposedDomainExperts();
			if (proposedDomainExpertsList != null && !proposedDomainExpertsList.isEmpty())
				proposedDomainExpertsList.sort(
						(o1, o2) -> o1.getPmuWiseProposedDomainExpertsId() - o2.getPmuWiseProposedDomainExpertsId());
			// Collections.sort(proposedDomainExpertsList,
			// Comparator.comparing(PmuWiseProposedDomainExperts::getPmuWiseProposedDomainExpertsId));
			// pmuActivitiesList.get(0).setSetDistrictIdPmuWise(proposedDomainExpertsList.get(3).getDistrictId());
			if(isError==false) {
				model.addAttribute("pmuActivity", pmuActivitiesList.get(0));
			}
			Map<String, List<List<String>>> map = basicInfoService.fetchStateAndMoprPreComments(pmuActivitiesList.get(0).getPmuActivityDetails().size(),12);
			model.addAttribute("STATE_PRE_COMMENTS", map.get("statePreviousComments"));
			model.addAttribute("MOPR_PRE_COMMENTS", map.get("moprPreviousComments"));
			model.addAttribute("pmuWiseDomainList", proposedDomainExpertsList);
			pmuActivity.setPmuWiseProposedDomainExperts(proposedDomainExpertsList);
			model.addAttribute("initial_status", false);

		} else {
			model.addAttribute("initial_status", true);
		}
		model.addAttribute("STATE_CODE", userPreference.getStateCode());
		if (userPreference.getUserType().equalsIgnoreCase("C")) {
			List<PmuActivity> pmuActivityState = activityService.fetchPmuActivity('S');
			List<PmuActivity> pmuActivityMOPR = activityService.fetchPmuActivity('M');
			model.addAttribute("pmuActivityState", pmuActivityState.get(0));
			model.addAttribute("pmuActivityMOPR", pmuActivityMOPR.get(0));
			model.addAttribute("pmuWiseDomainListState", pmuActivityState.get(0).getPmuWiseProposedDomainExperts());
			model.addAttribute("pmuWiseDomainListMOPR", pmuActivityMOPR.get(0).getPmuWiseProposedDomainExperts());
			Map<String, Object> params = calTotalOfSpmuAndDpmu(pmuActivityState);
			if (!params.isEmpty()) {
				model.addAttribute("SPMU_TOTAL_STATE", params.get("spmu_total"));// spmu total for state tab in cec
				model.addAttribute("DPMU_TOTAL_STATE", params.get("dpmu_total"));// dpmu total for state tab in cec
			}
			params.clear();// clear map after using it for state

			params = calTotalOfSpmuAndDpmu(pmuActivityMOPR);
			if (!params.isEmpty()) {
				model.addAttribute("SPMU_TOTAL_MOPR", params.get("spmu_total"));// spmu total for mopr tab in cec
				model.addAttribute("DPMU_TOTAL_MOPR", params.get("dpmu_total"));// dpmu total for mopr tab in cec
			}
			return pmuActivity;
		} else {
			return pmuActivity;
		}
	}

	@RequestMapping(value = "addUpdatePmu", method = RequestMethod.POST)
	private String addUpdateMethod(@ModelAttribute("PMU_ACTIVITY") PmuActivity pmuActivity, Model model,
			HttpServletRequest request, RedirectAttributes redirectAttributes,BindingResult br) {
		Response response =pmuValidator.validate(pmuActivity);
		if (response.getResponseCode()==500) {
			model.addAttribute(Message.EXCEPTION_KEY, response.getResponseMessage());
			pmuActivity=setBasicAttributeofPMU(pmuActivity, model,true);
			model.addAttribute("pmuActivity",pmuActivity);
			if (userPreference.getUserType().equalsIgnoreCase("C")) {
				return PMU_CEC;
			}else {
				return PMU;
			}
			
		}else {
			activityService.saveAndUpdate(pmuActivity);
			redirectAttributes.addFlashAttribute(Message.SUCCESS_KEY, Message.SAVE_SUCCESS);
			return REDIRECT_PMU;
		}
		
	}

	@RequestMapping(value = "pmuFreezUnfreez", method = RequestMethod.POST)
	private String pmuFreezUnfreez(@ModelAttribute("PMU_ACTIVITY") PmuActivity pmuActivity,
			RedirectAttributes redirectAttributes) {
		activityService.pmuFreezUnfreeze(pmuActivity);
		if (pmuActivity.getIsFreeze() == true) {
			redirectAttributes.addFlashAttribute(Message.UPDATE_KEY, "UnFreezed Successfully");
		} else {
			redirectAttributes.addFlashAttribute(Message.UPDATE_KEY, "Freezed Successfully");
		}
		return REDIRECT_PMU;
	}

	private Map<String, Object> calTotalOfSpmuAndDpmu(List<PmuActivity> pmuActivity) {
		Map<String, Object> map = new HashMap<String, Object>();
		int spmu_total = 0, dpmu_total = 0;
		if (CollectionUtils.isNotEmpty(pmuActivity)) {
			for (PmuActivityDetails detail : pmuActivity.get(0).getPmuActivityDetails()) {
				if (detail.getPmuActivityType().getPmuActivityTypeId() < 4) {
					if (detail.getFund() != null)
						spmu_total += detail.getFund();
				} else {
					if (detail.getFund() != null)
						dpmu_total += detail.getFund();
				}
			}
			map.put("spmu_total", spmu_total);
			map.put("dpmu_total", dpmu_total);

		}
		return map;
	}

}
