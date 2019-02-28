package gov.in.rgsa.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.collections.CollectionUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.web.servlet.support.RequestContextUtils;
import gov.in.rgsa.entity.ExtentOfCoverage;
import gov.in.rgsa.entity.ExtentOfCoverageDetails;
import gov.in.rgsa.model.ExtentOfCoverageModel;
import gov.in.rgsa.service.ExtentOfCoverageService;
import gov.in.rgsa.utils.Message;



@Controller
public class ExtentOfCoverageController {
	
	@Autowired
	public ExtentOfCoverageService extentOfCoverageService;
	
	private static final String EXTENT_COVERAGE ="getExtentOfCoverage";

	private static final String REDIRECT_EXTENT_COVERAGE = "redirect:extentOfCoverage.html";

	@RequestMapping(value="extentOfCoverage", method=RequestMethod.GET)
	private String extentOfCoverageGet(@ModelAttribute("EXTENT_OF_COVERAGE_MODEL") ExtentOfCoverageModel extentOfCoverageModel ,Model model,HttpServletRequest request)
	{
		model.addAttribute("Fetch_Training_category", extentOfCoverageService.fetchTrainingCategories());
		List<ExtentOfCoverage> extentOfCoverage = new ArrayList<ExtentOfCoverage>();
		List<ExtentOfCoverageDetails> extentOfCoverageDetails = new ArrayList<ExtentOfCoverageDetails>();
		/*extentOfCoverage=extentOfCoverageService.fetchExtentOfCoverage();*/
		if(!CollectionUtils.isEmpty(extentOfCoverage))
		{
			model.addAttribute("extentOfCoverage", extentOfCoverage.get(0));
			extentOfCoverageDetails=extentOfCoverageService.fetchExtentOfCoverageDetails(extentOfCoverage.get(0).coverageId);
			extentOfCoverageModel.setExtentOfCoverageDetails(extentOfCoverageDetails);
		}
		Map<String, ?> param=RequestContextUtils.getInputFlashMap(request);
		if(param != null) {
			if((String)param.get("message") != null && !((String)param.get("message").toString()).isEmpty()) {
				if((String)param.get("message") == "freezed")
				{
				model.addAttribute("readOnlyEnabled",new Boolean(true));}
				else {
					model.addAttribute("readOnlyEnabled", new Boolean(false));
				}
				
			}
		}
		
		return EXTENT_COVERAGE;
	}
	
	@RequestMapping(value="extentOfCoverage",method=RequestMethod.POST)
	private String extentOfCoveragePost( @ModelAttribute("EXTENT_OF_COVERAGE_MODEL") ExtentOfCoverageModel extentOfCoverageModel ,Model model,HttpServletRequest request ,RedirectAttributes re) {
		extentOfCoverageService.save(extentOfCoverageModel);
		re.addFlashAttribute(Message.SUCCESS_KEY, Message.SAVE_SUCCESS);
		return REDIRECT_EXTENT_COVERAGE;
	}
	
	@RequestMapping(value="freezAndUnfreezEocs" , method=RequestMethod.POST) 
	public String freezeUnfreezeEocsmethod(@ModelAttribute("EXTENT_OF_COVERAGE_MODEL")  ExtentOfCoverageModel extentOfCoverageModel ,Model model,HttpServletRequest request ,RedirectAttributes re) {
		extentOfCoverageService.freezeAndUnfreezeEocs(extentOfCoverageModel);
		if(extentOfCoverageModel.getDbFileName().equals("freeze")) {
		re.addFlashAttribute("message", "freezed");}
		else {re.addFlashAttribute("message", "unfreezed");}
		return  REDIRECT_EXTENT_COVERAGE;
	}

}
