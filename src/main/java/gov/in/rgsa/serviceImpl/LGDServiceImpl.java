package gov.in.rgsa.serviceImpl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import gov.in.rgsa.dao.CommonRepository;
import gov.in.rgsa.entity.Block;
import gov.in.rgsa.entity.District;
import gov.in.rgsa.entity.GramPanchayat;
import gov.in.rgsa.entity.LocalGovTierSetup;
import gov.in.rgsa.entity.State;
import gov.in.rgsa.service.LGDService;

@Service
public class LGDServiceImpl implements LGDService{
	
	@Autowired CommonRepository dao;

	@Override
	public List<State> getAllStateList() {
		
		return dao.findAll("GET_ALL_STATE_LIST", null);
	}

	@Override
	public State getStateDetailsByCode(Integer  stateCode) {
		// TODO Auto-generated method stub
		Map<String, Object> params=new HashMap<String,Object>();
		params.put("id", stateCode);
		return dao.find("FETCH_STATE_BY_CODE", params);
				
	}

	@Override
	public List<District> getAllDistrictBasedOnState(Integer stateCode) {
		// TODO Auto-generated method stub
		Map<String, Object> params=new HashMap<String,Object>();
		params.put("id", stateCode);
		return dao.findAll("DISTRICT_LIST_BY_STATE_CODE", params);
	}

	@Override
	public List<Block> getAllBlockBasedOnDistrict(Integer districtCode) {
		// TODO Auto-generated method stub
		Map<String, Object> params=new HashMap<String,Object>();
		params.put("districtCode", districtCode);
		return dao.findAll("BLOCK_LIST_BY_DISTRICT_CODE", params);
	}

	@Override
	public List<LocalGovTierSetup> getLocalGovTierSetup(Integer stateCode) {
		Map<String, Object> params=new HashMap<String,Object>();
		params.put("id", stateCode);
		return dao.find("LOCAL_GOV_TIER_SETUP_BY_STATE", params);
	}

	@Override
	public List<GramPanchayat> getGramPanchayatList(int districtCode) {
		Map<String, Object> params=new HashMap<String,Object>();
		params.put("districtCode", districtCode);
		return dao.findAll("GRAM_PANCHAYAT_LGD", params);
	}
	
	@Override
	public List<GramPanchayat> gramPanchayatListBasedOnBlock(int blockCode) {
		Map<String, Object> params=new HashMap<String,Object>();
		params.put("blockCode", blockCode);
		return dao.findAll("GRAM_PANCHAYAT_BASED_ON_BLOCK", params);
	}

	//-------------------------method to get the detail of a particular district-----------------------------------------
	@Override
	public District getDistrictDetails(Integer stateCode, Integer districtCode) {
		Map<String, Object> params=new HashMap<String,Object>();
		params.put("id", stateCode);
		params.put("districtCode", districtCode);
		return dao.find("DISTRICT_DETAIL_BY_STATECODE_DISTRICTCODE", params);
	}
	
	

}
