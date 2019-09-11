package gov.in.rgsa.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;

import gov.in.rgsa.entity.TrgOfHundredDaysProgramCh2;
import gov.in.rgsa.service.MOPRService;

@Controller
public class FundSanctionVersion2Controller {
	
	private static final String FUND_SANCTION = "fundSanctionVersion2";
	
	@Autowired
	private  MOPRService moprService;

	@GetMapping(value="fundSanction")
	private String fundSanction(@ModelAttribute("HUN_DAY_TRAINING") TrgOfHundredDaysProgramCh2 entity, Model model) {
		entity = new TrgOfHundredDaysProgramCh2();
		model.addAttribute("entity", entity);
		return FUND_SANCTION;
	}

}
