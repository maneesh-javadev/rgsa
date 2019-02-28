package gov.in.rgsa.serviceImpl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import gov.in.rgsa.dao.CommonRepository;
import gov.in.rgsa.entity.AdditionalFacultyProgress;
import gov.in.rgsa.entity.AdditionalFacultyProgressDetail;
import gov.in.rgsa.entity.AdministrativeTechnicalDetailProgress;
import gov.in.rgsa.entity.AdministrativeTechnicalProgress;
import gov.in.rgsa.entity.IecQuater;
import gov.in.rgsa.entity.IecQuaterDetails;
import gov.in.rgsa.entity.InnovativeActivityDetails;
import gov.in.rgsa.entity.PmuProgress;
import gov.in.rgsa.entity.PmuProgressDetails;
import gov.in.rgsa.entity.QprAdminAndFinancialDataActivity;
import gov.in.rgsa.entity.QprAdminAndFinancialDataActivityDetails;
import gov.in.rgsa.entity.QprEnablement;
import gov.in.rgsa.entity.QprEnablementDetails;
import gov.in.rgsa.entity.QprCbActivity;
import gov.in.rgsa.entity.QprCbActivityDetails;
import gov.in.rgsa.entity.QprIncomeEnhancement;
import gov.in.rgsa.entity.QprIncomeEnhancementDetails;
import gov.in.rgsa.entity.QprInnovativeActivity;
import gov.in.rgsa.entity.QprInnovativeActivityDetails;
import gov.in.rgsa.entity.QprTnaTrgEvaluation;
import gov.in.rgsa.entity.QuarterDuration;
import gov.in.rgsa.entity.TrainingDetailsProgressReport;
import gov.in.rgsa.entity.TrainingProgressReport;
import gov.in.rgsa.service.ProgressReportService;
import gov.in.rgsa.user.preference.UserPreference;

@Service
public class ProgressReportServiceImpl implements ProgressReportService{

	@Autowired
	private
	CommonRepository commonRepository;
	
	@Autowired
	private UserPreference userPreference;
	
	@Override
	public List<QuarterDuration> getQuarterDurations() {
		return commonRepository.findAll("FETCH_QUARTER_DURATION", null);
	}

	@Override
	public void saveTrainingProgressData(TrainingProgressReport trainingProgressReport) {
		
		if(trainingProgressReport.getTrainingReportId() == null) {
		List<TrainingDetailsProgressReport> dtlsProgressRpt = trainingProgressReport.getTrainingDetailsProgressReportList();
		/*List<CategoriesOfParticipant> categoriesOfParticipants = dtlsProgressRpt.get(0).getCategoriesOfParticipantList();*/
		
		for(TrainingDetailsProgressReport detailsProgressReports : dtlsProgressRpt) {
			detailsProgressReports.setTrainingActivityDetails(detailsProgressReports.getTrainingActivityDetails());
			detailsProgressReports.setTrainingProgressReport(trainingProgressReport);
			detailsProgressReports.setQuarterDuration(dtlsProgressRpt.get(0).getQuarterDuration());
			
			/*for(CategoriesOfParticipant ofParticipant : categoriesOfParticipants) {
				ofParticipant.setTargetGrpMaster(ofParticipant.getTargetGrpMaster());
				ofParticipant.setTrainingDetailsProgressReport(dtlsProgressRpt.get(0));
				
			}*/
		}
		
		trainingProgressReport.setCreatedBy(userPreference.getUserId());
		trainingProgressReport.setLastUpdatedBy(userPreference.getUserId());
		commonRepository.save(trainingProgressReport);
		}
		else
		{
			List<TrainingDetailsProgressReport> dtlsProgressRpt = trainingProgressReport.getTrainingDetailsProgressReportList();
			/*List<CategoriesOfParticipant> categoriesOfParticipants = dtlsProgressRpt.get(0).getCategoriesOfParticipantList();*/
			
			for(TrainingDetailsProgressReport detailsProgressReports : dtlsProgressRpt) {
				detailsProgressReports.setTrainingActivityDetails(detailsProgressReports.getTrainingActivityDetails());
				detailsProgressReports.setTrainingProgressReport(trainingProgressReport);
				detailsProgressReports.setQuarterDuration(dtlsProgressRpt.get(0).getQuarterDuration());
				
				/*for(CategoriesOfParticipant ofParticipant : categoriesOfParticipants) {
					ofParticipant.setTargetGrpMaster(ofParticipant.getTargetGrpMaster());
					ofParticipant.setTrainingDetailsProgressReport(dtlsProgressRpt.get(0));
					
				}*/
			}
			trainingProgressReport.setLastUpdatedBy(userPreference.getUserId());
			commonRepository.update(trainingProgressReport);
		}
	}


