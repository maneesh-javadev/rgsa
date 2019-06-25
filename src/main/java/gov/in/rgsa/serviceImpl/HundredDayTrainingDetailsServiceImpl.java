package gov.in.rgsa.serviceImpl;

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.collections.CollectionUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import gov.in.rgsa.dao.CommonRepository;
import gov.in.rgsa.entity.TrgDetailsOfHundredDaysProgram;
import gov.in.rgsa.entity.TrgOfHundredDaysProgram;
import gov.in.rgsa.entity.TrgOfHundredDaysProgramCh1;
import gov.in.rgsa.model.HundredDayTrainingDetailModel;
import gov.in.rgsa.service.HundredDayTrainingDetailsService;
import gov.in.rgsa.user.preference.UserPreference;

@Service
public class HundredDayTrainingDetailsServiceImpl implements HundredDayTrainingDetailsService {

	@Autowired
	private CommonRepository dao;
	
	@Autowired
	private UserPreference userPreference;
	
	@Override
	public void saveDeatils(TrgOfHundredDaysProgramCh1 entity) {
		entity = setBasicFieldsInObject(entity);
		/*
		 * List<TrgDetailsOfHundredDaysProgram>
		 * details=entity.getTrgDetailsOfHundredDaysProgram();
		 * for(TrgDetailsOfHundredDaysProgram detail : details) {
		 * detail.setTrgOfHundredDaysProgram(entity); }
		 * entity.setTrgDetailsOfHundredDaysProgram(details);
		 */
		if (entity.getTrgOfHundredDaysProgramChId() != null) {
			dao.update(entity);
		} else {
			dao.save(entity);
		}
		 
	}

	private TrgOfHundredDaysProgramCh1 setBasicFieldsInObject(TrgOfHundredDaysProgramCh1 entity) {
		try {
		  entity.setStateCode(userPreference.getStateCode());
		  entity.setUserType(userPreference.getUserType());
		  entity.setYearId(userPreference.getFinYearId());
		  entity.setCreatedBy(userPreference.getUserId());
		 // Date dateStart = new Date(entity.getDemoStartDate());
		  DateFormat date= new SimpleDateFormat("dd-MM-yyyy");
		  Date sdate;
		 
			sdate = date.parse(entity.getDemoStartDate());
		 Date edate=date.parse(entity.getDemoEndDate());
		  entity.setTrgStartDate(sdate);
		  entity.setTrgEndDate(edate);
			if (entity.getMsg().equalsIgnoreCase("freeze")) {
				entity.setIsFreeze(true);
			} else {
				entity.setIsFreeze(false);
			}
			if (entity.getTrgOfHundredDaysProgramChId() != null) {
				entity.setLastUpdatedBy(userPreference.getUserId());
			}
		}catch (ParseException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		return entity;
	}

	@Override
	public TrgOfHundredDaysProgramCh1 fetchTrgOfHundredDaysProgram() {
		Map<String, Object> param=new HashMap<String, Object>();
		List<TrgOfHundredDaysProgramCh1> trgOfHundredDaysProgramCh1=new ArrayList<TrgOfHundredDaysProgramCh1>(); 
		param.put("stateCode", userPreference.getStateCode());
		param.put("yearId", userPreference.getFinYearId());
		trgOfHundredDaysProgramCh1=dao.findAll("FETCH_TRG_OF_100_CH_DAYS", param);
		if(CollectionUtils.isNotEmpty(trgOfHundredDaysProgramCh1)) {
			return trgOfHundredDaysProgramCh1.get(0);
		}else {
			return null;
		}
	}

	@Override
	public List<TrgDetailsOfHundredDaysProgram> fetchTrgDetailByTrgId(Long trgOfHundredDaysProgramId) {
		Map<String, Object> param=new HashMap<String, Object>();
		param.put("trgOfHundredDaysProgramId", trgOfHundredDaysProgramId);
		return dao.findAll("FETCH_TRG_DETAILS_OF_100_DAYS", param);
	}

	@Override
	public TrgOfHundredDaysProgramCh1 fetchTrgOfHundredDaysProgramByDate(TrgOfHundredDaysProgramCh1 form) {
		Map<String, Object> param=new HashMap<String, Object>();
		List<TrgOfHundredDaysProgramCh1> trgOfHundredDaysProgramCh1=new ArrayList<TrgOfHundredDaysProgramCh1>(); 
		param.put("stateCode", userPreference.getStateCode());
		param.put("yearId", userPreference.getFinYearId());
		param.put("startDate", form.getTrgStartDate());
		//param.put("EndDate", form.getTrgEndDate());
		trgOfHundredDaysProgramCh1 = dao.findAll("FETCH_TRG_OF_100_CH_DAYS_BY_DATE_RANGE", param);
		if(CollectionUtils.isNotEmpty(trgOfHundredDaysProgramCh1)) {
			return trgOfHundredDaysProgramCh1.get(0);
		}else {
			return null;
		}
	}
	
}
