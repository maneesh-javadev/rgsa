package gov.in.rgsa.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import gov.in.rgsa.service.CommonService;

@Controller
public class CenterreportController {

	private static final String CENTER_REPORT = "report.center";

	@Autowired
	private CommonService commonService;

	@RequestMapping(value = "finalReport", method = RequestMethod.GET)
	public String centerReport(Model model) {

		model.addAttribute("MENU_HEADER", commonService.findMenuByParentId(11));

		return CENTER_REPORT;
	}

}