	@Override
	public TrainingProgressReport fetchprogressReport(List<Integer> activityDetailsId, int activityId, int quarterId) {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("acivityDetailsId", activityDetailsId);
		params.put("activityId", activityId);
		params.put("quarterId", quarterId);
		List<TrainingProgressReport> report =commonRepository.findAll("TRAINING_REPORT_BASED_ON_QUARTER", params);
		if(!report.isEmpty() && report.get(0) != null) {
			return report.get(0);
		}else
		return null;
	}

	@Override
	public TrainingProgressReport fetchprogressReportToGeReportId(int activityId) {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("activityId", activityId);
		List<TrainingProgressReport> report =commonRepository.findAll("TRAINING_REPORT_BASED_ID", params);
		if(!report.isEmpty() && report.get(0) != null) {
			return report.get(0);
		}else
		return null;
	}

	

	@Override
	public void saveadministrativeTechnicalProgress(AdministrativeTechnicalProgress administrativeTechnicalProgress) {
		if(administrativeTechnicalProgress.getAtsId() == null) {
			List<AdministrativeTechnicalDetailProgress> administrativeTechnicalDetailProgress = administrativeTechnicalProgress.getAdministrativeTechnicalDetailProgress();
			administrativeTechnicalProgress.setLastUpdatedBy(userPreference.getUserId());
			administrativeTechnicalProgress.setCreatedBy(userPreference.getUserId());
			administrativeTechnicalProgress.setQuarterDuration(administrativeTechnicalProgress.getQuarterDuration());
			
			for (AdministrativeTechnicalDetailProgress Details : administrativeTechnicalDetailProgress) {
				if(Details != null)
				{
									Details.setAdministrativeTechnicalSupportProgress(administrativeTechnicalProgress);
									
											}
				
			}	
			commonRepository.save(administrativeTechnicalProgress);
			}
			else
			{
				List<AdministrativeTechnicalDetailProgress> administrativeTechnicalDetailProgress = administrativeTechnicalProgress.getAdministrativeTechnicalDetailProgress();
				administrativeTechnicalProgress.setQuarterDuration(administrativeTechnicalProgress.getQuarterDuration());
				for (AdministrativeTechnicalDetailProgress Details : administrativeTechnicalDetailProgress) {
					if(Details != null)
					{
										Details.setAdministrativeTechnicalSupportProgress(administrativeTechnicalProgress);
										
												}
					
				}	
				commonRepository.update(administrativeTechnicalProgress);
			}
		
		
		}

	@Override
	public AdministrativeTechnicalProgress fetchAdministrativeReportToGeReportId1(int administrativeTechnicalSupportId) {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("administrativeTechnicalSupportId", administrativeTechnicalSupportId);
		List<AdministrativeTechnicalProgress> administrativeTechnicalProgress =commonRepository.findAll("FETCH_Admin_Tech_Progress_progress_report_BASED_ID", params);
		if(!administrativeTechnicalProgress.isEmpty() && administrativeTechnicalProgress.get(0) != null) {
			return administrativeTechnicalProgress.get(0);
		}else
		return null;
	}

