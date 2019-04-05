package gov.in.rgsa.webServices;

import gov.in.rgsa.entity.FetchPlanStatusCount;

public interface WebserviceService {

	public FetchPlanStatusCount fetchPlanSubmitedAndApproved(String fin_year);
}
