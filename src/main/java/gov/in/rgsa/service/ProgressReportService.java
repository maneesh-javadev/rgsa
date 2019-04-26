package gov.in.rgsa.service;

import java.util.List;
import gov.in.rgsa.entity.QprIncomeEnhancement;
import gov.in.rgsa.entity.QprInnovativeActivity;
import gov.in.rgsa.dto.SubcomponentwiseQuaterBalance;
import gov.in.rgsa.entity.AdditionalFacultyProgress;
import gov.in.rgsa.entity.AdministrativeTechnicalProgress;
import gov.in.rgsa.entity.IecQuater;
import gov.in.rgsa.entity.InstInfraStatus;
import gov.in.rgsa.entity.InstitutionalInfraActivityPlanProgress;
import gov.in.rgsa.entity.PmuProgress;
import gov.in.rgsa.entity.QprAdminAndFinancialDataActivity;
import gov.in.rgsa.entity.QprCbActivity;
import gov.in.rgsa.entity.QprEnablement;
import gov.in.rgsa.entity.QprEnablementDetails;
import gov.in.rgsa.entity.QuarterDuration;
import gov.in.rgsa.entity.QuaterWiseFund;
import gov.in.rgsa.entity.StateAllocation;
import gov.in.rgsa.entity.TrainingProgressReport;


public interface ProgressReportService {

	public List<QuarterDuration> getQuarterDurations();
	
	public void saveTrainingProgressData(TrainingProgressReport trainingProgressReport);
	
	public TrainingProgressReport fetchprogressReport(List<Integer> activityDetailsId, int activityId, int quarterId);

	public TrainingProgressReport fetchprogressReportToGeReportId(int activityId);
	
    public void saveadministrativeTechnicalProgress(AdministrativeTechnicalProgress administrativeTechnicalProgress);
	
	public AdministrativeTechnicalProgress fetchAdministrativeReportToGeReportId1(int administrativeTechnicalSupportId);

	public AdministrativeTechnicalProgress fetchAdministrativeTechnicalProgress(int administrativeTechnicalSupportId, int quarterId);

	public AdditionalFacultyProgress fetchAdditionalFacultyProgressToGeReportId1(int instituteInfraHrActivityId);

	public AdditionalFacultyProgress fetchAdditionalFacultyProgress(int instituteInfraHrActivityId, int quarterId);

	public void saveAdditionalFacultyProgress(AdditionalFacultyProgress additionalFacultyProgress);
	
	/*public  InstitutionalInfraActivityPlanProgress fetchInstitutionalInfraActivityPlan(List<Integer> infraActivityDetailId ,int institutionalInfraActivityId ,int quarterId);

	public List<InstInfraStatus> getInstInfraStatus();

	public InstitutionalInfraActivityPlanProgress fetchInstitutionalInfraActivityPlanProgressToGeReportId(int institutionalInfraActivityId);

	public void saveInfraActivity(InstitutionalInfraActivityPlanProgress institutionalInfraActivityPlanProgress);
*/
	public PmuProgress fetchPmu(int pmuActivityId, int quarterId);

	public PmuProgress fetchPmuProgressToGeReportId(int pmuActivityId);

	public void savePmu(PmuProgress pmuProgress);

	public QprEnablement fetchQprEnablement(Integer eEnablementId, int quarterId);

	public QprEnablement fetchEEnablementProgressToGeReportId1(Integer id);

	public void saveQprIncomeEnhancement(QprIncomeEnhancement qprIncomeEnhancement);
	
	public QprIncomeEnhancement fetchQprIncmEnhncmnt(int quarterId);

	public void FrzUnfrzIncomeEnhancmnt(QprIncomeEnhancement qprIncomeEnhancement);

	public IecQuater getfetchIecQuaterProgressReportToGeReportId(Integer id);

	public IecQuater getSatcomProgress(Integer id, int quarterId);

	public void saveIec(IecQuater iecQuater);

	public void saveEnablement(QprEnablement qprEnablement);
	
	public QprCbActivity fetchQprCapcityBuilding(Integer showQqrtrId);

	public void saveQprCbActivity(QprCbActivity qprCbActivity);

	public QprInnovativeActivity getInnovative(Integer id, int quarterId);

	public void saveInnovative(QprInnovativeActivity qprInnovativeActivity);

	public QprInnovativeActivity getfetchInnovativeProgressReportToGeReportId(Integer id);

	public QprAdminAndFinancialDataActivity fetchQprAdminFin(int activityId, int quarterId);

	public void saveAdminDataFinQuaterly(QprAdminAndFinancialDataActivity qprAdminAndFinancialDataActivity);
	
	public List<StateAllocation> fetchStateAllocationData(int componentId, int subCompnentId, int installmentNo);

	public Boolean saveQprWiseFundData(int stateCode,int yearId,int quatorId,int componentId);

	public List<QuaterWiseFund> fetchQuaterWiseFundData(Integer stateCode, int quarterId, int componentId);

	public List<QprEnablementDetails> fetchQprEnablementDetails(Integer qprEEnablementId);

	public List<QuaterWiseFund> fetchTotalQuaterWiseFundData(Integer stateCode, int componentId);

	public List<StateAllocation> fetchStateAllocationDataByCompIdandInstallNo(int componentId, int installmentNo);
	
	public List<SubcomponentwiseQuaterBalance> fetchSubcomponentwiseQuaterBalance(Integer componentId,Integer quaterId);

}
