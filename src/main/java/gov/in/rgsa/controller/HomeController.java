package gov.in.rgsa.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class HomeController {

	private static final String HOME = "home";

	@RequestMapping(value="Home.html",method=RequestMethod.GET)
	private String homeGet(){
		
	return HOME;}
}
