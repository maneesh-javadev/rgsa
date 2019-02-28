package gov.in.rgsa.service;

import java.util.List;

import gov.in.rgsa.entity.AdminAndFinancialDataActivity;
import gov.in.rgsa.entity.AdminFinancialDataCellActivityDetails;

public interface AdminAndFinancialDataCellService {

	public void saveData(AdminAndFinancialDataActivity adminAndFinancialDataActivity);

	public List<AdminAndFinancialDataActivity> fetchAdminAndFinancialActivity(final String userType);

	public List<AdminFinancialDataCellActivityDetails> fetchAdminAndFinancialDetails(Integer adminFinancialDataActivityId);

}
