package gov.in.rgsa.serviceImpl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.transaction.Transactional;

import org.apache.commons.collections.CollectionUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import gov.in.rgsa.dao.CommonRepository;
import gov.in.rgsa.entity.IecActivity;
import gov.in.rgsa.entity.IecActivityDetails;
import gov.in.rgsa.entity.IecActivityDropedown;
import gov.in.rgsa.service.FacadeService;
import gov.in.rgsa.service.IecService;
import gov.in.rgsa.user.preference.UserPreference;

@Service
@Transactional
public class IecServiceImpl implements IecService {

	@Autowired
	private CommonRepository dao;

	@Autowired
	public UserPreference userPreference;

	@Autowired
	private CommonRepository commonRepository;

	@PersistenceContext
	private EntityManager entityManager;
	

	@Autowired
	private FacadeService facadeService;

	public List<IecActivityDropedown> findAllActivityById() {
		return dao.findAll("FIND_IEC_ID", null);
	}

	@Override
	public void save(final IecActivity iecActivity) {

		if (userPreference.getUserType().equalsIgnoreCase('s' + "")) {
			saveIecForState(iecActivity);
		} else {
			if (iecActivity.getUserType().equalsIgnoreCase("S")) {
				saveIecForMopr(iecActivity);

			} else {
				List<IecActivityDetails> iecActivityDetail = iecActivity.getIecActivityDetails();
				iecActivity.setCreatedBy(userPreference.getUserId());
				iecActivity.setStateCode(userPreference.getStateCode());
				iecActivity.setYearId(userPreference.getFinYearId());
				iecActivity.setUserType(userPreference.getUserType());
				iecActivity.setIsFreez(false);

				for (IecActivityDetails details : iecActivityDetail) {
					details.setIecActivity(iecActivity);
				}
				commonRepository.update(iecActivity);
			}
		}
		
		
	}

	private void saveIecForMopr(final IecActivity iecActivity) {
		iecActivity.setId(null);
		List<IecActivityDetails> iecActivityDetail = iecActivity.getIecActivityDetails();

		iecActivity.setCreatedBy(userPreference.getUserId());
		iecActivity.setUserType(userPreference.getUserType());
		iecActivity.setStateCode(userPreference.getStateCode());
		iecActivity.setYearId(userPreference.getFinYearId());
		iecActivity.setIsFreez(false);
		for (IecActivityDetails details : iecActivityDetail) {
			details.setIdMain(null);
			details.setIecActivity(iecActivity);
		}
		commonRepository.save(iecActivity);
	}

	private void saveIecForState(final IecActivity iecActivity) {

		List<IecActivityDetails> iecActivityDetail = iecActivity.getIecActivityDetails();
		if (iecActivity.getId() == null || iecActivity.getId() == 0) {

			iecActivity.setCreatedBy(userPreference.getUserId());
			iecActivity.setUserType(userPreference.getUserType());
			iecActivity.setStateCode(userPreference.getStateCode());
			iecActivity.setYearId(userPreference.getFinYearId());
			iecActivity.setIsFreez(false);
			for (IecActivityDetails details : iecActivityDetail) {
				details.setIecActivity(iecActivity);
			}
			commonRepository.save(iecActivity);
		}

		else {
			iecActivity.setCreatedBy(userPreference.getUserId());
			iecActivity.setStateCode(userPreference.getStateCode());
			iecActivity.setYearId(userPreference.getFinYearId());
			iecActivity.setUserType(userPreference.getUserType());
			iecActivity.setIsFreez(false);

			for (IecActivityDetails details : iecActivityDetail) {
				details.setIecActivity(iecActivity);
			}
			commonRepository.update(iecActivity);

		}
	}

	@Override
	public IecActivity fetchIecDetail(final String userType) {
		List<IecActivity> iecActivity = new ArrayList<>();
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("yearId", userPreference.getFinYearId());
		params.put("stateCode", userPreference.getStateCode());

		if (userType == null) {
			params.put("userType", userPreference.getUserType());
		} else {
			params.put("userType", userType);
		}

		iecActivity = commonRepository.findAll("FETCH_Iec_Activity", params);

		if (userPreference.getUserType().equalsIgnoreCase("M") && CollectionUtils.isEmpty(iecActivity)) {
			params.put("userType", "S");
			iecActivity = commonRepository.findAll("FETCH_Iec_Activity", params);
			iecActivity.get(0).setIsFreez(false);
		}
		
		if (userPreference.getUserType().equalsIgnoreCase("C") && CollectionUtils.isEmpty(iecActivity)) {
			params.put("userType", "S");
			iecActivity = commonRepository.findAll("FETCH_Iec_Activity", params);
		}

		if (!CollectionUtils.isEmpty(iecActivity)) {
			return iecActivity.get(0);
		} else {
			return null;
		}
	}

	public void update(IecActivity iecActivity) {

		/*
		 * iecActivity.setCreatedBy(user.getUserId());
		 * iecActivity.setStateCode(user.getStateCode());
		 * iecActivity.setYearId(user.getFinYearId());
		 * commonRepository.update(iecActivity);
		 */

	}

	@Override
	public void delete(int idMain) {
		IecActivity xyz = fetchIecDetail(userPreference.getUserType());
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("idMain", idMain);
		if (xyz.getIecActivityDetails().size() > 1) {
			commonRepository.excuteUpdate("FETCH_Iec_Activity_BY_ID", params);
		} else if (xyz.getIecActivityDetails().size() == 1) {
			commonRepository.excuteUpdate("FETCH_Iec_Activity_BY_ID", params);
			Map<String, Object> param = new HashMap<String, Object>();
			param.put("id", xyz.getId());
			commonRepository.excuteUpdate("REMOVE_Iec_Activity", param);
		}
	}

	@Override
	public void freezeAndUnfreeze(IecActivity iecActivity) {
		List<IecActivityDetails> iecActivityDetail = iecActivity.getIecActivityDetails();
		if (iecActivity.getId() != 0 || iecActivity.getId() != null) {
			iecActivity.setCreatedBy(userPreference.getUserId());
			iecActivity.setStateCode(userPreference.getStateCode());
			iecActivity.setYearId(userPreference.getFinYearId());
			iecActivity.setUserType(userPreference.getUserType());
			for (IecActivityDetails details : iecActivityDetail) {
				details.setIecActivity(iecActivity);
			}
			if (iecActivity.getDbFileName().equals("freeze")) {
				iecActivity.setIsFreez(true);
				
			} else {
				iecActivity.setIsFreez(false);
			}
			commonRepository.update(iecActivity);
		}
		
		if(iecActivity.getIsFreez()) {
			facadeService.populateStateFunds("11");
		}
	}
	@Override
	public List<IecActivity> fetchApprovedIec() {
		Map<String, Object> params=new HashMap<>();
		params.put("stateCode", userPreference.getStateCode());
		params.put("yearId", userPreference.getFinYearId());
		params.put("userType", userPreference.getUserType());
		return commonRepository.findAll("FETCH_IEC_APPROVED_ACTIVITY", params);
}
}