	@Override
	public AdministrativeTechnicalProgress fetchAdministrativeTechnicalProgress( List<Integer> postId,int administrativeTechnicalSupportId, int quarterId) {
        Map<String, Object> params = new HashMap<String, Object>();
		params.put("administrativeTechnicalSupportId", administrativeTechnicalSupportId);
		params.put("qtrId", quarterId); 
		params.put("postId", postId);
		List<AdministrativeTechnicalProgress> administrativeTechnicalProgress =commonRepository.findAll("FETCH_Admin_Tech_Progress_progress_report", params);
		if(!administrativeTechnicalProgress.isEmpty() && administrativeTechnicalProgress.get(0) != null) {
			return administrativeTechnicalProgress.get(0);
		}else
		return null;
	}

	@Override
	public AdditionalFacultyProgress fetchAdditionalFacultyProgressToGeReportId1(int instituteInfraHrActivityId) {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("instituteInfraHrActivityId", instituteInfraHrActivityId);
		List<AdditionalFacultyProgress> additionalFacultyProgress =commonRepository.findAll("FETCH_Additional_Facult_progress_report_BASED_ID", params);
		if(!additionalFacultyProgress.isEmpty() && additionalFacultyProgress.get(0) != null) {
			return additionalFacultyProgress.get(0);
		}else
		return null;
	}

	@Override
	public AdditionalFacultyProgress fetchAdditionalFacultyProgress(int instituteInfraHrActivityId, int quarterId) {
        Map<String, Object> params = new HashMap<String, Object>();
		params.put("instituteInfraHrActivityId", instituteInfraHrActivityId);
		params.put("qtrId", quarterId); 
	
		List<AdditionalFacultyProgress> additionalFacultyProgress =commonRepository.findAll("FETCH_Additional_Faculty_progress_report_DETAILS", params);
		if(!additionalFacultyProgress.isEmpty() && additionalFacultyProgress.get(0) != null) {
			return additionalFacultyProgress.get(0);
		}else
		return null;
	}

	@Override
	public void saveAdditionalFacultyProgress(AdditionalFacultyProgress additionalFacultyProgress) {
		if(additionalFacultyProgress.getQprInstInfraHrId() == null) {
			List<AdditionalFacultyProgressDetail> additionalFacultyProgressDetail = additionalFacultyProgress.getAdditionalFacultyProgressDetail();
				
			additionalFacultyProgress.setLastUpdatedBy(userPreference.getUserId());
			additionalFacultyProgress.setCreatedBy(userPreference.getUserId());
			additionalFacultyProgress.setQuarterDuration(additionalFacultyProgress.getQuarterDuration());
			
			for (AdditionalFacultyProgressDetail Details : additionalFacultyProgressDetail) {
				if(Details != null)
				{
									Details.setAdditionalFacultyProgress(additionalFacultyProgress);
									
			    }
				}	
			commonRepository.save(additionalFacultyProgress);
			}
			else
			{
				List<AdditionalFacultyProgressDetail> additionalFacultyProgressDetail = additionalFacultyProgress.getAdditionalFacultyProgressDetail();
				additionalFacultyProgress.setQuarterDuration(additionalFacultyProgress.getQuarterDuration());
				for (AdditionalFacultyProgressDetail Details : additionalFacultyProgressDetail) {
					if(Details != null)
					{
										Details.setAdditionalFacultyProgress(additionalFacultyProgress);
					 }
					}	
				commonRepository.update(additionalFacultyProgress);
			}
		
		
	}

