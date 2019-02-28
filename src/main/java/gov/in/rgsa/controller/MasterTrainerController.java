package gov.in.rgsa.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import gov.in.rgsa.model.ChangePasswordModel;

@Controller
public class MasterTrainerController {
      private static final String MASTER_TRAINER = "masterTrainer";

	@RequestMapping(value = "mastertrainer", method = RequestMethod.GET)
	public String masterTrainerGet(@ModelAttribute("CHANGE_PASSWORD_MODEL") ChangePasswordModel form, Model model)
	{
    	  return MASTER_TRAINER;
	}
}
