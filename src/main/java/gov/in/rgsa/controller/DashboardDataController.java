package gov.in.rgsa.controller;

import gov.in.rgsa.entity.State;
import org.springframework.stereotype.Controller;

import java.util.Map;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.stream.Collectors;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.*;
import com.fasterxml.jackson.databind.JsonNode;

import gov.in.rgsa.dao.CommonRepository;
import gov.in.rgsa.entity.DashboardData;

@Controller
public class DashboardDataController {	
	static Logger logger = LoggerFactory.getLogger(DashboardDataController.class);
    @Autowired
    private CommonRepository commonRepository;

//    @ResponseBody
//    @RequestMapping(value="dashboardBasicInformation", method = RequestMethod.GET, produces= MediaType.APPLICATION_JSON_VALUE)
//    public JsonNode basicInformation(@RequestParam("stateCode") Integer stateCode){
//    	Map<String, Object> passParams = new HashMap<>();
//    	passParams.put("stateCode", stateCode);
//    	passParams.put("pageReferenceName", "basic-information");
//    	DashboardData dashboardData = commonRepository.find(DashboardData.class, passParams);
//    	if(dashboardData == null)
//    		return null;
//    	return dashboardData.getJsonData();
//    }

    @ResponseBody
    @GetMapping(value="dashboard/get-data/{pageReferenceName}", produces= MediaType.APPLICATION_JSON_VALUE)
    public JsonNode basicInformation(@PathVariable String pageReferenceName, @RequestParam(value = "stateCode", defaultValue = "0") Integer stateCode){
    	Map<String, Object> passParams = new HashMap<>();
    	State state = commonRepository.find( State.class, new HashMap<String, Object>(){{
    	    put("stateCode", stateCode);
    	    put("isactive", true);
        }});
    	if(state != null)
    	    passParams.put("stateCode", stateCode);
    	passParams.put("pageReferenceName", pageReferenceName);
    	DashboardData dashboardData = commonRepository.find(DashboardData.class, passParams);
    	if(dashboardData == null)
    		return null;
    	return dashboardData.getJsonData();
    }

    @ResponseBody
    @GetMapping(value = "dashboard/menu/menu-list.json", produces = MediaType.APPLICATION_JSON_VALUE)
    private List<Map<String, Object>> getMenuList(){
        Map<String, String> nameUrls = new HashMap<String, String>(){{
            put("Capacity Building & Training", "/dashboard/capacity_building");
            put("Technical Support", "/dashboard/technical_support");
            put("Panchayat Assets", "/dashboard/panchayat_assets");
            put("Institutional Structure", "/dashboard/institutional_structure");
            put("Distance Learning", "/dashboard/distance_learning");
            put("e-Enablement", "/dashboard/e_enablement");
            put("Support in PESA Areas", "/dashboard/pesa_support");
            put("Innovative Activities", "/dashboard/innovative_activities");
            put("Economic Development", "/dashboard/economic_development");
            put("IEC Activities", "/dashboard/iec_activities");
            put("Programme Management Unit", "/dashboard/programme_management");
            put("Basic Information", "/dashboard/basic_information");
        }};

        return nameUrls.entrySet().stream().map(this::getMenu).collect(Collectors.toList());
    }

    private Map<String, Object> getMenu(Map.Entry<String, String> menuNameUrl){
        return new HashMap<String, Object>(){{
            put("name", menuNameUrl.getKey());
            put("url" , menuNameUrl.getValue());
            put("children", new ArrayList<Map<String, Object>>());
            put("icon","view list");
        }};
    }

}
