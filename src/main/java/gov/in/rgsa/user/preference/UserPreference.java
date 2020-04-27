package gov.in.rgsa.user.preference;

import java.util.List;

import gov.in.rgsa.utils.PlanUtil;
import org.springframework.context.annotation.Scope;
import org.springframework.context.annotation.ScopedProxyMode;
import org.springframework.stereotype.Component;

import gov.in.rgsa.dto.IsFreezeStatusDto;
import gov.in.rgsa.entity.ActionPlanStatus;
import gov.in.rgsa.entity.FinYear;
import gov.in.rgsa.entity.MenuProfile;
import gov.in.rgsa.entity.PlanComponents;
import gov.in.rgsa.entity.StatePlanComponentsFunds;

/**
 *
 * @author ANJIT
 */
@Component
@Scope(value = "session", proxyMode = ScopedProxyMode.TARGET_CLASS)
public class UserPreference {

	private Integer userId;
	private String userName;
	private Integer stateCode;
	private Integer districtcode;
	private String userType;
	private List<MenuProfile> menus;
	private String finYear;
	private Integer finYearId;
	private Integer menuId;
	private List<ActionPlanStatus> activityPlanStatus;
	private Integer planCode;
	private Integer planVersion;
	private Integer planStatus;
	private Boolean isNodalFilled=false; // added by aashish barua to check whether nodal officer is filled or not
	
	private List<PlanComponents> planComponents;
	
	private List<StatePlanComponentsFunds> statePlanComponentsFunds;
	
	private List<IsFreezeStatusDto> isFreezeStatusList;
	
	private long countPlanSubmittedByState;
	
	private long countPlanSubmittedByMOPR;
	
	private long countPlanApprovedByCec;
	
	private List<FinYear> finYearList; // added by aashish barua
	
	private boolean plansAreFreezed;
	
	public Integer getUserId() {
		return userId;
	}

	public void setUserId(Integer userId) {
		this.userId = userId;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public Integer getStateCode() {
		return stateCode;
	}

	public void setStateCode(Integer stateCode) {
		this.stateCode = stateCode;
	}

	public Integer getDistrictcode() {
		return districtcode;
	}

	public void setDistrictcode(Integer districtcode) {
		this.districtcode = districtcode;
	}

	public String getUserType() {
		return userType;
	}

	public void setUserType(String userType) {
		this.userType = userType;
	}

	public List<MenuProfile> getMenus() {
		return menus;
	}

	public void setMenus(List<MenuProfile> menus) {
		this.menus = menus;
	}

	public String getFinYear() {
		return finYear;
	}

	public void setFinYear(String finYear) {
		this.finYear = finYear;
	}

	public Integer getFinYearId() {
		return finYearId;
	}

	public void setFinYearId(Integer finYearId) {
		this.finYearId = finYearId;
	}

	
	
	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((userId == null) ? 0 : userId.hashCode());
		return result;
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		UserPreference other = (UserPreference) obj;
		if (userId == null) {
			if (other.userId != null)
				return false;
		} else if (!userId.equals(other.userId))
			return false;
		return true;
	}

	public Integer getMenuId() {
		return menuId;
	}

	public void setMenuId(Integer menuId) {
		this.menuId = menuId;
	}

	public List<ActionPlanStatus> getActivityPlanStatus() {
		return activityPlanStatus;
	}

	public void setActivityPlanStatus(List<ActionPlanStatus> activityPlanStatus) {
		this.activityPlanStatus = activityPlanStatus;
	}

	public List<PlanComponents> getPlanComponents() {
		return planComponents;
	}

	public void setPlanComponents(List<PlanComponents> planComponents) {
		this.planComponents = planComponents;
	}

	public boolean isPlansAreFreezed() {
		return plansAreFreezed;
	}

	public void setPlansAreFreezed(boolean plansAreFreezed) {
		this.plansAreFreezed = plansAreFreezed;
	}

	public long getCountPlanSubmittedByState() {
		return countPlanSubmittedByState;
	}

	public void setCountPlanSubmittedByState(long countPlanSubmittedByState) {
		this.countPlanSubmittedByState = countPlanSubmittedByState;
	}

	public long getCountPlanSubmittedByMOPR() {
		return countPlanSubmittedByMOPR;
	}

	public void setCountPlanSubmittedByMOPR(long countPlanSubmittedByMOPR) {
		this.countPlanSubmittedByMOPR = countPlanSubmittedByMOPR;
	}

	public List<StatePlanComponentsFunds> getStatePlanComponentsFunds() {
		return statePlanComponentsFunds;
	}

	public void setStatePlanComponentsFunds(List<StatePlanComponentsFunds> statePlanComponentsFunds) {
		this.statePlanComponentsFunds = statePlanComponentsFunds;
	}

	public Integer getPlanCode() {
		return planCode;
	}

	public void setPlanCode(Integer planCode) {
		this.planCode = planCode;
	}

	public Integer getPlanVersion() {
		return planVersion;
	}

	public void setPlanVersion(Integer planVersion) {
		this.planVersion = planVersion;
	}

	public Integer getPlanStatus() {
		return planStatus;
	}

	public void setPlanStatus(Integer planStatus) {
		this.planStatus = planStatus;
	}

	public boolean isState(){
		return getUserType().equalsIgnoreCase("S");
	}

	public boolean isMOPR(){
		return getUserType().equalsIgnoreCase("M");
	}

	public boolean isCEC(){
		return getUserType().equalsIgnoreCase("C");
	}

	public PlanUtil getPlanStatusEnum() {
		return new PlanUtil(getPlanStatus());
	}

	public List<FinYear> getFinYearList() {
		return finYearList;
	}

	public void setFinYearList(List<FinYear> finYearList) {
		this.finYearList = finYearList;
	}

	public Boolean getIsNodalFilled() {
		return isNodalFilled;
	}

	public void setIsNodalFilled(Boolean isNodalFilled) {
		this.isNodalFilled = isNodalFilled;
	}

	public List<IsFreezeStatusDto> getIsFreezeStatusList() {
		return isFreezeStatusList;
	}

	public void setIsFreezeStatusList(List<IsFreezeStatusDto> isFreezeStatusList) {
		this.isFreezeStatusList = isFreezeStatusList;
	}

	public long getCountPlanApprovedByCec()
	{
		return countPlanApprovedByCec;
	}

	public void setCountPlanApprovedByCec(long countPlanApprovedByCec)
	{
		this.countPlanApprovedByCec = countPlanApprovedByCec;
	}
	
	
}
