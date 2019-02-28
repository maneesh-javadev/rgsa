package gov.in.rgsa.controller;

import org.springframework.stereotype.Controller;

import java.util.Map;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import com.fasterxml.jackson.databind.JsonNode;

import gov.in.rgsa.dao.CommonRepository;
import gov.in.rgsa.entity.DashboardData;

@Controller
public class DashboardDataController {	
	static Logger logger = LoggerFactory.getLogger(DashboardDataController.class);
    @Autowired
    private CommonRepository commonRepository;

    @ResponseBody
    @RequestMapping(value="dashboardBasicInformation", method = RequestMethod.GET, produces= MediaType.APPLICATION_JSON_VALUE)
    public JsonNode basicInformation(@RequestParam("stateCode") Integer stateCode){
    	Map<String, Object> passParams = new HashMap<>();
    	passParams.put("stateCode", stateCode);
    	passParams.put("pageReferenceName", "basic-information");
    	DashboardData dashboardData = commonRepository.find(DashboardData.class, passParams);
    	if(dashboardData == null)
    		return null;
    	return dashboardData.getJsonData();
    }

}
