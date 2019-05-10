package gov.in.rgsa.service;

import java.util.List;

import gov.in.rgsa.dto.EEnablementReportDto;
import gov.in.rgsa.entity.EEnablemenEntity;
import gov.in.rgsa.entity.EEnablement;
import gov.in.rgsa.entity.EEnablementDetails;
import gov.in.rgsa.entity.EEnablementGPs;
import gov.in.rgsa.entity.EEnablementMaster;
import gov.in.rgsa.entity.QprEnablementDetails;
import gov.in.rgsa.model.Response;

public interface EEnablementOfPanchayatService {

	public List<EEnablementMaster> fetchEEnablementMaster();

	public void saveEEnablement(EEnablement enablement);

	public List<EEnablement> fetchEnablement(final Character userType);

	public List<EEnablementDetails> fetchEnablementDetails(Integer geteEnablementId);

	public List<EEnablemenEntity> fetchEEnablemenEntityDetails();
	
	public Response saveEnablemenGPs(List<EEnablementGPs> EEnablementGPsList); 
	
	public List<EEnablementGPs> fetchCapacityBuildingActivityGPsList(Integer eEnablementGpsId);

	public List<EEnablement> getApprovedEEnablement();

	public List<EEnablementReportDto> getEEnablementReportDto(int district);

	public List<QprEnablementDetails> getEEnablementReport(int localbodyCode, Integer qprEEnablementId);
	
	public List<EEnablemenEntity> fetchEEnablemenEntityDetailsCEC();

	public List<QprEnablementDetails> getEnablementQprActBasedOnActIdAndQtrId(Integer geteEnablementId, int quarterId);

}
