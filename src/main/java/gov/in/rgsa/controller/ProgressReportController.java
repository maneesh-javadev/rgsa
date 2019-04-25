package gov.in.rgsa.controller;

import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.io.FilenameUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import gov.in.rgsa.dto.EEnablementReportDto;
import gov.in.rgsa.dto.GramPanchayatProgressReportDTO;
import gov.in.rgsa.dto.InstitutionalInfraProgressReportDTO;
import gov.in.rgsa.entity.AdditionalFacultyProgress;
import gov.in.rgsa.entity.AdminAndFinancialDataActivity;
import gov.in.rgsa.entity.AdministrativeTechnicalDetailProgress;
import gov.in.rgsa.entity.AdministrativeTechnicalProgress;
import gov.in.rgsa.entity.AdministrativeTechnicalSupport;
import gov.in.rgsa.entity.AttachmentMaster;
import gov.in.rgsa.entity.EEnablement;
import gov.in.rgsa.entity.EEnablementGPs;
import gov.in.rgsa.entity.GPBhawanStatus;
import gov.in.rgsa.entity.IecActivity;
import gov.in.rgsa.entity.IecQuater;
import gov.in.rgsa.entity.IncomeEnhancementActivity;
import gov.in.rgsa.entity.InnovativeActivity;
import gov.in.rgsa.entity.InstitueInfraHrActivity;
import gov.in.rgsa.entity.InstitueInfraHrActivityDetails;
import gov.in.rgsa.entity.InstituteInfraHrActivityType;
import gov.in.rgsa.entity.PmuActivity;
import gov.in.rgsa.entity.PmuProgress;
import gov.in.rgsa.entity.PmuProgressDetails;
import gov.in.rgsa.entity.QprAdminAndFinancialDataActivity;
import gov.in.rgsa.entity.QprAdminAndFinancialDataActivityDetails;
import gov.in.rgsa.entity.QprEnablement;
import gov.in.rgsa.entity.QprEnablementDetails;
import gov.in.rgsa.entity.QprIncomeEnhancement;
import gov.in.rgsa.entity.QprInnovativeActivity;
import gov.in.rgsa.entity.QprInstitutionalInfraDetails;
import gov.in.rgsa.entity.QprInstitutionalInfrastructure;
import gov.in.rgsa.entity.QprPanchayatBhawan;
import gov.in.rgsa.entity.QuaterWiseFund;
import gov.in.rgsa.entity.SatcomActivity;
import gov.in.rgsa.entity.SatcomActivityProgress;
import gov.in.rgsa.entity.SatcomActivityProgressDetails;
import gov.in.rgsa.entity.StateAllocation;
import gov.in.rgsa.entity.TrainingActivity;
import gov.in.rgsa.entity.TrainingProgressReport;
import gov.in.rgsa.service.AdditionalFacultyAndMainService;
import gov.in.rgsa.service.AdminAndFinancialDataCellService;
import gov.in.rgsa.service.AdminTechSupportService;
import gov.in.rgsa.service.EEnablementOfPanchayatService;
import gov.in.rgsa.service.IecService;
import gov.in.rgsa.service.IncomeEnhancementService;
import gov.in.rgsa.service.InnovativeActivityService;
import gov.in.rgsa.service.InstitutionalInfraActivityPlanService;
import gov.in.rgsa.service.LGDService;
import gov.in.rgsa.service.PanchayatBhawanService;
import gov.in.rgsa.service.PmuActivityService;
import gov.in.rgsa.service.ProgressReportService;
import gov.in.rgsa.service.SatcomActivityProgressService;
import gov.in.rgsa.service.SatcomFacilityService;
import gov.in.rgsa.service.TrainingActivityService;
import gov.in.rgsa.service.TrainingInstitutionService;
import gov.in.rgsa.user.preference.UserPreference;
import gov.in.rgsa.utils.Message;

@Controller
public class ProgressReportController {

	public static final String TRAINING_PROGRESS_REPORT = "approvedTrainingReport";
	public static final String REDIRECT_TRAINING_PROGRESS_REPORT = "redirect:trainingProgressReport.html";
	public static final String REDIRECT_INCOMEENHANCEMENT_QUATERLY = "redirect:incomeEnhancementQuaterly.html";
	public static final String REDIRECT_ENABLEMENT_PROGRESS_REPORT = "redirect:enablementQuaterly.html";
	public static final String ENABLEMENT_PROGRESS_REPORT = "approveEnablementQuaterly";
	public static final String GRAM_PANCHAYAT_PROGRESS_REPORT = "gramPanchayatProgressReport";
	public static final String CAPACITY_BUILDING__PROGRESS_REPORT = "capacityBuildingOneQtrProgressReport";
	public static final String IEC_PROGRESS_REPORT = "approvedIecQtrProgressReport";
	public static final String REDIRECT_IEC_PROGRESS_REPORT = "redirect:iecQtrProgressReport.html";
	public static final String INNOVATIVE_PROGRESS_REPORT = "approvedInnovativeActivityQpr";
	public static final String REDIRECT_INNOVATIVE_PROGRESS_REPORT = "redirect:innovativeActivityQpr.html";
	public static final String TRAINING_PROGRESS_PMU = "approvePmuQuaterly";
	public static final String REDIRECT_TRAINING_PROGRESS_PMU = "redirect:pmuProgresReport.html";

	/*
	 * private static final String PANCHAYAT_BHAWAN_REPORT =
	 * "panchayatBhawanQuaterlyReport";
	 */
	private static final String INSTITUTIONAL_INFRA_REPORT = "institutionalInfraQuaterlyReport";
	public static final String INCOMEENHANCEMENT_QUATERLY = "incomeEnhancementQuaterly";
	public static final String CURRENT_SATCOM_QUATERLY = "approvedCurrentUsageSatcomQuaterly";
	public static final String REDIRECT_CURRENT_SATCOM_QUATERLY = "redirect:currentUsageSatcomQuaterly.html";

	public static final String ADMIN_QUADERLY = "approvedadminTechQuaderly";
	public static final String REDIRECT_ADMIN_QUADERLY = "redirect:adminTechQuaderly.html";
	public static final String ADDITIONAL_FACULTY_QUADERLY = "approvedAdditionalfacultyProgress";
	public static final String REDIRECT_ADDITIONAL_QUADERLY = "redirect:additionalfacultyProgress.html";
	/*
	 * private static final String INSTITUTIONAL_INFRA_REPORT=
	 * "approvedInstitutionalInfraQuaterlyReport";
	 */ public static final String REDIRECT_INSTITUTIONAL_INFRA_REPORT = "redirect:institutionalInfraQuaterlyReport.html";
	public static final String ADMIN_DATA_FIN_QUATERLY = "approvedadminDataFinQuaterlyGet";

	public static final String REDIRECT_ADMIN_DATA_FIN_QUATERLY = "redirect:adminDataFinQuaterlyGet.html";
	private static final String NO_FUND_ALLOCATED_JSP = "noFundAlloctedJsp";

	@Autowired
	private UserPreference userPreference;

	@Autowired
	private TrainingActivityService trainingActivityService;

	@Autowired
	private PanchayatBhawanService panchayatBhawanService;

	@Autowired
	private TrainingInstitutionService trainingInstitutionService;

	@Autowired
	private ProgressReportService progressReportService;

	@Autowired
	private IecService iecService;

	/*
	 * @Autowired private PmuActivityService activityService;
	 */

	@Autowired
	InnovativeActivityService innovativeActivityService;

	@Autowired
	private InstitutionalInfraActivityPlanService institutionalInfraActivityPlanService;

	@Autowired
	private IncomeEnhancementService enhancementService;

	@Autowired
	private SatcomFacilityService satcomFacilityService;

	@Autowired
	private LGDService lgdService;

	@Autowired
	private AdminTechSupportService adminTechSupportService;

	@Autowired
	private SatcomActivityProgressService satcomActivityProgressService;

	@Autowired
	private AdditionalFacultyAndMainService additionalFacultyAndMainService;

	/*
	 * @Autowired private CapacityBuildingService capacityBuildingService;
	 */

	@Autowired
	private PmuActivityService pmuActivityService;

	@Autowired
	private EEnablementOfPanchayatService eEnablementOfPanchayatService;

	/*
	 * @Autowired private CBMasterService cbMasterService;
	 */

	@Autowired
	private AdminAndFinancialDataCellService adminAndFinancialDataCellService;

	@Autowired
	InstitutionalInfraActivityPlanService InstitutionalInfraActivityPlanService;

	@RequestMapping(value = "trainingProgressReport", method = RequestMethod.GET)
	public String qprGetFormTrainingProgressReport(
			@ModelAttribute("TRAINING_DETAILS") TrainingProgressReport progressReportJsp, Model model) {
		/*
		 * public String trainingProgressReport(@ModelAttribute("TRAINING_DETAILS")
		 * TrainingProgressReportModel progressReportModel, Model model) BY Monty
		 */
		int quarterId = 1;
		model.addAttribute("approved", true);
		List<TrainingActivity> approvedTraining = trainingActivityService.getApprovedTrainingActivity();
		if (approvedTraining != null && !approvedTraining.isEmpty()) {

			int activityId = approvedTraining.get(0).getTrainingActivityId();
			if (progressReportJsp.getQtrIdJsp() != null) {
				quarterId = progressReportJsp.getQtrIdJsp();
			} else
				quarterId = 1;

			List<Integer> activityDetailsId = new ArrayList<>();
			for (int i = 0; i < approvedTraining.get(0).getTrainingActivityDetailsList().size(); i++) {
				int id = approvedTraining.get(0).getTrainingActivityDetailsList().get(i).getTrainingActivityDetailsId();
				activityDetailsId.add(id);
			}
			TrainingProgressReport fetchTrainingProgressReport = progressReportService
					.fetchprogressReport(activityDetailsId, activityId, quarterId);
			if (fetchTrainingProgressReport != null) {
				model.addAttribute("fetchTrainingProgressReport", fetchTrainingProgressReport);
			}

			else {
				TrainingProgressReport trainingReport = progressReportService
						.fetchprogressReportToGeReportId(activityId);
				if (trainingReport != null) {
					model.addAttribute("trainingReportIdFromDb", trainingReport.getTrainingReportId());
				}
			}

			model.addAttribute("SetNewQtrId", progressReportJsp.getQtrIdJsp());
			model.addAttribute("allTrainingActivity", approvedTraining.get(0));
			model.addAttribute("trainingInstituteList", trainingInstitutionService.getTrainingIsntituteType());
			model.addAttribute("quarter_duration", progressReportService.getQuarterDurations());
			model.addAttribute("TARGET_GROUP", trainingActivityService.targetGroupMastersList());
		} else {
			model.addAttribute("approved", false);
		}
		return TRAINING_PROGRESS_REPORT;
	}

