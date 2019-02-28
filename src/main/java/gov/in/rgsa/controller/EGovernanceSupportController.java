package gov.in.rgsa.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class EGovernanceSupportController {
	
	private static final String GOVERN_SUPPORT = "eGovernSupport";

	@RequestMapping(value="egovernancesupport",method=RequestMethod.GET)
	private String eGovernanceSupportGet(){
		
	return GOVERN_SUPPORT;}
	

}
