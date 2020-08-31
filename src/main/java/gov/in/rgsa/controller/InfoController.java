package gov.in.rgsa.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import gov.in.rgsa.service.MOPRService;

@Controller
public class InfoController {
	
	@Autowired
	private MOPRService moprervice ;
	
	private static String RGSA_SQL_PANNEL="RGSA_SQL_PANNEL";
	
	private static String RGSA_SQL_PANNEL_UPDATE="RGSA_SQL_PANNEL_UPDATE";

	@RequestMapping(value = "info", method = RequestMethod.GET)
	public String info() {

		return "underdevelopment";
	}
	
	
	@RequestMapping(value = "rgsaSqlPannel", method = RequestMethod.GET)
	public String lgdSqlPannel( Model model, HttpSession session, HttpServletRequest request,HttpServletResponse response) {
		return RGSA_SQL_PANNEL;	
	}
	
	@RequestMapping(value = "rgsaSqlPannelRun", method = RequestMethod.POST)
	public String rgsaSqlPannelRun( Model model, HttpSession session, HttpServletRequest request,HttpServletResponse response) {
		String queryString= request.getParameter("queryString");
		model.addAttribute("queryString",queryString);
		try {
		if(queryString.length()>0 && queryString.contains("select")) {
			String tempStr=queryString.substring(queryString.indexOf("from")+5);
			String taleName=tempStr;
			if(tempStr.length()>0 && tempStr.indexOf(" ")>0) {
				 taleName=tempStr.substring(0,tempStr.indexOf(" "));
			}
			
			model.addAttribute("tableColumnList",moprervice.getTableColumnDetails(taleName));
			model.addAttribute("tableDataList",moprervice.getTableDataDetail(queryString));
		}
		}catch(Exception e ) {
			model.addAttribute("errorData",e.toString());
		}
		return RGSA_SQL_PANNEL;	
	}
	
	@RequestMapping(value = "rgsaSqlPannelUpdate", method = RequestMethod.GET)
	public String rgsaSqlPannelUpdate( Model model, HttpSession session, HttpServletRequest request,HttpServletResponse response) {
		return RGSA_SQL_PANNEL_UPDATE;	
	}
	
	@RequestMapping(value = "rgsaSqlPannelRunUpdate", method = RequestMethod.POST)
	public String rgsaSqlPannelRunUpdate( Model model, HttpSession session, HttpServletRequest request,HttpServletResponse response) {
		String queryString= request.getParameter("queryString");
		model.addAttribute("queryString",queryString);
		try {
		if(queryString.contains("update")) {
			Integer retRow=moprervice.fetchUpdateTableQuery(queryString);
			model.addAttribute("retRow",retRow);
		}else {
			model.addAttribute("errorData","not update query");
		}
		}catch(Exception e ) {
			model.addAttribute("errorData",e.toString());
		}
		return RGSA_SQL_PANNEL_UPDATE;	
	}

}
