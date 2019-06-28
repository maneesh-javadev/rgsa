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
import gov.in.rgsa.entity.TrgOfHundredDaysProgramCh1;
import gov.in.rgsa.entity.TrgOfHundredDaysProgramCh2;
import gov.in.rgsa.service.HundredDayTrainingDetailsService;
import gov.in.rgsa.user.preference.UserPreference;

@Service
public class HundredDayTrainingDetailsServiceImpl implements HundredDayTrainingDetailsService {

	@Autowired
	private CommonRepository dao;
	
	@Autowired
	private UserPreference userPreference;
	
	@Override
	public void saveDeatils(TrgOfHundredDaysProgramCh2 entity) {
		entity = setBasicFieldsInObject(entity);
		/*
		 * List<TrgDetailsOfHundredDaysProgram>
		 * details=entity.getTrgDetailsOfHundredDaysProgram();
		 * for(TrgDetailsOfHundredDaysProgram detail : details) {
		 * detail.setTrgOfHundredDaysProgram(entity); }
		 * entity.setTrgDetailsOfHundredDaysProgram(details);
		 */
		if (entity.getTrgOfHundredDaysProgramCh2Id() != null) {
			dao.update(entity);
		} else {
			dao.save(entity);
		}
		 
	}

	private TrgOfHundredDaysProgramCh2 setBasicFieldsInObject(TrgOfHundredDaysProgramCh2 entity) {
		
		  entity.setStateCode(userPreference.getStateCode());
		  entity.setUserType(userPreference.getUserType());
		  entity.setYearId(userPreference.getFinYearId());
		  entity.setCreatedBy(userPreference.getUserId());
		  Date originalDate = null;
		  DateFormat date = new SimpleDateFormat("dd-MM-yyyy");
		  try {
				originalDate = date.parse(entity.getDemoDate());
			} catch (ParseException e) {
				e.printStackTrace();
			}
		  entity.setTrgDate(originalDate);
			if (entity.getMsg().equalsIgnoreCase("freeze")) {
				entity.setIsFreeze(true);
			} else {
				entity.setIsFreeze(false);
			}
			if (entity.getTrgOfHundredDaysProgramCh2Id() != null) {
				entity.setLastUpdatedBy(userPreference.getUserId());
			}
		/*}catch (ParseException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}*/
		return entity;
	}

	@Override
	public TrgOfHundredDaysProgramCh2 fetchLatestData() {
		Map<String, Object> param=new HashMap<String, Object>();
		List<TrgOfHundredDaysProgramCh2> trgOfHundredDaysProgramCh2=new ArrayList<TrgOfHundredDaysProgramCh2>(); 
		param.put("stateCode", userPreference.getStateCode());
		param.put("yearId", userPreference.getFinYearId());
		trgOfHundredDaysProgramCh2=dao.findAll("FETCH_TRG_OF_100_LATEST", param);
		if(CollectionUtils.isNotEmpty(trgOfHundredDaysProgramCh2)) {
			return trgOfHundredDaysProgramCh2.get(0);
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
	public TrgOfHundredDaysProgramCh2 fetchTrgOfHundredDaysProgramByDate(TrgOfHundredDaysProgramCh2 form) {
		Map<String, Object> param=new HashMap<String, Object>();
		List<TrgOfHundredDaysProgramCh2> trgOfHundredDaysProgramCh2=new ArrayList<TrgOfHundredDaysProgramCh2>(); 
		param.put("stateCode", userPreference.getStateCode());
		param.put("yearId", userPreference.getFinYearId());
		param.put("trgDate", form.getTrgDate());
		trgOfHundredDaysProgramCh2 = dao.findAll("FETCH_TRG_100_DAYS_CH2", param);
		if(CollectionUtils.isNotEmpty(trgOfHundredDaysProgramCh2)) {
			return trgOfHundredDaysProgramCh2.get(0);
		}else {
			return null;
		}
	}

	@Override
	public TrgOfHundredDaysProgramCh1 fetchTrgOfHundredDaysProgram() {
		// TODO Auto-generated method stub
		return null;
	}

	
	
}
