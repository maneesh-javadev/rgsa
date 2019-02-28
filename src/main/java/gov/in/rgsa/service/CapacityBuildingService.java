package gov.in.rgsa.service;

import java.util.List;

import gov.in.rgsa.entity.CapacityBuildingActivity;
import gov.in.rgsa.entity.CapacityBuildingActivityGPs;
import gov.in.rgsa.model.Response;

public interface CapacityBuildingService {
	
	public CapacityBuildingActivity fetchCapacityBuildingActivity(Character userType);
	
	public void saveCapacityBuildingActivityAndDetails(final CapacityBuildingActivity capacityBuildingActivity);

	public CapacityBuildingActivity feezUnFreezCapacityBuildingActivity(CapacityBuildingActivity capacityBuildingActivity);
	
	public Response saveCBFinalizeWorkLocaion(List<CapacityBuildingActivityGPs> capacityBuildingActivityGPsList);
	
	public List<CapacityBuildingActivityGPs> fetchCapacityBuildingActivityGPsList(Integer capacityBuildingActivityDetailsId,Integer cbMasterId);


}
