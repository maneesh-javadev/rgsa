package gov.in.rgsa.serviceImpl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import gov.in.rgsa.dao.CommonRepository;
import gov.in.rgsa.dto.DemographicProfileDataDto;
import gov.in.rgsa.entity.FinYear;
import gov.in.rgsa.model.ViewReportAtMoprModel;
import gov.in.rgsa.service.ViewReportAtMoprService;
import gov.in.rgsa.user.preference.UserPreference;

@Service
public class ViewReportAtMoprServiceImpl implements ViewReportAtMoprService {

	@Autowired
	private CommonRepository dao;
	
	@Autowired
	UserPreference userPreference;
	
	@Override
	public List<FinYear> getFinYearList() {
		return dao.findAll("FETCH_ALL_FIN_YEAR", null);
	}

	@Override
	public List<DemographicProfileDataDto> fetchDemographicData(ViewReportAtMoprModel viewReportModel) {
		Map<String, Object> parameter = new HashMap<String, Object>();
		parameter.put("stateCode",viewReportModel.getStateCode());
		parameter.put("yearId", userPreference.getFinYearId());
		return dao.findAll("FETCH_DEMOGRAPHIC_DATA", parameter);
	}

}
