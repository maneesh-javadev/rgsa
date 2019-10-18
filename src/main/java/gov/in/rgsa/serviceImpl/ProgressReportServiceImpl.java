package gov.in.rgsa.serviceImpl;

import gov.in.rgsa.dao.CommonRepository;
import gov.in.rgsa.dto.SubcomponentwiseQuaterBalance;
import gov.in.rgsa.entity.*;
import gov.in.rgsa.service.InnovativeActivityService;
import gov.in.rgsa.service.InstitutionalInfraActivityPlanService;
import gov.in.rgsa.service.ProgressReportService;
import gov.in.rgsa.user.preference.UserPreference;
import gov.in.rgsa.utils.FileNodeUtils;
import org.apache.commons.collections.CollectionUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;

import java.math.BigDecimal;
import java.math.BigInteger;
import java.util.*;

@Service
public class ProgressReportServiceImpl implements ProgressReportService {

    @Autowired
    private
    CommonRepository commonRepository;

    @Autowired
    private UserPreference userPreference;

    @PersistenceContext
    private EntityManager entityManager;

    @Autowired
    InnovativeActivityService innovativeActivityService;

    @Autowired
    InstitutionalInfraActivityPlanService institutionalInfraActivityPlanService;

    @Override
    public List<QuarterDuration> getQuarterDurations() {
        System.out.println("in am in method");
        return commonRepository.findAll("FETCH_QUARTER_DURATION", null);
    }

