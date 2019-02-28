package gov.in.rgsa.serviceImpl;

import java.math.BigInteger;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import gov.in.rgsa.dao.CommonRepository;
import gov.in.rgsa.entity.Plan;
import gov.in.rgsa.entity.State;
import gov.in.rgsa.model.StatewisePlanDetails;
import gov.in.rgsa.model.StatewisePlanStatus;
import gov.in.rgsa.service.LGDService;
import gov.in.rgsa.service.PlanDetailsService;
import gov.in.rgsa.user.preference.UserPreference;

@Service
public class PlanDetailsServiceImpl implements PlanDetailsService {
	
	@Autowired
	private CommonRepository commonRepository;
	
	@Autowired
	private LGDService lGDService;
	
	@Autowired
	private UserPreference userPreference;
	
	private static final int PLAN_FORWARDED_TO_MOPR=2; 
	private static final int PLAN_FORWARDED_TO_CEC=4; 

	@Override
	public List<Plan> getAllSubmittedPlan() {
		List<Plan> planStatus=null;
		Map<String, Object> params=new HashMap<>();
		params.put("yearId",userPreference.getFinYearId());
		params.put("isactive",true);
		if(userPreference.getUserType().equalsIgnoreCase("M")){
			params.put("planStatusId", PLAN_FORWARDED_TO_MOPR);
		}else{
			params.put("planStatusId", PLAN_FORWARDED_TO_CEC);
		}
		planStatus = commonRepository.findAll("PLAN_STATUS_LIST",params);
		for (Plan planStatus2 : planStatus) {
			State state=lGDService.getStateDetailsByCode(planStatus2.getStateCode());
			planStatus2.setStateName(state.getStateNameEnglish());
		}
		 return planStatus;
	}

	@Override
	public long countPlanSubmittedByState(String userType) {
		Map<String, Object> params=new HashMap<>();
		if(userType.equalsIgnoreCase("M")){
			params.put("plan_status_id", PLAN_FORWARDED_TO_MOPR);
		}else if (userType.equalsIgnoreCase("C")){
			params.put("plan_status_id", PLAN_FORWARDED_TO_CEC);
		}
		else{
			return 0;
		}
		params.put("isactive", true);
		BigInteger count = commonRepository.find("PLAN_COUNT", params);
		return count.intValue();
	}
	
	@Override
	public List<StatewisePlanStatus> getStatewisePlanStatus() {
		List<StatewisePlanStatus> statewisePlanStatusList=null;
		statewisePlanStatusList = commonRepository.findAll("STATEWISEPLANSTATUS",null);
		 return statewisePlanStatusList;
	}
	
	
	@Override
	public List<StatewisePlanDetails> getStatewisePlanDetails(Integer compId,Integer stateCode,Integer yearId) {
		List<StatewisePlanDetails> statewisePlanDetailList=null;
		Map<String, Object> params=new HashMap<>();
		params.put("stateCode", stateCode);
		params.put("yearId", yearId);
		statewisePlanDetailList = commonRepository.findAll("STATEWISEPLANDETAILS",params);
		 return statewisePlanDetailList;
	}
	
	
	@Override
	public List<Plan> getAllSubmittedPlanbyStatus(Integer planStatusId) {
		List<Plan> planStatus=null;
		Map<String, Object> params=new HashMap<>();
		params.put("yearId",userPreference.getFinYearId());
		params.put("isactive",true);
		
		params.put("planStatusId", planStatusId);
		
		planStatus = commonRepository.findAll("PLAN_STATUS_LIST",params);
		for (Plan planStatus2 : planStatus) {
			State state=lGDService.getStateDetailsByCode(planStatus2.getStateCode());
			planStatus2.setStateName(state.getStateNameEnglish());
		}
		 return planStatus;
	}

}
