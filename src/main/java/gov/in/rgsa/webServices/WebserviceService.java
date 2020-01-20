package gov.in.rgsa.webServices;

import gov.in.rgsa.entity.CapacityBuildingErForOoms;
import gov.in.rgsa.dto.HundredDaysWebServiceDTO;
import gov.in.rgsa.dto.ERRepresentativeHundredDayProgStateWise;
import gov.in.rgsa.dto.ERRepresentativeHundredDayProgLastWeekWise;
import gov.in.rgsa.dto.ERRepresentativeHundredDayProg;
import gov.in.rgsa.dto.StatewiseNoOfParticipants;
import java.util.List;
import gov.in.rgsa.entity.FetchPlanStatusCount;

public interface WebserviceService {
	FetchPlanStatusCount fetchPlanSubmitedAndApproved(final String fin_year);

	Integer fetchNoOfParticipantsIndia(final String fin_year);

	List<StatewiseNoOfParticipants> fetchNoOfParticipantsStateWise(final String fin_year);

	List<ERRepresentativeHundredDayProg> fetchERRepresentativeHundredDayProg(final String fin_year, final String stDate,
			final String endDate);

	List<ERRepresentativeHundredDayProgLastWeekWise> fetchERRepresentativeHundredDayProgLASTWEEKWISE();

	List<ERRepresentativeHundredDayProgStateWise> fetchERRepresentativeHundredDayProgStateWise(final String fin_year,
			final String stDate, final String endDate);

	List<HundredDaysWebServiceDTO> fetchHundredDayWSData(final String fieldType);

	List<CapacityBuildingErForOoms> fetchCapacityBuildingErForOoms(final String finYear, final String type);
}