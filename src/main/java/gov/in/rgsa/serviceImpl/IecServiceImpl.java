package gov.in.rgsa.serviceImpl;

import java.util.*;
import java.util.function.Consumer;
import java.util.stream.Collectors;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.transaction.Transactional;

import gov.in.rgsa.entity.*;
import gov.in.rgsa.model.IecFormModel;
import org.apache.commons.collections.CollectionUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.EnableTransactionManagement;

import gov.in.rgsa.dao.CommonRepository;
import gov.in.rgsa.service.FacadeService;
import gov.in.rgsa.service.IecService;
import gov.in.rgsa.user.preference.UserPreference;

@Service
@EnableTransactionManagement(proxyTargetClass= false)
public class IecServiceImpl implements IecService {

	@Autowired
	public UserPreference userPreference;

	@Autowired
	private CommonRepository commonRepository;
	

	@Autowired
	private FacadeService facadeService;

	/*

	@Override
	public void save(final IecActivity iecActivity) {
		if(userPreference.isState())
			saveIecForState(iecActivity);
		if(userPreference.isMOPR()){
			saveIecForMopr(iecActivity, iecActivityState);
		}

		if (userPreference.getUserType().equalsIgnoreCase('s' + "") || userPreference.getUserType().equalsIgnoreCase("C")) {
			saveIecForState(iecActivity);
		} else {
			if (iecActivity.getUserType().equalsIgnoreCase("S")) {
				saveIecForMopr(iecActivity);

			} else {
				IecActivityDetails iecActivityDetail = iecActivity.getIecActivityDetails();
				iecActivity.setCreatedBy(userPreference.getUserId());
				iecActivity.setStateCode(userPreference.getStateCode());
				iecActivity.setYearId(userPreference.getFinYearId());
				iecActivity.setUserType(userPreference.getUserType());
				iecActivity.setIsFreez(false);
				iecActivityDetail.setIecActivity(iecActivity);
				commonRepository.update(iecActivity);
			}
		}
	}


	private void saveIecForMopr(IecActivity iecActivity) {
		setIecActivity(iecActivity);
		commonRepository.save(iecActivity);
	}

	private void saveIecForState(final IecActivity iecActivity) {

		IecActivityDetails iecActivityDetail = iecActivity.getIecActivityDetails();
		if (iecActivity.getId() == null || iecActivity.getId() == 0) {

			iecActivity.setCreatedBy(userPreference.getUserId());
			iecActivity.setUserType(userPreference.getUserType());
			iecActivity.setStateCode(userPreference.getStateCode());
			iecActivity.setYearId(userPreference.getFinYearId());
			iecActivity.setIsFreez(false);
			iecActivityDetail.setIecActivity(iecActivity);
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
		
		

		if (!CollectionUtils.isEmpty(iecActivity)) {
			return iecActivity.get(0);
		} else {
			return null;
		}
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
		IecActivityDetails iecActivityDetail = iecActivity.getIecActivityDetails();
		if (iecActivity.getId() != 0 || iecActivity.getId() != null) {
			iecActivity.setCreatedBy(userPreference.getUserId());
			iecActivity.setStateCode(userPreference.getStateCode());
			iecActivity.setYearId(userPreference.getFinYearId());
			iecActivity.setUserType(userPreference.getUserType());
			iecActivityDetail.setIecActivity(iecActivity);
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
	*/



	@Override
	public List<IecActivityDropdown> findAllActivityById() {
		return commonRepository.findAll(IecActivityDropdown.class);
		//return dao.findAll("FIND_IEC_ID", null);
	}


	@Override
	public IecActivity fetchIecDetail(String userType){
		Map<String, Object> params = new HashMap<>();
		params.put("stateCode", userPreference.getStateCode());
		params.put("userType", userType);
		params.put("yearId", userPreference.getFinYearId());
		params.put("versionNo", userPreference.getPlanVersion());
		return commonRepository.find(IecActivity.class, params);
	}


	@Override
	public List<IecActivity> fetchApprovedIec() {
		Map<String, Object> params=new HashMap<>();
		params.put("stateCode", userPreference.getStateCode());
		params.put("yearId", userPreference.getFinYearId());
		params.put("userType", Users.getTypeForCEC());
		return commonRepository.findAll("FETCH_IEC_APPROVED_ACTIVITY", params);
	}



	private void setIecActivity(IecActivity iecActivity){
		setIecActivity(iecActivity, userPreference.getStateCode());
	}

	private void setIecActivity(IecActivity iecActivity, Integer stateCode){
		iecActivity.setCreatedBy(userPreference.getUserId());
		iecActivity.setUserType(userPreference.getUserType());
		iecActivity.setStateCode(stateCode);
		iecActivity.setYearId(userPreference.getFinYearId());
		iecActivity.setIsFreez(false);
		iecActivity.setVersionNo(userPreference.getPlanVersion());
		iecActivity.setIsActive(true);
	}

	private void saveForState(IecFormModel iecFormModel){
		IecActivity iecActivity;
		if(iecFormModel.getIecId() == 0 || iecFormModel.getIecId() == null) {
			// Create scenario
			iecActivity = new IecActivity();
			setIecActivity(iecActivity);
			commonRepository.save(iecActivity);
		}else {
			// Modify scenario
			iecActivity = commonRepository.find(IecActivity.class, iecFormModel.getIecId());
			if(iecActivity.getIsFreez())
				throw new RuntimeException("Frozen forms cannot be saved. UnFreeze first.");
		}
		// Now save the details and link
		saveDetailLink(iecFormModel, iecActivity);
	}

