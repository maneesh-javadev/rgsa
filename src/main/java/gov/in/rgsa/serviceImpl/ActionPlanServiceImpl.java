package gov.in.rgsa.serviceImpl;

import java.math.BigInteger;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import gov.in.rgsa.dao.CommonRepository;
import gov.in.rgsa.entity.Plan;
import gov.in.rgsa.entity.PlanPK;
import gov.in.rgsa.service.ActionPlanService;
import gov.in.rgsa.user.preference.UserPreference;

@Service
public class ActionPlanServiceImpl implements ActionPlanService{
	
	@Autowired
	private CommonRepository commonRepository;
	
	@Autowired
	private UserPreference userPreference;
	
	private static final int PLAN_STATUS_DRAFT=1;

	@Override
	public Plan actionPlanStatus() {
		if(userPreference.getUserType().equalsIgnoreCase("S")){
			Map<String, Object> params=new HashMap<String, Object>();
			params.put("stateCode", userPreference.getStateCode());
			params.put("yearId", userPreference.getFinYearId());
			params.put("planStatusId", PLAN_STATUS_DRAFT);
			params.put("planVersion", userPreference.getPlanVersion());
			List<Plan>  planStatus= commonRepository.findAll("PLAN_STATUS", params);	
			if(planStatus==null || planStatus.isEmpty()){
				System.out.println(" plan exist");
				BigInteger biPlanCode = commonRepository.find("_FECH_PLAN_CODE_SEQUENCE", null);
				Plan status=new Plan();
				PlanPK planPK=new PlanPK();
				planPK.setPlanCode(biPlanCode.intValue());
				planPK.setPlanVersion(1);
				planPK.setPlanStatusId(PLAN_STATUS_DRAFT);
				status.setPlanPK(planPK);
				status.setStateCode(userPreference.getStateCode());
				status.setYearId(userPreference.getFinYearId());
				status.setIsactive(true);
				status.setCreatedBy(userPreference.getUserId());
				commonRepository.save(status);
				return status;
				
			}
			
		}
		
		return null;
	}
	
	@Override
	public List<Plan> fetchPlanDetailbyStatus(Integer planStatus){
		Map<String, Object> params=new HashMap<>();
		params.put("yearId", userPreference.getFinYearId());
		params.put("stateCode", userPreference.getStateCode());
		params.put("planStatusId", planStatus);
		List<Plan> planList = commonRepository.findAll("CURRENT_PLAN_STATUS",params);
		return planList;
	}
}