	@RequestMapping(value = "trainingProgressRptQtr", method = RequestMethod.POST)
	public String trainingProgressReportByQtr(
			@ModelAttribute("TRAINING_DETAILS") TrainingProgressReport progressReportJsp, Model model) {
		/*
		 * public String trainingProgressReport(@ModelAttribute("TRAINING_DETAILS")
		 * TrainingProgressReportModel progressReportModel, Model model) BY Monty
		 */
		int quarterId = 1;
		model.addAttribute("approved", true);
		List<TrainingActivity> approvedTraining = trainingActivityService.getApprovedTrainingActivity();
		if (approvedTraining != null && !approvedTraining.isEmpty()) {

			int activityId = approvedTraining.get(0).getTrainingActivityId();
			if (progressReportJsp.getQtrIdJsp() != null) {
				quarterId = progressReportJsp.getQtrIdJsp();
			} else
				quarterId = 1;

			List<Integer> activityDetailsId = new ArrayList<>();
			for (int i = 0; i < approvedTraining.get(0).getTrainingActivityDetailsList().size(); i++) {
				int id = approvedTraining.get(0).getTrainingActivityDetailsList().get(i).getTrainingActivityDetailsId();
				activityDetailsId.add(id);
			}
			TrainingProgressReport fetchTrainingProgressReport = progressReportService
					.fetchprogressReport(activityDetailsId, activityId, quarterId);
			if (fetchTrainingProgressReport != null) {
				model.addAttribute("fetchTrainingProgressReport", fetchTrainingProgressReport);
			}

			else {
				TrainingProgressReport trainingReport = progressReportService
						.fetchprogressReportToGeReportId(activityId);
				if (trainingReport != null) {
					model.addAttribute("trainingReportIdFromDb", trainingReport.getTrainingReportId());
				}
			}

			model.addAttribute("SetNewQtrId", progressReportJsp.getQtrIdJsp());
			model.addAttribute("allTrainingActivity", approvedTraining.get(0));
			model.addAttribute("trainingInstituteList", trainingInstitutionService.getTrainingIsntituteType());
			model.addAttribute("quarter_duration", progressReportService.getQuarterDurations());
			model.addAttribute("TARGET_GROUP", trainingActivityService.targetGroupMastersList());
		} else {
			model.addAttribute("approved", false);
		}
		return TRAINING_PROGRESS_REPORT;
	}

	@RequestMapping(value = "trainingProgressReport", method = RequestMethod.POST)
	public String saveTrainingProgressData(
			@ModelAttribute("TRAINING_DETAILS") TrainingProgressReport progressReportJsp) {

		progressReportService.saveTrainingProgressData(progressReportJsp);

		return REDIRECT_TRAINING_PROGRESS_REPORT;
	}

	@RequestMapping(value = "gramPanchayatProgressReport", method = RequestMethod.GET)
	public String qprGetFormGramPanchayatProgressReport() {
		return GRAM_PANCHAYAT_PROGRESS_REPORT;
	}

	@RequestMapping(value = "fetchDetailsForGramPanchayatProgressReport", method = RequestMethod.GET)
	private @ResponseBody Map<String, Object> fetchDetailsForGramPanchayatProgressReport() {
		Map<String, Object> detailsMaps = new HashMap<>();
		detailsMaps.put("quarterDuration", progressReportService.getQuarterDurations());
		detailsMaps.put("panchayatActivity", panchayatBhawanService.fetchPanchayatBhawanActivity());
		detailsMaps.put("districtList", lgdService.getAllDistrictBasedOnState(userPreference.getStateCode()));
		return detailsMaps;
	}

	@ResponseBody
	@RequestMapping(value = "fetchGpBhawanStatus", method = RequestMethod.GET)
	private List<GPBhawanStatus> fetchGPBhawanStatus(
			@RequestParam(value = "PanchayatBhawanActvityId", required = false) Integer PanchayatBhawanActvityId) {
		return panchayatBhawanService.fetchGPBhawanStatus(PanchayatBhawanActvityId);
	}

	@ResponseBody
	@RequestMapping(value = "fetchGpBhawanData", method = RequestMethod.GET)
	private List<GramPanchayatProgressReportDTO> fetchGPBhawanData(
			@RequestParam(value = "PanchayatBhawanActvityId", required = false) Integer PanchayatBhawanActvityId,
			@RequestParam(value = "DistrictListId", required = false) Integer DistrictListId) {
		return panchayatBhawanService.fetchGPBhawanData(PanchayatBhawanActvityId, DistrictListId);
	}

	@ResponseBody
	@RequestMapping(value = "fetchDataAccordingToQuator", method = RequestMethod.GET)
	private Map<String, Object> fetchDataAccordingToQuator(
			@RequestParam(value = "quatorId", required = false) Integer quatorId,
			@RequestParam(value = "PanchayatBhawanActvityId", required = false) Integer PanchayatBhawanActvityId,
			@RequestParam(value = "districtCode", required = false) Integer districtCode) {
		Map<String, Object> map = new HashMap<>();
		map.put("QprPanchayatBhawan", panchayatBhawanService
				.fetchDataAccordingToQuator(quatorId, PanchayatBhawanActvityId, districtCode).get(0));
		map.put("QprPanhcayatBhawanDetails",
				panchayatBhawanService.fetchDataAccordingToQuator(quatorId, PanchayatBhawanActvityId, districtCode)
						.get(0).getQprPanhcayatBhawanDetails());
		return map;
	}

	@ResponseBody
	@RequestMapping(value = "saveQprPanchayatBhawanData", method = RequestMethod.POST)
	private QprPanchayatBhawan saveQprPanchayatBhawanData(@RequestBody final QprPanchayatBhawan qprPanchayatBhawan,
			@RequestParam(value = "file", required = false) MultipartFile filepath) {
		panchayatBhawanService.saveQprPanchayatBhawanData(qprPanchayatBhawan);
		return qprPanchayatBhawan;
	}

	@RequestMapping(value = "capacityBuildingOneQtrProgressReport", method = RequestMethod.GET)
	public String capacityBuildingOneQtrProgressReportGet(@RequestParam(value = "menuId") int menuId) {
		userPreference.setMenuId(menuId);
		return CAPACITY_BUILDING__PROGRESS_REPORT;
	}

	@RequestMapping(value = "iecQtrProgressReport", method = RequestMethod.GET)
	public String qprGetFormIecQtrProgressReport1(@ModelAttribute("IEC_ACTIVITY_QUATER") IecQuater iecQuater,
			Model model, HttpServletRequest request) {
		int quarterId = 0;
		int installmentNo = (quarterId < 3) ? 1 : 2; // installment number for qtrId 1 & 2 = 1 and 3 & 4 = 2
		if (iecQuater.getQtrId() != null) {
			quarterId = iecQuater.getQtrId();
		} else {
			quarterId = 0;
		}
		model.addAttribute("QUATER_DETAILS", progressReportService.getQuarterDurations());
		List<QuaterWiseFund> totalQuatorWiseFund = new ArrayList<>();
		List<IecActivity> iecActivitiesApproved = iecService.fetchApprovedIec();// this gives CEC approved data.
		List<StateAllocation> stateAllocation = progressReportService.fetchStateAllocationDataByCompIdandInstallNo(11,installmentNo);
		if (quarterId == 3 || quarterId == 4) {
			stateAllocation.add(progressReportService.fetchStateAllocationDataByCompIdandInstallNo(11, 1).get(0)); // total fund allocated in first installment
			totalQuatorWiseFund = progressReportService.fetchTotalQuaterWiseFundData(userPreference.getStateCode(), 11);
			model.addAttribute("TOTAL_FUND_USED_IN_QTR_1_AND_2", calTotalFundUsedInQtr1And2(totalQuatorWiseFund));
		}
		if (CollectionUtils.isNotEmpty(stateAllocation) && CollectionUtils.isNotEmpty(iecActivitiesApproved)) {
			if (stateAllocation.size() > 1) {
				model.addAttribute("FUND_ALLOCATED_BY_STATE_PREVIOUS", stateAllocation.get(1).getFundsAllocated()); // we will use this in jsp to calculate the total remaining field
			}
			model.addAttribute("CEC_APPROVED_ACTIVITY", iecActivitiesApproved.get(0));
			model.addAttribute("CEC_APPROVED_ACT_ID", iecActivitiesApproved.get(0).getId());
			IecQuater iecQuaterProgressReport = progressReportService
					.getSatcomProgress(iecActivitiesApproved.get(0).getId(), quarterId);
			if (iecQuaterProgressReport != null) {
				Collections.sort(iecQuaterProgressReport.getIecQuaterDetails(),
						(o1, o2) -> o1.getQprIecDetailsId() - o2.getQprIecDetailsId());
				model.addAttribute("IEC_ACTIVITY_PROGRESS", iecQuaterProgressReport);
			} else {
				if (iecQuater.getIecQuaterDetails() != null)
					iecQuater.getIecQuaterDetails().clear();
			}
			/*
			 * used to get previous data stored which is then use to validate the
			 * expenditure incurred
			 */
			List<QuaterWiseFund> quaterWiseFund = new ArrayList<>();
			if (quarterId == 1 || quarterId == 3) {
				quaterWiseFund = progressReportService.fetchQuaterWiseFundData(userPreference.getStateCode(),
						(quarterId + 1), 11);
			} else {
				quaterWiseFund = progressReportService.fetchQuaterWiseFundData(userPreference.getStateCode(),
						(quarterId - 1), 11);
			}
			if (CollectionUtils.isNotEmpty(quaterWiseFund)) {
				model.addAttribute("FUND_USED_IN_OTHER_QUATOR", quaterWiseFund.get(0).getFunds());
			}
			/*----------------------------end here-------------------------------------------------- */
			model.addAttribute("FUND_ALLOCATED_BY_STATE", stateAllocation.get(0).getFundsAllocated());
			model.addAttribute("QTR_ID", quarterId);
			return IEC_PROGRESS_REPORT;
		} else {
			return NO_FUND_ALLOCATED_JSP;
		}
	}

	@RequestMapping(value = "iecQtrProgressReportPost", method = RequestMethod.POST)
	public String iecQtrProgressReportPostQuaterly(@ModelAttribute("IEC_ACTIVITY_QUATER") IecQuater iecQuater,
			Model model, HttpServletRequest request, RedirectAttributes re) {
		progressReportService.saveIec(iecQuater);
		re.addFlashAttribute(Message.SUCCESS_KEY, Message.SAVE_SUCCESS);
		return REDIRECT_IEC_PROGRESS_REPORT;
	}

	/*
	 * @RequestMapping(value="panchayatBhawanQuaterlyReport",method =
	 * RequestMethod.GET) public String panchayatBhawanGet() { return
	 * PANCHAYAT_BHAWAN_REPORT; }
	 */

