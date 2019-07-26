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
import gov.in.rgsa.service.MOPRService;
import gov.in.rgsa.service.ViewReportAtMoprService;
import gov.in.rgsa.user.preference.UserPreference;

@Controller
public class ViewReportAtMoprController {

	private static final String MOPR_REPORT="viewreportmopr";
	
	@Autowired
	private  ViewReportAtMoprService viewReportAtMoprService;
	
	@Autowired
	UserPreference userPreference;
	
	@Autowired
	FacadeService facadeService;
	
	@Autowired
	private  MOPRService moprService;
	
	@GetMapping(value = "viewReportMopr")
	private String getMoprReport(@ModelAttribute(name = "VIEW_REPORT_MODEL") ViewReportAtMoprModel viewReportModel, Model model) {
		model.addAttribute("FIN_YEAR_LIST", viewReportAtMoprService.getFinYearList());
		if(viewReportModel.getFinYearId() != null) {
			model.addAttribute("STATE_LIST", moprService.getStateListApprovedbyCEC(viewReportModel.getFinYearId()));
		}
		
		if(viewReportModel.getIsAnnualPlan()) {
			Map<String, Object> parameter = new HashMap<String, Object>();
			parameter.put("stateCode", viewReportModel.getStateCode());
			parameter.put("yearId", userPreference.getFinYearId());
			parameter.put("userType","C");
			model.addAttribute("planComponentsFunds", facadeService.fetchFundDetailsByUserType(parameter));
		}
		
		if(viewReportModel.getIsDemoGraphic()) {
			List<DemographicProfileDataDto> demographicData=viewReportAtMoprService.fetchDemographicData(viewReportModel);
			model.addAttribute("DEMO_GRAPHIC_DATA", demographicData);
		}
		return MOPR_REPORT;
	}
	
	@PostMapping(value = "viewReportMopr")
	private String fetchStateBasedOnFinYear(@ModelAttribute(name = "VIEW_REPORT_MODEL") ViewReportAtMoprModel viewReportModel,Model model){
		System.out.println("i am in ....>>>>>>>>");
		return getMoprReport(viewReportModel , model );
	}
	
	/*
	 * @GetMapping(value = "viewReportMoprAjax") private String
	 * getMoprReportAjax(@ModelAttribute(name = "VIEW_REPORT_MODEL")
	 * ViewReportAtMoprModel viewReportModel,Model model) {
	 * model.addAttribute("FIN_YEAR_LIST",
	 * viewReportAtMoprService.getFinYearList()); return MOPR_REPORT; }
	 * 
	 * @ResponseBody
	 * 
	 * @PostMapping(value = "fetchStateList") private Map<String,Object>
	 * getMoprReportAjax(@RequestParam(value = "finYear",required = false) Integer
	 * finYear) { Map<String, Object> response=new HashMap<String,Object>();
	 * response.put("StateList",moprService.getStateListApprovedbyCEC(finYear));
	 * return response; }
	 */
	
}