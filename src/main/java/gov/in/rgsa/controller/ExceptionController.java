package gov.in.rgsa.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import gov.in.rgsa.entity.ErrorLog;
import gov.in.rgsa.exception.CustomExceptionHandler;
import gov.in.rgsa.exception.RGSAException;
import gov.in.rgsa.service.CommonService;
import gov.in.rgsa.user.preference.UserPreference;
import gov.in.rgsa.utils.CommonConstant;
import gov.in.rgsa.utils.Message;

@ControllerAdvice
public class ExceptionController {

	private static final String VIEW_ERROR = "errorPage";

	@Autowired
	private UserPreference userPreference;

	@Autowired
	private CustomExceptionHandler exceptionHandler;
	
	@Autowired
	private CommonService commonService;

	@ExceptionHandler(RGSAException.class)
	public String customException(RGSAException e, Model model, RedirectAttributes re,HttpServletRequest request) {

		try {
			System.err.println(request.getRequestURL()+" <----> "+request.getRequestURI()+" <----> "+ userPreference.getStateCode());
			e.printStackTrace();
			String couse = exceptionHandler.findCouse(e);
			re.addFlashAttribute(Message.EXCEPTION_KEY, couse);
			Long errorLogId =commonService.saveErrorLog(e,request);
			model.addAttribute("ERROR_ID", errorLogId);
			if (StringUtils.isEmpty(couse))
				return VIEW_ERROR;
			if (userPreference.getUserId() != null)
				return CommonConstant.REDIRECT_HOME_VIEW;
			else
				return CommonConstant.REDIRECT_INDEX_VIEW;

		} catch (RGSAException ex) {
			ex.printStackTrace();
			return VIEW_ERROR;
		}
	}

	@ExceptionHandler(RuntimeException.class)
	public String exception(RuntimeException e, Model model, RedirectAttributes re,HttpServletRequest request) {

		try {
			System.err.println(request.getRequestURL()+" <----> "+request.getRequestURI() +" <----> "+ userPreference.getStateCode());
			String couse = exceptionHandler.findCouse(e);
			re.addFlashAttribute(Message.EXCEPTION_KEY, couse);
			Long errorLogId =commonService.saveErrorLog(e,request);
			model.addAttribute("ERROR_ID", errorLogId);
			if (StringUtils.isEmpty(couse))
				return VIEW_ERROR;
			if (userPreference.getUserId() != null)
				return CommonConstant.REDIRECT_HOME_VIEW;
			else
				return CommonConstant.REDIRECT_INDEX_VIEW;

		} catch (RuntimeException ex) {
			ex.printStackTrace();
			return VIEW_ERROR;
		}
	}
}