	/*@Override
	public InstitutionalInfraActivityPlanProgress fetchInstitutionalInfraActivityPlan(List<Integer> infraActivityDetailId, int institutionalInfraActivityId, int quarterId) {
		Map<String,Object> params = new HashMap<>();
	
		params.put("infraActivityDetailId", infraActivityDetailId);
		params.put("institutionalInfraActivityId", institutionalInfraActivityId);
		params.put("quarterId", quarterId);
		List<InstitutionalInfraActivityPlanProgress> institutionalInfraActivityPlanProgress =commonRepository.findAll("FETCH_INSTITUTIONAL_INFRA_PROGRESS_REPORT_DETAILS", params);
		if(!institutionalInfraActivityPlanProgress.isEmpty() && institutionalInfraActivityPlanProgress.get(0) != null)
		{
			return institutionalInfraActivityPlanProgress.get(0);
		}
		else
		return null;
	}
	@Override
	public List<InstInfraStatus> getInstInfraStatus() {
		return commonRepository.findAll("FETCH_INST_INFRA_STATUS", null);
	}

	@Override
	public InstitutionalInfraActivityPlanProgress fetchInstitutionalInfraActivityPlanProgressToGeReportId(int institutionalInfraActivityId) {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("institutionalInfraActivityId", institutionalInfraActivityId);
		List<InstitutionalInfraActivityPlanProgress> institutionalInfraActivityPlanProgress =commonRepository.findAll("FETCH_INSTITUTIONAL_INFRAACTIVITY_PROGRESS_REPORT_BASED_ID", params);
		if(!institutionalInfraActivityPlanProgress.isEmpty() && institutionalInfraActivityPlanProgress.get(0) != null) {
			return institutionalInfraActivityPlanProgress.get(0);
		}else
		return null;
	}

	@Override
	public void saveInfraActivity(InstitutionalInfraActivityPlanProgress institutionalInfraActivityPlanProgress) {
		// TODO Auto-generated method stub
		
	}
	
	
	*/

	@Override
	public PmuProgress fetchPmu(int pmuActivityId, int quarterId) {
		  Map<String, Object> params = new HashMap<String, Object>();
			params.put("pmuActivityId", pmuActivityId);
			params.put("qtrId", quarterId); 
		
			List<PmuProgress> pmuProgress =commonRepository.findAll("FETCH_PMU_PROGRESS_PROGRESS_REPORT_DETAILS", params);
			if(!pmuProgress.isEmpty() && pmuProgress.get(0) != null) {
				return pmuProgress.get(0);
			}else
			return null;
	}

	
	@Override
	public PmuProgress fetchPmuProgressToGeReportId(int pmuActivityId) {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("pmuActivityId", pmuActivityId);
		List<PmuProgress> pmuProgress =commonRepository.findAll("FETCH_Pmu_Progress_progress_report_BASED_ID", params);
		if(!pmuProgress.isEmpty() && pmuProgress.get(0) != null) {
			return pmuProgress.get(0);
		}else
		return null;
	}

	@Override
	public void savePmu(PmuProgress pmuProgress) {
		
		
		if(pmuProgress.getQprPmuId() == null) {
			List<PmuProgressDetails> pmuProgressDetails = pmuProgress.getPmuProgressDetails();
				
			pmuProgress.setLastUpdatedBy(userPreference.getUserId());
			pmuProgress.setCreatedBy(userPreference.getUserId());
			pmuProgress.setQuarterDuration(pmuProgress.getQuarterDuration());
			
			for (PmuProgressDetails Details : pmuProgressDetails) {
				if(Details != null)
				{
									Details.setPmuProgress(pmuProgress);
									
			    }
				}	
			commonRepository.save(pmuProgress);
			}
			else
			{
				List<PmuProgressDetails> pmuProgressDetails = pmuProgress.getPmuProgressDetails();
				pmuProgress.setQuarterDuration(pmuProgress.getQuarterDuration());
				for (PmuProgressDetails Details : pmuProgressDetails) {
					if(Details != null)
					{
										Details.setPmuProgress(pmuProgress);
										
				    }
					}	
				commonRepository.update(pmuProgress);
			}
		
		
		
	}

