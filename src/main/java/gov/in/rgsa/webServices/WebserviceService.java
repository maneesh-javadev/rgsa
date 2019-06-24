package gov.in.rgsa.webServices;

import java.util.List;

import gov.in.rgsa.dto.ERRepresentativeHundredDayProg;
import gov.in.rgsa.dto.StatewiseNoOfParticipants;
import gov.in.rgsa.entity.FetchPlanStatusCount;

public interface WebserviceService {

	FetchPlanStatusCount fetchPlanSubmitedAndApproved(String fin_year);
	Integer fetchNoOfParticipantsIndia(String fin_year);
	List<StatewiseNoOfParticipants> fetchNoOfParticipantsStateWise(String fin_year);
	List<ERRepresentativeHundredDayProg> fetchERRepresentativeHundredDayProg(String fin_year);
}
