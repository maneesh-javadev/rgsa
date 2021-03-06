package gov.in.rgsa.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import gov.in.rgsa.service.OtherAchievementsDetailService;


@Controller
public class OtherAchievementsDetailController {

    @Autowired
    private OtherAchievementsDetailService otherAchievementsDetailService;
    
    private String KPI_HEADER_PAGE="kpiheaderpage";
	
	@ResponseBody
	@RequestMapping(value = "basicOrientationTrainingofER", method = RequestMethod.POST, produces = MediaType.APPLICATION_JSON_VALUE, consumes = MediaType.APPLICATION_JSON_VALUE)
	public  List<String>  fetchTrainingBreakUpData(@RequestParam(value = "detailId", required = false) Integer detailId) {
		List<String> list = new ArrayList<>();
		String result=null;
		
		try {
			result=otherAchievementsDetailService.basicOrientationTrainingofER(2);
			list.add(result);
			result=otherAchievementsDetailService.basicOrientationTrainingofER(3);
			list.add(result);
			result=otherAchievementsDetailService.basicOrientationTrainingofER(7);
			list.add(result);
			result=otherAchievementsDetailService.enablementsOfPanchat(1);
			list.add(result);
			result=otherAchievementsDetailService.enablementsOfPanchat(2);
			list.add(result);
			result= otherAchievementsDetailService.enablementsOfPanchyatComputerization(3);
			list.add(result);
			result= otherAchievementsDetailService.exposureVisit(5);
			list.add(result);
			result= otherAchievementsDetailService.exposureVisit(6);
			list.add(result);
			result= otherAchievementsDetailService.supportForPanchayatAsset("5","1");
			list.add(result);
			result= otherAchievementsDetailService.supportForPanchayatAsset("8","2");
			list.add(result);
			result= otherAchievementsDetailService.supportForPanchayatAsset("11","3");
			list.add(result);
			result=  otherAchievementsDetailService.panchyatStakehlderTrained();
			list.add(result);
			// method for Technical support to GPs 
			result= otherAchievementsDetailService.enablementsOfPanchyatComputerization(1);
			list.add(result);
			
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		 
		return list;
	}
 

	
	@ResponseBody
	@RequestMapping(value = "kpiHeaderPage", method = RequestMethod.POST, produces = MediaType.APPLICATION_JSON_VALUE, consumes = MediaType.APPLICATION_JSON_VALUE)
	public List kpiHeaderPage(@RequestParam(value = "kpiName", required = false) String kpiName) {
		List  list=new LinkedList();
		try {
			String result=null;
			list= otherAchievementsDetailService.fetchQprEenablementProgressReport();
			 
		}catch(Exception e)
		{
			e.printStackTrace();
		}
			return list ;
	 
	}
	
	
	
	@ResponseBody
	@RequestMapping(value = "kpiRajeevPage", method = RequestMethod.GET)
	public Map<String, List<Object>> kpiRajeevPage(@RequestParam(value = "kpiName", required = false) String kpiName) {
		Map<String, List<Object>> map= new HashMap<>();
		try {
			map.put(kpiName,  otherAchievementsDetailService.fetchEspmu(kpiName));
			}catch(Exception e)
		{
			e.printStackTrace();
		}
		return map ;
	}
	
	@ResponseBody
	@RequestMapping(value = "basicOrientationById", method = RequestMethod.GET)
	public Map<String, List<Object>> basicOrientationById(@RequestParam(value = "id", required = false) String id,@RequestParam(value = "kpiname", required = false) String kpiname) {
		Map<String, List<Object>> map= new HashMap<>();
		try {
			map.put("ErList",  otherAchievementsDetailService.fetchbasicOrientationById(id ,kpiname));
			}catch(Exception e)
		{
			e.printStackTrace();
		}
		return map ;
	}
	
}
