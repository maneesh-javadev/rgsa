package gov.in.rgsa.service;

import java.util.List;
import java.util.Map;

import gov.in.rgsa.dto.IsFreezeStatusDto;
import gov.in.rgsa.entity.PlanSubcomponents;
import gov.in.rgsa.entity.StatePlanComponentsFunds;
import gov.in.rgsa.model.FacadeModel;
import gov.in.rgsa.user.preference.UserPreference;	

/**
 *
 * @author ANJIT
 */

public interface FacadeService {

	public UserPreference findUser(FacadeModel model);

	public void forwardPlans();
	
	public int findVisitorCount() ;
	
	public String getPlanStatusName();
	
	public void populateStateFunds(String subcomponentIds);
	
	public List<PlanSubcomponents> getPlanSubComponents() ;
	
	public List<StatePlanComponentsFunds> fetchFundDetailsByUserType(Map<String, Object> parameter );
	
	public boolean populateFundbyUserType(String componentIds);

	public UserPreference changeAccToNewFinYearId(UserPreference _userPreference, String finYearId);
	
	public List<IsFreezeStatusDto> fetchFormsIsFreezeStatus(Integer stateCode);

}
