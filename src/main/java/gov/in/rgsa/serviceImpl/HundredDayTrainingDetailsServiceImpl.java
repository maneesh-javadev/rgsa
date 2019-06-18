package gov.in.rgsa.serviceImpl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import gov.in.rgsa.dao.CommonRepository;
import gov.in.rgsa.entity.TrgDetailsOfHundredDaysProgram;
import gov.in.rgsa.service.HundredDayTrainingDetailsService;
import gov.in.rgsa.user.preference.UserPreference;

@Service
public class HundredDayTrainingDetailsServiceImpl implements HundredDayTrainingDetailsService {

	@Autowired
	private CommonRepository dao;
	
	@Autowired
	private UserPreference userPreference;
	
	@Override
	public void saveDeatils(TrgDetailsOfHundredDaysProgram entity) {
		entity = setBasicFieldsInObject(entity);
		if(entity.getId() != null) {
			dao.update(entity);
		}else {
		dao.save(entity);
		}
	}

	private TrgDetailsOfHundredDaysProgram setBasicFieldsInObject(TrgDetailsOfHundredDaysProgram entity) {
		entity.setStateCode(userPreference.getStateCode());
		entity.setUserType(userPreference.getUserType());
		entity.setYearId(userPreference.getFinYearId());
		entity.setCreatedBy(userPreference.getUserId());
		 if(entity.getId() != null) {
			 entity.setLastUpdatedBy(userPreference.getUserId());
		 }
		return entity;
	}

	@Override
	public TrgDetailsOfHundredDaysProgram fetchDetails() {
		Map<String, Object> param=new HashMap<String, Object>();
		param.put("stateCode", userPreference.getStateCode());
		param.put("yearId", userPreference.getFinYearId());
		List<TrgDetailsOfHundredDaysProgram> details = dao.findAll("FETCH_DETAILS", param);
		if(!details.isEmpty()) {
			return details.get(0);
		}else {
			return null;
		}
	}
}
