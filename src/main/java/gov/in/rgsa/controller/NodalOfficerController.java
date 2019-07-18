package gov.in.rgsa.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import gov.in.rgsa.entity.NodalOfficerDetails;
import gov.in.rgsa.service.NodalOfficerService;
import gov.in.rgsa.user.preference.UserPreference;
import gov.in.rgsa.utils.Message;

@Controller
public class NodalOfficerController {
	
	@Autowired
	private NodalOfficerService officerService;
	
	@Autowired
	private UserPreference _userPreference;

	private static final String NODAL_OFFICER = "nodalOfficerDetails";
	private static final String REDIRECT_NODAL_OFFICER = "redirect:nodalOfficer.html";

	@RequestMapping(value="nodalOfficer",method=RequestMethod.GET)
	private String nodalOfficerDetails(@ModelAttribute("SAVE_NODAL_DETAILS") NodalOfficerDetails nodalOfficerDetails, Model model)
	{
		nodalOfficerDetails =officerService.getNodalOfficerDetails();
		model.addAttribute("nodalOfficerDetails",nodalOfficerDetails);
		if(nodalOfficerDetails != null)
			_userPreference.setIsNodalFilled(true);
		return NODAL_OFFICER;
	}
	
	@RequestMapping(value = "nodalOfficerDetailsSave", method = RequestMethod.POST)
	public String ChangePasswordModelPost(@ModelAttribute("SAVE_NODAL_DETAILS") NodalOfficerDetails nodalOfficerDetails, Model model,RedirectAttributes re) {
		officerService.saveNodalOfficerDetails(nodalOfficerDetails);
		re.addFlashAttribute(Message.SUCCESS_KEY, Message.SAVE_SUCCESS);
		return REDIRECT_NODAL_OFFICER;
	}
}
