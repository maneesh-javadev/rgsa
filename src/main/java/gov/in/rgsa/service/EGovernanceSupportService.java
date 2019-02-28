package gov.in.rgsa.service;

import java.util.List;

import gov.in.rgsa.entity.EGovPost;
import gov.in.rgsa.entity.EGovSupportActivity;
import gov.in.rgsa.entity.EGovSupportActivityDetails;
import gov.in.rgsa.model.EGovernanceSupportModel;

public interface EGovernanceSupportService {

	public List<EGovPost> fetchPostLevel();


	public void saveEGovSupportActivity(EGovSupportActivity eGovSupportActivity);


	public List<EGovSupportActivity> fetchEGovActivity(final Character userType);


	public List<EGovSupportActivityDetails> fetchEGovActivityDetails(Integer geteGovSupportActivityId);


	public void freezeAndUnfreeze(EGovernanceSupportModel form);


	public void saveEGovSupportActivityCEC(final EGovSupportActivity eGovSupportActivity);

	/*
	 * public Boolean handelDataForMOPR();
	 */
	
	

}