	@Override
	public void saveQprIncomeEnhancement(QprIncomeEnhancement qprIncomeEnhancement) {
		if(qprIncomeEnhancement.getQprIncomeEnhancementId() == null){
			qprIncomeEnhancement.setCreatedBy(userPreference.getUserId());
			qprIncomeEnhancement.setIsFreeze(false);
			qprIncomeEnhancement.setLastUpdatedBy(userPreference.getUserId());
			
			List<QprIncomeEnhancementDetails> enhancementDetails = qprIncomeEnhancement.getQprIncomeEnhancementDetails();
				for(QprIncomeEnhancementDetails qprIncomeEnhancementDetails : enhancementDetails){
					qprIncomeEnhancementDetails.setQprIncomeEnhancement(qprIncomeEnhancement);
				}
				commonRepository.save(qprIncomeEnhancement);
		}
		else{
			qprIncomeEnhancement.setIsFreeze(false);
			qprIncomeEnhancement.setLastUpdatedBy(userPreference.getUserId());
			List<QprIncomeEnhancementDetails> enhancementDetails = qprIncomeEnhancement.getQprIncomeEnhancementDetails();
			for(QprIncomeEnhancementDetails qprIncomeEnhancementDetails : enhancementDetails){
				qprIncomeEnhancementDetails.setQprIncomeEnhancement(qprIncomeEnhancement);
			}
			commonRepository.update(qprIncomeEnhancement);
		}
	}
	
	
	@Override
	public QprIncomeEnhancement fetchQprIncmEnhncmnt(int quarterId) {
		List<QprIncomeEnhancement> qprIncomeEnhancement =null;
		Map<String, Object> params = new HashMap<>();
		params.put("stateCode", userPreference.getStateCode());
		params.put("yearId", userPreference.getFinYearId());
		params.put("userType", userPreference.getUserType().charAt(0));
		params.put("quarterId",quarterId);
		qprIncomeEnhancement = commonRepository.findAll("QPR_INCM_ENHNCMNT_REPORT_BASED_ON_QUARTER", params);
		if(!qprIncomeEnhancement.isEmpty()){
			return qprIncomeEnhancement.get(0);
		}else
		return null;
	}

	@Override
	public void FrzUnfrzIncomeEnhancmnt(QprIncomeEnhancement qprIncomeEnhancement) {
		Map<String,Object> params = new HashMap<>();
		if(qprIncomeEnhancement.getIsFreeze() == true) {
		params.put("isFreeze", false);}
		else if(qprIncomeEnhancement.getIsFreeze() == false) {
			params.put("isFreeze", true);}
		params.put("qprIncomeEnhancementId", qprIncomeEnhancement.getQprIncomeEnhancementId());
		commonRepository.excuteUpdate("UPDATE_QPR_FRZUNFREEZ_STATUS", params);
		
	}

	@Override
	public IecQuater getfetchIecQuaterProgressReportToGeReportId(Integer id) {
    	Map<String, Object> params = new HashMap<String, Object>();
		params.put("id", id);
		List<IecQuater> iecQuater =commonRepository.findAll("FETCH_IEC__REPORT_BASED_ID", params);
		if(!iecQuater.isEmpty() && iecQuater.get(0) != null) {
			return iecQuater.get(0);
		}else
		return null;
	}

	@Override
	public IecQuater getSatcomProgress(Integer id, int quarterId) {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("id", id);
		params.put("qtrId", quarterId); 
	
		List<IecQuater> iecQuaters =commonRepository.findAll("FETCH_IEC_REPORT_DETAILS", params);
		if(!iecQuaters.isEmpty() && iecQuaters.get(0) != null) {
			return iecQuaters.get(0);
		}else
	
		return null;
	}

