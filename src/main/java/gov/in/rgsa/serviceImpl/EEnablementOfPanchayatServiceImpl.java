package gov.in.rgsa.serviceImpl;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.apache.commons.collections.CollectionUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import gov.in.rgsa.dao.CommonRepository;
import gov.in.rgsa.dto.EEnablementReportDto;
import gov.in.rgsa.entity.EEnablemenEntity;
import gov.in.rgsa.entity.EEnablement;
import gov.in.rgsa.entity.EEnablementDetails;
import gov.in.rgsa.entity.EEnablementGPs;
import gov.in.rgsa.entity.EEnablementMaster;
import gov.in.rgsa.entity.QprEnablement;
import gov.in.rgsa.entity.QprEnablementDetails;
import gov.in.rgsa.model.Response;
import gov.in.rgsa.service.EEnablementOfPanchayatService;
import gov.in.rgsa.service.FacadeService;
import gov.in.rgsa.user.preference.UserPreference;

@Service
public class EEnablementOfPanchayatServiceImpl implements EEnablementOfPanchayatService {

	@Autowired
	public CommonRepository commonRepository;
	
	@Autowired
	public UserPreference userPreference;
	
	@Autowired
	private FacadeService facadeService;
		

	@Override
	public List<EEnablementMaster> fetchEEnablementMaster() {

		return commonRepository.findAll("FIND_ALL_INFRA_RESOURCES", null);
	}
	
	@Override
	public void saveEEnablement(EEnablement eEnablement)
	{
		if(userPreference.getUserType().equalsIgnoreCase('s'+"") || userPreference.getUserType().equalsIgnoreCase("C")){
			saveEEnablementDetailsForState(eEnablement);
		}else{
			if(eEnablement.getUserType() == 'S'){
				saveEEnablementDetailsForMinistry(eEnablement);
			}else{
					List<EEnablementDetails> eEnablementDetails=eEnablement.geteEnablementDetails();
					for (EEnablementDetails eEnablementDetail : eEnablementDetails) {
						if(eEnablementDetails != null)
							{
								eEnablementDetail.setFund(eEnablementDetail.getNoOfUnit() * eEnablementDetail.getUnitCost());
								eEnablementDetail.seteEnablement(eEnablement);
								
							}
					}
					eEnablement.setCreatedBy(userPreference.getUserId());
					eEnablement.setLastUpdatedBy(userPreference.getUserId());
					eEnablement.setStateCode(userPreference.getStateCode());
					eEnablement.setVersionNo(userPreference.getPlanVersion());
					eEnablement.setYearId(userPreference.getFinYearId());
					eEnablement.setIsActive(Boolean.TRUE);
					commonRepository.update(eEnablement);
				
				}
			}
				if(eEnablement.getStatus()!=null && eEnablement.getStatus().length()>0 && eEnablement.getStatus().charAt(0)=='f') {
						facadeService.populateStateFunds("5");
				}
		
			}
	
	private void saveEEnablementDetailsForMinistry(EEnablement eEnablement){
		//support id null
		eEnablement.seteEnablementId(null);
		List<EEnablementDetails> eEnablementDetails=eEnablement.geteEnablementDetails();
		EEnablement eEnablement1=eEnablement;
		eEnablement1.setStateCode(userPreference.getStateCode());
		eEnablement1.setYearId(userPreference.getFinYearId());
		eEnablement1.setVersionNo(userPreference.getPlanVersion());
		eEnablement1.setIsActive(Boolean.TRUE);
		eEnablement1.setUserType(userPreference.getUserType().charAt(0));
		eEnablement1.setCreatedBy(userPreference.getUserId());
		eEnablement1.setLastUpdatedBy(userPreference.getUserId());
		
		for (EEnablementDetails eEnablementDetail : eEnablementDetails) {
			if(eEnablementDetail != null)
				{
					eEnablementDetail.seteEnablementDetailId(null);
					eEnablementDetail.setFund(eEnablementDetail.getNoOfUnit() * eEnablementDetail.getUnitCost());
					eEnablementDetail.seteEnablement(eEnablement);
					
				}
			
		}
		commonRepository.save(eEnablement1);
	}
	
