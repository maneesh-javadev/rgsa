package gov.in.rgsa.service;

import java.util.List;

import gov.in.rgsa.entity.Plan;
import gov.in.rgsa.model.StatewisePlanDetails;
import gov.in.rgsa.model.StatewisePlanStatus;

public interface PlanDetailsService {
	
	public List<Plan> getAllSubmittedPlan();
	
	
	public long countPlanSubmittedByState(String userType);
	
	public List<StatewisePlanStatus> getStatewisePlanStatus();
	
	public List<StatewisePlanDetails> getStatewisePlanDetails(Integer compId,Integer stateCode,Integer yearId);
	
	public List<Plan> getAllSubmittedPlanbyStatus(Integer planStatusId);

}
