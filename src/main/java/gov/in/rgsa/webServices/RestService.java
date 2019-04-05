package gov.in.rgsa.webServices;


import javax.servlet.ServletContext;
import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.QueryParam;
import javax.ws.rs.core.Context;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.stereotype.Controller;
import org.springframework.web.context.support.WebApplicationContextUtils;

import gov.in.rgsa.entity.FetchPlanStatusCount;





@Controller
@Path("/rgsaWebService")
public class RestService {
	
	@Autowired
	private WebserviceService webserviceService;
	
	

	
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