	private void saveEEnablementDetailsForState(EEnablement eEnablement){
		List<EEnablementDetails> eenablementDetails= eEnablement.geteEnablementDetails();
		
		if(eEnablement.geteEnablementId() == null) {
			
			EEnablement eenablement=new EEnablement();
			eenablement.setStateCode(userPreference.getStateCode());
			eenablement.setYearId(userPreference.getFinYearId());
			eenablement.setCreatedBy(userPreference.getUserId());
			eenablement.setUserType(userPreference.getUserType().charAt(0));
			eenablement.setLastUpdatedBy(userPreference.getUserId());
			eenablement.setVersionNo(userPreference.getPlanVersion());
			eenablement.setIsActive(Boolean.TRUE);
			eenablement.setStatus("s");
			eenablement.setLastUpdatedOn(new Date());
			eenablement.setAdditionalRequirement(eEnablement.getAdditionalRequirement());
			commonRepository.save(eenablement);
			
		for (EEnablementDetails eEnablementDetail : eenablementDetails) {
			if(eenablementDetails != null)
				{
					eEnablementDetail.setFund(eEnablementDetail.getNoOfUnit() * eEnablementDetail.getUnitCost());
					eEnablementDetail.seteEnablement(eenablement);
					commonRepository.save(eEnablementDetail);
				}
			}
		}
			else {
				EEnablement eenablement = commonRepository.find(EEnablement.class, eEnablement.geteEnablementId());
				eenablement.setAdditionalRequirement(eEnablement.getAdditionalRequirement());
				eenablement.setLastUpdatedOn(new Date());
				eenablement.setStatus(eEnablement.getStatus());
				commonRepository.update(eenablement);
				for(EEnablementDetails eeEnablementDetail : eenablementDetails )
				{
					eeEnablementDetail.setFund(eeEnablementDetail.getNoOfUnit() * eeEnablementDetail.getUnitCost());
					eeEnablementDetail.seteEnablement(eenablement);
					commonRepository.update(eeEnablementDetail);
				}
				
			}
	}
	
	@Override
	public List<EEnablement> fetchEnablement(final Character userType) {
		java.util.Map<String, Object> params=new HashMap<String,Object>();
		List<EEnablement> enablement = new ArrayList<EEnablement>();
		if(userType == null){
			params.put("userType", userPreference.getUserType().charAt(0));
		}else{
			params.put("userType", userType);
		}
		params.put("yearId", userPreference.getFinYearId());
		params.put("stateCode", userPreference.getStateCode());
		params.put("versionNo", userPreference.getPlanVersion());
		enablement=commonRepository.findAll("FETCH_ENABLEMENT", params);
		
		if(userPreference.getUserType().equalsIgnoreCase("M") && enablement.size() == 0){
			params.put("userType", 'S');
			enablement=commonRepository.findAll("FETCH_ENABLEMENT", params);
			if(enablement.get(0).getUserType()=='S' && enablement.get(0).getStatus().equalsIgnoreCase("f")){
				enablement.get(0).setStatus("u");
			}
		}
		
		if(!CollectionUtils.isEmpty(enablement) && enablement.size()>0){
			return enablement;
		}
		return null;
	}

	@Override
	public List<EEnablementDetails> fetchEnablementDetails(Integer geteEnablementId) {
		java.util.Map<String, Object> params=new HashMap<String,Object>();
		params.put("eEnablementId", geteEnablementId);
	    return commonRepository.findAll("FETCH_ENABLEMENT_DETAILS", params);
	}
	
	@Override
	public List<EEnablemenEntity> fetchEEnablemenEntityDetails() {
		java.util.Map<String, Object> params=new HashMap<String,Object>();
		params.put("stateCode", userPreference.getStateCode());
		params.put("yearId", userPreference.getFinYearId());
		params.put("userType", userPreference.getUserType());
	    return commonRepository.findAll("FETCH_ENABLEMENT_DETAILS_GPs", params);
	}
	
