package gov.in.rgsa.intercepter;

import java.net.URL;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import gov.in.rgsa.service.FacadeService;

public class VisitorCountInterceptor extends HandlerInterceptorAdapter {

	@Autowired
	private FacadeService service;
	

	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object obj, ModelAndView mav) throws Exception {
	    try{
	    	
	    	
	    	HttpServletRequest httpServletRequest = (HttpServletRequest) request;
			
			String requestURL = httpServletRequest.getRequestURL().toString();
			URL url = new URL(requestURL);
			String path = url.getPath();
			String contextPath = httpServletRequest.getContextPath();
			//System.out.println("path-->"+path);
			//System.out.println("contextPath-->"+contextPath);
			int count =0;
			boolean visitorFlag=false;
	    	if((contextPath+"/index.html").equalsIgnoreCase(path) || (contextPath+"/").equalsIgnoreCase(path) ){
	    		HttpSession session = request.getSession(true);
	    		if(session.getAttribute("visitorFlag")!=null) {
	    			visitorFlag=(boolean)session.getAttribute("visitorFlag");
	    		}
	    		
	    		//System.out.println(count);
	    		if(visitorFlag) {
	    			visitorFlag=false;
	    		}else {
	    			visitorFlag=true;
	    		}
	    		
	    		session.setAttribute("visitorFlag",visitorFlag);
	    		if(visitorFlag) {
	    			count =service.findVisitorCount();
	    			session.setAttribute("visitorCount",count);
	    		}
	    		
	    	}
		}catch (Exception e) {
			// TODO: handle exception
	    	throw e;
		}
	 }

}