	/*
	 * @RequestMapping(value="institutionalInfraQuaterlyReport",method =
	 * RequestMethod.GET) public String qprGetFormInstituteInfraQprGet(Model model)
	 * { return INSTITUTIONAL_INFRA_REPORT; }
	 * 
	 * @RequestMapping(value = "fetchDetailsForInstInfraProgressReport", method =
	 * RequestMethod.GET) private @ResponseBody Map<String, Object>
	 * fetchDetailsForInstitutionalInfraProgressReport(){ Map<String, Object>
	 * detailsMaps = new HashMap<>(); detailsMaps.put("quarterDuration",
	 * progressReportService.getQuarterDurations());
	 * detailsMaps.put("buildingType",institutionalInfraActivityPlanService.
	 * fetchTrainingInstituteType()); return detailsMaps; }
	 * 
	 * @ResponseBody
	 * 
	 * @RequestMapping(value="fetchInstInfraStateData",method=RequestMethod.GET)
	 * private List<InstitutionalInfraProgressReportDTO>
	 * fetchInstInfraStateData(@RequestParam(value="TrainingInstituteTypeId" ,
	 * required=false) Integer TrainingInstituteTypeId){ return
	 * institutionalInfraActivityPlanService.
	 * fetchInstInfraStateDataForProgressReport(TrainingInstituteTypeId); }
	 * 
	 * @ResponseBody
	 * 
	 * @RequestMapping(value="fetchInstInfraStatus",method=RequestMethod.GET)
	 * private List<InstInfraStatus>
	 * fetchInstInfraStatus(@RequestParam(value="TrainingInstituteTypeId" ,
	 * required=false) Integer TrainingInstituteTypeId){ return
	 * institutionalInfraActivityPlanService.fetchInstInfraStatus(
	 * TrainingInstituteTypeId); }
	 * 
	 * @ResponseBody
	 * 
	 * @RequestMapping(value="saveQprInstitutionalInfrastructureData" ,
	 * method=RequestMethod.POST) private QprInstitutionalInfrastructure
	 * saveQprInstInfraData(@RequestBody final QprInstitutionalInfrastructure
	 * qprInstitutionalInfrastructure){
	 * institutionalInfraActivityPlanService.saveQprInstInfraData(
	 * qprInstitutionalInfrastructure); return qprInstitutionalInfrastructure; }
	 * 
	 * @ResponseBody
	 * 
	 * @RequestMapping(value="fetchDataAccordingToQuatorInstInfra",method=
	 * RequestMethod.GET) private Map<String, Object>
	 * fetchDataAccordingToQuatorInstInfra(@RequestParam(value="quatorId" ,
	 * required=false) Integer
	 * quatorId,@RequestParam(value="TrainingInstituteTypeId" , required=false)
	 * Integer TrainingInstituteTypeId){ Map<String , Object> map=new HashMap<>();
	 * List<InstitutionalInfraActivityPlan>
	 * institutionalInfraActivityPlan=institutionalInfraActivityPlanService.
	 * fetchInstitutionalInfraActivity(null); List<QprInstitutionalInfrastructure>
	 * qprInstitutionalInfrastructure=new
	 * ArrayList<QprInstitutionalInfrastructure>();
	 * if(!CollectionUtils.isEmpty(institutionalInfraActivityPlan)) {
	 * qprInstitutionalInfrastructure=institutionalInfraActivityPlanService.
	 * fetchDataAccordingToQuator(quatorId,institutionalInfraActivityPlan.get(0).
	 * getInstitutionalInfraActivityId()); }
	 * if(!CollectionUtils.isEmpty(qprInstitutionalInfrastructure)) {
	 * map.put("QprInstitutionalInfrastructure",qprInstitutionalInfrastructure.get(0
	 * )); map.put("qprInstitutionalInfraDetails",
	 * institutionalInfraActivityPlanService.fetchDataOfDetailsAccordingToQuator(
	 * qprInstitutionalInfrastructure.get(0).getQprInstInfraId(),
	 * TrainingInstituteTypeId)); } return map; }
	 */

	@RequestMapping(value = "incomeEnhancementQuaterly", method = RequestMethod.GET)
	public String qprGetFormIncomeEnhancementDetailsQuaterly(
			@ModelAttribute("QPR_INCOME_ENHANCEMENT") QprIncomeEnhancement qprIncomeEnhancement, Model model) {
		int quarterId = 0;
		if (qprIncomeEnhancement.getShowQqrtrId() != null) {
			quarterId = qprIncomeEnhancement.getShowQqrtrId();
		} else {
			quarterId = 0;
		}

		int installmentNo = (quarterId < 3) ? 1 : 2; // installment number for qtrId 1 & 2 = 1 and 3 & 4 = 2
		List<QuaterWiseFund> totalQuatorWiseFund = new ArrayList<>();
		List<IncomeEnhancementActivity> incomeEnhancementActApproved = enhancementService
				.fetchAllIncmEnhncmntActvty('C');
		List<StateAllocation> stateAllocation = progressReportService.fetchStateAllocationDataByCompIdandInstallNo(10,
				installmentNo);
		model.addAttribute("QUATER_DETAILS", progressReportService.getQuarterDurations());
		if (quarterId == 3 || quarterId == 4) {
			stateAllocation.add(progressReportService.fetchStateAllocationDataByCompIdandInstallNo(10, 1).get(0)); // total fund allocated in first quator
			totalQuatorWiseFund = progressReportService.fetchTotalQuaterWiseFundData(userPreference.getStateCode(), 10);
			model.addAttribute("TOTAL_FUND_USED_IN_QTR_1_AND_2", calTotalFundUsedInQtr1And2(totalQuatorWiseFund));
		}

		if (CollectionUtils.isNotEmpty(stateAllocation) && CollectionUtils.isNotEmpty(incomeEnhancementActApproved)) {
			if (stateAllocation.size() > 1) {
				model.addAttribute("FUND_ALLOCATED_BY_STATE_PREVIOUS", stateAllocation.get(1).getFundsAllocated()); // we will use this in jsp to calculate the total remaining field
			}
			
			QprIncomeEnhancement qprEnhancement = progressReportService.fetchQprIncmEnhncmnt(incomeEnhancementActApproved.get(0).getIncomeEnhancementId(), quarterId);
			if (qprEnhancement != null) {
				Collections.sort(qprEnhancement.getQprIncomeEnhancementDetails(),
						(o1, o2) -> o1.getQprIncomeEnhancementDetailsId() - o1.getQprIncomeEnhancementDetailsId());
				model.addAttribute("QPR_ENHANCEMENT", qprEnhancement);
			} else {
				if (qprIncomeEnhancement.getQprIncomeEnhancementDetails() != null) {
					qprIncomeEnhancement.getQprIncomeEnhancementDetails().clear();
				}
			}

			/*used to get previous data stored which is then use to validate the expenditure incurred  */
			List<QuaterWiseFund> quaterWiseFund = new ArrayList<>();
			if (quarterId == 1 || quarterId == 3) {
				quaterWiseFund = progressReportService.fetchQuaterWiseFundData(userPreference.getStateCode(),
						(quarterId + 1), 10);
			} else {
				quaterWiseFund = progressReportService.fetchQuaterWiseFundData(userPreference.getStateCode(),
						(quarterId - 1), 10);
			}
			if (CollectionUtils.isNotEmpty(quaterWiseFund)) {
				model.addAttribute("FUND_USED_IN_OTHER_QUATOR", quaterWiseFund.get(0).getFunds());
			}
			/*----------------------------end here-------------------------------------------------- */

			model.addAttribute("QTR_ID", quarterId);
			model.addAttribute("CEC_APPROVED_ACTIVITY", incomeEnhancementActApproved.get(0));
			model.addAttribute("FUND_ALLOCATED_BY_STATE", stateAllocation.get(0).getFundsAllocated());
			model.addAttribute("DISTRICT_LIST", lgdService.getAllDistrictBasedOnState(userPreference.getStateCode()));
			return INCOMEENHANCEMENT_QUATERLY;
		} else {
			return NO_FUND_ALLOCATED_JSP;
		}
	}

	@RequestMapping(value = "incomeEnhancementQuaterly", method = RequestMethod.POST)
	public String saveIncomeEnhancementQuaterly(@ModelAttribute("QPR_INCOME_ENHANCEMENT") QprIncomeEnhancement qprIncomeEnhancement,RedirectAttributes redirectAttributes) {
		progressReportService.saveQprIncomeEnhancement(qprIncomeEnhancement);
		redirectAttributes.addFlashAttribute(Message.SUCCESS_KEY, Message.SAVE_SUCCESS);
		return REDIRECT_INCOMEENHANCEMENT_QUATERLY;
	}

