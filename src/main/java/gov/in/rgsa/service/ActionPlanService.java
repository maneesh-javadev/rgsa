package gov.in.rgsa.service;

import java.util.List;

import gov.in.rgsa.entity.Plan;

public interface ActionPlanService {

	public Plan actionPlanStatus();
	public List<Plan> fetchPlanDetailbyStatus(Integer planStatus);
}