	@Override
	public void saveIec(IecQuater iecQuater) {
		// TODO Auto-generated method stub
		if(iecQuater.getQprIecId() == null){
			iecQuater.setCreatedBy(userPreference.getUserId());
			iecQuater.setIsFreeze(false);
			iecQuater.setLastUpdatedBy(userPreference.getUserId());
			
			List<IecQuaterDetails> iecQuaterDetail = iecQuater.getIecQuaterDetails();
				for(IecQuaterDetails iecQuaterDetails : iecQuaterDetail){
					iecQuaterDetails.setIecQuater(iecQuater);
				}
				commonRepository.save(iecQuater);
		}
		else{
			iecQuater.setIsFreeze(false);
			iecQuater.setLastUpdatedBy(userPreference.getUserId());
			List<IecQuaterDetails> iecQuaterDetail = iecQuater.getIecQuaterDetails();
			for(IecQuaterDetails iecQuaterDetails : iecQuaterDetail){
				iecQuaterDetails.setIecQuater(iecQuater);
			}
			commonRepository.update(iecQuater);
		}
	}

	@Override
	public QprCbActivity fetchQprCapcityBuilding(Integer showQqrtrId) {
		List<QprCbActivity> qprCbActivity =null;
		Map<String, Object> params = new HashMap<>();
		params.put("stateCode", userPreference.getStateCode());
		params.put("yearId", userPreference.getFinYearId());
		params.put("userType", userPreference.getUserType().charAt(0));
		params.put("quarterId",showQqrtrId);
		qprCbActivity = commonRepository.findAll("QPR_CAPACITY_BUILDING_REPORT_BASED_ON_QUARTER", params);
		if(!qprCbActivity.isEmpty()){
			return qprCbActivity.get(0);
		}else
		return null;
	}

	@Override
	public void saveQprCbActivity(QprCbActivity qprCbActivity) {
		if(qprCbActivity.getQpCbActivityId() == null){
			qprCbActivity.setCreatedBy(userPreference.getUserId());
			qprCbActivity.setLastUpdatedBy(userPreference.getUserId());
			qprCbActivity.setIsFreeze(false);
			
			List<QprCbActivityDetails> qprCbActivityDetails = qprCbActivity.getQprCbActivityDetails();
			for(QprCbActivityDetails details : qprCbActivityDetails){
				details.setQprCbActivity(qprCbActivity);
			}
			qprCbActivity.getQprCbActivityDetails().get(0).getQprTnaTrgEvaluation().get(0).setCbActivityDetails(qprCbActivityDetails.get(0));
			qprCbActivity.getQprCbActivityDetails().get(1).getQprTrgMaterialAndModule().get(0).setCbActivityDetails(qprCbActivityDetails.get(1));
			qprCbActivity.getQprCbActivityDetails().get(2).getQprTrgMaterialAndModule().get(0).setCbActivityDetails(qprCbActivityDetails.get(2));
			qprCbActivity.getQprCbActivityDetails().get(3).getQprTnaTrgEvaluation().get(0).setCbActivityDetails(qprCbActivityDetails.get(3));
			qprCbActivity.getQprCbActivityDetails().get(6).getQprHandholdingGpdp().setCbActivityDetails(qprCbActivityDetails.get(6));
			qprCbActivity.getQprCbActivityDetails().get(7).getQprPanchayatLearningCenter().setCbActivityDetails(qprCbActivityDetails.get(7));
			
			commonRepository.save(qprCbActivity);
		}
		else{
			qprCbActivity.setLastUpdatedBy(userPreference.getUserId());
			qprCbActivity.setIsFreeze(false);
			
			List<QprCbActivityDetails> qprCbActivityDetails = qprCbActivity.getQprCbActivityDetails();
			for(QprCbActivityDetails details : qprCbActivityDetails){
				details.setQprCbActivity(qprCbActivity);
			}
			QprTnaTrgEvaluation evaluation = new QprTnaTrgEvaluation();
			evaluation.setCbActivityDetails(qprCbActivityDetails.get(0));
			qprCbActivity.getQprCbActivityDetails().get(0).getQprTnaTrgEvaluation().get(0).setCbActivityDetails(qprCbActivityDetails.get(0));
			qprCbActivity.getQprCbActivityDetails().get(1).getQprTrgMaterialAndModule().get(0).setCbActivityDetails(qprCbActivityDetails.get(1));
			qprCbActivity.getQprCbActivityDetails().get(2).getQprTrgMaterialAndModule().get(0).setCbActivityDetails(qprCbActivityDetails.get(2));
			qprCbActivity.getQprCbActivityDetails().get(3).getQprTnaTrgEvaluation().get(0).setCbActivityDetails(qprCbActivityDetails.get(3));
			qprCbActivity.getQprCbActivityDetails().get(6).getQprHandholdingGpdp().setCbActivityDetails(qprCbActivityDetails.get(6));
			qprCbActivity.getQprCbActivityDetails().get(7).getQprPanchayatLearningCenter().setCbActivityDetails(qprCbActivityDetails.get(7));
			commonRepository.update(qprCbActivity);
		}
	}

	
		
		
	

