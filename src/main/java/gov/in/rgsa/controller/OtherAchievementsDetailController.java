package gov.in.rgsa.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
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
			result= otherAchievementsDetailService.enablementsOfPanchyatComputerization(1);
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
			result= otherAchievementsDetailService.enablementsOfPanchyatComputerization(3);
			list.add(result);
			
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		 
		return list;
	}
	
	
	@ResponseBody
	@RequestMapping(value = "kpiHeaderPage", method = RequestMethod.POST, produces = MediaType.APPLICATION_JSON_VALUE, consumes = MediaType.APPLICATION_JSON_VALUE)
	public String kpiHeaderPage(@RequestParam(value = "kpiName", required = false) String kpiName) {
		try {
			 
		}catch(Exception e)
		{
			e.printStackTrace();
		}
		return KPI_HEADER_PAGE ;
	}
}
