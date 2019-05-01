package gov.in.rgsa.service;

import java.util.List;

import gov.in.rgsa.dto.InstitutionalInfraProgressReportDTO;
import gov.in.rgsa.entity.InstInfraStatus;
import gov.in.rgsa.entity.InstitutionalInfraActivityPlan;
import gov.in.rgsa.entity.InstitutionalInfraActivityPlanDetails;
import gov.in.rgsa.entity.QprInstitutionalInfraDetails;
import gov.in.rgsa.entity.QprInstitutionalInfrastructure;
import gov.in.rgsa.entity.TrainingInstitueType;

/**
 *
 * @author ANJIT
 */

public interface InstitutionalInfraActivityPlanService {
	
	public void saveInstitutionalInfraActivityPlanDetails(InstitutionalInfraActivityPlan institutionalInfraActivityPlan,Integer instituteType,String updateStatus);

	public List<InstitutionalInfraActivityPlan> fetchInstitutionalInfraActivity(String userType);

	public List<InstitutionalInfraActivityPlanDetails> fetchInstitutionalInfraActivityDetails(InstitutionalInfraActivityPlan institutionalInfraActivityPlan,Integer institutionalInfraActivityId, Integer instituteType);

	public InstitutionalInfraActivityPlan feezUnFreezInstitutionalInfraActivityPlan(InstitutionalInfraActivityPlan institutionalInfraActivityPlan);

	public List<TrainingInstitueType> fetchTrainingInstituteType();

	public List<InstitutionalInfraActivityPlanDetails> fetchAllDetails(Integer institutionalInfraActivityId);

	public List<InstitutionalInfraProgressReportDTO> fetchInstInfraStateDataForProgressReport();

	public List<InstInfraStatus> fetchInstInfraStatus(Integer trainingInstituteTypeId);

	public void saveQprInstInfraData(QprInstitutionalInfrastructure qprInstitutionalInfrastructure);

	public List<QprInstitutionalInfrastructure> fetchDataAccordingToQuator(Integer quatorId,Integer activityId);

	public List<QprInstitutionalInfraDetails> fetchDataOfDetailAccordingToQuator(int trainingInstituteTypeId,int qprInstInfraId);

	public InstitutionalInfraActivityPlan saveCecData(InstitutionalInfraActivityPlan institutionalInfraActivityPlan);

	public List<TrainingInstitueType> fetchTrainingInstituteTypeId();
	
	public void saveInstitutionalInfra(InstitutionalInfraActivityPlan institutionalInfraActivityPlan,String updateStatus);
	
	public void saveInstitutionalInfraMOPRCEC(InstitutionalInfraActivityPlan institutionalInfraActivityPlan);
	
	public List<InstInfraStatus> fetchALLInstInfraStatus();

}