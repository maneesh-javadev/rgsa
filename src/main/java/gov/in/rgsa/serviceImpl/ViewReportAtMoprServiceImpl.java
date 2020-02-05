package gov.in.rgsa.serviceImpl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Stream;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.validation.annotation.Validated;

import gov.in.rgsa.dao.CommonRepository;
import gov.in.rgsa.dto.AnualActionPlanPhysically;
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
		parameter.put("stateCode", viewReportModel.getStateCode());
		parameter.put("yearId", userPreference.getFinYearId());
		return dao.findAll("FETCH_DEMOGRAPHIC_DATA", parameter);
	}

	@Override
	public List<AnualActionPlanPhysically> fetchAnualActionPlanPhysically(String component ,String slc, String fin) {
		Integer total=0;
		Map<String, Object> parameter = new HashMap<String, Object>();
			List<AnualActionPlanPhysically> actionPlanPhysicallies = null;
		if(("S").equals(userPreference.getUserType())){
			
			parameter.put("stateCode", userPreference.getStateCode());
			parameter.put("yearId", userPreference.getFinYearId());
			parameter.put("version", userPreference.getPlanVersion());
		}else if(("M").equals(userPreference.getUserType())){
			parameter.put("version", 1);
			parameter.put("stateCode", Integer.valueOf(slc));
			parameter.put("yearId", userPreference.getFinYearId());
			}else {
			parameter.put("stateCode", Integer.valueOf(slc));
			parameter.put("yearId", Integer.valueOf(fin));
			parameter.put("version", 1);
			}
			
			

		if (("TD").equals(component)) {
			actionPlanPhysicallies = dao.findAll("FETCH_ANUAL_ACTION_PLAN_DETAILS_TD", parameter);
			
		}
		if (("PP").equals(component)) {
			actionPlanPhysicallies = dao.findAll("FETCH_ANUAL_ACTION_PLAN_DETAILS_PP", parameter);
		}
		if (("EE").equals(component)) {
			actionPlanPhysicallies = dao.findAll("FETCH_ANUAL_ACTION_PLAN_DETAILS_EE", parameter);
		}
		if (("PB").equals(component)) {
			actionPlanPhysicallies = dao.findAll("FETCH_ANUAL_ACTION_PLAN_DETAILS_PB", parameter);

		}
		if (("DLS").equals(component)) {
			actionPlanPhysicallies = dao.findAll("FETCH_ANUAL_ACTION_PLAN_DETAILS_DLS", parameter);

		}
		if (("IEC").equals(component)) {
			actionPlanPhysicallies = dao.findAll("FETCH_ANUAL_ACTION_PLAN_DETAILS_IEC", parameter);
		}
		if (("ATS").equals(component)) {
			actionPlanPhysicallies = dao.findAll("FETCH_ANUAL_ACTION_PLAN_DETAILS_ATS", parameter);
		}
		if (("TRA").equals(component)) {
			actionPlanPhysicallies = dao.findAll("FETCH_ANUAL_ACTION_PLAN_DETAILS_TRA", parameter);
		}
		if (("PMU").equals(component)) {
			actionPlanPhysicallies = dao.findAll("FETCH_ANUAL_ACTION_PLAN_DETAILS_PMU", parameter);
		}
		if (("AFD").equals(component)) {
			actionPlanPhysicallies = dao.findAll("FETCH_ANUAL_ACTION_PLAN_DETAILS_AFD", parameter);
		}
		if (("IE").equals(component)) {
			actionPlanPhysicallies = dao.findAll("FETCH_ANUAL_ACTION_PLAN_DETAILS_IE", parameter);
		}
		if (("IA").equals(component)) {
			actionPlanPhysicallies = dao.findAll("FETCH_ANUAL_ACTION_PLAN_DETAILS_IA", parameter);
		}
		if (("HR").equals(component)) {
			actionPlanPhysicallies = dao.findAll("FETCH_ANUAL_ACTION_PLAN_DETAILS_HR", parameter);
		}
		if (("EGOV").equals(component)) {
			actionPlanPhysicallies = dao.findAll("FETCH_ANUAL_ACTION_PLAN_DETAILS_EGOV", parameter);
		}
		if (("ALL").equals(component)) {
			actionPlanPhysicallies = dao.findAll("FETCH_ANUAL_ACTION_PLAN_DETAILS_ALL_COMPONENT", parameter);
		}
		
		
		return actionPlanPhysicallies;
	}

}
