package gov.in.rgsa.webServices;


import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.QueryParam;
import javax.ws.rs.core.Context;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.context.support.WebApplicationContextUtils;

import gov.in.rgsa.dto.ERRepresentativeHundredDayProg;
import gov.in.rgsa.dto.ERRepresentativeHundredDayProgLastWeekWise;
import gov.in.rgsa.dto.ERRepresentativeHundredDayProgStateWise;
import gov.in.rgsa.dto.HundredDaysWebServiceDTO;
import gov.in.rgsa.dto.StatewiseNoOfParticipants;
import gov.in.rgsa.entity.FetchPlanStatusCount;



@CrossOrigin(origins = "*", allowedHeaders = "*")
@RestController

public class RestService {
	
	@Autowired
	private WebserviceService webserviceService;
	
	@GetMapping("/webService/noOfParticipantsAllIndia/{finYear}")
	public Integer noOfParticipantsAllIndia(@PathVariable String finYear,HttpServletResponse response,HttpServletRequest request) {
		response.setHeader("Access-Control-Allow-Origin", "*");
		response.setHeader("Access-Control-Allow-Headers", request.getHeader("Access-Control-Request-Headers"));
		response.setHeader("Access-Control-Allow-Methods", request.getHeader("Access-Control-Request-Method"));	
		return webserviceService.fetchNoOfParticipantsIndia(finYear);
	}
	
	@GetMapping("/webService/fetchHundredDayWSData/{fieldType}")
	public List<HundredDaysWebServiceDTO> fetchHundredDayWSData(@PathVariable String fieldType,HttpServletResponse response,HttpServletRequest request) {
		response.setHeader("Access-Control-Allow-Origin", "*");
		response.setHeader("Access-Control-Allow-Headers", request.getHeader("Access-Control-Request-Headers"));
		response.setHeader("Access-Control-Allow-Methods", request.getHeader("Access-Control-Request-Method"));	
		return webserviceService.fetchHundredDayWSData(fieldType);
	}
	
	
	@GetMapping("/webService/noOfParticipantsStatewise/{finYear}")
	public List<StatewiseNoOfParticipants> noOfParticipantsStatewise(@PathVariable String finYear,HttpServletResponse response,HttpServletRequest request) {
		response.setHeader("Access-Control-Allow-Origin", "*");
		response.setHeader("Access-Control-Allow-Headers", request.getHeader("Access-Control-Request-Headers"));
		response.setHeader("Access-Control-Allow-Methods", request.getHeader("Access-Control-Request-Method"));	
		return webserviceService.fetchNoOfParticipantsStateWise(finYear);
	}
	
	
	@GetMapping("/webService/totalERRepresentativeDetails/{finYear}")
	public List<ERRepresentativeHundredDayProg> totalERRepresentativeDetails(@PathVariable String finYear,HttpServletResponse response,HttpServletRequest request) {
		response.setHeader("Access-Control-Allow-Origin", "*");
		response.setHeader("Access-Control-Allow-Headers", request.getHeader("Access-Control-Request-Headers"));
		response.setHeader("Access-Control-Allow-Methods", request.getHeader("Access-Control-Request-Method"));	
		return webserviceService.fetchERRepresentativeHundredDayProg(finYear,null,null);
	}
	
	@GetMapping("/webService/totalERRepresentativeDetailsDateWise/{stDate}/{endDate}")
	public List<ERRepresentativeHundredDayProg> totalERRepresentativeDetailsDateWise(@PathVariable String stDate,@PathVariable String endDate,HttpServletResponse response,HttpServletRequest request) {
		response.setHeader("Access-Control-Allow-Origin", "*");
		response.setHeader("Access-Control-Allow-Headers", request.getHeader("Access-Control-Request-Headers"));
		response.setHeader("Access-Control-Allow-Methods", request.getHeader("Access-Control-Request-Method"));	
		return webserviceService.fetchERRepresentativeHundredDayProg(null,stDate,endDate);
	}
	
