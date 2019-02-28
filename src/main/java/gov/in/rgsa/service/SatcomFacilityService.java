package gov.in.rgsa.service;

import java.util.List;

import gov.in.rgsa.entity.SatcomActivity;
import gov.in.rgsa.entity.SatcomCurrentStatus;
import gov.in.rgsa.entity.SatcomLevel;
import gov.in.rgsa.entity.SatcomMaster;
import gov.in.rgsa.entity.SchemeMaster;

public interface SatcomFacilityService {

	public List<SatcomMaster> getSatcomeActivityName();
	
	public List<SatcomLevel> getSatcomeLevel();
	
	public void saveSatcomeFacility(SatcomActivity activity, String userType);
	
	public List<SatcomActivity> fetchSatcomActivities(String userType);
	
	public List<SatcomCurrentStatus> fetchSatcomStatus();
	
	public List<SchemeMaster> fetchSchemeMaster();
	
	public void saveSatcomCurrentStatus(final SatcomCurrentStatus satcomCurrentStatus);

	public List<SatcomActivity> getApprovedSatcomActivity();
}