    @Override
    public void saveTrainingProgressData(TrainingProgressReport trainingProgressReport) {

        if (trainingProgressReport.getTrainingReportId() == null) {
            List<TrainingDetailsProgressReport> dtlsProgressRpt = trainingProgressReport.getTrainingDetailsProgressReportList();
            /*List<CategoriesOfParticipant> categoriesOfParticipants = dtlsProgressRpt.get(0).getCategoriesOfParticipantList();*/

            for (TrainingDetailsProgressReport detailsProgressReports : dtlsProgressRpt) {
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
        } else {
            List<TrainingDetailsProgressReport> dtlsProgressRpt = trainingProgressReport.getTrainingDetailsProgressReportList();
            /*List<CategoriesOfParticipant> categoriesOfParticipants = dtlsProgressRpt.get(0).getCategoriesOfParticipantList();*/

            for (TrainingDetailsProgressReport detailsProgressReports : dtlsProgressRpt) {
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
        List<TrainingProgressReport> report = commonRepository.findAll("TRAINING_REPORT_BASED_ON_QUARTER", params);
        if (!report.isEmpty() && report.get(0) != null) {
            return report.get(0);
        } else
            return null;
    }

    @Override
    public TrainingProgressReport fetchprogressReportToGeReportId(int activityId) {
        Map<String, Object> params = new HashMap<String, Object>();
        params.put("activityId", activityId);
        List<TrainingProgressReport> report = commonRepository.findAll("TRAINING_REPORT_BASED_ID", params);
        if (!report.isEmpty() && report.get(0) != null) {
            return report.get(0);
        } else
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
        saveQprWiseFundData(userPreference.getStateCode(), userPreference.getFinYearId(), administrativeTechnicalProgress.getQuarterDuration().getQtrId(), 4);
    }

    @Override
    public AdministrativeTechnicalProgress fetchAdministrativeReportToGeReportId1(int administrativeTechnicalSupportId) {
        Map<String, Object> params = new HashMap<String, Object>();
        params.put("administrativeTechnicalSupportId", administrativeTechnicalSupportId);
        List<AdministrativeTechnicalProgress> administrativeTechnicalProgress = commonRepository.findAll("FETCH_Admin_Tech_Progress_progress_report_BASED_ID", params);
        if (!administrativeTechnicalProgress.isEmpty() && administrativeTechnicalProgress.get(0) != null) {
            return administrativeTechnicalProgress.get(0);
        } else
            return null;
    }

    @Override
    public AdministrativeTechnicalProgress fetchAdministrativeTechnicalProgress(int administrativeTechnicalSupportId, int quarterId) {
        Map<String, Object> params = new HashMap<String, Object>();
        params.put("administrativeTechnicalSupportId", administrativeTechnicalSupportId);
        params.put("qtrId", quarterId);
        List<AdministrativeTechnicalProgress> administrativeTechnicalProgress = commonRepository.findAll("FETCH_Admin_Tech_Progress_progress_report", params);
        if (!administrativeTechnicalProgress.isEmpty() && administrativeTechnicalProgress.get(0) != null) {
            return administrativeTechnicalProgress.get(0);
        } else
            return null;
    }

    @Override
    public AdditionalFacultyProgress fetchAdditionalFacultyProgressToGeReportId1(int instituteInfraHrActivityId) {
        Map<String, Object> params = new HashMap<String, Object>();
        params.put("instituteInfraHrActivityId", instituteInfraHrActivityId);
        List<AdditionalFacultyProgress> additionalFacultyProgress = commonRepository.findAll("FETCH_Additional_Facult_progress_report_BASED_ID", params);
        if (!additionalFacultyProgress.isEmpty() && additionalFacultyProgress.get(0) != null) {
            return additionalFacultyProgress.get(0);
        } else
            return null;
    }

    @Override
    public AdditionalFacultyProgress fetchAdditionalFacultyProgress(int instituteInfraHrActivityId, int quarterId) {
        Map<String, Object> params = new HashMap<String, Object>();
        params.put("instituteInfraHrActivityId", instituteInfraHrActivityId);
        params.put("qtrId", quarterId);

        List<AdditionalFacultyProgress> additionalFacultyProgress = commonRepository.findAll("FETCH_Additional_Faculty_progress_report_DETAILS", params);
        if (!additionalFacultyProgress.isEmpty() && additionalFacultyProgress.get(0) != null) {
            return additionalFacultyProgress.get(0);
        } else
            return null;
    }

    @Override
    public void saveAdditionalFacultyProgress(AdditionalFacultyProgress additionalFacultyProgress) {
        List<AdditionalFacultyProgressDetail> additionalFacultyProgressDetail = additionalFacultyProgress.getAdditionalFacultyProgressDetail();
        List<QprTiWiseDomainExpert> qprTiWiseDomainExpert=additionalFacultyProgress.getQprTiWiseDomainExpert();
        additionalFacultyProgress.setLastUpdatedBy(userPreference.getUserId());
        additionalFacultyProgress.setCreatedBy(userPreference.getUserId());
        additionalFacultyProgress.setQuarterDuration(additionalFacultyProgress.getQuarterDuration());
        
        for (AdditionalFacultyProgressDetail Details : additionalFacultyProgressDetail) {
            if (Details != null) {
                Details.setAdditionalFacultyProgress(additionalFacultyProgress);
            }
        }
        
        qprTiWiseDomainExpert.forEach( obj -> {
        	if(obj != null)
        		obj.setAdditionalFacultyProgress(additionalFacultyProgress);
        });
        
        additionalFacultyProgress.setQprTiWiseDomainExpert(qprTiWiseDomainExpert);
        if (additionalFacultyProgress.getQprInstInfraHrId() == null) {
            commonRepository.save(additionalFacultyProgress);
        } else {
            commonRepository.update(additionalFacultyProgress);
        }

        /* this method is to insert and update record in quater_wise_fund table*/
        saveQprWiseFundData(userPreference.getStateCode(), userPreference.getFinYearId(), additionalFacultyProgress.getQuarterDuration().getQtrId(), 14);
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

        List<PmuProgress> pmuProgress = commonRepository.findAll("FETCH_PMU_PROGRESS_PROGRESS_REPORT_DETAILS", params);
        if (!pmuProgress.isEmpty() && pmuProgress.get(0) != null) {
            return pmuProgress.get(0);
        } else
            return null;
    }


    @Override
    public PmuProgress fetchPmuProgressToGeReportId(int pmuActivityId) {
        Map<String, Object> params = new HashMap<String, Object>();
        params.put("pmuActivityId", pmuActivityId);
        List<PmuProgress> pmuProgress = commonRepository.findAll("FETCH_Pmu_Progress_progress_report_BASED_ID", params);
        if (!pmuProgress.isEmpty() && pmuProgress.get(0) != null) {
            return pmuProgress.get(0);
        } else
            return null;
    }

    @Override
    public void savePmu(PmuProgress pmuProgress) {

        List<PmuProgressDetails> pmuProgressDetails = pmuProgress.getPmuProgressDetails();
        List<QprPmuWiseProposedDomainExperts> qprPmuWiseProposedDomainExperts = pmuProgress.getQprPmuWiseProposedDomainExperts();
        pmuProgress.setLastUpdatedBy(userPreference.getUserId());
        pmuProgress.setCreatedBy(userPreference.getUserId());
        pmuProgress.setQuarterDuration(pmuProgress.getQuarterDuration());
        for (PmuProgressDetails Details : pmuProgressDetails) {
            if (Details != null) {
                Details.setPmuProgress(pmuProgress);
            }
        }
        
        qprPmuWiseProposedDomainExperts.forEach(obj ->{
        	obj.setPmuProgress(pmuProgress);
        });
        
        pmuProgress.setQprPmuWiseProposedDomainExperts(qprPmuWiseProposedDomainExperts);
        if (pmuProgress.getQprPmuId() == null) {
            commonRepository.save(pmuProgress);
        } else {
            commonRepository.update(pmuProgress);
        }

        /* this method is to insert and update record in quater_wise_fund table*/
        saveQprWiseFundData(userPreference.getStateCode(), userPreference.getFinYearId(), pmuProgress.getQuarterDuration().getQtrId(), 12);
    }

    @Override
    public void saveQprIncomeEnhancement(QprIncomeEnhancement qprIncomeEnhancement) {
        qprIncomeEnhancement.setCreatedBy(userPreference.getUserId());
        qprIncomeEnhancement.setIsFreeze(false);
        qprIncomeEnhancement.setLastUpdatedBy(userPreference.getUserId());
        List<QprIncomeEnhancementDetails> enhancementDetails = qprIncomeEnhancement.getQprIncomeEnhancementDetails();
        for (QprIncomeEnhancementDetails qprIncomeEnhancementDetails : enhancementDetails) {
            qprIncomeEnhancementDetails.setQprIncomeEnhancement(qprIncomeEnhancement);
        }
        if (qprIncomeEnhancement.getQprIncomeEnhancementId() == null) {
            commonRepository.save(qprIncomeEnhancement);
        } else {
            qprIncomeEnhancement.setIsFreeze(false);
            commonRepository.update(qprIncomeEnhancement);
        }

        /* this method is to insert and update record in quater_wise_fund table*/
        saveQprWiseFundData(userPreference.getStateCode(), userPreference.getFinYearId(), qprIncomeEnhancement.getQuarterDuration().getQtrId(), 10);
    }


    @Override
    public QprIncomeEnhancement fetchQprIncmEnhncmnt(int incomeEnhancementId, int quarterId) {
        List<QprIncomeEnhancement> qprIncomeEnhancement = null;
        Map<String, Object> params = new HashMap<>();
        params.put("quarterId", quarterId);
        params.put("incomeEnhancementId", incomeEnhancementId);
        qprIncomeEnhancement = commonRepository.findAll("QPR_INCM_ENHNCMNT_REPORT_BASED_ON_QUARTER", params);
        if (!qprIncomeEnhancement.isEmpty()) {
            return qprIncomeEnhancement.get(0);
        } else
            return null;
    }

    @Override
    public void FrzUnfrzIncomeEnhancmnt(QprIncomeEnhancement qprIncomeEnhancement) {
        Map<String, Object> params = new HashMap<>();
        if (qprIncomeEnhancement.getIsFreeze() == true) {
            params.put("isFreeze", false);
        } else if (qprIncomeEnhancement.getIsFreeze() == false) {
            params.put("isFreeze", true);
        }
        params.put("qprIncomeEnhancementId", qprIncomeEnhancement.getQprIncomeEnhancementId());
        commonRepository.excuteUpdate("UPDATE_QPR_FRZUNFREEZ_STATUS", params);

    }

    @Override
    public IecQuater getfetchIecQuaterProgressReportToGeReportId(Integer id) {
        Map<String, Object> params = new HashMap<String, Object>();
        params.put("id", id);
        List<IecQuater> iecQuater = commonRepository.findAll("FETCH_IEC__REPORT_BASED_ID", params);
        if (!iecQuater.isEmpty() && iecQuater.get(0) != null) {
            return iecQuater.get(0);
        } else
            return null;
    }

    @Override
    public IecQuater getSatcomProgress(Integer id, int quarterId) {
        Map<String, Object> params = new HashMap<String, Object>();
        params.put("id", id);
        params.put("qtrId", quarterId);

        List<IecQuater> iecQuaters = commonRepository.findAll("FETCH_IEC_REPORT_DETAILS", params);
        if (!iecQuaters.isEmpty() && iecQuaters.get(0) != null) {
            return iecQuaters.get(0);
        } else

            return null;
    }

    @Override
    public void saveIec(IecQuater iecQuater) {
        iecQuater.setCreatedBy(userPreference.getUserId());
        iecQuater.setIsFreeze(false);
        iecQuater.setLastUpdatedBy(userPreference.getUserId());
        iecQuater.getIecQuaterDetails().setIecQuater(iecQuater);
        if (iecQuater.getQprIecId() == null) {
            commonRepository.save(iecQuater);
        } else {
            commonRepository.update(iecQuater);
        }
        /* this method is to insert and update record in quater_wise_fund table*/
        saveQprWiseFundData(userPreference.getStateCode(), userPreference.getFinYearId(), iecQuater.getQuarterDuration().getQtrId(), 11);
    }

    @Override
    public QprCbActivity fetchQprCapcityBuilding(Integer cbActivityId, Integer showQqrtrId) {
        List<QprCbActivity> qprCbActivity = null;
        Map<String, Object> params = new HashMap<>();
        params.put("stateCode", userPreference.getStateCode());
        params.put("yearId", userPreference.getFinYearId());
        params.put("quarterId", showQqrtrId);
        params.put("cbActivityId", cbActivityId);
        qprCbActivity = commonRepository.findAll("QPR_CAPACITY_BUILDING_REPORT_BASED_ON_QUARTER", params);
        if (!qprCbActivity.isEmpty()) {
            return qprCbActivity.get(0);
        } else
            return null;
    }

    @Override
    public void saveQprCbActivity(QprCbActivity qprCbActivity) {
        qprCbActivity.setCreatedBy(userPreference.getUserId());
        qprCbActivity.setLastUpdatedBy(userPreference.getUserId());
        qprCbActivity.setIsFreeze(false);

        List<QprCbActivityDetails> qprCbActivityDetails = qprCbActivity.getQprCbActivityDetails();
        for (QprCbActivityDetails details : qprCbActivityDetails) {
            details.setQprCbActivity(qprCbActivity);
        }
        qprCbActivity.getQprCbActivityDetails().get(0).getQprTnaTrgEvaluation().setCbActivityDetails(qprCbActivityDetails.get(0));
        qprCbActivity.getQprCbActivityDetails().get(1).getQprTrgMaterialAndModule().setCbActivityDetails(qprCbActivityDetails.get(1));
        qprCbActivity.getQprCbActivityDetails().get(2).getQprTrgMaterialAndModule().setCbActivityDetails(qprCbActivityDetails.get(2));
        qprCbActivity.getQprCbActivityDetails().get(3).getQprTnaTrgEvaluation().setCbActivityDetails(qprCbActivityDetails.get(3));
        qprCbActivity.getQprCbActivityDetails().get(6).getQprHandholdingGpdp().setCbActivityDetails(qprCbActivityDetails.get(6));
        qprCbActivity.getQprCbActivityDetails().get(7).getQprPanchayatLearningCenter().setCbActivityDetails(qprCbActivityDetails.get(7));
        if (qprCbActivity.getQpCbActivityId() == null) {
            commonRepository.save(qprCbActivity);
        } else {
            commonRepository.update(qprCbActivity);
        }

        /* this method is to insert and update record in quater_wise_fund table*/
        saveQprWiseFundData(userPreference.getStateCode(), userPreference.getFinYearId(), qprCbActivity.getQuarterDuration().getQtrId(), 13);
    }

    @Override
    public QprEnablement fetchQprEnablement(Integer eEnablementId, int quarterId) {
        Map<String, Object> params = new HashMap<String, Object>();
        params.put("eEnablementId", eEnablementId);
        params.put("qtrId", quarterId);

        List<QprEnablement> qprEnablement = commonRepository.findAll("FETCH_QPR_ENABLEMENT_REPORT_DETAILS", params);
        if (!qprEnablement.isEmpty() && qprEnablement.get(0) != null) {
            return qprEnablement.get(0);
        } else
            return null;
    }

    @Override
    public QprEnablement fetchEEnablementProgressToGeReportId1(Integer id) {
        Map<String, Object> params = new HashMap<String, Object>();
        params.put("eEnablementId", id);
        List<QprEnablement> qprEnablement = commonRepository.findAll("FETCH_QPR_ENABLEMENT_REPORT_BASED_ID", params);
        if (!qprEnablement.isEmpty() && qprEnablement.get(0) != null) {
            return qprEnablement.get(0);
        } else
            return null;
    }

    @Override
    public void saveEnablement(QprEnablement qprEnablement) {
        if (qprEnablement.getQprEEnablementId() == null) {
            qprEnablement.setCreatedBy(userPreference.getUserId());

            qprEnablement.setLastUpdatedBy(userPreference.getUserId());

            List<QprEnablementDetails> qprEnablementDetails = qprEnablement.getQprEnablementDetails();
            for (QprEnablementDetails qprEnablementDetail : qprEnablementDetails) {
                qprEnablementDetail.setQprEnablement(qprEnablement);
            }
            commonRepository.save(qprEnablement);
        } else {

            qprEnablement.setLastUpdatedBy(userPreference.getUserId());
            List<QprEnablementDetails> qprEnablementDetails = qprEnablement.getQprEnablementDetails();
            for (QprEnablementDetails qprEnablementDetail : qprEnablementDetails) {
                qprEnablementDetail.setQprEnablement(qprEnablement);
            }
            commonRepository.update(qprEnablement);
        }
        /* this method is to insert and update record in quater_wise_fund table*/
        saveQprWiseFundData(userPreference.getStateCode(), userPreference.getFinYearId(), qprEnablement.getQuarterDuration().getQtrId(), 5);
    }

    @Override
    public QprInnovativeActivity getInnovative(Integer id, int quarterId) {
        Map<String, Object> params = new HashMap<String, Object>();
        params.put("innovativeActivityId", id);
        params.put("qtrId", quarterId);

        List<QprInnovativeActivity> qprInnovativeActivity = commonRepository.findAll("FETCH_INNOVATIVE_REPORT_DETAILS", params);
        if (!qprInnovativeActivity.isEmpty() && qprInnovativeActivity.get(0) != null) {
            return qprInnovativeActivity.get(0);
        } else

            return null;
    }

    @Override
    public void saveInnovative(QprInnovativeActivity qprInnovativeActivity) {
        qprInnovativeActivity.setCreatedBy(userPreference.getUserId());
        qprInnovativeActivity.setIsFreeze(false);
        qprInnovativeActivity.setLastUpdatedBy(userPreference.getUserId());
        List<QprInnovativeActivityDetails> innovativeActivityDetail = qprInnovativeActivity.getQprInnovativeActivityDetails();
        for (QprInnovativeActivityDetails innovativeActivityDetails : innovativeActivityDetail) {
            innovativeActivityDetails.setQprInnovativeActivity(qprInnovativeActivity);
        }
        if (qprInnovativeActivity.getQprIaId() == null) {
            commonRepository.save(qprInnovativeActivity);
        } else {
            commonRepository.update(qprInnovativeActivity);
        }

        /* this method is to insert and update record in quater_wise_fund table*/
        saveQprWiseFundData(userPreference.getStateCode(), userPreference.getFinYearId(), qprInnovativeActivity.getQuarterDuration().getQtrId(), 9);
    }

    @Override
    public QprInnovativeActivity getfetchInnovativeProgressReportToGeReportId(Integer id) {
        Map<String, Object> params = new HashMap<String, Object>();
        params.put("innovativeActivityId", id);
        List<QprInnovativeActivity> qprInnovativeActivities = commonRepository.findAll("FETCH_INNOVATIVE__REPORT_BASED_ID", params);
        if (!qprInnovativeActivities.isEmpty() && qprInnovativeActivities.get(0) != null) {
            return qprInnovativeActivities.get(0);
        } else
            return null;
    }

    @Override
    public QprAdminAndFinancialDataActivity fetchQprAdminFin(int activityId, int quarterId) {
        List<QprAdminAndFinancialDataActivity> qprAdminAndFinancialDataActivities = null;
        Map<String, Object> params = new HashMap<>();
        params.put("activityId", activityId);
        params.put("quarterId", quarterId);
        qprAdminAndFinancialDataActivities = commonRepository.findAll("QPR_ADMIN_FINANCIALDATA_ACTIVITY_REPORT_BASED_ON_QUARTER", params);
        if (!qprAdminAndFinancialDataActivities.isEmpty()) {
            return qprAdminAndFinancialDataActivities.get(0);
        } else
            return null;
    }

    @Override
    public void saveAdminDataFinQuaterly(QprAdminAndFinancialDataActivity qprAdminAndFinancialDataActivity) {
        qprAdminAndFinancialDataActivity.setCreatedBy(userPreference.getUserId());
        qprAdminAndFinancialDataActivity.setCreatedOn(qprAdminAndFinancialDataActivity.getCreatedOn());
        qprAdminAndFinancialDataActivity.setLastUpdatedBy(userPreference.getUserId());
        qprAdminAndFinancialDataActivity.setLastUpdatedOn(qprAdminAndFinancialDataActivity.getLastUpdatedOn());
        List<QprAdminAndFinancialDataActivityDetails> qprAdminAndFinancialDataActivityDetails = qprAdminAndFinancialDataActivity.getQprAdminAndFinancialDataActivityDetails();
        for (QprAdminAndFinancialDataActivityDetails qprAdminAndFinancialDataActivityDetail : qprAdminAndFinancialDataActivityDetails) {
            qprAdminAndFinancialDataActivityDetail.setQprAdminAndFinancialDataActivity(qprAdminAndFinancialDataActivity);
        }

        if (qprAdminAndFinancialDataActivity.getQprAfpId() == null) {
            commonRepository.save(qprAdminAndFinancialDataActivity);
        } else {
            commonRepository.update(qprAdminAndFinancialDataActivity);
        }
        /* this method is to insert and update record in quater_wise_fund table*/
        saveQprWiseFundData(userPreference.getStateCode(), userPreference.getFinYearId(), qprAdminAndFinancialDataActivity.getQuarterDuration().getQtrId(), 8);
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
        Map<String, Object> params = new HashMap<>();
        params.put("stateCode", stateCode);
        params.put("quarterId", quarterId);
        params.put("componentId", componentId);
        return commonRepository.findAll("FETCH_QUATOR_WISE_FUND", params);
    }

    @Override
    public List<QprEnablementDetails> fetchQprEnablementDetails(Integer qprEEnablementId) {
        Map<String, Object> params = new HashMap<>();
        params.put("qprEEnablementId", qprEEnablementId);
        return commonRepository.findAll("FETCH_EENABLEMENT_QPR_DETAILS", params);
    }

    @Override
    public List<QuaterWiseFund> fetchTotalQuaterWiseFundData(Integer stateCode, int componentId) {
        Map<String, Object> params = new HashMap<>();
        params.put("stateCode", stateCode);
        params.put("componentId", componentId);
        return commonRepository.findAll("FETCH_ALL_QUATOR_WISE_FUND", params);
    }


    public List<StateAllocation> fetchStateAllocationData(int componentId, int installmentNo,int planCode) {
        Map<String, Object> params = new HashMap<>();
        params.put("componentId", componentId);
        params.put("installmentNo", installmentNo);
        params.put("planCode", planCode);
        return commonRepository.findAll("FETCH_STATE_ALLOCATION_BY_COMP_ID_AND_INSTALL_NO", params);
    }


    public List<StateAllocation> fetchStateAllocationData(int componentId, int subComponentId, int installmentNo,int planCode) {
        Map<String, Object> params = new HashMap<>();
        params.put("componentId", componentId);
        params.put("installmentNo", installmentNo);
        params.put("subComponentId", subComponentId);
        params.put("planCode", planCode);
        return commonRepository.findAll("FETCH_STATE_ALLOCATION_BY_COMP_ID_AND_SUBCOMPID_AND_INSTALL_NO", params);
    }


    public List<QprCbActivityDetails> getQprTrainActBasedOnActIdAndQtrId(Integer cbActivityId, int quarterId) {
        Map<String, Object> params = new HashMap();
        params.put("cbActivityId", cbActivityId);
        params.put("quarterId", quarterId);
        List<QprCbActivity> qprCbActivities = commonRepository.findAll("FETCH_QPR_TRAINING_ACT_BY_QTR_ID_AND_ACT_ID", params);
        List<QprCbActivityDetails> qprCbActivityDetails = new ArrayList<>();
        if (CollectionUtils.isNotEmpty(qprCbActivities)) {
            for (QprCbActivity qprCbActivity : qprCbActivities) {
                qprCbActivityDetails.addAll(qprCbActivity.getQprCbActivityDetails());
            }
            return qprCbActivityDetails;
        } else {
            return null;
        }
    }

    @Override
    public List<StateAllocation> fetchStateAllocationDataByCompIdandInstallNo(int componentId, int installmentNo) {
        Map<String, Object> params = new HashMap<>();
        params.put("componentId", componentId);
        params.put("installmentNo", installmentNo);
        return commonRepository.findAll("FETCH_STATE_ALLOCATION_BY_COMP_ID_AND_INSTALL_NO", params);
    }

    @Override
    public List<SubcomponentwiseQuaterBalance> fetchSubcomponentwiseQuaterBalance(Integer componentId, Integer quaterId) {
        Map<String, Object> params = new HashMap<>();
        params.put("stateCode", userPreference.getStateCode());
        params.put("yearId", userPreference.getFinYearId());
        params.put("componentId", componentId);
        params.put("quaterId", quaterId);
        return commonRepository.findAll("FETCH_Subcomponent_wise_Quater_Balance", params);
    }

    @Override
    public void saveInstitutionalInfraProgressReport(QprInstitutionalInfrastructure qprInstitutionalInfrastructure) {

        FileNodeUtils uploadReport = null;
        MultipartFile multipartFile = null;

        try {

            String uploadPath = innovativeActivityService.findfilePath().getFileLocation();
            if (qprInstitutionalInfrastructure.getQprInstInfraId() == null) {
                qprInstitutionalInfrastructure.setCreatedBy(userPreference.getUserId());
                qprInstitutionalInfrastructure.setCreatedOn(new Date());
            } else {
                Map<String, Object> params = new HashMap<>();
                params.put("additionalRequirement", qprInstitutionalInfrastructure.getAdditionalRequirement());
                params.put("additionalRequirementDPRC", qprInstitutionalInfrastructure.getAdditionalRequirementDPRC());
                params.put("qprInstInfraId", qprInstitutionalInfrastructure.getQprInstInfraId());
                commonRepository.excuteUpdate("UPDATE_QPR_INST_ACTIVITY_DEPEND_ON_QUATOR", params);
            }

            qprInstitutionalInfrastructure.setLastUpdatedBy(userPreference.getUserId());
            qprInstitutionalInfrastructure.setLastUpdateOn(new Date());

            List<QprInstitutionalInfraDetails> updateQprInstitutionalInfraDetailsList = new ArrayList<QprInstitutionalInfraDetails>();

            for (QprInstitutionalInfraDetails obj : qprInstitutionalInfrastructure.getQprInstitutionalInfraDetails()) {
                obj.setQprInstitutionalInfrastructure(qprInstitutionalInfrastructure);
                if (obj.getExpenditureIncurred() != null && obj.getInstInfraStatusId() != null) {
                    multipartFile = obj.getFile();
                    if (multipartFile.getSize() > 0) {
                        uploadReport = attemptUpload(obj.getFileNode(), multipartFile, uploadPath, qprInstitutionalInfrastructure.getQtrId(), "institutional");
                        obj.setFileNode(uploadReport.getFileNode());
                        updateQprInstitutionalInfraDetailsList.add(obj);
                    } else {
                        obj.setFileNode(null);
                    }
                }
            }

            for (QprInstitutionalInfraDetails obj : updateQprInstitutionalInfraDetailsList) {

                if (qprInstitutionalInfrastructure.getQprInstInfraId() != null) {
                    if (obj.getQprInstInfraDetailsId() == null) {
                        commonRepository.save(obj);
                    } else {
                        commonRepository.update(obj);
                    }
                }

            }


            if (qprInstitutionalInfrastructure.getQprInstInfraId() == null) {
                qprInstitutionalInfrastructure.setQprInstitutionalInfraDetails(updateQprInstitutionalInfraDetailsList);
                commonRepository.save(qprInstitutionalInfrastructure);


            }

            this.saveQprWiseFundData(userPreference.getStateCode(), userPreference.getFinYearId(), qprInstitutionalInfrastructure.getQtrId(), 2);

        } catch (Exception e) {
            e.printStackTrace();
        }

    }

    private FileNodeUtils attemptUpload(FileNode fileNode, MultipartFile multipartFile, String uploadPath, Integer quarterId, String string) {
        FileNodeUtils uploadReport;

        if (fileNode != null && fileNode.getFileNodeId() != null) {
            // if file node is not loaded
            if (fileNode.getFileName() == null)
                fileNode = this.loadFileNode(fileNode);
            uploadReport = FileNodeUtils.updateFile(multipartFile, fileNode);
            if (uploadReport.getUploadStatus() == FileNodeUtils.UPLOAD_STATUS.REQUESTED_FAILED)
                throw new RuntimeException();
        } else {
            uploadReport = FileNodeUtils.createNewFile(multipartFile, uploadPath, getNameForFile(quarterId, string, "pdf"));
            if (uploadReport.getUploadStatus() == FileNodeUtils.UPLOAD_STATUS.REQUESTED_FAILED)
                throw new RuntimeException();
        }
        return uploadReport;
    }

    private String getNameForFile(Integer quarterId, String formName, String extension) {
        return String.format("Uploaded_QprCbActivity_%d_%d_%d_%s.%s", userPreference.getStateCode(), userPreference.getFinYearId(), quarterId, formName, extension);
    }


    @Override
    public FileNode loadFileNode(FileNode fileNode) {
        return commonRepository.find(FileNode.class, fileNode.getFileNodeId());
    }

    @Override
    public FileNode getUploadedFile(Integer fileNodeId) {
        return commonRepository.find(FileNode.class, fileNodeId);
    }
    
    @Override
    public String getBalanceAdditionalReqiurment(Integer componentId,Integer quaterId) {
    	Map<String, Object> params=new HashMap<>();
		params.put("stateCode", userPreference.getStateCode());
		params.put("yearId", userPreference.getFinYearId());
		params.put("componentId", componentId);
		params.put("quaterId", quaterId);
		// return balnce of additonal requirment sprc and dprc
		String addReqirmentDetails = commonRepository.find("FETCH_Component_wise_Additional_Requirment_Quater_Balance", params);
		return addReqirmentDetails;
    }
    
    @Override
    public void saveQprPanchayatBhawan(QprPanchayatBhawan qprPanchayatBhawan) {

        FileNodeUtils uploadReport = null;
        MultipartFile multipartFile = null;

        try {
        	int districtCode =qprPanchayatBhawan.getSelectDistrictId();
            String uploadPath = innovativeActivityService.findfilePath().getFileLocation();
            if (qprPanchayatBhawan.getQprPanchayatBhawanId() == null) {
            	qprPanchayatBhawan.setCreatedBy(userPreference.getUserId());
            	qprPanchayatBhawan.setCreatedOn(new Date());
            } else {
                Map<String, Object> params = new HashMap<>();
                params.put("additionalRequirement", qprPanchayatBhawan.getAdditionalRequirement());
               params.put("qprInstInfraId", qprPanchayatBhawan.getQprPanchayatBhawanId());
                commonRepository.excuteUpdate("UPDATE_QPR_Panchayat_Bhawan_DEPEND_ON_QUATOR", params);
            }

            qprPanchayatBhawan.setLastUpdatedBy(userPreference.getUserId());
            qprPanchayatBhawan.setLastUpdatedOn(new Date());

            List<QprPanhcayatBhawanDetails> updateQprPanhcayatBhawanDetailsList = new ArrayList<QprPanhcayatBhawanDetails>();

            for (QprPanhcayatBhawanDetails obj : qprPanchayatBhawan.getQprPanhcayatBhawanDetails()) {
                obj.setQprPanchayatBhawan(qprPanchayatBhawan);
                if (obj.getExpenditureIncurred() != null && obj.getGpBhawanStatusId() != null) {
                    multipartFile = obj.getFile();
                    if (multipartFile!=null && multipartFile.getSize() > 0) {
                        uploadReport = attemptUpload(obj.getFileNode(), multipartFile, uploadPath, qprPanchayatBhawan.getQtrId(), "panchayat bhwan");
                        obj.setFileNode(uploadReport.getFileNode());
                        obj.setDistrictCode(districtCode);
                        updateQprPanhcayatBhawanDetailsList.add(obj);
                    } else {
                        obj.setFileNode(null);
                    }
                }
            }

            for (QprPanhcayatBhawanDetails obj : updateQprPanhcayatBhawanDetailsList) {

                if (qprPanchayatBhawan.getQprPanchayatBhawanId() != null) {
                    if (obj.getQprPanhcayatBhawanDetailsId() == null) {
                        commonRepository.save(obj);
                    } else {
                        commonRepository.update(obj);
                    }
                }

            }


            if (qprPanchayatBhawan.getQprPanchayatBhawanId() == null) {
            	qprPanchayatBhawan.setQprPanhcayatBhawanDetails(updateQprPanhcayatBhawanDetailsList);
                commonRepository.save(qprPanchayatBhawan);


            }

            this.saveQprWiseFundData(userPreference.getStateCode(), userPreference.getFinYearId(), qprPanchayatBhawan.getQtrId(), 3);

        } catch (Exception e) {
            e.printStackTrace();
        }

    }
    
    @Override
	public List<District> getDistrictBasedOnPNCHAYATBHAWANnState(Integer activityId) {
		// TODO Auto-generated method stub
		Map<String, Object> params=new HashMap<String,Object>();
		params.put("stateCode", userPreference.getStateCode());
		params.put("yearId", userPreference.getFinYearId());
		params.put("activityId",activityId);
		return commonRepository.findAll("PNCHAYAT_BHAWAN_DISTRICT_LIST_BY_STATE_CODE", params);
	}
    
    @Override
    public BigDecimal subTOTALofOTHERQPRPANCHAYATBHAWAN() {
    	 Map<String, Object> params=new HashMap<>();
    	params.put("stateCode", userPreference.getStateCode());
		params.put("yearId", userPreference.getFinYearId());
		BigDecimal otherTotal = (BigDecimal)commonRepository.find("SUB_TOTAL_OTHER_PANCHAYAT_BHAWAN", params);
		return otherTotal;
    }
    
    @Override
    public Map<String,Object> fetchTrainingDetailsCEC(Integer qtrId){
    	
    	List<FetchTrainingDetails> fetchTrainingDetailsList=new ArrayList<FetchTrainingDetails>();
		FetchTraining fetchTraining=null;
		Map<String,Object> data = new HashMap<>();
		Map<String,Object> params = null;
    	
			fetchTraining=new FetchTraining();
			fetchTrainingDetailsList=new ArrayList<FetchTrainingDetails>();
			params = new HashMap<>();
			params.put("yearId", userPreference.getFinYearId());
			params.put("versionId", userPreference.getPlanVersion());
			params.put("stateCode", userPreference.getStateCode());
			params.put("userType", 'C');
			List<FetchTraining> fetchTrainingList = commonRepository.findAll("Fetch_Training", params);
			
			if(fetchTrainingList!=null && !fetchTrainingList.isEmpty()) {
				fetchTraining=fetchTrainingList.get(0);
				Integer trainingActivityId=fetchTraining.getTrainingActivityId();
				params = new HashMap<>();
				params.put("trainingActivityId", trainingActivityId);
				params.put("isactive", Boolean.TRUE);
				fetchTrainingDetailsList = commonRepository.findAll("Fetch_Training_Details", params);
				data.put("fetchTrainingCEC", fetchTraining);
				data.put("fetchTrainingDetailsListCEC", fetchTrainingDetailsList);
			}
			
			 params = new HashMap<>();
			 params.put("qtrId", qtrId);
			 params.put("trainingActivityId", fetchTraining.getTrainingActivityId());
			List<QuarterTrainings> quarterTrainingsList = commonRepository.findAll("FETCH_QPR_TRAINING_DETAIL_DEPEND_ON_QUATOR", params);
			data.put("quarterTrainings", quarterTrainingsList);
			
			return data;
    }
    
    @Override
    public void savetrainingProgressReport(QuarterTrainings quarterTrainings) {

        FileNodeUtils uploadReport = null;
        MultipartFile multipartFile = null;
        int index;
        if(quarterTrainings.getDetailsListsIndex() != null)
        	 index = quarterTrainings.getDetailsListsIndex();

        try {

            String uploadPath = innovativeActivityService.findfilePath().getFileLocation();
            if (quarterTrainings.getQprTrainingsId() == null) {
            	quarterTrainings.setCreatedBy(userPreference.getUserId());
            	quarterTrainings.setCreatedOn(new Date());
            } else {
                Map<String, Object> params = new HashMap<>();
                params.put("additionalRequirement", quarterTrainings.getAdditionalRequirement());
                params.put("qprTrainingsId", quarterTrainings.getQprTrainingsId());
                commonRepository.excuteUpdate("UPDATE_QPR_TRAINING_DETAIL_DEPEND_ON_QUATOR", params);
            }

            quarterTrainings.setLastUpdatedBy(userPreference.getUserId());
            quarterTrainings.setLastUpdateOn(new Date());

            List<QuarterTrainingsDetails> updateQuarterTrainingsDetailsList = new ArrayList<QuarterTrainingsDetails>();

            for (QuarterTrainingsDetails obj : quarterTrainings.getQuarterTrainingsDetailsList()) {
                obj.setQuarterTrainings(quarterTrainings);
                //if (obj.getExpenditureIncurred() != null ) {
                    multipartFile = obj.getFile();
                    if (multipartFile.getSize() > 0) {
                        uploadReport = attemptUpload(obj.getFileNode(), multipartFile, uploadPath, quarterTrainings.getQtrId(), "QPR Training Detail");
                        obj.setFileNode(uploadReport.getFileNode());
                       
                    } else {
                    	if(!(obj.getFileNode()!=null && obj.getFileNode().getFileNodeId()!=null)) {
                    		obj.setFileNode(null);
                    	}else {
                    		  obj.setFileNode(this.loadFileNode(obj.getFileNode()));
                    	}
                        
                    }
                    
                    if(obj.getQprTrainingBreakup() != null) {
                    	List<QprTrainingBreakup> breakUpList=obj.getQprTrainingBreakup();
                    	 for(QprTrainingBreakup data : breakUpList) {
               			  data.setQuarterTrainingsDetails(obj);
       			  		}
                    	 obj.setQprTrainingBreakup(breakUpList);
                    }
                    updateQuarterTrainingsDetailsList.add(obj);
              //  }
            }

            for (QuarterTrainingsDetails obj : updateQuarterTrainingsDetailsList) {

                if (quarterTrainings.getQprTrainingsId() != null) {
                    if (obj.getQprTrainingsDetailsId() == null) {
                        commonRepository.save(obj);
                    } else {
                        commonRepository.update(obj);
                    }
                }

            }
            
           // int index = quarterTrainings.getDetailsListsIndex();
            //List<QprTrainingBreakup> breakUpList=quarterTrainings.getQuarterTrainingsDetailsList().get(index).getQprTrainingBreakup();
			/*
			 * for(QprTrainingBreakup data : breakUpList) {
			 * data.setQuarterTrainingsDetails(quarterTrainings.
			 * getQuarterTrainingsDetailsList().get(index));
			 * if(data.getQprTrainingBreakupId() == null) { commonRepository.save(data);
			 * }else { commonRepository.update(data); } }
			 */


            if (quarterTrainings.getQprTrainingsId() == null) {
            	quarterTrainings.setQuarterTrainingsDetailsList(updateQuarterTrainingsDetailsList);
                commonRepository.save(quarterTrainings);
            }

            this.saveQprWiseFundData(userPreference.getStateCode(), userPreference.getFinYearId(), quarterTrainings.getQtrId(), 1);

        } catch (Exception e) {
            e.printStackTrace();
        }

    }

	@Override
	public int getCurrentPlanCode() {
		Map<String,Object> map=new HashMap();
		map.put("stateCode", userPreference.getStateCode());
		map.put("yearId",userPreference.getFinYearId());
		Plan plan= (Plan)commonRepository.find("GET_PLAN_CURRENT", map);
		if(plan == null) {
			return 0;
		}else {
			return plan.getPlanCode();
		}
	}

	@Override
	public List<QprTrainingBreakup> fetchTrainingBreakUpData(int qprTrainingsDetailsId) {
		Map<String,Object> map=new HashMap();
		map.put("qprTrainingsDetailsId", qprTrainingsDetailsId);
		return commonRepository.findAll("FETCH_BREAK_UP_BY_QPR_TRAINING_DETAIL_ID", map);
	}

	@Override
	public void savetrainingBreakUpData(QuarterTrainings quarterTrainings) {
		savetrainingProgressReport(quarterTrainings);
		
		/*
		 * int index = quarterTrainings.getDetailsListsIndex(); List<QprTrainingBreakup>
		 * breakUpList=quarterTrainings.getQuarterTrainingsDetailsList().get(index).
		 * getQprTrainingBreakup(); for(QprTrainingBreakup data : breakUpList) {
		 * data.setQuarterTrainingsDetails(quarterTrainings.
		 * getQuarterTrainingsDetailsList().get(index));
		 * if(data.getQprTrainingBreakupId() == null) { commonRepository.save(data);
		 * }else { commonRepository.update(data); } }
		 */
		
	}
	
	

	@Override
	public void freezeAndUnfreezeReport(Integer componentId, Integer activityId, Integer quaterId, String msg) {
		boolean isFreeze = (msg.equalsIgnoreCase("freeze")) ? true : false;
		switch(componentId) {
		case 1 :
			TrainingProgressReport  trainingProgressReport= commonRepository.find(TrainingProgressReport.class, activityId);
			if(trainingProgressReport != null) {
				trainingProgressReport.setIsFreeze(isFreeze);
				commonRepository.update(trainingProgressReport);
			}
			break;
		case 2 :
			QprInstitutionalInfrastructure  qprInstitutionalInfrastructure= commonRepository.find(QprInstitutionalInfrastructure.class, activityId);
			if(qprInstitutionalInfrastructure != null) {
				qprInstitutionalInfrastructure.setIsFreeze(isFreeze);
				commonRepository.update(qprInstitutionalInfrastructure);
			}
			break;
		case 3 : 
			QprPanchayatBhawan  qprPanchayatBhawan= commonRepository.find(QprPanchayatBhawan.class, activityId);
			if(qprPanchayatBhawan != null) {
				qprPanchayatBhawan.setIsFreeze(isFreeze);
				commonRepository.update(qprPanchayatBhawan);
			}
			break;
		case 4 :
			AdministrativeTechnicalProgress  administrativeTechnicalProgress= commonRepository.find(AdministrativeTechnicalProgress.class, activityId);
			if(administrativeTechnicalProgress != null) {
				administrativeTechnicalProgress.setIsFreeze(isFreeze);
				commonRepository.update(administrativeTechnicalProgress);
			}
			break;
		case 5 :
			QprEnablement  qprEnablement= commonRepository.find(QprEnablement.class, activityId);
			if(qprEnablement != null) {
				qprEnablement.setIsFreeze(isFreeze);
				commonRepository.update(qprEnablement);
			}
			break;
		case 6 : 
			QprPesa  qprPesa= commonRepository.find(QprPesa.class, activityId);
			if(qprPesa != null) {
				qprPesa.setIsFreeze(isFreeze);
				commonRepository.update(qprPesa);
			}
			break;
		case 7 :
			SatcomActivityProgress  satcomActivityProgress= commonRepository.find(SatcomActivityProgress.class, activityId);
			if(satcomActivityProgress != null) {
				satcomActivityProgress.setIsFreeze(isFreeze);
				commonRepository.update(satcomActivityProgress);
			}
			break;
		case 8 :
			QprAdminAndFinancialDataActivity  qprAdminAndFinancialDataActivity= commonRepository.find(QprAdminAndFinancialDataActivity.class, activityId);
			if(qprAdminAndFinancialDataActivity != null) {
				qprAdminAndFinancialDataActivity.setIsFreeze(isFreeze);
				commonRepository.update(qprAdminAndFinancialDataActivity);
			}
			break;
		case 9 :
			QprInnovativeActivity  qprInnovativeActivity= commonRepository.find(QprInnovativeActivity.class, activityId);
			if(qprInnovativeActivity != null) {
				qprInnovativeActivity.setIsFreeze(isFreeze);
				commonRepository.update(qprInnovativeActivity);
			}
			break;
		case 10 :
			QprIncomeEnhancement  qprIncomeEnhancement= commonRepository.find(QprIncomeEnhancement.class, activityId);
			if(qprIncomeEnhancement != null) {
				qprIncomeEnhancement.setIsFreeze(isFreeze);
				commonRepository.update(qprIncomeEnhancement);
			}
			break;
		case 11 :
			IecQuater  iecQuater= commonRepository.find(IecQuater.class, activityId);
			if(iecQuater != null) {
				iecQuater.setIsFreeze(isFreeze);
				commonRepository.update(iecQuater);
			}
			break;
		case 12 :
			PmuProgress  pmuProgress= commonRepository.find(PmuProgress.class, activityId);
			if(pmuProgress != null) {
				pmuProgress.setIsFreeze(isFreeze);
				commonRepository.update(pmuProgress);
			}
			break;	
		case 13 :
			QprCbActivity  qprCbActivity= commonRepository.find(QprCbActivity.class, activityId);
			if(qprCbActivity != null) {
				qprCbActivity.setIsFreeze(isFreeze);
				commonRepository.update(qprCbActivity);
			}
			break;
		case 14 :
			AdditionalFacultyProgress  additionalFacultyProgress= commonRepository.find(AdditionalFacultyProgress.class, activityId);
			if(additionalFacultyProgress != null) {
				additionalFacultyProgress.setIsFreeze(isFreeze);
				commonRepository.update(additionalFacultyProgress);
			}
			break;
		case 15 : 
			QprEGov  qprEGov= commonRepository.find(QprEGov.class, activityId);
			if(qprEGov != null) {
				qprEGov.setIsFreeze(isFreeze);
				commonRepository.update(qprEGov);
			}
			break;
		}
 	}

	@Override
	public <T extends IFreezable> void freezeAndUnfreezeReport(Class<T> clazz, Integer qprActivityId, Boolean isFreeze) {
		T  entity= commonRepository.find(clazz, qprActivityId);
		if(entity != null) {
			entity.setIsFreeze(isFreeze);
			commonRepository.update(entity);
		}
		
		
	}
    

}
