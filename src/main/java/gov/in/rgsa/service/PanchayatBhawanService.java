package gov.in.rgsa.service;

import java.util.List;

import gov.in.rgsa.entity.GPBhawanStatus;
import gov.in.rgsa.dto.GramPanchayatProgressReportDTO;
import gov.in.rgsa.entity.BasicInfoDetails;
import gov.in.rgsa.entity.FinalizeFreezeStatus;
import gov.in.rgsa.entity.GramPanchayatActivity;
import gov.in.rgsa.entity.PanchatayBhawanActivity;
import gov.in.rgsa.entity.PanchayatBhawanProposedInfo;
import gov.in.rgsa.entity.PanchyatBhawanCurrentStatus;
import gov.in.rgsa.entity.QprPanchayatBhawan;
import gov.in.rgsa.entity.ServiceMaster;
import gov.in.rgsa.model.Response;

public interface PanchayatBhawanService{
	
	public List<GramPanchayatActivity> fetchPanchayatBhawanActivity();
	
	public void savePanchayatBhawanActivity(PanchatayBhawanActivity activity);
	
	public PanchatayBhawanActivity getPanchatayBhawanActivity(String userType);

	public List<ServiceMaster> fetchServicesProvided();

	public void savePanchayatBhawanCsDetails(PanchyatBhawanCurrentStatus bhawanStatus);

	public List<PanchyatBhawanCurrentStatus> fetchPanchyatBhawanCurrentStatusBasedOnLocalBodySelected(List<Long> localbodyList);

	public List<GPBhawanStatus> fetchGPBhawanStatus(Integer panchayatBhawanActvityId);
	
	public BasicInfoDetails findNumberOfPnchayatWithOutBhawanByState(Integer stateCode);

	public List<GramPanchayatProgressReportDTO> fetchGPBhawanData(Integer activityId, Integer districtListId ,Integer panchayatBhawanActivityId);

	public void saveQprPanchayatBhawanData(QprPanchayatBhawan qprPanchayatBhawan);
	
	public Response savePanchayatBhwanFinalizeWorkLocaion(List<PanchayatBhawanProposedInfo> panchayatBhawanProposedInfoList); 
	
	public List<PanchayatBhawanProposedInfo> fetchPanchayatBhawanProposedGPsList(Integer activityDetailsId);

	List<QprPanchayatBhawan> fetchDataAccordingToQuator(Integer quatorId,Integer activityId,Integer districtCode,Integer panchayatBhawanActivityId );
	
	public Integer fetchBasicInfoKeyValue(Integer stateCode,String defination_key);
	
	Response freezeUnfreezeFinalizeWorkLocation(FinalizeFreezeStatus finalizeFreezeStatus);
	
	FinalizeFreezeStatus loadFreezeUnfreezeFinalizeWorkLocation(FinalizeFreezeStatus finalizeFreezeStatus); 
	
	public boolean validateFinalizeWorklocationBasedonQPR(Character finalizeType);
}