	private void saveForMOPRCEC(IecFormModel iecFormModel, String agent){
		IecActivity stateIecActivity = commonRepository.find(IecActivity.class, iecFormModel.getIecId());
		if(stateIecActivity == null) {
			throw new RuntimeException(agent + " can only modify.");
		}
		IecActivity iecActivity;
		if(stateIecActivity.getUserType().equalsIgnoreCase(Users.getTypeForState())) {
			// Creation for MOPR
			iecActivity = new IecActivity();
			setIecActivity(iecActivity, stateIecActivity.getStateCode());
			commonRepository.save(iecActivity);
		} else {
			// Modification for MOPR
			iecActivity = stateIecActivity;
			if(iecActivity.getIsFreez())
				throw new RuntimeException("Frozen forms cannot be saved. UnFreeze first.");
		}
		// Now save the details and link
		saveDetailLink(iecFormModel, iecActivity);
	}

	private void saveDetailLink(IecFormModel iecFormModel, IecActivity iecActivity) {
		IecActivityDetails iecActivityDetails = iecActivity.getIecActivityDetails();

		// Create if doesn't exist
		if(iecActivityDetails == null){
			iecActivityDetails = new IecActivityDetails();
			iecActivityDetails.setIecActivity(iecActivity);
			iecActivityDetails.setIsActive(true);
		}

		// Set amount in both cases
		if(userPreference.getUserType().equalsIgnoreCase("M")) {
			iecActivityDetails.setIsApproved(iecFormModel.getIsApproved());
		}else {
			iecActivityDetails.setIsApproved(false);
		}
		iecActivityDetails.setTotalAmountProposed(iecFormModel.getAmount());
		iecActivityDetails.setRemarks(iecFormModel.getRemarks());
		commonRepository.save(iecActivityDetails);

		// Now update Detail-Dropdown-link
		final IecActivityDetails fIecActivityDetails = iecActivityDetails;
		List<IecDetailsDropdown> dropdownSet = iecActivityDetails.getIecDetailsDropdownSet();
		Set<Integer> previousIds = dropdownSet==null? new HashSet<>(): dropdownSet.stream()
				.map(item -> item.getIecActivityDropdown().getIecId())
				.collect(Collectors.toSet());
		IecFormModel previousFormModel = new IecFormModel();
		previousFormModel.setSelectedIdInteger(previousIds);
		iecFormModel.invokeOnChanges(previousFormModel, addedDropDownId -> {
			IecDetailsDropdown iecDetailsDropdown = new IecDetailsDropdown();
			iecDetailsDropdown.setIecActivityDetails(fIecActivityDetails);
			iecDetailsDropdown.setIecActivityDropdown(commonRepository.find(IecActivityDropdown.class, addedDropDownId));
			commonRepository.save(iecDetailsDropdown);
		}, deletedDropDownId -> {
			Map<String, Object> findParams = new HashMap<>(2);
			findParams.put("iecActivityDropdown", deletedDropDownId);
			findParams.put("iecActivityDetails", fIecActivityDetails.getIdMain());
			IecDetailsDropdown iecDetailsDropdown = commonRepository.find(IecDetailsDropdown.class,findParams);
			if(iecDetailsDropdown != null)
				commonRepository.delete(IecDetailsDropdown.class, iecDetailsDropdown.getIecDetailsDropdownId());
		});
	}

	@Override
	public void save(IecFormModel iecFormModel){

		// If iecFormModel has no drop-downs throw
		if(iecFormModel.getSelectedId().isEmpty())
			throw new RuntimeException("No Activity has been selected please select some.");
		if(userPreference.isState())
			saveForState(iecFormModel);
		if(userPreference.isMOPR())
			saveForMOPRCEC(iecFormModel, "MOPR");
		if(userPreference.isCEC())
			saveForMOPRCEC(iecFormModel, "CEC");
	}

	private IecActivity checkFreezeValidity(IecFormModel iecFormModel, boolean atFreeze) {
		IecActivity iecActivity = commonRepository.find(IecActivity.class, iecFormModel.getIecId());
		if(iecActivity == null)
			throw new RuntimeException("Form doesn't exists for unfreezing");
		if(iecActivity.getIsFreez() != atFreeze)
			throw new RuntimeException("Form already unfreezed");
		return iecActivity;
	}

	@Override
	public void freeze(IecFormModel iecFormModel){
		IecActivity iecActivity = checkFreezeValidity(iecFormModel,false);
		iecActivity.setIsFreez(true);
		commonRepository.save(iecActivity);
		if(iecActivity.getIsFreez()) {
			facadeService.populateStateFunds("11");
		}
	}

	@Override
	public void unfreeze(IecFormModel iecFormModel){
		IecActivity iecActivity = checkFreezeValidity(iecFormModel,true);
		iecActivity.setIsFreez(false);
		commonRepository.save(iecActivity);
	}


	@Override
	public List<IecQuaterDetails> getIecQprActBasedOnActIdAndQtrId(Integer id, int quarterId) {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("id", id);
		params.put("quarterId", quarterId);	
		List<IecQuater> iecQuater= commonRepository.findAll("FETCH_IEC_QPR_ACT_BY_QTR_ID_AND_ACT_ID", params);
		List<IecQuaterDetails> iecQuaterDetails=new ArrayList<>();
		if(CollectionUtils.isNotEmpty(iecQuater)){
			for (IecQuater iec_quater : iecQuater) {
				iecQuaterDetails.add(iec_quater.getIecQuaterDetails());
			}
			return iecQuaterDetails;
		}else{
			return null;
		}
	}


}