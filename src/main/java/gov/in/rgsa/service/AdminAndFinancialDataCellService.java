package gov.in.rgsa.service;

import java.util.List;
import java.util.Map;

import gov.in.rgsa.entity.AdminAndFinancialDataActivity;
import gov.in.rgsa.entity.AdminFinancialDataCellActivityDetails;
import gov.in.rgsa.entity.QprAdminAndFinancialDataActivityDetails;

public interface AdminAndFinancialDataCellService {

	public void saveData(AdminAndFinancialDataActivity adminAndFinancialDataActivity);

	public List<AdminAndFinancialDataActivity> fetchAdminAndFinancialActivity(final String userType);

	public List<AdminFinancialDataCellActivityDetails> fetchAdminAndFinancialDetails(Integer adminFinancialDataActivityId);

	public List<AdminAndFinancialDataActivity> fetchApprovedActivity();

	public List<QprAdminAndFinancialDataActivityDetails> getPmuProgressActBasedOnActIdAndQtrId(
			Integer adminFinancialDataActivityId, int quarterId);

}
