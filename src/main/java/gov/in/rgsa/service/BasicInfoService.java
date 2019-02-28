package gov.in.rgsa.service;

import java.util.List;

import gov.in.rgsa.entity.BasicInfo;
import gov.in.rgsa.entity.BasicInfoDefination;
import gov.in.rgsa.entity.FocusArea;
import gov.in.rgsa.model.BasicInfoModel;
import gov.in.rgsa.user.preference.UserPreference;

public interface BasicInfoService {

	public BasicInfoDefination getBasicInfoDefinationDetails(int finYearId,String type);
	public UserPreference save(BasicInfoModel basicInfoModel);
	public BasicInfo getBasicInfoDetails(int finYearId,int stateCode,int basicInfoDefId);
	public List<FocusArea> fetchFocusAreas();
	public BasicInfo findBesicInfo(Integer finYearId,Integer stateCode,Integer basicInfoDefId);
	public void delete(BasicInfoModel info);
	public void freezeBasicInfoDetails(Integer basicInfoId);
	public String fillFirstBasicInfo();
	
}
