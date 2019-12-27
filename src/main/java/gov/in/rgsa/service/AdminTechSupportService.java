package gov.in.rgsa.service;

import java.util.List;

import gov.in.rgsa.entity.AdministrativeTechnicalDetailProgress;
import gov.in.rgsa.entity.AdministrativeTechnicalSupport;
import gov.in.rgsa.entity.PostLevel;
import gov.in.rgsa.entity.PostType;

public interface AdminTechSupportService {

	public List<PostType> getTypeOfPost();
	
	public void saveAdminTechSupportDetails(AdministrativeTechnicalSupport technicalSupport);
	
	public AdministrativeTechnicalSupport fetchAdministrativeTechnicalSupport(final String userType);
	
	public List<PostLevel> fetchAdministrativeLevel();

	public List<AdministrativeTechnicalSupport> getApprovedSatcomActivity();

	public void freezeAndUnfreeze(AdministrativeTechnicalSupport administrativeTechnicalSupport);

	public List<AdministrativeTechnicalDetailProgress> getadminTechProgressActBasedOnActIdAndQtrId(
			Integer administrativeTechnicalSupportId, int quarterId);
	
	public Integer getExpenditureDetailsOfQpr(
			Integer administrativeTechnicalSupportId, int quarterId);
}
	