	@Override
	public Response saveEnablemenGPs(List<EEnablementGPs> EEnablementGPsList) {
		Response response = new Response();
		Integer activityGPsId=null;
		//EntityTransaction tx=entityManager.getTransaction();
		//tx.begin();
		try {
			
			
			Set<Integer> eEnablementDetailId = new HashSet<Integer>();
			for(EEnablementGPs obj:EEnablementGPsList) {
				eEnablementDetailId.add(obj.geteEnablementDetailsId());
			}
			
			Map<String, Object> params=new HashMap<String, Object>() ;  
			params.put("eEnablementDetailId", eEnablementDetailId);
			
			Map<String, Integer> exitingObj=new HashMap<String, Integer>();
			List<EEnablementGPs>  EEnablementGPsListOld= commonRepository.findAll("RESET_Enablement_GP", params);
			if(EEnablementGPsListOld!=null && !EEnablementGPsListOld.isEmpty()) {
				for(EEnablementGPs objold:EEnablementGPsListOld) {
					if(!objold.isIsactive()) {
						exitingObj.put(objold.geteEnablementDetailsId()+"_"+objold.getLocalBodyCode(), objold.geteEnablementGpsId());
					}
					objold.setIsactive(Boolean.FALSE);
					commonRepository.update(objold);
				}
			}
				
			
			
		for(EEnablementGPs obj:EEnablementGPsList) {
			activityGPsId=obj.geteEnablementGpsId();
			if(activityGPsId==null) {
				activityGPsId=exitingObj.get(obj.geteEnablementDetailsId()+"_"+obj.getLocalBodyCode());
			}
			
			
			
			obj.setIsactive(Boolean.TRUE);
			if(activityGPsId!=null) {
				obj.seteEnablementGpsId(activityGPsId);
				commonRepository.update(obj);
			}else {
				commonRepository.save(obj);
			}
		}
		response.setResponseMessage("GP of Training Activity save Successfully");
		response.setResponseCode(200);
		}catch(Exception e) {
			response.setResponseMessage("GP of Training Activity save UnSuccessfully"+e.getMessage());
			response.setResponseCode(500);
		}
		//tx.commit();
		return response;
	}
	
	@Override
	public List<EEnablementGPs> fetchCapacityBuildingActivityGPsList(Integer eEnablementDetailsId){
		Map<String, Object> params=new HashMap<String, Object>();
		params.put("eEnablementDetailsId", eEnablementDetailsId);
		List<EEnablementGPs>  eEnablementGPsList= commonRepository.findAll("FIND_Enablement_GP", params);
		if(eEnablementGPsList!=null && !eEnablementGPsList.isEmpty()) {
			return eEnablementGPsList;
		}
		return null;
	}
	@Override
	public List<EEnablement> getApprovedEEnablement() {
		Map<String,Object> params = new HashMap<>();
		params.put("yearId", userPreference.getFinYearId());
		params.put("stateCode", userPreference.getStateCode());
		params.put("userType", 'C');
		List<EEnablement> eEnablements = commonRepository.findAll("GET_EENABLEMENT_APPROVED_TRAINING", params);
		return eEnablements;
	}
	

	@Override
	public List<EEnablementReportDto> getEEnablementReportDto(int district) {
		Map<String,Object> params = new HashMap<>();
		params.put("districtCode", district);
		List<EEnablementReportDto> eEnablementReportDto = commonRepository.findAll("FETCH_EEnablement_REPORT_DETAILS", params);
		return eEnablementReportDto;
	}

	@Override
	public List<QprEnablementDetails> getEEnablementReport(int localbodyCode, Integer qprEEnablementId) {
		Map<String,Object> params = new HashMap<>();
		params.put("localbodyCode", localbodyCode);
		params.put("qprEEnablementId", qprEEnablementId);
		List<QprEnablementDetails> qprEnablementDetails = commonRepository.findAll("FETCH_EENABLEMENT_REPORT_DETAILS_BY_LB", params);
		
		return qprEnablementDetails;
	}

	
	@Override
	public List<EEnablemenEntity> fetchEEnablemenEntityDetailsCEC() {
		java.util.Map<String, Object> params=new HashMap<String,Object>();
		params.put("stateCode", userPreference.getStateCode());
		params.put("yearId", userPreference.getFinYearId());
		params.put("userType", "C");
	    return commonRepository.findAll("FETCH_ENABLEMENT_DETAILS_GPs", params);
	}

	@Override
	public List<QprEnablementDetails> getEnablementQprActBasedOnActIdAndQtrId(Integer eEnablementId, int quarterId) {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("eEnablementId", eEnablementId);
		params.put("quarterId", quarterId);	
		List<QprEnablement> qprEnablement= commonRepository.findAll("FETCH_ENABLEMENT_QPR_ACT_BY_QTR_ID_AND_ACT_ID", params);
		List<QprEnablementDetails> qprEnablementDetails=new ArrayList<>();
		if(CollectionUtils.isNotEmpty(qprEnablement)){
			for (QprEnablement qpr_enablement : qprEnablement) {
				qprEnablementDetails.addAll(qpr_enablement.getQprEnablementDetails());
			}
			return qprEnablementDetails;
		}else{
			return null;
		}
	}
	}


