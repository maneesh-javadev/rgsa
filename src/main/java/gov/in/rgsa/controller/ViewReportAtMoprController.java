package gov.in.rgsa.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;

import gov.in.rgsa.dto.DemographicProfileDataDto;
import gov.in.rgsa.model.ViewReportAtMoprModel;
import gov.in.rgsa.service.FacadeService;
import gov.in.rgsa.service.LGDService;
import gov.in.rgsa.service.MOPRService;
import gov.in.rgsa.service.ViewReportAtMoprService;
import gov.in.rgsa.user.preference.UserPreference;

@Controller
public class ViewReportAtMoprController {

	private static final String VIEW_REPORT_DEMOGRAPHIC_PROFILE = "viewReportDemographicProfile";
	private static final String VIEW_REPORT_ANNUAL_ACTION = "viewReportAnnualAction";

	private static final String VIEW_REPORT_DEMOGRAPHIC_PROFILE_STATE = "viewReportDemographicProfileState";
	private static final String VIEW_REPORT_ANNUAL_ACTION_STATE = "viewReportAnnualActionState";

	@Autowired
	private ViewReportAtMoprService viewReportAtMoprService;

	@Autowired
	UserPreference userPreference;

	@Autowired
	FacadeService facadeService;

	@Autowired
	LGDService lGDService;

	@Autowired
	private MOPRService moprService;

	@GetMapping(value = "viewReportDemographicProfile")
	private String viewReportDemographicProfile(
			@ModelAttribute(name = "VIEW_REPORT_MODEL") ViewReportAtMoprModel viewReportModel, Model model) {
		model.addAttribute("FIN_YEAR_LIST", viewReportAtMoprService.getFinYearList());
		if (viewReportModel.getFinYearId() != null) {
			model.addAttribute("STATE_LIST", moprService.getStateListApprovedbyCEC(viewReportModel.getFinYearId()));
		}
		if (viewReportModel.getIsDemoGraphic() != null && viewReportModel.getIsDemoGraphic()) {
			List<DemographicProfileDataDto> demographicData = viewReportAtMoprService
					.fetchDemographicData(viewReportModel);
			model.addAttribute("DEMO_GRAPHIC_DATA", demographicData);
		}

		return VIEW_REPORT_DEMOGRAPHIC_PROFILE;
	}

	@PostMapping(value = "viewReportDemographicProfile")
	private String fetchReportDemographicProfile(
			@ModelAttribute(name = "VIEW_REPORT_MODEL") ViewReportAtMoprModel viewReportModel, Model model) {
		System.out.println("i am in ....>>>>>>>>");
		return viewReportDemographicProfile(viewReportModel, model);
	}

	@GetMapping(value = "viewReportAnnualAction")
	private String viewReportAnnualAction(
			@ModelAttribute(name = "VIEW_REPORT_MODEL") ViewReportAtMoprModel viewReportModel, Model model) {
		model.addAttribute("FIN_YEAR_LIST", viewReportAtMoprService.getFinYearList());
		if (viewReportModel.getFinYearId() != null) {
			model.addAttribute("STATE_LIST", moprService.getStateListApprovedbyCEC(viewReportModel.getFinYearId()));
		}
		if (viewReportModel.getIsAnnualPlan() != null && viewReportModel.getIsAnnualPlan()) {
			Map<String, Object> parameter = new HashMap<String, Object>();
			parameter.put("stateCode", viewReportModel.getStateCode());
			parameter.put("yearId", userPreference.getFinYearId());
			parameter.put("userType", "C");
			model.addAttribute("planComponentsFunds", facadeService.fetchFundDetailsByUserType(parameter));
		}
		return VIEW_REPORT_ANNUAL_ACTION;
	}

	@PostMapping(value = "viewReportAnnualAction")
	private String fetchReportAnnualAction(
			@ModelAttribute(name = "VIEW_REPORT_MODEL") ViewReportAtMoprModel viewReportModel, Model model) {
		System.out.println("i am in ....>>>>>>>>");
		return viewReportAnnualAction(viewReportModel, model);
	}

	@GetMapping(value = "viewReportDemographicProfileState")
	private String viewReportDemographicProfileState(
			@ModelAttribute(name = "VIEW_REPORT_MODEL") ViewReportAtMoprModel viewReportModel, Model model) {
		model.addAttribute("FIN_YEAR", userPreference.getFinYear());
		model.addAttribute("STATE", lGDService.getStateDetailsByCode(userPreference.getStateCode()));
		viewReportModel.setFinYearId(userPreference.getFinYearId());
		viewReportModel.setStateCode(userPreference.getStateCode());
		List<DemographicProfileDataDto> demographicData = viewReportAtMoprService.fetchDemographicData(viewReportModel);
		model.addAttribute("DEMO_GRAPHIC_DATA", demographicData);
		return VIEW_REPORT_DEMOGRAPHIC_PROFILE_STATE;
	}

	@GetMapping(value = "viewReportAnnualActionState")
	private String viewReportAnnualActionState(
			@ModelAttribute(name = "VIEW_REPORT_MODEL") ViewReportAtMoprModel viewReportModel, Model model) {
		return getReportAnnualActionState(viewReportModel, model);
	}

	@GetMapping(value = "viewReportAnnualStateDetail")
	private String viewReportAnnualStateDetail(
			@ModelAttribute(name = "VIEW_REPORT_MODEL") ViewReportAtMoprModel viewReportModel, Model model) {
		viewReportModel.setIsDetailed(true);
		return getReportAnnualActionState(viewReportModel, model);
	}

	private String getReportAnnualActionState(ViewReportAtMoprModel viewReportModel, Model model) {
		model.addAttribute("FIN_YEAR", userPreference.getFinYear());
		model.addAttribute("STATE", lGDService.getStateDetailsByCode(userPreference.getStateCode()));
		Map<String, Object> parameter = new HashMap<String, Object>();
		parameter.put("stateCode", userPreference.getStateCode());
		parameter.put("yearId", userPreference.getFinYearId());
		parameter.put("userType", "C");
		model.addAttribute("planComponentsFunds", facadeService.fetchFundDetailsByUserType(parameter));
		return VIEW_REPORT_ANNUAL_ACTION_STATE;
	}
}