	@Override
	public QprEnablement fetchQprEnablement(Integer eEnablementId, int quarterId) {
		  Map<String, Object> params = new HashMap<String, Object>();
			params.put("eEnablementId", eEnablementId);
			params.put("qtrId", quarterId); 
		
			List<QprEnablement> qprEnablement =commonRepository.findAll("FETCH_QPR_ENABLEMENT_REPORT_DETAILS", params);
			if(!qprEnablement.isEmpty() && qprEnablement.get(0) != null) {
				return qprEnablement.get(0);
			}else
			return null;
	}

	@Override
	public QprEnablement fetchEEnablementProgressToGeReportId1(Integer id) {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("eEnablementId", id);
		List<QprEnablement> qprEnablement =commonRepository.findAll("FETCH_QPR_ENABLEMENT_REPORT_BASED_ID", params);
		if(!qprEnablement.isEmpty() && qprEnablement.get(0) != null) {
			return qprEnablement.get(0);
		}else
		return null;
	}

	@Override
	public void saveEnablement(QprEnablement qprEnablement) {
		if(qprEnablement.getQprEEnablementId() == null){
			qprEnablement.setCreatedBy(userPreference.getUserId());
			
			qprEnablement.setLastUpdatedBy(userPreference.getUserId());
			
			List<QprEnablementDetails> qprEnablementDetails = qprEnablement.getQprEnablementDetails();
				for(QprEnablementDetails qprEnablementDetail : qprEnablementDetails){
					qprEnablementDetail.setQprEnablement(qprEnablement);
				}
				commonRepository.save(qprEnablement);
		}
		else{
			
			qprEnablement.setLastUpdatedBy(userPreference.getUserId());
			List<QprEnablementDetails> qprEnablementDetails = qprEnablement.getQprEnablementDetails();
			for(QprEnablementDetails qprEnablementDetail : qprEnablementDetails){
				qprEnablementDetail.setQprEnablement(qprEnablement);
			}
			commonRepository.update(qprEnablement);
		}
		
		
		
		
	}

	@Override
	public QprInnovativeActivity getInnovative(Integer id, int quarterId) {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("innovativeActivityId", id);
		params.put("qtrId", quarterId); 
	
		List<QprInnovativeActivity> qprInnovativeActivity =commonRepository.findAll("FETCH_INNOVATIVE_REPORT_DETAILS", params);
		if(!qprInnovativeActivity.isEmpty() && qprInnovativeActivity.get(0) != null) {
			return qprInnovativeActivity.get(0);
		}else
	
		return null;
	}

