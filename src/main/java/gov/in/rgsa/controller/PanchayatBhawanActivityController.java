package gov.in.rgsa.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class PanchayatBhawanActivityController {
	

	private static final String MANAGE_PANACHAYAT = "managePanchayatActivities";

	@RequestMapping(value="managepanchayatactivities",method=RequestMethod.GET)
	private String managePanchayatActivityGet()
	{
		
		return MANAGE_PANACHAYAT;
	}
}