	/* new method starts from here */
	@RequestMapping(value = "currentUsageSatcomQuaterly", method = RequestMethod.GET)
	public String qprGetFormcurrentUsageSatcomGetQuaterlyNew(
			@ModelAttribute("SATCOM_QUATER") SatcomActivityProgress satcomActivityProgress, Model model) {
		int quarterId = 1;
		if (satcomActivityProgress.getQtrIdJsp1() != null) {
			quarterId = satcomActivityProgress.getQtrIdJsp1();
		} else {
			quarterId = 1;
		}
		int installmentNo = (quarterId < 3) ? 1 : 2; // installment number for qtrId 1 & 2 = 1 and 3 & 4 = 2
		List<QuaterWiseFund> totalQuatorWiseFund = new ArrayList<>();
		List<SatcomActivity> satcomActivityApproved = satcomFacilityService.getApprovedSatcomActivity();// this will give us the data that was approved by the CEC
		List<StateAllocation> stateAllocation = progressReportService.fetchStateAllocationDataByCompIdandInstallNo(7,
				installmentNo);
		model.addAttribute("QUATER_DETAILS", progressReportService.getQuarterDurations());
		if (quarterId == 3 || quarterId == 4) {
			stateAllocation.add(progressReportService.fetchStateAllocationDataByCompIdandInstallNo(7, 1).get(0)); // total fund allocated in first quator
			totalQuatorWiseFund = progressReportService.fetchTotalQuaterWiseFundData(userPreference.getStateCode(), 7);
			model.addAttribute("TOTAL_FUND_USED_IN_QTR_1_AND_2", calTotalFundUsedInQtr1And2(totalQuatorWiseFund));
		}

		if (CollectionUtils.isNotEmpty(stateAllocation) /* && CollectionUtils.isNotEmpty(satcomActivityApproved) */) {
			if (stateAllocation.size() > 1) {
				model.addAttribute("FUND_ALLOCATED_BY_STATE_PREVIOUS", stateAllocation.get(1).getFundsAllocated()); // we will use this in jsp to calculate the total remaining field
			}
			// list to get total number of unit in all quator except current one
			List<SatcomActivityProgressDetails> deatilForTotalNoOfUnit = new ArrayList<>();
			if (satcomActivityProgress.getSatcomActivityProgressId() == null) {
				model.addAttribute("DEATIL_FOR_TOTAL_NO_OF_UNIT", null);
			} else {
				deatilForTotalNoOfUnit = getTotalUnitInAllQtrSatcom(deatilForTotalNoOfUnit,
						satcomActivityProgressService.getDetailsBasedOnActIdAndQtrId(
								satcomActivityProgress.getSatcomActivityProgressId(), quarterId));
				model.addAttribute("DEATIL_FOR_TOTAL_NO_OF_UNIT", deatilForTotalNoOfUnit);
			}

			if (CollectionUtils.isNotEmpty(satcomActivityApproved)) {
				SatcomActivityProgress satcomActivityProgressBasedOnCecActivityId = satcomActivityProgressService
						.getSatcomProgress(satcomActivityApproved.get(0).getSatcomActivityId(), quarterId);
				if (satcomActivityProgressBasedOnCecActivityId != null) {
					Collections.sort(satcomActivityProgressBasedOnCecActivityId.getSatcomActivityProgressDetails(),
							(o1, o2) -> o1.getSatcomDetailsProgressId() - o2.getSatcomDetailsProgressId());
					satcomActivityProgress.setSatcomActivityProgressDetails(
							satcomActivityProgressBasedOnCecActivityId.getSatcomActivityProgressDetails());
					model.addAttribute("QPR_DATA_BASED_CEC_ACT_ID", satcomActivityProgressBasedOnCecActivityId);
					model.addAttribute("PROGRESS_REPORT_ACT_ID",
							satcomActivityProgressBasedOnCecActivityId.getSatcomActivityProgressId());
				} else {
					if (satcomActivityProgress.getSatcomActivityProgressDetails() != null) {
						satcomActivityProgress.getSatcomActivityProgressDetails().clear();
					}
					model.addAttribute("PROGRESS_REPORT_ACT_ID", satcomActivityProgress.getSatcomActivityProgressId());// when record is not found then it take the id previous record
				}

				/*
				 * used to get previous data stored which is then use to validate the
				 * expenditure incurred
				 */
				List<QuaterWiseFund> quaterWiseFund = new ArrayList<>();
				if (quarterId == 1 || quarterId == 3) {
					quaterWiseFund = progressReportService.fetchQuaterWiseFundData(userPreference.getStateCode(),
							(quarterId + 1), 7);
				} else {
					quaterWiseFund = progressReportService.fetchQuaterWiseFundData(userPreference.getStateCode(),
							(quarterId - 1), 7);
				}
				if (CollectionUtils.isNotEmpty(quaterWiseFund)) {
					model.addAttribute("FUND_USED_IN_OTHER_QUATOR", quaterWiseFund.get(0).getFunds());
				}
				/*----------------------------end here-------------------------------------------------- */
				model.addAttribute("FUND_ALLOCATED_BY_STATE", stateAllocation.get(0).getFundsAllocated());
				model.addAttribute("SATCOM_ACTIVITY_APPROVED", satcomActivityApproved.get(0));
				model.addAttribute("QTR_ID", quarterId);
				model.addAttribute("satcomActivityId", satcomActivityApproved.get(0).getSatcomActivityId());
			}
			return CURRENT_SATCOM_QUATERLY;
		} else {
			return NO_FUND_ALLOCATED_JSP;
		}
	}

	/* method for satcom/Ip report */
	private List<SatcomActivityProgressDetails> getTotalUnitInAllQtrSatcom(
			List<SatcomActivityProgressDetails> deatilForTotalNoOfUnit,
			List<SatcomActivityProgressDetails> detailsBasedOnActIdAndQtrId) {
		int count = 0;
		for (int i = 0; i < 5; i++) {
			deatilForTotalNoOfUnit.add(new SatcomActivityProgressDetails());
		}
		for (int j = 0; j < detailsBasedOnActIdAndQtrId.size(); j++) {
			if (count == 5) {
				count = 0;
			}
			for (int i = count; i < count + 1; i++) {
				if (deatilForTotalNoOfUnit.get(i).getNoOfUnitCompleted() != null) {
					deatilForTotalNoOfUnit.get(i)
							.setNoOfUnitCompleted(deatilForTotalNoOfUnit.get(i).getNoOfUnitCompleted()
									+ detailsBasedOnActIdAndQtrId.get(j).getNoOfUnitCompleted());
				} else {
					deatilForTotalNoOfUnit.get(i)
							.setNoOfUnitCompleted(0 + detailsBasedOnActIdAndQtrId.get(j).getNoOfUnitCompleted());
				}
			}
			++count;
		}
		return deatilForTotalNoOfUnit;
	}

	/* new method ends here */

	@RequestMapping(value = "currentUsageSatcomQuaterlyPost", method = RequestMethod.POST)
	public String currentUsageSatcomPostQuaterly1(
			@ModelAttribute("SATCOM_QUATER") SatcomActivityProgress satcomActivityProgress, Model model,
			HttpServletRequest request, RedirectAttributes re) {
		satcomActivityProgressService.savesatcomProgress(satcomActivityProgress);
		re.addFlashAttribute(Message.SUCCESS_KEY, Message.SAVE_SUCCESS);
		return REDIRECT_CURRENT_SATCOM_QUATERLY;
	}

	@RequestMapping(value = "adminTechQuaderly", method = RequestMethod.GET)
	public String qprGetFormAdminSupportQuaderly(
			@ModelAttribute("ADMIN_QUATER") AdministrativeTechnicalProgress administrativeTechnicalProgress,
			Model model, HttpServletRequest request) {
		int quarterId = 0;
		if (administrativeTechnicalProgress.getQtrIdJsp2() != null) {
			quarterId = administrativeTechnicalProgress.getQtrIdJsp2();
		} else {
			quarterId = 0;
		}

		int installmentNo = (quarterId < 3) ? 1 : 2; // installment number for qtrId 1 & 2 = 1 and 3 & 4 = 2
		List<QuaterWiseFund> totalQuatorWiseFund = new ArrayList<>();
		List<AdministrativeTechnicalSupport> administrativeTechnicalApproved = adminTechSupportService
				.getApprovedSatcomActivity();
		List<StateAllocation> stateAllocation = progressReportService.fetchStateAllocationDataByCompIdandInstallNo(4,
				installmentNo);
		model.addAttribute("QUATER_DETAILS", progressReportService.getQuarterDurations());
		if (quarterId == 3 || quarterId == 4) {
			stateAllocation.add(progressReportService.fetchStateAllocationDataByCompIdandInstallNo(4, 1).get(0)); // total fund allocated in first quator
			totalQuatorWiseFund = progressReportService.fetchTotalQuaterWiseFundData(userPreference.getStateCode(), 4);
			model.addAttribute("TOTAL_FUND_USED_IN_QTR_1_AND_2", calTotalFundUsedInQtr1And2(totalQuatorWiseFund));
		}
		if (CollectionUtils.isNotEmpty(stateAllocation)
				&& CollectionUtils.isNotEmpty(administrativeTechnicalApproved)) {

			if (stateAllocation.size() > 1) {
				model.addAttribute("FUND_ALLOCATED_BY_STATE_PREVIOUS", stateAllocation.get(1).getFundsAllocated()); // we will use this in jsp to calculate the total remaining field
			}

			// list to get total number of unit in all quator except current one
			List<AdministrativeTechnicalDetailProgress> detailForTotalNoOfUnit = new ArrayList<>();
			List<AdministrativeTechnicalDetailProgress> adminTechReportDetailOfRestQuater = adminTechSupportService
					.getadminTechProgressActBasedOnActIdAndQtrId(
							administrativeTechnicalApproved.get(0).getAdministrativeTechnicalSupportId(), quarterId);
			if (adminTechReportDetailOfRestQuater != null) {
				Collections.sort(adminTechReportDetailOfRestQuater,
						(o1, o2) -> o1.getAtsDetailsProgressId() - o2.getAtsDetailsProgressId());
				detailForTotalNoOfUnit = getTotalUnitAndExpIncurredInAllQtrAdminTech(detailForTotalNoOfUnit,
						adminTechReportDetailOfRestQuater);
				model.addAttribute("DEATIL_FOR_TOTAL_NO_OF_UNIT", detailForTotalNoOfUnit);
			} else {
				model.addAttribute("DEATIL_FOR_TOTAL_NO_OF_UNIT", null);
			}
			AdministrativeTechnicalProgress administrativeTechnicalProgressActivty = progressReportService
					.fetchAdministrativeTechnicalProgress(
							administrativeTechnicalApproved.get(0).getAdministrativeTechnicalSupportId(), quarterId);
			if (administrativeTechnicalProgressActivty != null) {
				Collections.sort(administrativeTechnicalProgressActivty.getAdministrativeTechnicalDetailProgress(),
						(o1, o2) -> o1.getAtsDetailsProgressId() - o2.getAtsDetailsProgressId());
				model.addAttribute("ADMINISTRATIVE_TECHNICAL_PROGRESS", administrativeTechnicalProgressActivty);
			} else {
				if (administrativeTechnicalProgress.getAdministrativeTechnicalDetailProgress() != null) {
					administrativeTechnicalProgress.getAdministrativeTechnicalDetailProgress().clear();
				}
			}

			/*
			 * used to get previous data stored which is then use to validate the
			 * expenditure incurred
			 */
			List<QuaterWiseFund> quaterWiseFund = new ArrayList<>();
			if (quarterId == 1 || quarterId == 3) {
				quaterWiseFund = progressReportService.fetchQuaterWiseFundData(userPreference.getStateCode(),
						(quarterId + 1), 4);
			} else {
				quaterWiseFund = progressReportService.fetchQuaterWiseFundData(userPreference.getStateCode(),
						(quarterId - 1), 4);
			}
			if (CollectionUtils.isNotEmpty(quaterWiseFund)) {
				model.addAttribute("FUND_USED_IN_OTHER_QUATOR", quaterWiseFund.get(0).getFunds());
			}
			/*----------------------------end here-------------------------------------------------- */
			model.addAttribute("FUND_ALLOCATED_BY_STATE", stateAllocation.get(0).getFundsAllocated());
			model.addAttribute("QTR_ID", quarterId);
			model.addAttribute("APPROVED_ADMIN_TECH_ACT", administrativeTechnicalApproved.get(0));

			return ADMIN_QUADERLY;
		} else {
			return NO_FUND_ALLOCATED_JSP;

		}
	}

