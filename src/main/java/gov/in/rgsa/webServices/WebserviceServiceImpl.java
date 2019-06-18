package gov.in.rgsa.webServices;

import java.math.BigInteger;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import gov.in.rgsa.dao.CommonRepository;
import gov.in.rgsa.dto.StatewiseNoOfParticipants;
import gov.in.rgsa.entity.FetchPlanStatusCount;


@Service
public class WebserviceServiceImpl implements WebserviceService {

	@Autowired
	private CommonRepository commonRepository;
	
	@Override
	public FetchPlanStatusCount fetchPlanSubmitedAndApproved(String fin_year) {
		FetchPlanStatusCount fetchPlanStatusCount=null;
		Map<String, Object> params=new HashMap<>();
		params.put("fin_year",fin_year);
		List<FetchPlanStatusCount> fetchPlanStatusCountList= commonRepository.findAll("FETCH_PLAN_STAUS_COUNT",params);
		if(fetchPlanStatusCountList!=null && !fetchPlanStatusCountList.isEmpty()) {
			fetchPlanStatusCount=fetchPlanStatusCountList.get(0);	
		 
		}
		return fetchPlanStatusCount;
	}
	
	

	@Override
	public Integer fetchNoOfParticipantsIndia(String fin_year) {
		try {
		Map<String, Object> params=new HashMap<>();
		params.put("fin_year",fin_year);
		params.put("isactive", true);
		String squery="select (coalesce(sum(no_of_participants_sc),0)+coalesce(sum(no_of_participants_st),0)"
				+ "+coalesce(sum(no_of_participants_woman),0)+coalesce(sum(no_of_participants_others),0))no_of_participants  "
				+ " from rgsa.trg_details_of_hundred_days_program td inner join rgsa.fin_year  fy  on td.year_id =fy.year_id "
				+ "where   td.isactive=:isactive and fy.finyear = :fin_year"; 
		BigInteger countbig = commonRepository.findByNativeQuery(squery, params);
		return countbig.intValue();
		}catch(Exception e) {
			e.printStackTrace();
			return -1;
		}
		
	}
	
	
	@Override
	public List<StatewiseNoOfParticipants> fetchNoOfParticipantsStateWise(String fin_year) {
		List<StatewiseNoOfParticipants> statewiseNoOfParticipantsList=null;
		try {
		Map<String, Object> params=new HashMap<>();
		params.put("fin_year",fin_year);
		statewiseNoOfParticipantsList= commonRepository.findAll("NO_OF_PARTICIPANTS_STATE_WISE", params);
		
		}catch(Exception e) {
			e.printStackTrace();
		}
		return statewiseNoOfParticipantsList;
	}

}