	@Override
	public void saveInnovative(QprInnovativeActivity qprInnovativeActivity) {
		if(qprInnovativeActivity.getQprIaId() == null){
			qprInnovativeActivity.setCreatedBy(userPreference.getUserId());
			qprInnovativeActivity.setIsFreeze(false);
			qprInnovativeActivity.setLastUpdatedBy(userPreference.getUserId());
			
			List<QprInnovativeActivityDetails> innovativeActivityDetail = qprInnovativeActivity.getQprInnovativeActivityDetails();
				for(QprInnovativeActivityDetails innovativeActivityDetails : innovativeActivityDetail){
					innovativeActivityDetails.setQprInnovativeActivity(qprInnovativeActivity);
				}
				commonRepository.save(qprInnovativeActivity);
		}
		else{
			qprInnovativeActivity.setIsFreeze(false);
			qprInnovativeActivity.setLastUpdatedBy(userPreference.getUserId());
			List<QprInnovativeActivityDetails> qprInnovativeActivityDetail = qprInnovativeActivity.getQprInnovativeActivityDetails();
			for(QprInnovativeActivityDetails qprInnovativeActivityDetails : qprInnovativeActivityDetail){
				qprInnovativeActivityDetails.setQprInnovativeActivity(qprInnovativeActivity);
			}
			commonRepository.update(qprInnovativeActivity);
		}
		
	}

	@Override
	public QprInnovativeActivity getfetchInnovativeProgressReportToGeReportId(Integer id) {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("innovativeActivityId", id);
		List<QprInnovativeActivity> qprInnovativeActivities =commonRepository.findAll("FETCH_INNOVATIVE__REPORT_BASED_ID", params);
		if(!qprInnovativeActivities.isEmpty() && qprInnovativeActivities.get(0) != null) {
			return qprInnovativeActivities.get(0);
		}else
		return null;
	}

	@Override
	public QprAdminAndFinancialDataActivity fetchQprAdminFin(int quarterId) {
		List<QprAdminAndFinancialDataActivity> qprAdminAndFinancialDataActivities =null;
		Map<String, Object> params = new HashMap<>();
		params.put("stateCode", userPreference.getStateCode());
		params.put("yearId", userPreference.getFinYearId());
		params.put("userType", userPreference.getUserType());
		params.put("quarterId",quarterId);
		qprAdminAndFinancialDataActivities = commonRepository.findAll("QPR_ADMIN_FINANCIALDATA_ACTIVITY_REPORT_BASED_ON_QUARTER", params);
		if(!qprAdminAndFinancialDataActivities.isEmpty()){
			return qprAdminAndFinancialDataActivities.get(0);
		}else
		return null;
	}

	@Override
	public void saveAdminDataFinQuaterly(QprAdminAndFinancialDataActivity qprAdminAndFinancialDataActivity) {
		qprAdminAndFinancialDataActivity.setCreatedBy(userPreference.getUserId());
		qprAdminAndFinancialDataActivity.setCreatedOn(qprAdminAndFinancialDataActivity.getCreatedOn());
		qprAdminAndFinancialDataActivity.setLastUpdatedBy(userPreference.getUserId());
		qprAdminAndFinancialDataActivity.setLastUpdatedOn(qprAdminAndFinancialDataActivity.getLastUpdatedOn());
	
		if(qprAdminAndFinancialDataActivity.getQprAfpId()== null)
		{
			
		List<QprAdminAndFinancialDataActivityDetails> qprAdminAndFinancialDataActivityDetails =qprAdminAndFinancialDataActivity.getQprAdminAndFinancialDataActivityDetails();
		for(QprAdminAndFinancialDataActivityDetails qprAdminAndFinancialDataActivityDetail :qprAdminAndFinancialDataActivityDetails)
		{
			qprAdminAndFinancialDataActivityDetail.setQprAdminAndFinancialDataActivity(qprAdminAndFinancialDataActivity);
		}
		commonRepository.save(qprAdminAndFinancialDataActivity);
		}
		
		else
		{
		
			List<QprAdminAndFinancialDataActivityDetails> qprAdminAndFinancialDataActivityDetails =qprAdminAndFinancialDataActivity.getQprAdminAndFinancialDataActivityDetails();
			for(QprAdminAndFinancialDataActivityDetails qprAdminAndFinancialDataActivityDetail :qprAdminAndFinancialDataActivityDetails)
			{
				qprAdminAndFinancialDataActivityDetail.setQprAdminAndFinancialDataActivity(qprAdminAndFinancialDataActivity);
			}
			commonRepository.update(qprAdminAndFinancialDataActivity);
		
	}
}
}