	@GetMapping("/webService/totalERRepresentativeDetailsStateWise/{stDate}/{endDate}")
	public List<ERRepresentativeHundredDayProgStateWise> totalERRepresentativeDetailsStateWise(@PathVariable String stDate,@PathVariable String endDate,HttpServletResponse response,HttpServletRequest request) {
		response.setHeader("Access-Control-Allow-Origin", "*");
		response.setHeader("Access-Control-Allow-Headers", request.getHeader("Access-Control-Request-Headers"));
		response.setHeader("Access-Control-Allow-Methods", request.getHeader("Access-Control-Request-Method"));	
		return webserviceService.fetchERRepresentativeHundredDayProgStateWise(null, stDate, endDate);
	}
	
	@GetMapping("/webService/totalERRepresentativeDetailsLastWeekWise")
	public List<ERRepresentativeHundredDayProgLastWeekWise> totalERRepresentativeDetailsLastWeekWise(HttpServletResponse response,HttpServletRequest request) {
		response.setHeader("Access-Control-Allow-Origin", "*");
		response.setHeader("Access-Control-Allow-Headers", request.getHeader("Access-Control-Request-Headers"));
		response.setHeader("Access-Control-Allow-Methods", request.getHeader("Access-Control-Request-Method"));	
		return webserviceService.fetchERRepresentativeHundredDayProgLASTWEEKWISE();
	}

	
	@GET
	@Path("/TESTHI")
	@Produces(MediaType.APPLICATION_XML)
	public Response getTotalSubmittedPlans(@Context ServletContext servletContext){
		Response response = null;
		
			ApplicationContext ctx = WebApplicationContextUtils.getWebApplicationContext(servletContext);
			webserviceService =ctx.getBean(WebserviceService.class);
			StringBuilder sw=new StringBuilder("<xml>\n<status>HI HOW R U\n");
			sw.append("\n</status>\n</xml>");
			
			
			
		
		return response;
		
	}

@GET
@Path("/totalNumberOfSubmittedStatePlans")
@Produces(MediaType.APPLICATION_XML)
public Response getTotalSubmittedPlans(@Context ServletContext servletContext,@QueryParam(value = "finYear") String finYear) throws Exception{
	Response response = null;
	try {
		System.out.println("1");
		
		if(finYear!=null) {
			ApplicationContext ctx = WebApplicationContextUtils.getWebApplicationContext(servletContext);
			webserviceService =ctx.getBean(WebserviceService.class);
			System.out.println("2");
			FetchPlanStatusCount fetchPlanStatusCount = webserviceService.fetchPlanSubmitedAndApproved(finYear);
			StringBuilder sw=new StringBuilder("<xml>\n<status>\n");
			if(fetchPlanStatusCount!=null )
			{
				sw.append("States submitted RGSA plans-:"+fetchPlanStatusCount.getPlanSumitCount()).append(";");
				sw.append("Plans approved-:"+fetchPlanStatusCount.getPlanApprovedCount()).append(";");
				sw.append("Meetings of CEC held year-wise-:"+fetchPlanStatusCount.getCecMettingCount()).append(";");
				sw.append("\n</status>\n</xml>");
				response = Response.ok().type(MediaType.APPLICATION_XML).entity(sw.toString().getBytes("UTF-8")).build();
			}else{
				response = Response.serverError().entity("No plan is submitted or approved in this particular fin year.").build();
			}
		}else {
			response = Response.serverError().entity("No input parameter").build();
		}
		
		
			
	} catch (Exception e) {
		StringBuilder sw=new StringBuilder("<xml>\n<error>\n");
		sw.append(e);
		sw.append("\n</error>\n</xml>");
		response = Response.serverError().type(MediaType.APPLICATION_XML).entity(sw.toString().getBytes("UTF-8")).build();
		e.printStackTrace();
	}
	return response;
	
}


	
}
