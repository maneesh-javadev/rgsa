package gov.in.rgsa.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class StatusOfPanchayatController {
    
	private static final String STATUS_PANCHAYAT = "statusPanchayat";

	@RequestMapping(value="statuspanchayatbhawan",method=RequestMethod.GET)
	private String statusPanchayatGet()
	{
		return STATUS_PANCHAYAT;
	}
}