	/* method for administrative technical report */
	private List<AdministrativeTechnicalDetailProgress> getTotalUnitAndExpIncurredInAllQtrAdminTech(
			List<AdministrativeTechnicalDetailProgress> deatilForTotalNoOfUnit,
			List<AdministrativeTechnicalDetailProgress> detailsBasedOnActIdAndQtrId) {
		int count = 0;
		for (int i = 0; i < 9; i++) {
			deatilForTotalNoOfUnit.add(new AdministrativeTechnicalDetailProgress());
		}
		for (int j = 0; j < detailsBasedOnActIdAndQtrId.size(); j++) {
			if (count == 9) {
				count = 0;
			}
			for (int i = count; i < count + 1; i++) {
				if (deatilForTotalNoOfUnit.get(i).getNoOfUnitCompleted() != null) {
					deatilForTotalNoOfUnit.get(i)
							.setNoOfUnitCompleted(deatilForTotalNoOfUnit.get(i).getNoOfUnitCompleted()
									+ detailsBasedOnActIdAndQtrId.get(j).getNoOfUnitCompleted());
				} else {
					deatilForTotalNoOfUnit.get(i)
							.setNoOfUnitCompleted(0 + detailsBasedOnActIdAndQtrId.get(j).getNoOfUnitCompleted());
				}
				if (deatilForTotalNoOfUnit.get(i).getExpenditureIncurred() != null) {
					deatilForTotalNoOfUnit.get(i)
							.setExpenditureIncurred(deatilForTotalNoOfUnit.get(i).getExpenditureIncurred()
									+ detailsBasedOnActIdAndQtrId.get(j).getExpenditureIncurred());
				} else {
					deatilForTotalNoOfUnit.get(i)
							.setExpenditureIncurred(detailsBasedOnActIdAndQtrId.get(j).getExpenditureIncurred() + 0);
				}
			}
			++count;
		}
		return deatilForTotalNoOfUnit;
	}

	/* new method ends here */
	@RequestMapping(value = "adminTechQuaderly", method = RequestMethod.POST)
	public String getAdminSupportPostQuaterly(
			@ModelAttribute("ADMIN_QUATER") AdministrativeTechnicalProgress administrativeTechnicalProgress,
			Model model, HttpServletRequest request, RedirectAttributes re) {
		progressReportService.saveadministrativeTechnicalProgress(administrativeTechnicalProgress);
		re.addFlashAttribute(Message.SUCCESS_KEY, Message.SAVE_SUCCESS);
		return REDIRECT_ADMIN_QUADERLY;
	}

	@RequestMapping(value = "additionalfacultyProgress", method = RequestMethod.GET)
	public String qprGetFormAdditionalFacalltyHr(
			@ModelAttribute("ADD_QUATER") AdditionalFacultyProgress additionalFacultyProgress, Model model,
			HttpServletRequest request) {
		int quarterId = 1;
		model.addAttribute("approved", true);
		List<InstitueInfraHrActivity> institutionalInfraHRActivity = additionalFacultyAndMainService
				.fetchApprovedInstituteHrActivity();
		if (institutionalInfraHRActivity != null && !institutionalInfraHRActivity.isEmpty()) {
			int instituteInfraHrActivityId = institutionalInfraHRActivity.get(0).getInstituteInfraHrActivityId();
			List<InstitueInfraHrActivityDetails> institueInfraHrActivityDetails = additionalFacultyAndMainService
					.fetchInstituteHrActivityApprovedDetails(instituteInfraHrActivityId);

			if (additionalFacultyProgress.getQtrIdJsp3() != null) {
				quarterId = additionalFacultyProgress.getQtrIdJsp3();
			} else

				quarterId = 1;

			AdditionalFacultyProgress fetchAdditionalFacultyProgress = progressReportService
					.fetchAdditionalFacultyProgress(instituteInfraHrActivityId, quarterId);
			if (fetchAdditionalFacultyProgress != null) {

				model.addAttribute("Additional_Faculty_PROGRESS", fetchAdditionalFacultyProgress);
				model.addAttribute("adtnlfacltyDtlsList",
						fetchAdditionalFacultyProgress.getAdditionalFacultyProgressDetail());
			}

			else {
				AdditionalFacultyProgress fetchAdditionalFacultyProgress1 = progressReportService
						.fetchAdditionalFacultyProgressToGeReportId1(instituteInfraHrActivityId);
				if (fetchAdditionalFacultyProgress1 != null) {
					model.addAttribute("qprInstInfraHrId", fetchAdditionalFacultyProgress1.getQprInstInfraHrId());
				}
			}
			List<InstituteInfraHrActivityType> params = new ArrayList<>();
			params = additionalFacultyAndMainService.fetchHrActvityType();
			model.addAttribute("LIST_OF_ACTIVITY_HR_TYPE", params);
			model.addAttribute("instituteInfraHrActivityId", instituteInfraHrActivityId);
			model.addAttribute("SetNewQtrId1", additionalFacultyProgress.getQtrIdJsp3());
			model.addAttribute("fetchinstitueInfraHrActivityDetails", institueInfraHrActivityDetails);
			model.addAttribute("QUATER_DETAILS", progressReportService.getQuarterDurations());

		} else {
			model.addAttribute("approved", false);

		}
		return ADDITIONAL_FACULTY_QUADERLY;

	}

	@RequestMapping(value = "additionalfacultyProgress1", method = RequestMethod.POST)
	public String getAdditionalFacalltyHr1(
			@ModelAttribute("ADD_QUATER") AdditionalFacultyProgress additionalFacultyProgress, Model model,
			HttpServletRequest request) {
		int quarterId = 1;
		model.addAttribute("approved", true);
		List<InstitueInfraHrActivity> institutionalInfraHRActivity = additionalFacultyAndMainService
				.fetchApprovedInstituteHrActivity();
		if (institutionalInfraHRActivity != null && !institutionalInfraHRActivity.isEmpty()) {
			int instituteInfraHrActivityId = institutionalInfraHRActivity.get(0).getInstituteInfraHrActivityId();
			List<InstitueInfraHrActivityDetails> institueInfraHrActivityDetails = additionalFacultyAndMainService
					.fetchInstituteHrActivityApprovedDetails(instituteInfraHrActivityId);

			if (additionalFacultyProgress.getQtrIdJsp3() != null) {
				quarterId = additionalFacultyProgress.getQtrIdJsp3();
			} else

				quarterId = 1;

			AdditionalFacultyProgress fetchAdditionalFacultyProgress = progressReportService
					.fetchAdditionalFacultyProgress(instituteInfraHrActivityId, quarterId);
			if (fetchAdditionalFacultyProgress != null) {

				model.addAttribute("Additional_Faculty_PROGRESS", fetchAdditionalFacultyProgress);
				model.addAttribute("adtnlfacltyDtlsList",
						fetchAdditionalFacultyProgress.getAdditionalFacultyProgressDetail());
			}

			else {
				AdditionalFacultyProgress fetchAdditionalFacultyProgress1 = progressReportService
						.fetchAdditionalFacultyProgressToGeReportId1(instituteInfraHrActivityId);
				if (fetchAdditionalFacultyProgress1 != null) {
					model.addAttribute("qprInstInfraHrId", fetchAdditionalFacultyProgress1.getQprInstInfraHrId());
				}
			}
			List<InstituteInfraHrActivityType> params = new ArrayList<>();
			params = additionalFacultyAndMainService.fetchHrActvityType();
			model.addAttribute("LIST_OF_ACTIVITY_HR_TYPE", params);
			model.addAttribute("instituteInfraHrActivityId", instituteInfraHrActivityId);
			model.addAttribute("SetNewQtrId1", additionalFacultyProgress.getQtrIdJsp3());
			model.addAttribute("fetchinstitueInfraHrActivityDetails", institueInfraHrActivityDetails);
			model.addAttribute("QUATER_DETAILS", progressReportService.getQuarterDurations());

		} else {
			model.addAttribute("approved", false);

		}
		return ADDITIONAL_FACULTY_QUADERLY;

	}

	@RequestMapping(value = "additionalfacultyProgress", method = RequestMethod.POST)
	public String getAdditionalFacalltyHrPost(
			@ModelAttribute("ADD_QUATER") AdditionalFacultyProgress additionalFacultyProgress, Model model,
			HttpServletRequest request, RedirectAttributes re) {
		// Integer Activity =
		// satcomActivityProgress.getSatcomActivity().get(0).getSatcomActivityId();
		progressReportService.saveAdditionalFacultyProgress(additionalFacultyProgress);
		re.addFlashAttribute(Message.SUCCESS_KEY, Message.SAVE_SUCCESS);
		return REDIRECT_ADDITIONAL_QUADERLY;
	}

