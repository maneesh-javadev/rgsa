package gov.in.rgsa.service;

import java.util.List;

import gov.in.rgsa.entity.Block;
import gov.in.rgsa.entity.District;
import gov.in.rgsa.entity.GramPanchayat;
import gov.in.rgsa.entity.LocalGovTierSetup;
import gov.in.rgsa.entity.State;

public interface LGDService {
	
	public List<State> getAllStateList();
	
	public State getStateDetailsByCode(Integer stateCode);
	
	public List<District> getAllDistrictBasedOnState(Integer stateCode);
	
	public District getDistrictDetails(Integer stateCode, Integer districtCode);
	
	public List<Block> getAllBlockBasedOnDistrict(Integer districtCode);
	
	public List<LocalGovTierSetup> getLocalGovTierSetup(Integer stateCode);
	
	public List<GramPanchayat> getGramPanchayatList(int districtCode);

	public List<GramPanchayat> gramPanchayatListBasedOnBlock(int blockCode);

}
