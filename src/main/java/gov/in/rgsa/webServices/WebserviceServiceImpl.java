package gov.in.rgsa.webServices;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import gov.in.rgsa.dao.CommonRepository;
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

}
