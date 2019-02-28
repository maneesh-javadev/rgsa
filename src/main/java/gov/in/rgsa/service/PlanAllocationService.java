package gov.in.rgsa.service;

import java.util.List;

import gov.in.rgsa.entity.Plan;
import gov.in.rgsa.entity.PlanComponents;
import gov.in.rgsa.entity.State;
import gov.in.rgsa.entity.StateAllocation;
import gov.in.rgsa.model.StateAllocationModal;

public interface PlanAllocationService {

	public List<PlanComponents> getPlanComponents();
	
	public Boolean approveCecPlan();
	
	public List<State> states(int stateCode);
	
	public List<Plan> showHidePlanStatus(int stateCode);
	
	public StateAllocationModal getBasicDetailofPlanAllocation(StateAllocationModal stateAllocationModal);
	
	public boolean  savePlanAllocation(StateAllocationModal stateAllocationModal);
	
	public List<StateAllocation> fetchStateAllocationList(Integer planCode,Integer installmentNo);
	
	
	
	
}