	@RequestMapping(value = "pmuProgresReport", method = RequestMethod.GET)
	public String qprGetFormPmuActivityMethodQuaterly(@ModelAttribute("PMU_ACTIVITY_QUATERLY") PmuProgress pmuProgress,
			Model model, HttpServletRequest request) {
		int quarterId = 0;
		int installmentNo = (quarterId < 3) ? 1 : 2; // installment number for qtrId 1 & 2 = 1 and 3 & 4 = 2
		if (pmuProgress.getQtrIdJsp6() != null) {
			quarterId = pmuProgress.getQtrIdJsp6();
		} else {
			quarterId = 0;
		}

		List<StateAllocation> stateAllocation = new ArrayList<>();
		List<QuaterWiseFund> totalQuatorWiseFund = new ArrayList<>();
		List<PmuActivity> pmuCecApprovedActivities = pmuActivityService.fetchApprovedPmu();
		stateAllocation = progressReportService.fetchStateAllocationDataByCompIdandInstallNo(12, installmentNo);
		model.addAttribute("QUATER_DETAILS", progressReportService.getQuarterDurations());
		if (quarterId == 3 || quarterId == 4) {
			stateAllocation.add(progressReportService.fetchStateAllocationDataByCompIdandInstallNo(12, 1).get(0)); // total fund allocated in first quator
			totalQuatorWiseFund = progressReportService.fetchTotalQuaterWiseFundData(userPreference.getStateCode(), 12);
			model.addAttribute("TOTAL_FUND_USED_IN_QTR_1_AND_2", calTotalFundUsedInQtr1And2(totalQuatorWiseFund));
		}
		if (CollectionUtils.isNotEmpty(stateAllocation) && CollectionUtils.isNotEmpty(pmuCecApprovedActivities)) {

			if (stateAllocation.size() > 1) {
				model.addAttribute("FUND_ALLOCATED_BY_STATE_PREVIOUS", stateAllocation.get(1).getFundsAllocated()); // we will use this in jsp to calculate the total remaining field
			}

			// list to get total number of unit in all quator except current one
			List<PmuProgressDetails> detailForTotalNoOfUnit = new ArrayList<>();
			List<PmuProgressDetails> pmuReportDetailOfRestQuater = pmuActivityService
					.getPmuProgressActBasedOnActIdAndQtrId(pmuCecApprovedActivities.get(0).getPmuActivityId(),
							quarterId);
			if (pmuReportDetailOfRestQuater != null) {
				Collections.sort(pmuReportDetailOfRestQuater,
						(o1, o2) -> o1.getQprPmuDetailsId() - o2.getQprPmuDetailsId());
				detailForTotalNoOfUnit = getTotalUnitAndExpIncurredInAllQtrPmu(detailForTotalNoOfUnit,
						pmuReportDetailOfRestQuater);
				model.addAttribute("DEATIL_FOR_TOTAL_NO_OF_UNIT", detailForTotalNoOfUnit);
			} else {
				model.addAttribute("DEATIL_FOR_TOTAL_NO_OF_UNIT", null);
			}

			PmuProgress pmuProgressActivity = progressReportService
					.fetchPmu(pmuCecApprovedActivities.get(0).getPmuActivityId(), quarterId);
			if (pmuProgressActivity != null) {
				Collections.sort(pmuProgressActivity.getPmuProgressDetails(),
						(o1, o2) -> o1.getQprPmuDetailsId() - o2.getQprPmuDetailsId());
				model.addAttribute("PMU_PROGRESS", pmuProgressActivity);
			} else {
				if (pmuProgress.getPmuProgressDetails() != null) {
					pmuProgress.getPmuProgressDetails().clear();
				}
			}

			/*
			 * used to get previous data stored which is then use to validate the
			 * expenditure incurred
			 */
			List<QuaterWiseFund> quaterWiseFund = new ArrayList<>();
			if (quarterId == 1 || quarterId == 3) {
				quaterWiseFund = progressReportService.fetchQuaterWiseFundData(userPreference.getStateCode(),
						(quarterId + 1), 12);
			} else {
				quaterWiseFund = progressReportService.fetchQuaterWiseFundData(userPreference.getStateCode(),
						(quarterId - 1), 12);
			}
			if (CollectionUtils.isNotEmpty(quaterWiseFund)) {
				model.addAttribute("FUND_USED_IN_OTHER_QUATOR", quaterWiseFund.get(0).getFunds());
			}
			/*----------------------------end here-------------------------------------------------- */
			model.addAttribute("FUND_ALLOCATED_BY_STATE", stateAllocation.get(0).getFundsAllocated());
			model.addAttribute("CEC_APPROVED_ACTIVITY", pmuCecApprovedActivities.get(0));
			model.addAttribute("QTR_ID", quarterId);

			return TRAINING_PROGRESS_PMU;
		} else {
			return NO_FUND_ALLOCATED_JSP;
		}
	}

	@RequestMapping(value = "pmuProgresReport", method = RequestMethod.POST)
	public String getPmuActivityPost(@ModelAttribute("PMU_ACTIVITY_QUATERLY") PmuProgress pmuProgress, Model model,
			HttpServletRequest request, RedirectAttributes re) {
		progressReportService.savePmu(pmuProgress);
		re.addFlashAttribute(Message.SUCCESS_KEY, Message.SAVE_SUCCESS);
		return REDIRECT_TRAINING_PROGRESS_PMU;
	}

	/* method for pmu report */
	private List<PmuProgressDetails> getTotalUnitAndExpIncurredInAllQtrPmu(
			List<PmuProgressDetails> deatilForTotalNoOfUnit, List<PmuProgressDetails> detailsBasedOnActIdAndQtrId) {
		int count = 0;
		for (int i = 0; i < 6; i++) {
			deatilForTotalNoOfUnit.add(new PmuProgressDetails());
		}
		for (int j = 0; j < detailsBasedOnActIdAndQtrId.size(); j++) {
			if (count == 6) {
				count = 0;
			}
			for (int i = count; i < count + 1; i++) {
				if (deatilForTotalNoOfUnit.get(i).getNoOfUnitsFilled() != null) {
					deatilForTotalNoOfUnit.get(i).setNoOfUnitsFilled(deatilForTotalNoOfUnit.get(i).getNoOfUnitsFilled()
							+ detailsBasedOnActIdAndQtrId.get(j).getNoOfUnitsFilled());
				} else {
					deatilForTotalNoOfUnit.get(i)
							.setNoOfUnitsFilled(0 + detailsBasedOnActIdAndQtrId.get(j).getNoOfUnitsFilled());
				}
				if (deatilForTotalNoOfUnit.get(i).getExpenditureIncurred() != null) {
					deatilForTotalNoOfUnit.get(i)
							.setExpenditureIncurred(deatilForTotalNoOfUnit.get(i).getExpenditureIncurred()
									+ detailsBasedOnActIdAndQtrId.get(j).getExpenditureIncurred());
				} else {
					deatilForTotalNoOfUnit.get(i)
							.setExpenditureIncurred(detailsBasedOnActIdAndQtrId.get(j).getExpenditureIncurred() + 0);
				}
			}
			++count;
		}
		return deatilForTotalNoOfUnit;
	}

	/* new method ends here */

	@RequestMapping(value = "enablementQuaterly", method = RequestMethod.GET)
	public String qprGetFormEnablementQuaderly(@ModelAttribute("Enablement") QprEnablement qprEnablement, Model model,
			RedirectAttributes re) {

		int quarterId = 0;
		if (qprEnablement.getQrtId() != null) {
			quarterId = qprEnablement.getQrtId();
		} else {
			quarterId = 0;
		}
		model.addAttribute("approved", true);
		List<EEnablement> eEnablementsApproved = eEnablementOfPanchayatService.getApprovedEEnablement();
		/* getting stateAllocation data by using component id */
		List<StateAllocation> stateAllocation = new ArrayList<>();
		List<QuaterWiseFund> totalQuatorWiseFund = new ArrayList<>();
		model.addAttribute("QUATER_DETAILS", progressReportService.getQuarterDurations());
		model.addAttribute("LGD_DISTRICT", lgdService.getAllDistrictBasedOnState(userPreference.getStateCode()));
		int installmentNo = (quarterId < 3) ? 1 : 2; // installment number for qtrId 1 & 2 = 1 and 3 & 4 = 2
		stateAllocation = progressReportService.fetchStateAllocationData(5, 16, installmentNo);
		if (quarterId == 3 || quarterId == 4) {
			stateAllocation.add(progressReportService.fetchStateAllocationData(5, 16, 1).get(0)); // total fund allocated in first quator
			totalQuatorWiseFund = progressReportService.fetchTotalQuaterWiseFundData(userPreference.getStateCode(), 5);
			model.addAttribute("TOTAL_FUND_USED_IN_QTR_1_AND_2", calTotalFundUsedInQtr1And2(totalQuatorWiseFund));
		}
		if (CollectionUtils.isNotEmpty(stateAllocation)) {
			model.addAttribute("FUND_ALLOCATED_BY_STATE", stateAllocation.get(0).getFundsAllocated());
			if (stateAllocation.size() > 1) {
				model.addAttribute("FUND_ALLOCATED_BY_STATE_PREVIOUS", stateAllocation.get(1).getFundsAllocated()); // we will  use this in jsp to calculate the total remaining field
			}
			Integer id = eEnablementsApproved.get(0).geteEnablementId();
			Integer eEnablementDetailsId = eEnablementsApproved.get(0).geteEnablementDetails().get(0)
					.geteEnablementDetailId();
			List<EEnablementGPs> eEnablementGPs = eEnablementOfPanchayatService
					.fetchCapacityBuildingActivityGPsList(eEnablementDetailsId);
			int district = eEnablementGPs.get(0).getDistrictCode();
			if (qprEnablement.getDistrictId() != null) {
				district = qprEnablement.getDistrictId();
			} else {
				district = eEnablementGPs.get(0).getDistrictCode();
			}
			List<EEnablementReportDto> eEnablementReportDto = eEnablementOfPanchayatService
					.getEEnablementReportDto(district);
			model.addAttribute("eEnablementReportDto", eEnablementReportDto);
			model.addAttribute("eEnablementGPs", eEnablementGPs);
			model.addAttribute("idEEnablement", id);
			model.addAttribute("SetNewQtrId1", qprEnablement.getQrtId());
			model.addAttribute("SetNewDistrictId", qprEnablement.getDistrictId());
			model.addAttribute("quarterId", quarterId);
			if (eEnablementReportDto.size() == 0) {
				model.addAttribute("record", false);
				return ENABLEMENT_PROGRESS_REPORT;
			}
			int eEnablementId = eEnablementReportDto.get(0).geteEnablementId();
			int localbodyCode = eEnablementReportDto.get(0).getLocalBodyCode();
			List<QprEnablementDetails> fetchDetails = eEnablementOfPanchayatService.getEEnablementReport(localbodyCode,
					qprEnablement.getQprEEnablementId());
			QprEnablement fetchQprEnablement = progressReportService.fetchQprEnablement(eEnablementId, quarterId);
			/*
			 * used to get previous data stored which is then use to validate the
			 * expenditure incurred
			 */

			List<QuaterWiseFund> quaterWiseFund = new ArrayList<>();
			List<QprEnablementDetails> qprEnablementDetails = new ArrayList<>();
			if (quarterId == 1 || quarterId == 3) {
				quaterWiseFund = progressReportService.fetchQuaterWiseFundData(userPreference.getStateCode(),
						(quarterId + 1), 5);
			} else {
				quaterWiseFund = progressReportService.fetchQuaterWiseFundData(userPreference.getStateCode(),
						(quarterId - 1), 5);
			}
			if (CollectionUtils.isNotEmpty(quaterWiseFund)) {
				model.addAttribute("FUND_USED_IN_OTHER_QUATOR", quaterWiseFund.get(0).getFunds());
			}

			/*----------------------------end here-------------------------------------------------- */
			model.addAttribute("fetchDetails", fetchDetails);
			if (fetchQprEnablement != null) {
				model.addAttribute("Qpr_Enablement", fetchQprEnablement);
				qprEnablementDetails = progressReportService
						.fetchQprEnablementDetails(fetchQprEnablement.getQprEEnablementId());
				model.addAttribute("EnablementDtlsList", qprEnablementDetails);
			} else {
				QprEnablement fetchQprEnablement1 = progressReportService.fetchEEnablementProgressToGeReportId1(id);
				if (fetchQprEnablement1 != null) {
					model.addAttribute("qprEEnablementId", fetchQprEnablement1.getQprEEnablementId());
				}
			}
		} else {
			model.addAttribute("approved", false);
			return NO_FUND_ALLOCATED_JSP;
		}
		return ENABLEMENT_PROGRESS_REPORT;
	}

	protected double calTotalFundUsedInQtr1And2(List<QuaterWiseFund> obj) {
		double total = 0;
		for (QuaterWiseFund object : obj) {
			if (object.getQuarter_id() < 3) {
				total += object.getFunds();
			}
		}
		return total;
	}

