package gov.in.rgsa.serviceImpl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;

import org.apache.commons.collections.CollectionUtils;
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
import gov.in.rgsa.entity.QuaterWiseFund;
import gov.in.rgsa.entity.StateAllocation;
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
	
	@PersistenceContext
	private EntityManager entityManager;
	
	@Override
	public List<QuarterDuration> getQuarterDurations() {
		System.out.println("in am in method");
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
		
			administrativeTechnicalProgress.setLastUpdatedBy(userPreference.getUserId());
			administrativeTechnicalProgress.setCreatedBy(userPreference.getUserId());
			List<AdministrativeTechnicalDetailProgress> administrativeTechnicalDetailProgress = administrativeTechnicalProgress.getAdministrativeTechnicalDetailProgress();
			for (AdministrativeTechnicalDetailProgress Detail : administrativeTechnicalDetailProgress) {
				if (Detail != null) {
					Detail.setAdministrativeTechnicalSupportProgress(administrativeTechnicalProgress);
				}
			}
			if (administrativeTechnicalProgress.getAtsId() == null) {
				commonRepository.save(administrativeTechnicalProgress);
			} else {
				commonRepository.update(administrativeTechnicalProgress);
			}
			/* this method is to insert and update record in quater_wise_fund table*/
			saveQprWiseFundData(userPreference.getStateCode(),userPreference.getFinYearId(),administrativeTechnicalProgress.getQuarterDuration().getQtrId(),4);
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
	public AdministrativeTechnicalProgress fetchAdministrativeTechnicalProgress(int administrativeTechnicalSupportId, int quarterId) {
        Map<String, Object> params = new HashMap<String, Object>();
		params.put("administrativeTechnicalSupportId", administrativeTechnicalSupportId);
		params.put("qtrId", quarterId); 
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
		
		List<PmuProgressDetails> pmuProgressDetails = pmuProgress.getPmuProgressDetails();
		pmuProgress.setLastUpdatedBy(userPreference.getUserId());
		pmuProgress.setCreatedBy(userPreference.getUserId());
		if (pmuProgress.getQprPmuId() == null) {
			pmuProgress.setQuarterDuration(pmuProgress.getQuarterDuration());

			for (PmuProgressDetails Details : pmuProgressDetails) {
				if (Details != null) {
					Details.setPmuProgress(pmuProgress);
				}
			}
			commonRepository.save(pmuProgress);
		}else{
			pmuProgress.setQuarterDuration(pmuProgress.getQuarterDuration());
			for (PmuProgressDetails Details : pmuProgressDetails) {
				if (Details != null) {
					Details.setPmuProgress(pmuProgress);
				}
			}
			commonRepository.update(pmuProgress);
		}
		
		/* this method is to insert and update record in quater_wise_fund table*/
		saveQprWiseFundData(userPreference.getStateCode(),userPreference.getFinYearId(),pmuProgress.getQuarterDuration().getQtrId(),12);
	}

	@Override
	public void saveQprIncomeEnhancement(QprIncomeEnhancement qprIncomeEnhancement) {
		qprIncomeEnhancement.setCreatedBy(userPreference.getUserId());
		qprIncomeEnhancement.setIsFreeze(false);
		qprIncomeEnhancement.setLastUpdatedBy(userPreference.getUserId());
		List<QprIncomeEnhancementDetails> enhancementDetails = qprIncomeEnhancement.getQprIncomeEnhancementDetails();
			for(QprIncomeEnhancementDetails qprIncomeEnhancementDetails : enhancementDetails){
				qprIncomeEnhancementDetails.setQprIncomeEnhancement(qprIncomeEnhancement);
			}
		if(qprIncomeEnhancement.getQprIncomeEnhancementId() == null){
				commonRepository.save(qprIncomeEnhancement);
		}
		else{
			qprIncomeEnhancement.setIsFreeze(false);
			commonRepository.update(qprIncomeEnhancement);
		}
		
		/* this method is to insert and update record in quater_wise_fund table*/
		saveQprWiseFundData(userPreference.getStateCode(),userPreference.getFinYearId(),qprIncomeEnhancement.getQuarterDuration().getQtrId(),10);
	}
	
	
	@Override
	public QprIncomeEnhancement fetchQprIncmEnhncmnt(int incomeEnhancementId,int quarterId) {
		List<QprIncomeEnhancement> qprIncomeEnhancement =null;
		Map<String, Object> params = new HashMap<>();
		params.put("quarterId",quarterId);
		params.put("incomeEnhancementId",incomeEnhancementId);
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
		iecQuater.setCreatedBy(userPreference.getUserId());
		iecQuater.setIsFreeze(false);
		iecQuater.setLastUpdatedBy(userPreference.getUserId());
		if(iecQuater.getQprIecId() == null){
			List<IecQuaterDetails> iecQuaterDetail = iecQuater.getIecQuaterDetails();
				for(IecQuaterDetails iecQuaterDetails : iecQuaterDetail){
					iecQuaterDetails.setIecQuater(iecQuater);
				}
			commonRepository.save(iecQuater);
		}
		else{
			List<IecQuaterDetails> iecQuaterDetail = iecQuater.getIecQuaterDetails();
			for(IecQuaterDetails iecQuaterDetails : iecQuaterDetail){
				iecQuaterDetails.setIecQuater(iecQuater);
			}
			commonRepository.update(iecQuater);
		}
		/* this method is to insert and update record in quater_wise_fund table*/
		saveQprWiseFundData(userPreference.getStateCode(),userPreference.getFinYearId(),iecQuater.getQuarterDuration().getQtrId(),11);
	}

	@Override
	public QprCbActivity fetchQprCapcityBuilding(Integer cbActivityId,Integer showQqrtrId) {
		List<QprCbActivity> qprCbActivity =null;
		Map<String, Object> params = new HashMap<>();
		params.put("stateCode", userPreference.getStateCode());
		params.put("yearId", userPreference.getFinYearId());
		params.put("quarterId",showQqrtrId);
		params.put("cbActivityId",cbActivityId);
		qprCbActivity = commonRepository.findAll("QPR_CAPACITY_BUILDING_REPORT_BASED_ON_QUARTER", params);
		if(!qprCbActivity.isEmpty()){
			return qprCbActivity.get(0);
		}else
		return null;
	}

	@Override
	public void saveQprCbActivity(QprCbActivity qprCbActivity) {
		qprCbActivity.setCreatedBy(userPreference.getUserId());
		qprCbActivity.setLastUpdatedBy(userPreference.getUserId());
		qprCbActivity.setIsFreeze(false);
		
		List<QprCbActivityDetails> qprCbActivityDetails = qprCbActivity.getQprCbActivityDetails();
		for(QprCbActivityDetails details : qprCbActivityDetails){
			details.setQprCbActivity(qprCbActivity);
		}
		qprCbActivity.getQprCbActivityDetails().get(0).getQprTnaTrgEvaluation().setCbActivityDetails(qprCbActivityDetails.get(0));
		qprCbActivity.getQprCbActivityDetails().get(1).getQprTrgMaterialAndModule().setCbActivityDetails(qprCbActivityDetails.get(1));
		qprCbActivity.getQprCbActivityDetails().get(2).getQprTrgMaterialAndModule().setCbActivityDetails(qprCbActivityDetails.get(2));
		qprCbActivity.getQprCbActivityDetails().get(3).getQprTnaTrgEvaluation().setCbActivityDetails(qprCbActivityDetails.get(3));
		qprCbActivity.getQprCbActivityDetails().get(6).getQprHandholdingGpdp().setCbActivityDetails(qprCbActivityDetails.get(6));
		qprCbActivity.getQprCbActivityDetails().get(7).getQprPanchayatLearningCenter().setCbActivityDetails(qprCbActivityDetails.get(7));
		if(qprCbActivity.getQpCbActivityId() == null){
			commonRepository.save(qprCbActivity);
		}
		else{
			commonRepository.update(qprCbActivity);
		}
		
		/* this method is to insert and update record in quater_wise_fund table*/
		saveQprWiseFundData(userPreference.getStateCode(),userPreference.getFinYearId(),qprCbActivity.getQuarterDuration().getQtrId(),13);
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
		/* this method is to insert and update record in quater_wise_fund table*/
		saveQprWiseFundData(userPreference.getStateCode(),userPreference.getFinYearId(),qprEnablement.getQuarterDuration().getQtrId(),5);
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
		qprInnovativeActivity.setCreatedBy(userPreference.getUserId());
		qprInnovativeActivity.setIsFreeze(false);
		qprInnovativeActivity.setLastUpdatedBy(userPreference.getUserId());
		List<QprInnovativeActivityDetails> innovativeActivityDetail = qprInnovativeActivity.getQprInnovativeActivityDetails();
		for(QprInnovativeActivityDetails innovativeActivityDetails : innovativeActivityDetail){
			innovativeActivityDetails.setQprInnovativeActivity(qprInnovativeActivity);
		}
		if(qprInnovativeActivity.getQprIaId() == null){
				commonRepository.save(qprInnovativeActivity);
		}else{
			commonRepository.update(qprInnovativeActivity);
		}
		
		/* this method is to insert and update record in quater_wise_fund table*/
		saveQprWiseFundData(userPreference.getStateCode(),userPreference.getFinYearId(),qprInnovativeActivity.getQuarterDuration().getQtrId(),9);
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
	public QprAdminAndFinancialDataActivity fetchQprAdminFin(int activityId,int quarterId) {
		List<QprAdminAndFinancialDataActivity> qprAdminAndFinancialDataActivities =null;
		Map<String, Object> params = new HashMap<>();
		params.put("activityId", activityId);
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
		List<QprAdminAndFinancialDataActivityDetails> qprAdminAndFinancialDataActivityDetails =qprAdminAndFinancialDataActivity.getQprAdminAndFinancialDataActivityDetails();
		for(QprAdminAndFinancialDataActivityDetails qprAdminAndFinancialDataActivityDetail :qprAdminAndFinancialDataActivityDetails)
		{
			qprAdminAndFinancialDataActivityDetail.setQprAdminAndFinancialDataActivity(qprAdminAndFinancialDataActivity);
		}
		
		if(qprAdminAndFinancialDataActivity.getQprAfpId()== null){
			commonRepository.save(qprAdminAndFinancialDataActivity);
		}else{
			commonRepository.update(qprAdminAndFinancialDataActivity);
		}
		/* this method is to insert and update record in quater_wise_fund table*/
		saveQprWiseFundData(userPreference.getStateCode(),userPreference.getFinYearId(),qprAdminAndFinancialDataActivity.getQuarterDuration().getQtrId(),8);
}
	
	@Override
	public List<StateAllocation> fetchStateAllocationData(int componentId,int subCompnentId,int installmentNo) {
		Map<String, Object> params=new HashMap<>();
		params.put("componentId", componentId);
		params.put("subCompnentId", subCompnentId);
		params.put("installmentNo", installmentNo);
		return commonRepository.findAll("FETCH_STATE_ALLOCATION_BY_COMP_ID", params);
	}

	@Override
	public Boolean saveQprWiseFundData(int stateCode, int yearId, int quatorId, int componentId) {
		Query query = entityManager.createNativeQuery("select * from rgsa.populate_quarter_wise_funds(:stateCode,:yearId,:quatorId,:componentId)");
		query.setParameter("stateCode", stateCode);
		query.setParameter("yearId", yearId);
		query.setParameter("quatorId", quatorId);
		query.setParameter("componentId", componentId);
		 Boolean value = (Boolean) query.getSingleResult();
		 return value;
	}

	@Override
	public List<QuaterWiseFund> fetchQuaterWiseFundData(Integer stateCode, int quarterId, int componentId) {
		Map<String, Object> params=new HashMap<>();
		params.put("stateCode", stateCode);
		params.put("quarterId", quarterId);
		params.put("componentId", componentId);
		return commonRepository.findAll("FETCH_QUATOR_WISE_FUND", params);
	}

	@Override
	public List<QprEnablementDetails> fetchQprEnablementDetails(Integer qprEEnablementId) {
		Map<String, Object> params=new HashMap<>();
		params.put("qprEEnablementId", qprEEnablementId);
		return commonRepository.findAll("FETCH_EENABLEMENT_QPR_DETAILS", params);
	}

	@Override
	public List<QuaterWiseFund> fetchTotalQuaterWiseFundData(Integer stateCode, int componentId) {
		Map<String, Object> params=new HashMap<>();
		params.put("stateCode", stateCode);
		params.put("componentId", componentId);
		return commonRepository.findAll("FETCH_ALL_QUATOR_WISE_FUND", params);
	}

	@Override
	public List<StateAllocation> fetchStateAllocationDataByCompIdandInstallNo(int componentId, int installmentNo) {
		Map<String, Object> params=new HashMap<>();
		params.put("componentId", componentId);
		params.put("installmentNo", installmentNo);
		return commonRepository.findAll("FETCH_STATE_ALLOCATION_BY_COMP_ID_AND_INSTALL_NO", params);
	}

	@Override
	public List<QprCbActivityDetails> getQprTrainActBasedOnActIdAndQtrId(Integer cbActivityId, int quarterId) {
		Map<String, Object> params = new HashMap();
		params.put("cbActivityId", cbActivityId);
		params.put("quarterId", quarterId);	
		List<QprCbActivity> qprCbActivities= commonRepository.findAll("FETCH_QPR_TRAINING_ACT_BY_QTR_ID_AND_ACT_ID", params);
		List<QprCbActivityDetails> qprCbActivityDetails=new ArrayList<>();
		if(CollectionUtils.isNotEmpty(qprCbActivities)){
			for (QprCbActivity qprCbActivity : qprCbActivities) {
				qprCbActivityDetails.addAll(qprCbActivity.getQprCbActivityDetails());
			}
			return qprCbActivityDetails;
		}else{
			return null;
		}
	}
}
