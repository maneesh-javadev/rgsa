package gov.in.rgsa.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import gov.in.rgsa.model.ChangePasswordModel;
import gov.in.rgsa.service.ChangePasswordService;
import gov.in.rgsa.utils.Message;

@Controller
public class ChangePasswordController {

	private static final String CHANGE_PASSWORD = "changePassword";

	private static final String REDIRECT_CHANGE_PASSWORD = "redirect:changepassword.html";

	@Autowired
	private ChangePasswordService service;

	@RequestMapping(value = "changepassword.html", method = RequestMethod.GET)
	public String changePasswordGet(@ModelAttribute("CHANGE_PASSWORD_MODEL") ChangePasswordModel form, Model model) {

		return CHANGE_PASSWORD;
	}

	@RequestMapping(value = "changepassword.html", method = RequestMethod.POST)
	public String ChangePasswordModelPost(@ModelAttribute("CHANGE_PASSWORD_MODEL") ChangePasswordModel form,
			Model model,RedirectAttributes re) {

		service.changePassword(form);
		re.addFlashAttribute(Message.UPDATE_KEY, Message.UPDATE_SUCCESS);
		return REDIRECT_CHANGE_PASSWORD;
	}
}