	@RequestMapping(value = "enablementQuaterly", method = RequestMethod.POST)
	public String getEnablementQuaterlyPost(@ModelAttribute("Enablement") QprEnablement qprEnablement, Model model,
			HttpServletRequest request, RedirectAttributes re) {
		progressReportService.saveEnablement(qprEnablement);
		re.addFlashAttribute(Message.SUCCESS_KEY, Message.SAVE_SUCCESS);
		return REDIRECT_ENABLEMENT_PROGRESS_REPORT;
	}

	@RequestMapping(value = "innovativeActivityQpr", method = RequestMethod.GET)
	public String qprGetFormInnovativeActivityQpr(
			@ModelAttribute("INNOVATIVE_ACTIVITY_QUATERLY_REPORT") QprInnovativeActivity qprInnovativeActivity, Model model,
			HttpServletRequest request) {

		int quarterId = 0;
		if (qprInnovativeActivity.getQtrId() != null) {
			quarterId = qprInnovativeActivity.getQtrId();
		} else {
			quarterId = 0;
		}
		
		int installmentNo = (quarterId < 3) ? 1 : 2; // installment number for qtrId 1 & 2 = 1 and 3 & 4 = 2
		model.addAttribute("QTR_ID", quarterId);
		model.addAttribute("QUATER_DETAILS", progressReportService.getQuarterDurations());
		List<QuaterWiseFund> totalQuatorWiseFund = new ArrayList<>();
		List<InnovativeActivity> innovativeActApproved=innovativeActivityService.fetchApprovedInnovative(); 
		List<StateAllocation> stateAllocation = progressReportService.fetchStateAllocationDataByCompIdandInstallNo(9,installmentNo);
		if (quarterId == 3 || quarterId == 4) {
			stateAllocation.add(progressReportService.fetchStateAllocationDataByCompIdandInstallNo(9, 1).get(0)); // total fund allocated in first quator
			totalQuatorWiseFund = progressReportService.fetchTotalQuaterWiseFundData(userPreference.getStateCode(), 9);
			model.addAttribute("TOTAL_FUND_USED_IN_QTR_1_AND_2", calTotalFundUsedInQtr1And2(totalQuatorWiseFund));
		}
		
		if(CollectionUtils.isNotEmpty(stateAllocation) && CollectionUtils.isNotEmpty(innovativeActApproved)) {
			if (stateAllocation.size() > 1) {
				model.addAttribute("FUND_ALLOCATED_BY_STATE_PREVIOUS", stateAllocation.get(1).getFundsAllocated()); // we will use this in jsp to calculate the total remaining field
			}
			
			QprInnovativeActivity qprInnovativeAct=progressReportService.getInnovative(innovativeActApproved.get(0).getInnovativeActivityId(), quarterId);
			if(qprInnovativeAct != null) {
				Collections.sort(qprInnovativeAct.getQprInnovativeActivityDetails(), (o1,o2) -> o1.getQprIaDetailsId() - o2.getQprIaDetailsId());
				model.addAttribute("QPR_INNOVATIVE_ACTIVITY", qprInnovativeAct);
			}else {
				if(qprInnovativeActivity.getQprInnovativeActivityDetails() != null) {
					qprInnovativeActivity.getQprInnovativeActivityDetails().clear();
				}
			}
			
			/* used to get previous data stored which is then use to validate the  expenditure incurred */
			List<QuaterWiseFund> quaterWiseFund = new ArrayList<>();
			if (quarterId == 1 || quarterId == 3) {
				quaterWiseFund = progressReportService.fetchQuaterWiseFundData(userPreference.getStateCode(),
						(quarterId + 1), 9);
			} else {
				quaterWiseFund = progressReportService.fetchQuaterWiseFundData(userPreference.getStateCode(),
						(quarterId - 1), 9);
			}
			if (CollectionUtils.isNotEmpty(quaterWiseFund)) {
				model.addAttribute("FUND_USED_IN_OTHER_QUATOR", quaterWiseFund.get(0).getFunds());
			}
			/*----------------------------end here-------------------------------------------------- */
			
			model.addAttribute("FUND_ALLOCATED_BY_STATE", stateAllocation.get(0).getFundsAllocated());
			model.addAttribute("CEC_APPROVED_ACTIVITY", innovativeActApproved.get(0));
			return INNOVATIVE_PROGRESS_REPORT;
		}else {
			return NO_FUND_ALLOCATED_JSP;
		}
		
	}

	@RequestMapping(value = "innovativeActivityQpr", method = RequestMethod.POST)
	public String innovativeQtrProgressReport(@ModelAttribute("INNOVATIVE_ACTIVITY_QUATERLY_REPORT") QprInnovativeActivity qprInnovativeActivity, RedirectAttributes re) {
 		progressReportService.saveInnovative(qprInnovativeActivity);
		re.addFlashAttribute(Message.SUCCESS_KEY, Message.SAVE_SUCCESS);
		return REDIRECT_INNOVATIVE_PROGRESS_REPORT;
	}

	@RequestMapping(value = "adminDataFinQuaterlyGet", method = RequestMethod.GET)
	public String qprGetFormAdminDataFinQuaterly(@ModelAttribute("QPR_ADMIN_DATA_FIN") QprAdminAndFinancialDataActivity qprAdminAndFinancialDataActivity,Model model) {

		int quarterId = 0;
		if (qprAdminAndFinancialDataActivity.getShowQqrtrId() != null) {
			quarterId = qprAdminAndFinancialDataActivity.getShowQqrtrId();
		} else {
			quarterId = 0;
		}

		int installmentNo = (quarterId < 3) ? 1 : 2; // installment number for qtrId 1 & 2 = 1 and 3 & 4 = 2
		List<QuaterWiseFund> totalQuatorWiseFund = new ArrayList<>();
		List<AdminAndFinancialDataActivity> adminAndFinancialDataActivityApproved = adminAndFinancialDataCellService.fetchApprovedActivity();
		List<StateAllocation> stateAllocation = progressReportService.fetchStateAllocationDataByCompIdandInstallNo(8,installmentNo);
		model.addAttribute("quarter_duration", progressReportService.getQuarterDurations());
		if (quarterId == 3 || quarterId == 4) {
			stateAllocation.add(progressReportService.fetchStateAllocationDataByCompIdandInstallNo(8, 1).get(0)); // total fund allocated in first quator
			totalQuatorWiseFund = progressReportService.fetchTotalQuaterWiseFundData(userPreference.getStateCode(), 8);
			model.addAttribute("TOTAL_FUND_USED_IN_QTR_1_AND_2", calTotalFundUsedInQtr1And2(totalQuatorWiseFund));
		}
		if (CollectionUtils.isNotEmpty(stateAllocation)
				&& CollectionUtils.isNotEmpty(adminAndFinancialDataActivityApproved)) {

			if (stateAllocation.size() > 1) {
				model.addAttribute("FUND_ALLOCATED_BY_STATE_PREVIOUS", stateAllocation.get(1).getFundsAllocated()); // we will use this in jsp to calculate the total remaining field
			}

			// list to get total number of unit in all quator except current one
			List<QprAdminAndFinancialDataActivityDetails> detailForTotalNoOfUnit = new ArrayList<>();
			List<QprAdminAndFinancialDataActivityDetails> AdminFinCellReportDetailOfRestQuater = adminAndFinancialDataCellService
					.getPmuProgressActBasedOnActIdAndQtrId(
							adminAndFinancialDataActivityApproved.get(0).getAdminFinancialDataActivityId(), quarterId);
			if (AdminFinCellReportDetailOfRestQuater != null) {
				Collections.sort(AdminFinCellReportDetailOfRestQuater,
						(o1, o2) -> o1.getQprAfpDetailsId() - o2.getQprAfpDetailsId());
				detailForTotalNoOfUnit = getTotalUnitAndExpIncurredInAllQtrAdminFinCell(detailForTotalNoOfUnit,
						AdminFinCellReportDetailOfRestQuater);
				model.addAttribute("DEATIL_FOR_TOTAL_NO_OF_UNIT", detailForTotalNoOfUnit);
			} else {
				model.addAttribute("DEATIL_FOR_TOTAL_NO_OF_UNIT", null);
			}

			QprAdminAndFinancialDataActivity activity = progressReportService.fetchQprAdminFin(
					adminAndFinancialDataActivityApproved.get(0).getAdminFinancialDataActivityId(), quarterId);
			if (activity != null) {
				Collections.sort(activity.getQprAdminAndFinancialDataActivityDetails(),
						(o1, o2) -> o1.getQprAfpDetailsId() - o2.getQprAfpDetailsId());
				model.addAttribute("ADMIN_FIN_CELL_QPR_ACT", activity);
			} else {
				if (qprAdminAndFinancialDataActivity.getQprAdminAndFinancialDataActivityDetails() != null) {
					qprAdminAndFinancialDataActivity.getQprAdminAndFinancialDataActivityDetails().clear();
				}
			}

			/* used to get previous data stored which is then use to validate the  expenditure incurred */
			List<QuaterWiseFund> quaterWiseFund = new ArrayList<>();
			if (quarterId == 1 || quarterId == 3) {
				quaterWiseFund = progressReportService.fetchQuaterWiseFundData(userPreference.getStateCode(),
						(quarterId + 1), 8);
			} else {
				quaterWiseFund = progressReportService.fetchQuaterWiseFundData(userPreference.getStateCode(),
						(quarterId - 1), 8);
			}
			if (CollectionUtils.isNotEmpty(quaterWiseFund)) {
				model.addAttribute("FUND_USED_IN_OTHER_QUATOR", quaterWiseFund.get(0).getFunds());
			}
			/*----------------------------end here-------------------------------------------------- */
			model.addAttribute("FUND_ALLOCATED_BY_STATE", stateAllocation.get(0).getFundsAllocated());
			model.addAttribute("CEC_APPROVED_ACTIVITY", adminAndFinancialDataActivityApproved.get(0));
			model.addAttribute("QTR_ID", quarterId);
			return ADMIN_DATA_FIN_QUATERLY;
		} else {
			return NO_FUND_ALLOCATED_JSP;
		}
	}

	@RequestMapping(value = "adminDataFinQuaterlyGet", method = RequestMethod.POST)
	public String saveadminDataFinQuaterly(
			@ModelAttribute("QPR_ADMIN_DATA_FIN") QprAdminAndFinancialDataActivity qprAdminAndFinancialDataActivity,
			Model model, RedirectAttributes redirectAttributes) {
		progressReportService.saveAdminDataFinQuaterly(qprAdminAndFinancialDataActivity);
		redirectAttributes.addFlashAttribute(Message.SUCCESS_KEY, Message.SAVE_SUCCESS);
		return REDIRECT_ADMIN_DATA_FIN_QUATERLY;
	}

