package gov.in.rgsa.service;

import java.util.List;

import gov.in.rgsa.dto.AnualActionPlanPhysically;
import gov.in.rgsa.dto.DemographicProfileDataDto;
import gov.in.rgsa.entity.FinYear;
import gov.in.rgsa.model.ViewReportAtMoprModel;

public interface ViewReportAtMoprService {

	List<FinYear> getFinYearList();

	List<DemographicProfileDataDto> fetchDemographicData(ViewReportAtMoprModel viewReportModel);

	List<AnualActionPlanPhysically> fetchAnualActionPlanPhysically(String component ,String slc ,String fin);
}
