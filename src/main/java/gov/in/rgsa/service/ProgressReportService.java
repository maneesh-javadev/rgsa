package gov.in.rgsa.service;

import java.math.BigDecimal;
import java.math.BigInteger;
import java.util.List;
import java.util.Map;

import gov.in.rgsa.dto.SubcomponentwiseQuaterBalance;
import gov.in.rgsa.entity.*;
import gov.in.rgsa.model.multipart.FileNodeMultipart;

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
	
	public QprIncomeEnhancement fetchQprIncmEnhncmnt(int incomeEnhancementId, int quarterId);

	public void FrzUnfrzIncomeEnhancmnt(QprIncomeEnhancement qprIncomeEnhancement);

	public IecQuater getfetchIecQuaterProgressReportToGeReportId(Integer id);

	public IecQuater getSatcomProgress(Integer id, int quarterId);

	public void saveIec(IecQuater iecQuater);

	public void saveEnablement(QprEnablement qprEnablement);
	
	public QprCbActivity fetchQprCapcityBuilding(Integer cbActivityId,Integer showQqrtrId);

	public void saveQprCbActivity(QprCbActivity qprCbActivity);

	public QprInnovativeActivity getInnovative(Integer id, int quarterId);

	public void saveInnovative(QprInnovativeActivity qprInnovativeActivity);

	public QprInnovativeActivity getfetchInnovativeProgressReportToGeReportId(Integer id);

	public QprAdminAndFinancialDataActivity fetchQprAdminFin(int activityId, int quarterId);

	public void saveAdminDataFinQuaterly(QprAdminAndFinancialDataActivity qprAdminAndFinancialDataActivity);

	public Boolean saveQprWiseFundData(int stateCode,int yearId,int quatorId,int componentId);

	public List<QuaterWiseFund> fetchQuaterWiseFundData(Integer stateCode, int quarterId, int componentId);

	public List<QprEnablementDetails> fetchQprEnablementDetails(Integer qprEEnablementId);

	public List<QuaterWiseFund> fetchTotalQuaterWiseFundData(Integer stateCode, int componentId);

	public List<StateAllocation> fetchStateAllocationData(int componentId, int installmentNo, int planCode);
	
	public List<StateAllocation> fetchStateAllocationData(int componentId, int subComponentId ,int installmentNo, int planCode);

	public List<QprCbActivityDetails> getQprTrainActBasedOnActIdAndQtrId(Integer cbActivityId, int quarterId);

	public List<StateAllocation> fetchStateAllocationDataByCompIdandInstallNo(int componentId, int installmentNo);
	
	public List<SubcomponentwiseQuaterBalance> fetchSubcomponentwiseQuaterBalance(Integer componentId, Integer quaterId);
	
	public void saveInstitutionalInfraProgressReport(QprInstitutionalInfrastructure qprInstitutionalInfrastructure);
	
	public FileNode loadFileNode(FileNode fileNode);

	FileNode getUploadedFile(Integer fileNodeId);
	
    String getBalanceAdditionalReqiurment(Integer componentId,Integer quaterId);
    
     void saveQprPanchayatBhawan(QprPanchayatBhawan qprPanchayatBhawan);
     
     List<District> getDistrictBasedOnPNCHAYATBHAWANnState(Integer activityId);
     
     BigDecimal subTOTALofOTHERQPRPANCHAYATBHAWAN();
     
     Map<String,Object> fetchTrainingDetailsCEC(Integer qtrId);
     
     public void savetrainingProgressReport(QuarterTrainings quarterTrainings);
     
     // newly added function to get plan code
      public int getCurrentPlanCode();
}
