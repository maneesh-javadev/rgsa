package gov.in.rgsa.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import gov.in.rgsa.model.FacadeModel;



@Controller
public class RGSAPublicController {
	
	public static final String ABOUT_RGSA = "aboutRGSA";
	
	public static final String ABOUT_GPDP = "aboutGPDP";
	
	@RequestMapping(value="aboutRGSA" , method = RequestMethod.GET)
	public String aboutRGSA(Model model,RedirectAttributes re)throws Exception{	
		 model.addAttribute("FACADE_MODEL", new FacadeModel()); 
		 return ABOUT_RGSA;
	}
	
	@RequestMapping(value="aboutGPDP" , method = RequestMethod.GET)
	public String aboutGPDP(Model model,RedirectAttributes re)throws Exception{	
		 model.addAttribute("FACADE_MODEL", new FacadeModel()); 
		 return ABOUT_GPDP;
	}

}
