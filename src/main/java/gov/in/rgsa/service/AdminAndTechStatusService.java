package gov.in.rgsa.service;

import gov.in.rgsa.entity.AdministrativeAndTechnicalStaffStatus;

public interface AdminAndTechStatusService {

	public AdministrativeAndTechnicalStaffStatus fetchAdministrativeTechnicalSupport();
	
	public void saveAdminAndTechnicalStaffStatusAndDetails(final AdministrativeAndTechnicalStaffStatus administrativeAndTechnicalStaffStatus);

	public AdministrativeAndTechnicalStaffStatus freezUnFreezAdminAndTechStaffStatus(
			AdministrativeAndTechnicalStaffStatus administrativeAndTechnicalStaffStatus);
	
}
