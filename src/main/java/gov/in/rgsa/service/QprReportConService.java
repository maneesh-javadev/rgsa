package gov.in.rgsa.service;

import java.util.List;

import gov.in.rgsa.entity.FinYear;
import gov.in.rgsa.entity.QuarterDuration;
import gov.in.rgsa.entity.State;

public interface QprReportConService
{
	public List<FinYear> fetchFinYearList();

	public List<State> fetchStateList();

	public List<QuarterDuration> fetchQuarterList();

	public List fetchTrainingActivityList(String statecode,String yearId,String UserType,String quarterId);
	
	public List fetchQprTrainingDetails(String statecode,String yearId,String UserType,String quarterId) ;
	
	public List fetchQprHRsupportSprcDprc(String statecode,String yearId,String UserType,String quarterId);
	
	public List fetchQprEgovProgressReport(String statecode,String yearId,String UserType,String quarterId);
	
	public List fetchQprEenablementProgressReport(String statecode,String yearId,String UserType,String quarterId);
	
	public List fetchQprPesaReport(String statecode,String yearId,String UserType,String quarterId);
	
	public List fetchQprIncomeEnhancement(String statecode,String yearId,String UserType,String quarterId);
	
	public List fetchQprIEC(String statecode,String yearId,String UserType,String quarterId);
	
	public List fetchQprPMU(String statecode,String yearId,String UserType,String quarterId);
	
	public List fetchQprPanchayatBhawan(String statecode,String yearId,String UserType,String quarterId);
	
	public List fetchQprAdministrativeAndTechnicalSupport(String statecode,String yearId,String UserType,String quarterId);
	
	public List fetchQprSATCOM(String statecode,String yearId,String UserType,String quarterId);
	
	public List fetchQprInstitutionalInfrastructure(String statecode,String yearId,String UserType,String quarterId);
	
	public List fetchQprInnovativeActive(String statecode,String yearId,String UserType,String quarterId) ;
	
	public List fetchQpradminFinancial(String statecode,String yearId,String UserType,String quarterId) ;
	
	List<FinYear> fetchTwoFinYear();
	
	//Added by Sushma Singh for New Report
	
	public List fetchTrainingActivityListYearWiseNew(String statecode, String yearId, String UserType, String quarterId);
	
	public List fetchQprTrainingDetailsYearWiseNew(String statecode, String yearId, String UserType, String quarterId);
	
	public List fetchQprHRsupportSprcDprcYearWiseNew(String statecode, String yearId, String UserType, String quarterId);

	public List fetchQprEgovProgressReportYearWiseNew(String statecode, String yearId, String UserType, String quarterId);

	public List fetchQprEenablementProgressReportYearWiseNew(String statecode, String yearId, String UserType, String quarterId);

	public List fetchQprPesaReportYearWiseNew(String statecode, String yearId, String UserType, String quarterId);

	public List fetchQprIncomeEnhancementYearWiseNew(String statecode, String yearId, String UserType, String quarterId);

	public List fetchQprIECYearWiseNew(String statecode, String yearId, String UserType, String quarterId);

	public List fetchQprPMUYearWiseNew(String statecode, String yearId, String UserType, String quarterId);

	public List fetchQprAdministrativeAndTechnicalSupportYearWiseNew(String statecode, String yearId, String UserType, String quarterId);

	public List fetchQprPanchayatBhawanYearWiseNew(String statecode, String yearId, String UserType, String quarterId);

	public List fetchQprSATCOMYearWiseNew(String statecode, String yearId, String UserType, String quarterId);

	public List fetchQprInstitutionalInfrastructureYearWiseNew(String statecode, String yearId, String UserType, String quarterId);

	public List fetchQprInnovativeActiveYearWiseNew(String statecode, String yearId, String UserType, String quarterId);

	public List fetchQpradminFinancialYearWiseNew(String statecode, String yearId, String UserType, String quarterId);

	
	
	
	
	
	
	
}






