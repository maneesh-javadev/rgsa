package gov.in.rgsa.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class TrainingNeedsAssessmentController {

	private static final String NEED_ASSESS = "trainingNeedAssess";

	@RequestMapping(value="trainingassessment",method=RequestMethod.GET)
	private String trainingNeedGet()
	{
		return NEED_ASSESS;
	}
}
