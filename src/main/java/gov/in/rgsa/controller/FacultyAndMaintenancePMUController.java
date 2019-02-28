package gov.in.rgsa.controller;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import gov.in.rgsa.model.BasicInfoModel;

@Controller
public class FacultyAndMaintenancePMUController {
	
public static final String FACILITY_THROUGH_SATCOM = "facilityAndMaintainancePmu";

public static final String STATUS_FACULTY_MAINTENANCE_PMU = "facultyMaintenancePmu.status";
	
	
	
	@RequestMapping(value = "facilityAndMaintainancePmu", method = RequestMethod.GET)
	private String administrativeTechSupportStaff(@ModelAttribute("BASIC_INFO_MODEL") BasicInfoModel basicInfoModel, Model model) {
		return FACILITY_THROUGH_SATCOM ;
	}
	
	@RequestMapping(value = "statusFacultyAnMaintenancePMU", method = RequestMethod.GET)
	private String statusFacultyAnMaintenancePMU(@ModelAttribute("BASIC_INFO_MODEL") BasicInfoModel basicInfoModel, Model model) {
		return STATUS_FACULTY_MAINTENANCE_PMU ;
	}
}