	/* method for admin fin cell report */
	private List<QprAdminAndFinancialDataActivityDetails> getTotalUnitAndExpIncurredInAllQtrAdminFinCell(
			List<QprAdminAndFinancialDataActivityDetails> deatilForTotalNoOfUnit,
			List<QprAdminAndFinancialDataActivityDetails> detailsBasedOnActIdAndQtrId) {
		int count = 0;
		for (int i = 0; i < 3; i++) {
			deatilForTotalNoOfUnit.add(new QprAdminAndFinancialDataActivityDetails());
		}
		for (int j = 0; j < detailsBasedOnActIdAndQtrId.size(); j++) {
			if (count == 3) {
				count = 0;
			}
			for (int i = count; i < count + 1; i++) {
				if (deatilForTotalNoOfUnit.get(i).getNoOfUnitsFilled() != null) {
					deatilForTotalNoOfUnit.get(i).setNoOfUnitsFilled(deatilForTotalNoOfUnit.get(i).getNoOfUnitsFilled()
							+ detailsBasedOnActIdAndQtrId.get(j).getNoOfUnitsFilled());
				} else {
					deatilForTotalNoOfUnit.get(i)
							.setNoOfUnitsFilled(0 + detailsBasedOnActIdAndQtrId.get(j).getNoOfUnitsFilled());
				}
				if (deatilForTotalNoOfUnit.get(i).getExpenditureIncurred() != null) {
					deatilForTotalNoOfUnit.get(i)
							.setExpenditureIncurred(deatilForTotalNoOfUnit.get(i).getExpenditureIncurred()
									+ detailsBasedOnActIdAndQtrId.get(j).getExpenditureIncurred());
				} else {
					deatilForTotalNoOfUnit.get(i)
							.setExpenditureIncurred(detailsBasedOnActIdAndQtrId.get(j).getExpenditureIncurred() + 0);
				}
			}
			++count;
		}
		return deatilForTotalNoOfUnit;
	}

	/* new method ends here */

	@RequestMapping(value = "institutionalInfraQuaterlyReport", method = RequestMethod.GET)
	public String getQprgGramPanchayat(
			@ModelAttribute("QPR_INSTITUTIONALINFRAQUATERLY") QprInstitutionalInfrastructure qprInstitutionalInfrastructure,
			Model model, HttpServletResponse httpResponse) {
		model.addAttribute("quarterDuration", progressReportService.getQuarterDurations());
		model.addAttribute("buildingType", institutionalInfraActivityPlanService.fetchTrainingInstituteTypeId());

		return INSTITUTIONAL_INFRA_REPORT;
	}

	@RequestMapping(value = "institutionalInfraQuaterlyReport", method = RequestMethod.POST)
	private String getQprgGramPanchayatActivity(
			@ModelAttribute("QPR_INSTITUTIONALINFRAQUATERLY") QprInstitutionalInfrastructure qprInstitutionalInfrastructure,
			Model model) {
		int quatorId = qprInstitutionalInfrastructure.getQuaterId();
		int institutionalInfraActivivtyId = 0;
		int instituteInfrsaHrActivityDetailsId = 0;
		int TrainingInstituteTypeId = qprInstitutionalInfrastructure.getTrainingInstituteTypeId();
		Set<InstitutionalInfraProgressReportDTO> set = new HashSet<>();
		List<InstitutionalInfraProgressReportDTO> institutionalInfraProgressReportDTO = institutionalInfraActivityPlanService
				.fetchInstInfraStateDataForProgressReport(TrainingInstituteTypeId);
		Iterator<InstitutionalInfraProgressReportDTO> itr = institutionalInfraProgressReportDTO.iterator();
		while (itr.hasNext()) {

			InstitutionalInfraProgressReportDTO obj = (InstitutionalInfraProgressReportDTO) itr.next();

			if (obj != null) {
				set.add(obj);

			}
			institutionalInfraActivivtyId = obj.getInstitutionalInfraActivityId();
			instituteInfrsaHrActivityDetailsId = obj.getInstitutionalInfraActivityDetailId();
		}

		// List<InstInfraStatus> qprInstitutionalInfra =
		// institutionalInfraActivityPlanService.fetchInstInfraStatus(TrainingInstituteTypeId);
		List<QprInstitutionalInfrastructure> qprInstitutionalInfra = institutionalInfraActivityPlanService
				.fetchDataAccordingToQuator(quatorId, institutionalInfraActivivtyId);

		if (!qprInstitutionalInfra.isEmpty()) {
			for (int i = 0; i < qprInstitutionalInfra.get(0).getQprInstitutionalInfraDetails().size(); i++) {
				if (qprInstitutionalInfrastructure.getTrainingInstituteTypeId() == 2) {
					List<QprInstitutionalInfraDetails> qprInstitutionalInfraDetailsForType2 = institutionalInfraActivityPlanService
							.fetchDataOfDetailAccordingToQuator(
									qprInstitutionalInfrastructure.getTrainingInstituteTypeId(),
									qprInstitutionalInfra.get(0).getQprInstInfraId());
					model.addAttribute("QPR_INSTITUTIONAL_INFRA_DETAILS", qprInstitutionalInfraDetailsForType2);

				} else if (qprInstitutionalInfrastructure.getTrainingInstituteTypeId() == 4) {
					List<QprInstitutionalInfraDetails> qprInstitInfraDetailsForType4 = institutionalInfraActivityPlanService
							.fetchDataOfDetailAccordingToQuator(
									qprInstitutionalInfrastructure.getTrainingInstituteTypeId(),
									qprInstitutionalInfra.get(0).getQprInstInfraId());

					model.addAttribute("QPR_INSTITUTIONAL_INFRA_DETAILS", qprInstitInfraDetailsForType4);
				}

			}
			model.addAttribute("QPRPANCHAYATBHAWAN", qprInstitutionalInfra.get(0));

		}
		// Collections.sort(QprPanchayatBhawan.get(0).getQprPanhcayatBhawanDetails(),
		// Comparator.comparing(QprPanhcayatBhawanDetails::getQprPanhcayatBhawanDetailsId));

		model.addAttribute("INSTITUTIONAL_INFRA_REPORT_DTO", set);

		// model.addAttribute("GPBhawanStatus",
		// panchayatBhawanService.fetchGPBhawanStatus(TrainingInstituteTypeId));
		model.addAttribute("panchayatActivity", institutionalInfraActivityPlanService.fetchTrainingInstituteTypeId());
		model.addAttribute("buildingType", institutionalInfraActivityPlanService.fetchTrainingInstituteTypeId());
		model.addAttribute("InstInfraStatus",
				institutionalInfraActivityPlanService.fetchInstInfraStatus(TrainingInstituteTypeId));
		model.addAttribute("institutionalInfraActivivtyId", institutionalInfraActivivtyId);
		model.addAttribute("instituteInfrsaHrActivityDetailsId", instituteInfrsaHrActivityDetailsId);

		model.addAttribute("quarterDuration", progressReportService.getQuarterDurations());
		model.addAttribute("SetActivityId", qprInstitutionalInfrastructure.getTrainingInstituteTypeId());

		model.addAttribute("SetQuaterId", qprInstitutionalInfrastructure.getQuaterId());

		return INSTITUTIONAL_INFRA_REPORT;
	}

	@RequestMapping(value = "saveQprInstitutionalInfrastructureData", method = RequestMethod.POST)
	private String saveQprInstInfraData(
			@ModelAttribute("QPR_INSTITUTIONALINFRAQUATERLY") QprInstitutionalInfrastructure qprInstitutionalInfrastructure,
			Model model, RedirectAttributes redirectAttributes) throws IOException {

		for (int i = 0; i < qprInstitutionalInfrastructure.getQprInstitutionalInfraDetails().size(); i++) {
			if (qprInstitutionalInfrastructure.getQprInstitutionalInfraDetails().get(i).getFile() != null
					&& qprInstitutionalInfrastructure.getQprInstitutionalInfraDetails().get(i).getFile()
							.getSize() != 0) {

				MultipartFile file = qprInstitutionalInfrastructure.getQprInstitutionalInfraDetails().get(i).getFile();

				String filename = file.getOriginalFilename();
				String filenameWithoutExtnsn = FilenameUtils.removeExtension(filename);
				String extnsn = FilenameUtils.getExtension(filename);

				AttachmentMaster attachmentMaster = enhancementService.findDetailsofAttachmentMaster();

				String path = attachmentMaster.getFileLocation();

				if (file.isEmpty()) {
					redirectAttributes.addFlashAttribute(Message.ERROR_KEY, "File Upload Required");
					return REDIRECT_INSTITUTIONAL_INFRA_REPORT;
				} else if (!file.getContentType().equals("application/pdf")) {
					redirectAttributes.addFlashAttribute(Message.ERROR_KEY, "File Upload Type Required(Pdf)");
					return REDIRECT_INSTITUTIONAL_INFRA_REPORT;
				} else if (file.getSize() > 2097152) {
					redirectAttributes.addFlashAttribute(Message.ERROR_KEY, "Max File Size is 2MB");
					return REDIRECT_INSTITUTIONAL_INFRA_REPORT;
				}

				Date date = new Date();
				SimpleDateFormat dateFormat = new SimpleDateFormat("yyyyMMddHHmmss");
				String newFilename = filenameWithoutExtnsn + "_" + dateFormat.format(date) + "." + extnsn;

				/* ......................File Delete code................. */

				File deleteFile = new File(qprInstitutionalInfrastructure.getPath() + "/"
						+ qprInstitutionalInfrastructure.getDbFileName());
				if (deleteFile.exists()) {
					deleteFile.delete();
				}
				/* ......................File Delete code................. */

				byte[] bytes = file.getBytes();
				File dir = new File(path + File.separator + "qprInstitutionalInfrastructure");

				BufferedOutputStream stream = new BufferedOutputStream(new FileOutputStream(dir + "/" + newFilename));
				stream.write(bytes);
				stream.close();

				qprInstitutionalInfrastructure.getQprInstitutionalInfraDetails().get(i)
						.setFileContentType(file.getContentType());
				qprInstitutionalInfrastructure.getQprInstitutionalInfraDetails().get(i).setFileLocation(path);
				qprInstitutionalInfrastructure.getQprInstitutionalInfraDetails().get(i).setFileName(newFilename);
			}
		}
		institutionalInfraActivityPlanService.saveQprInstInfraData(qprInstitutionalInfrastructure);
		redirectAttributes.addFlashAttribute(Message.SUCCESS_KEY, Message.SAVE_SUCCESS);

		return REDIRECT_INSTITUTIONAL_INFRA_REPORT;
	}
}