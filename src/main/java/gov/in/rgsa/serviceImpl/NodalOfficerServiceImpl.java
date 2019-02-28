package gov.in.rgsa.serviceImpl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import gov.in.rgsa.dao.CommonRepository;
import gov.in.rgsa.entity.NodalOfficerDetails;
import gov.in.rgsa.entity.NodalOfficerHistory;
import gov.in.rgsa.service.NodalOfficerService;
import gov.in.rgsa.user.preference.UserPreference;

@Service
public class NodalOfficerServiceImpl implements NodalOfficerService {
	
	@Autowired
	private UserPreference  userPreference;
	
	@Autowired 
	private CommonRepository commonRepository;

	@Override
	public void saveNodalOfficerDetails(NodalOfficerDetails details) {
		details.setStateCode(userPreference.getStateCode());
		if(details.getNodalOfficerId()==null || details.getNodalOfficerId() == 0){
			commonRepository.save(details);
		}
		else{
			commonRepository.update(details);
		}
		NodalOfficerHistory history = new NodalOfficerHistory();
		history.setNodalOfficerEmailId(details.getNodalOfficerEmailId());
		history.setNodalOfficerDesignation(details.getNodalOfficerDesignation());
		history.setNodalOfficerMobileNumber(details.getNodalOfficerMobileNumber());
		history.setNodalOfficerId(details.getNodalOfficerId());
		history.setNodalOfficerName(details.getNodalOfficerName());
		history.setPmuDesignation(details.getPmuDesignation());
		history.setPmuMobileNumber(details.getPmuMobileNumber());
		history.setPmuEmailId(details.getPmuEmailId());
		history.setDacDesignation(details.getDacDesignation());
		history.setDacMobileNumber(details.getDacMobileNumber());
		history.setDacEmailId(details.getDacEmailId());
		history.setStateCode(details.getStateCode());
		 commonRepository.save(history);
	}
	

	@Override
	public NodalOfficerDetails getNodalOfficerDetails() {
		Map<String, Object> params=new HashMap<>();
		params.put("stateCode", userPreference.getStateCode());
			List<NodalOfficerDetails> details=	commonRepository.findAll("FETCH_NODAL_DETAILS", params);
			if(details!=null && details.size()>0){
				return details.get(0);
			}
			return null;
	}

}
