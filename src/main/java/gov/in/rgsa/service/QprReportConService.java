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
}
