package gov.in.rgsa.controller;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.collections.CollectionUtils;
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
import gov.in.rgsa.entity.AdministrativeTechnicalProgress;
import gov.in.rgsa.entity.AdministrativeTechnicalSupport;
import gov.in.rgsa.entity.EEnablement;
import gov.in.rgsa.entity.EEnablementGPs;
import gov.in.rgsa.entity.GPBhawanStatus;
import gov.in.rgsa.entity.Block;
import gov.in.rgsa.entity.IecActivity;
import gov.in.rgsa.entity.IecQuater;
import gov.in.rgsa.entity.IncomeEnhancementActivity;
import gov.in.rgsa.entity.InnovativeActivity;
import gov.in.rgsa.entity.InnovativeActivityDetails;
import gov.in.rgsa.entity.InstInfraStatus;
import gov.in.rgsa.entity.InstitueInfraHrActivity;
import gov.in.rgsa.entity.InstitueInfraHrActivityDetails;
import gov.in.rgsa.entity.InstituteInfraHrActivityType;
import gov.in.rgsa.entity.InstitutionalInfraActivityPlan;
import gov.in.rgsa.entity.InstitutionalInfraActivityPlanDetails;
import gov.in.rgsa.entity.PmuActivity;
import gov.in.rgsa.entity.PmuActivityType;
import gov.in.rgsa.entity.PmuProgress;
import gov.in.rgsa.entity.QprEnablement;
import gov.in.rgsa.entity.QprEnablementDetails;
import gov.in.rgsa.entity.PmuWiseProposedDomainExperts;
import gov.in.rgsa.entity.QprAdminAndFinancialDataActivity;
import gov.in.rgsa.entity.QprAdminAndFinancialDataActivityDetails;
import gov.in.rgsa.entity.QprPanchayatBhawan;
import gov.in.rgsa.entity.QprIncomeEnhancement;
import gov.in.rgsa.entity.QprIncomeEnhancementDetails;
import gov.in.rgsa.entity.QprInnovativeActivity;
import gov.in.rgsa.entity.QprInstitutionalInfrastructure;
import gov.in.rgsa.entity.QprPanchayatBhawan;
import gov.in.rgsa.entity.SatcomActivity;
import gov.in.rgsa.entity.SatcomActivityProgress;
import gov.in.rgsa.entity.TrainingActivity;
import gov.in.rgsa.entity.TrainingProgressReport;
import gov.in.rgsa.model.IecModel;
import gov.in.rgsa.service.AdditionalFacultyAndMainService;
import gov.in.rgsa.service.AdminAndFinancialDataCellService;
import gov.in.rgsa.service.AdminTechSupportService;
import gov.in.rgsa.service.CBMasterService;
import gov.in.rgsa.service.CapacityBuildingService;
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
	public static final String REDIRECT_IncomeEnhancement_Quaterly = "redirect:incomeEnhancementQuaterly.html";
	public static final String REDIRECT_ENABLEMENT_PROGRESS_REPORT ="redirect:enablementQuaterly.html";
	public static final String ENABLEMENT_PROGRESS_REPORT = "approveEnablementQuaterly";
	public static final String GRAM_PANCHAYAT_PROGRESS_REPORT = "gramPanchayatProgressReport";
	public static final String CAPACITY_BUILDING__PROGRESS_REPORT = "capacityBuildingOneQtrProgressReport";
	public static final String IEC_PROGRESS_REPORT = "approvedIecQtrProgressReport";
	public static final String REDIRECT_IEC_PROGRESS_REPORT ="redirect:iecQtrProgressReport.html";
	public static final String INNOVATIVE_PROGRESS_REPORT = "approvedInnovativeActivityQpr";
	public static final String REDIRECT_INNOVATIVE_PROGRESS_REPORT = "redirect:innovativeActivityQpr.html";
	public static final String TRAINING_PROGRESS_PMU ="approvePmuQuaterly";
	public static final String REDIRECT_TRAINING_PROGRESS_PMU ="redirect:pmuProgresReport.html";
	
	private static final String PANCHAYAT_BHAWAN_REPORT= "panchayatBhawanQuaterlyReport";
	private static final String INSTITUTIONAL_INFRA_REPORT= "institutionalInfraQuaterlyReport";
	public static final String IncomeEnhancement_Quaterly ="incomeEnhancementQuaterly";
	public static final String CURRENT_SATCOM_QUATERLY ="approvedCurrentUsageSatcomQuaterly";
	public static final String REDIRECT_CURRENT_SATCOM_QUATERLY ="redirect:currentUsageSatcomQuaterly.html";

	public static final String ADMIN_QUADERLY ="approvedadminTechQuaderly";
	public static final String REDIRECT_ADMIN_QUADERLY ="redirect:adminTechQuaderly.html";
	public static final String ADDITIONAL_FACULTY_QUADERLY ="approvedAdditionalfacultyProgress";
	public static final String REDIRECT_ADDITIONAL_QUADERLY ="redirect:additionalfacultyProgress.html";
/*	private static final String INSTITUTIONAL_INFRA_REPORT= "approvedInstitutionalInfraQuaterlyReport";
*/	public static final String REDIRECT_INSTITUTIONAL_INFRA_REPORT ="redirect:institutionalInfraQuaterlyReport.html";
public static final String ADMIN_DATA_FIN_QUATERLY ="approvedadminDataFinQuaterlyGet";

public static final String REDIRECT_ADMIN_DATA_FIN_QUATERLY ="redirect:adminDataFinQuaterlyGet.html";


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
	
	@Autowired
	private CapacityBuildingService capacityBuildingService;
	
	@Autowired
	private PmuActivityService pmuActivityService;
	
	@Autowired
	private EEnablementOfPanchayatService  eEnablementOfPanchayatService ;
	 
	@Autowired
	private CBMasterService cbMasterService;
	
	@Autowired
	private AdminAndFinancialDataCellService adminAndFinancialDataCellService;
	
	
	@Autowired
	InstitutionalInfraActivityPlanService InstitutionalInfraActivityPlanService;
	
	
	@RequestMapping(value = "trainingProgressReport", method = RequestMethod.GET)
	public String qprGetFormTrainingProgressReport(@ModelAttribute("TRAINING_DETAILS") TrainingProgressReport progressReportJsp, Model model) {
	/*public String trainingProgressReport(@ModelAttribute("TRAINING_DETAILS") TrainingProgressReportModel progressReportModel, Model model) BY Monty*/ 
		int quarterId = 1;
		model.addAttribute("approved",true);
		List<TrainingActivity> approvedTraining=trainingActivityService.getApprovedTrainingActivity();
		if(approvedTraining!=null && !approvedTraining.isEmpty()){
			
			int activityId = approvedTraining.get(0).getTrainingActivityId();
			if(progressReportJsp.getQtrIdJsp() != null) {
				quarterId = progressReportJsp.getQtrIdJsp();
			}else
				quarterId = 1;
			
			List<Integer> activityDetailsId = new ArrayList<>();
			for(int i=0;i<approvedTraining.get(0).getTrainingActivityDetailsList().size();i++) {
				int id = approvedTraining.get(0).getTrainingActivityDetailsList().get(i).getTrainingActivityDetailsId();
				activityDetailsId.add(id);
			}
			TrainingProgressReport fetchTrainingProgressReport = progressReportService.fetchprogressReport(activityDetailsId,activityId,quarterId);
			if(fetchTrainingProgressReport != null) {
			model.addAttribute("fetchTrainingProgressReport",fetchTrainingProgressReport);
			}
			
			else {
				TrainingProgressReport trainingReport = progressReportService.fetchprogressReportToGeReportId(activityId);
				if(trainingReport != null) {
				model.addAttribute("trainingReportIdFromDb", trainingReport.getTrainingReportId());}
			}
			
			model.addAttribute("SetNewQtrId", progressReportJsp.getQtrIdJsp());
			model.addAttribute("allTrainingActivity",approvedTraining.get(0));
			model.addAttribute("trainingInstituteList",trainingInstitutionService.getTrainingIsntituteType());
			model.addAttribute("quarter_duration", progressReportService.getQuarterDurations());
			model.addAttribute("TARGET_GROUP",trainingActivityService.targetGroupMastersList());
		}
		else{
			model.addAttribute("approved",false);
		}
		return TRAINING_PROGRESS_REPORT;
	}
	
	@RequestMapping(value = "trainingProgressRptQtr", method = RequestMethod.POST)
	public String trainingProgressReportByQtr(@ModelAttribute("TRAINING_DETAILS") TrainingProgressReport progressReportJsp, Model model) {
	/*public String trainingProgressReport(@ModelAttribute("TRAINING_DETAILS") TrainingProgressReportModel progressReportModel, Model model) BY Monty*/ 
		int quarterId = 1;
		model.addAttribute("approved",true);
		List<TrainingActivity> approvedTraining=trainingActivityService.getApprovedTrainingActivity();
		if(approvedTraining!=null && !approvedTraining.isEmpty()){
			
			int activityId = approvedTraining.get(0).getTrainingActivityId();
			if(progressReportJsp.getQtrIdJsp() != null) {
				quarterId = progressReportJsp.getQtrIdJsp();
			}else
				quarterId = 1;
			
			List<Integer> activityDetailsId = new ArrayList<>();
			for(int i=0;i<approvedTraining.get(0).getTrainingActivityDetailsList().size();i++) {
				int id = approvedTraining.get(0).getTrainingActivityDetailsList().get(i).getTrainingActivityDetailsId();
				activityDetailsId.add(id);
			}
			TrainingProgressReport fetchTrainingProgressReport = progressReportService.fetchprogressReport(activityDetailsId,activityId,quarterId);
			if(fetchTrainingProgressReport != null) {
			model.addAttribute("fetchTrainingProgressReport",fetchTrainingProgressReport);
			}
			
			else {
				TrainingProgressReport trainingReport = progressReportService.fetchprogressReportToGeReportId(activityId);
				if(trainingReport != null) {
				model.addAttribute("trainingReportIdFromDb", trainingReport.getTrainingReportId());}
			}
			
			model.addAttribute("SetNewQtrId", progressReportJsp.getQtrIdJsp());
			model.addAttribute("allTrainingActivity",approvedTraining.get(0));
			model.addAttribute("trainingInstituteList",trainingInstitutionService.getTrainingIsntituteType());
			model.addAttribute("quarter_duration", progressReportService.getQuarterDurations());
			model.addAttribute("TARGET_GROUP",trainingActivityService.targetGroupMastersList());
		}
		else{
			model.addAttribute("approved",false);
		}
		return TRAINING_PROGRESS_REPORT;
	}
	
	@RequestMapping(value = "trainingProgressReport", method = RequestMethod.POST)
	public String saveTrainingProgressData(@ModelAttribute("TRAINING_DETAILS") TrainingProgressReport progressReportJsp) {
		
		progressReportService.saveTrainingProgressData(progressReportJsp);
		
		return REDIRECT_TRAINING_PROGRESS_REPORT;
	}
	
	@RequestMapping(value = "gramPanchayatProgressReport", method = RequestMethod.GET)
	public String qprGetFormGramPanchayatProgressReport(){
		return GRAM_PANCHAYAT_PROGRESS_REPORT;
	}
	
	@RequestMapping(value = "fetchDetailsForGramPanchayatProgressReport", method = RequestMethod.GET)
	private @ResponseBody Map<String, Object> fetchDetailsForGramPanchayatProgressReport(){
		Map<String, Object> detailsMaps = new HashMap<>();
		detailsMaps.put("quarterDuration", progressReportService.getQuarterDurations());
		detailsMaps.put("panchayatActivity", panchayatBhawanService.fetchPanchayatBhawanActivity());
		detailsMaps.put("districtList", lgdService.getAllDistrictBasedOnState(userPreference.getStateCode()));
		return detailsMaps;
	}
	
	@ResponseBody
	@RequestMapping(value="fetchGpBhawanStatus",method=RequestMethod.GET)
	private List<GPBhawanStatus> fetchGPBhawanStatus(@RequestParam(value="PanchayatBhawanActvityId" , required=false) Integer PanchayatBhawanActvityId){
		return panchayatBhawanService.fetchGPBhawanStatus(PanchayatBhawanActvityId);
	}
	
	@ResponseBody
	@RequestMapping(value="fetchGpBhawanData",method=RequestMethod.GET)
	private List<GramPanchayatProgressReportDTO> fetchGPBhawanData(@RequestParam(value="PanchayatBhawanActvityId" , required=false) Integer PanchayatBhawanActvityId,@RequestParam(value="DistrictListId",required=false) Integer DistrictListId){
		return panchayatBhawanService.fetchGPBhawanData(PanchayatBhawanActvityId,DistrictListId);
	}
	
	@ResponseBody
	@RequestMapping(value="fetchDataAccordingToQuator",method=RequestMethod.GET)
	private Map<String, Object> fetchDataAccordingToQuator(@RequestParam(value="quatorId" , required=false) Integer quatorId,@RequestParam(value="PanchayatBhawanActvityId" , required=false) Integer PanchayatBhawanActvityId,@RequestParam(value="districtCode",required=false) Integer districtCode){
		Map<String , Object> map=new HashMap<>();
		map.put("QprPanchayatBhawan", panchayatBhawanService.fetchDataAccordingToQuator(quatorId,PanchayatBhawanActvityId,districtCode).get(0));
		map.put("QprPanhcayatBhawanDetails", panchayatBhawanService.fetchDataAccordingToQuator(quatorId,PanchayatBhawanActvityId,districtCode).get(0).getQprPanhcayatBhawanDetails());
		return map;
	}
	
	@ResponseBody
	@RequestMapping(value="saveQprPanchayatBhawanData" , method=RequestMethod.POST)
	private QprPanchayatBhawan saveQprPanchayatBhawanData(@RequestBody final QprPanchayatBhawan qprPanchayatBhawan,@RequestParam(value = "file",required=false) MultipartFile filepath){
		panchayatBhawanService.saveQprPanchayatBhawanData(qprPanchayatBhawan);
		return qprPanchayatBhawan;
	}
	
	@RequestMapping(value="capacityBuildingOneQtrProgressReport",method=RequestMethod.GET)
	public String capacityBuildingOneQtrProgressReportGet(@RequestParam(value = "menuId") int menuId)
	{
		userPreference.setMenuId(menuId);
		return CAPACITY_BUILDING__PROGRESS_REPORT;
	}
	
	@RequestMapping(value="qprGetFormIecQtrProgressReport",method=RequestMethod.GET)
	public String iecQtrProgressReport(@ModelAttribute("IEC_ACTIVITY_QUATER") IecQuater iecQuater, Model model ,HttpServletRequest request)
	{
		
		int quarterId = 1;
		model.addAttribute("approved",true);
		List<IecActivity> iecActivitiesApproved =iecService.fetchApprovedIec();
	
		if(iecActivitiesApproved!=null && !iecActivitiesApproved.isEmpty()){
			Integer id = iecActivitiesApproved.get(0).getId();
			if(iecQuater.getQtrId() != null) {
				quarterId = iecQuater.getQtrId();
			}else
			
				quarterId = 1;
			
			/*List<Integer> activityDetailsId = new ArrayList<>();
			for(int i=0;i<approvedTraining.get(0).getTrainingActivityDetailsList().size();i++) {
				int id = approvedTraining.get(0).getTrainingActivityDetailsList().get(i).getTrainingActivityDetailsId();
				activityDetailsId.add(id);
			}*/
			IecQuater	fetchIecQuaterProgressReport =progressReportService.getSatcomProgress(id, quarterId);
				if(fetchIecQuaterProgressReport != null) {
					
					
			model.addAttribute("IEC_ACTIVITY_PROGRESS",fetchIecQuaterProgressReport);
			//model.addAttribute("satcomActivityProgressDetails", satcomActivityProgressDetails);
			}
			
			else {
				IecQuater iecQuater1 = progressReportService.getfetchIecQuaterProgressReportToGeReportId(id);
				if(iecQuater1 != null) {
				model.addAttribute("getIecId", iecQuater1.getQprIecId());}
			}
			
		model.addAttribute("id", id);
		model.addAttribute("SetNewQtrId1", iecQuater.getQtrId());
		model.addAttribute("fetchIecActivity",iecActivitiesApproved.get(0));
		model.addAttribute("QUATER_DETAILS", progressReportService.getQuarterDurations());
			}
	else{
		model.addAttribute("approved",false);
	}
	
		return IEC_PROGRESS_REPORT;
	}
	
	@RequestMapping(value="iecQtrProgressReport",method=RequestMethod.GET)
	public String qprGetFormIecQtrProgressReport1(@ModelAttribute("IEC_ACTIVITY_QUATER") IecQuater iecQuater, Model model ,HttpServletRequest request)
	{
		
		int quarterId = 1;
		model.addAttribute("approved",true);
		List<IecActivity> iecActivitiesApproved =iecService.fetchApprovedIec();
	
		if(iecActivitiesApproved!=null && !iecActivitiesApproved.isEmpty()){
			Integer id = iecActivitiesApproved.get(0).getId();
			if(iecQuater.getQtrId() != null) {
				quarterId = iecQuater.getQtrId();
			}else
			
				quarterId = 1;
			
			/*List<Integer> activityDetailsId = new ArrayList<>();
			for(int i=0;i<approvedTraining.get(0).getTrainingActivityDetailsList().size();i++) {
				int id = approvedTraining.get(0).getTrainingActivityDetailsList().get(i).getTrainingActivityDetailsId();
				activityDetailsId.add(id);
			}*/
			IecQuater	fetchIecQuaterProgressReport =progressReportService.getSatcomProgress(id, quarterId);
				if(fetchIecQuaterProgressReport != null) {
					
					
			model.addAttribute("IEC_ACTIVITY_PROGRESS",fetchIecQuaterProgressReport);
			//model.addAttribute("satcomActivityProgressDetails", satcomActivityProgressDetails);
			}
			
			else {
				IecQuater iecQuater1 = progressReportService.getfetchIecQuaterProgressReportToGeReportId(id);
				if(iecQuater1 != null) {
				model.addAttribute("getIecId", iecQuater1.getQprIecId());}
			}
			
		model.addAttribute("id", id);
		model.addAttribute("SetNewQtrId1", iecQuater.getQtrId());
		model.addAttribute("fetchIecActivity",iecActivitiesApproved.get(0));
		model.addAttribute("QUATER_DETAILS", progressReportService.getQuarterDurations());
			}
	else{
		model.addAttribute("approved",false);
	}
	
		return IEC_PROGRESS_REPORT;
	}
	
	
	@RequestMapping(value="iecQtrProgressReportPost",method=RequestMethod.POST)
	public String iecQtrProgressReportPostQuaterly(@ModelAttribute("IEC_ACTIVITY_QUATER")  IecQuater iecQuater, Model model ,HttpServletRequest request ,RedirectAttributes re) 
	{
		//Integer Activity = satcomActivityProgress.getSatcomActivity().get(0).getSatcomActivityId();
		progressReportService.saveIec(iecQuater);
		re.addFlashAttribute(Message.SUCCESS_KEY, Message.SAVE_SUCCESS);

		return REDIRECT_IEC_PROGRESS_REPORT;
	}
	
	@RequestMapping(value="panchayatBhawanQuaterlyReport",method = RequestMethod.GET)
	public String panchayatBhawanGet()
	{
		return PANCHAYAT_BHAWAN_REPORT;
	}
	
	@RequestMapping(value="institutionalInfraQuaterlyReport",method = RequestMethod.GET)
	public String qprGetFormInstituteInfraQprGet(Model model)
	{
		return INSTITUTIONAL_INFRA_REPORT;
	}
	
	@RequestMapping(value = "fetchDetailsForInstInfraProgressReport", method = RequestMethod.GET)
	private @ResponseBody Map<String, Object> fetchDetailsForInstitutionalInfraProgressReport(){
		Map<String, Object> detailsMaps = new HashMap<>();
		detailsMaps.put("quarterDuration", progressReportService.getQuarterDurations());
		detailsMaps.put("buildingType",institutionalInfraActivityPlanService.fetchTrainingInstituteType());
		return detailsMaps;
	}
	
	@ResponseBody
	@RequestMapping(value="fetchInstInfraStateData",method=RequestMethod.GET)
	private List<InstitutionalInfraProgressReportDTO> fetchInstInfraStateData(@RequestParam(value="TrainingInstituteTypeId" , required=false) Integer TrainingInstituteTypeId){
		return institutionalInfraActivityPlanService.fetchInstInfraStateDataForProgressReport(TrainingInstituteTypeId);
	}
	
	@ResponseBody
	@RequestMapping(value="fetchInstInfraStatus",method=RequestMethod.GET)
	private List<InstInfraStatus> fetchInstInfraStatus(@RequestParam(value="TrainingInstituteTypeId" , required=false) Integer TrainingInstituteTypeId){
		return institutionalInfraActivityPlanService.fetchInstInfraStatus(TrainingInstituteTypeId);
	}
	
	@ResponseBody
	@RequestMapping(value="saveQprInstitutionalInfrastructureData" , method=RequestMethod.POST)
	private QprInstitutionalInfrastructure saveQprInstInfraData(@RequestBody final QprInstitutionalInfrastructure qprInstitutionalInfrastructure){
		institutionalInfraActivityPlanService.saveQprInstInfraData(qprInstitutionalInfrastructure);
		return qprInstitutionalInfrastructure;
	}
	
	@ResponseBody
	@RequestMapping(value="fetchDataAccordingToQuatorInstInfra",method=RequestMethod.GET)
	private Map<String, Object> fetchDataAccordingToQuatorInstInfra(@RequestParam(value="quatorId" , required=false) Integer quatorId,@RequestParam(value="TrainingInstituteTypeId" , required=false) Integer TrainingInstituteTypeId){
		Map<String , Object> map=new HashMap<>();
		List<InstitutionalInfraActivityPlan> institutionalInfraActivityPlan=institutionalInfraActivityPlanService.fetchInstitutionalInfraActivity(null);
		List<QprInstitutionalInfrastructure> qprInstitutionalInfrastructure=new ArrayList<QprInstitutionalInfrastructure>();
		if(!CollectionUtils.isEmpty(institutionalInfraActivityPlan)) {
			qprInstitutionalInfrastructure=institutionalInfraActivityPlanService.fetchDataAccordingToQuator(quatorId,institutionalInfraActivityPlan.get(0).getInstitutionalInfraActivityId());
		}
		if(!CollectionUtils.isEmpty(qprInstitutionalInfrastructure)) {
			map.put("QprInstitutionalInfrastructure",qprInstitutionalInfrastructure.get(0));
			map.put("qprInstitutionalInfraDetails", institutionalInfraActivityPlanService.fetchDataOfDetailsAccordingToQuator(qprInstitutionalInfrastructure.get(0).getQprInstInfraId(),TrainingInstituteTypeId));
		}
		return map;
	}
	
	@RequestMapping(value = "incomeEnhancementQuaterly", method = RequestMethod.GET)
	public String qprGetFormIncomeEnhancementDetailsQuaterly(@ModelAttribute("Qpr_Income_Enhancement") QprIncomeEnhancement qprIncomeEnhancement, Model model) {
		QprIncomeEnhancement qprEnhancement = progressReportService.fetchQprIncmEnhncmnt(1);
		if(qprEnhancement !=null)
		Collections.sort(qprEnhancement.getQprIncomeEnhancementDetails(), Comparator.comparing(QprIncomeEnhancementDetails::getQprIncomeEnhancementDetailsId));
		
		List<IncomeEnhancementActivity> dbActivitiesList = enhancementService.fetchAllIncmEnhncmntActvty(userPreference.getUserType().charAt(0));
		if(!CollectionUtils.isEmpty(dbActivitiesList)) {
			model.addAttribute("dbActivitiesList", dbActivitiesList.get(0));
			}
			model.addAttribute("qprEnhancement", qprEnhancement);
		model.addAttribute("quarter_duration", progressReportService.getQuarterDurations());
		model.addAttribute("districtList", lgdService.getAllDistrictBasedOnState(userPreference.getStateCode()));
		return IncomeEnhancement_Quaterly;
	}
	
	@RequestMapping(value = "incomeEnhancementBasedOnQtr", method = RequestMethod.POST)
	public String incomeEnhancementDetailsBasedOnQtr(@ModelAttribute("Qpr_Income_Enhancement") QprIncomeEnhancement qprIncomeEnhancement, Model model) {
		QprIncomeEnhancement qprEnhancement = progressReportService.fetchQprIncmEnhncmnt(qprIncomeEnhancement.getShowQqrtrId());
		if(qprEnhancement !=null)
		Collections.sort(qprEnhancement.getQprIncomeEnhancementDetails(), Comparator.comparing(QprIncomeEnhancementDetails::getQprIncomeEnhancementDetailsId));
		
		List<IncomeEnhancementActivity> dbActivitiesList = enhancementService.fetchAllIncmEnhncmntActvty(userPreference.getUserType().charAt(0));
		if(!CollectionUtils.isEmpty(dbActivitiesList)) {
			model.addAttribute("dbActivitiesList", dbActivitiesList.get(0));
			}
			model.addAttribute("qprEnhancement", qprEnhancement);
		model.addAttribute("quarter_duration", progressReportService.getQuarterDurations());
		model.addAttribute("districtList", lgdService.getAllDistrictBasedOnState(userPreference.getStateCode()));
		model.addAttribute("SetNewQtrId", qprIncomeEnhancement.getShowQqrtrId());
		return IncomeEnhancement_Quaterly;
	}
	
	@RequestMapping(value="frzUnfrzQprIncomeEnhancement" , method=RequestMethod.POST)
	public String frzUnfrzIncomeEnhncmntMethod(@ModelAttribute("Qpr_Income_Enhancement") QprIncomeEnhancement qprIncomeEnhancement,HttpServletResponse httpResponse,Model model,RedirectAttributes redirectAttributes) {
		progressReportService.FrzUnfrzIncomeEnhancmnt(qprIncomeEnhancement);
		if(qprIncomeEnhancement.getIsFreeze() == false) {
		redirectAttributes.addFlashAttribute(Message.SUCCESS_KEY, "Freeze Successfully");
		}else
		{
			redirectAttributes.addFlashAttribute(Message.SUCCESS_KEY, "Unfreeze Successfully");
		}
		
		return REDIRECT_IncomeEnhancement_Quaterly;
	}
	
	@RequestMapping(value = "incomeEnhancementQuaterly", method = RequestMethod.POST)
	public String saveIncomeEnhancementQuaterly(@ModelAttribute("Qpr_Income_Enhancement") QprIncomeEnhancement qprIncomeEnhancement, Model model,RedirectAttributes redirectAttributes){
		progressReportService.saveQprIncomeEnhancement(qprIncomeEnhancement);
		redirectAttributes.addFlashAttribute(Message.SUCCESS_KEY, Message.SAVE_SUCCESS);
		return REDIRECT_IncomeEnhancement_Quaterly;
	}
	
	@RequestMapping(value="currentUsageSatcomQuaterly",method=RequestMethod.GET)
	public String qprGetFormcurrentUsageSatcomGetQuaterly(@ModelAttribute("SATCOM_QUATER") SatcomActivityProgress satcomActivityProgress , Model model ,HttpServletRequest request )
	{ 		
		int quarterId = 1;
		model.addAttribute("approved",true);
		List<SatcomActivity> satcomActivityApproved=satcomFacilityService.getApprovedSatcomActivity();
	
		if(satcomActivityApproved!=null && !satcomActivityApproved.isEmpty()){
			Integer id = satcomActivityApproved.get(0).getSatcomActivityId();
			int satcomActivityId = satcomActivityApproved.get(0).getSatcomActivityId();
			if(satcomActivityProgress.getQtrIdJsp1() != null) {
				quarterId = satcomActivityProgress.getQtrIdJsp1();
			}else
			
				quarterId = 1;
			
			/*List<Integer> activityDetailsId = new ArrayList<>();
			for(int i=0;i<approvedTraining.get(0).getTrainingActivityDetailsList().size();i++) {
				int id = approvedTraining.get(0).getTrainingActivityDetailsList().get(i).getTrainingActivityDetailsId();
				activityDetailsId.add(id);
			}*/
			SatcomActivityProgress	fetchTrainingProgressReport =satcomActivityProgressService.getSatcomProgress(satcomActivityId, quarterId);
				if(fetchTrainingProgressReport != null) {
					
					
			model.addAttribute("SATCOM_ACTIVITY_PROGRESS",fetchTrainingProgressReport);
			//model.addAttribute("satcomActivityProgressDetails", satcomActivityProgressDetails);
			}
			
			else {
				SatcomActivityProgress satcomActivityProgress1 = satcomActivityProgressService.getSatcomProgressReportToGeReportId(satcomActivityId);
				if(satcomActivityProgress1 != null) {
				model.addAttribute("getSatcomId", satcomActivityProgress1.getSatcomActivityProgressId());}
			}
			
		model.addAttribute("satcomActivityId", id);
		model.addAttribute("SetNewQtrId1", satcomActivityProgress.getQtrIdJsp1());
		model.addAttribute("Satcom_Activity_Pro",satcomActivityApproved);
		model.addAttribute("QUATER_DETAILS", progressReportService.getQuarterDurations());
			}
	else{
		model.addAttribute("approved",false);
	}
	return CURRENT_SATCOM_QUATERLY;
}
	
	@RequestMapping(value="currentUsageSatcomQuaterly",method=RequestMethod.POST)
	public String currentUsageSatcomGetQuaterlyPost(@ModelAttribute("SATCOM_QUATER") SatcomActivityProgress satcomActivityProgress , Model model ,HttpServletRequest request )
	{ 		
		int quarterId = 1;
		model.addAttribute("approved",true);
		List<SatcomActivity> satcomActivityApproved=satcomFacilityService.getApprovedSatcomActivity();
	
		if(satcomActivityApproved!=null && !satcomActivityApproved.isEmpty()){
			Integer id = satcomActivityApproved.get(0).getSatcomActivityId();
			int satcomActivityId = satcomActivityApproved.get(0).getSatcomActivityId();
			if(satcomActivityProgress.getQtrIdJsp1() != null) {
				quarterId = satcomActivityProgress.getQtrIdJsp1();
			}else
			
				quarterId = 1;
			
			/*List<Integer> activityDetailsId = new ArrayList<>();
			for(int i=0;i<approvedTraining.get(0).getTrainingActivityDetailsList().size();i++) {
				int id = approvedTraining.get(0).getTrainingActivityDetailsList().get(i).getTrainingActivityDetailsId();
				activityDetailsId.add(id);
			}*/
			SatcomActivityProgress	fetchTrainingProgressReport =satcomActivityProgressService.getSatcomProgress(satcomActivityId, quarterId);
				if(fetchTrainingProgressReport != null) {
					
					
			model.addAttribute("SATCOM_ACTIVITY_PROGRESS",fetchTrainingProgressReport);
			//model.addAttribute("satcomActivityProgressDetails", satcomActivityProgressDetails);
			}
			
			else {
				SatcomActivityProgress satcomActivityProgress1 = satcomActivityProgressService.getSatcomProgressReportToGeReportId(satcomActivityId);
				if(satcomActivityProgress1 != null) {
				model.addAttribute("getSatcomId", satcomActivityProgress1.getSatcomActivityProgressId());}
			}
			
		model.addAttribute("satcomActivityId", id);
		model.addAttribute("SetNewQtrId1", satcomActivityProgress.getQtrIdJsp1());
		model.addAttribute("Satcom_Activity_Pro",satcomActivityApproved);
		model.addAttribute("QUATER_DETAILS", progressReportService.getQuarterDurations());
			}
	else{
		model.addAttribute("approved",false);
	}
	return CURRENT_SATCOM_QUATERLY;
}
	
	@RequestMapping(value="currentUsageSatcomQuaterlyPost",method=RequestMethod.POST)
	public String currentUsageSatcomPostQuaterly1(@ModelAttribute("SATCOM_QUATER") SatcomActivityProgress satcomActivityProgress ,Model model,HttpServletRequest request ,RedirectAttributes re) 
	{
		//Integer Activity = satcomActivityProgress.getSatcomActivity().get(0).getSatcomActivityId();
		satcomActivityProgressService.savesatcomProgress(satcomActivityProgress);
		re.addFlashAttribute(Message.SUCCESS_KEY, Message.SAVE_SUCCESS);

		return REDIRECT_CURRENT_SATCOM_QUATERLY;
	}
	
	
	@RequestMapping(value="adminTechQuaderly" , method=RequestMethod.GET)
	public String qprGetFormAdminSupportQuaderly(@ModelAttribute("ADMIN_QUATER") AdministrativeTechnicalProgress administrativeTechnicalProgress, Model model ,HttpServletRequest request) {
		int quarterId = 1;
		model.addAttribute("approved",true);
		List<AdministrativeTechnicalSupport> administrativeTechnicalProgresses = adminTechSupportService.getApprovedSatcomActivity();
				
		if(administrativeTechnicalProgresses!=null && !administrativeTechnicalProgresses.isEmpty()){
			
			int administrativeTechnicalSupportId = administrativeTechnicalProgresses.get(0).getAdministrativeTechnicalSupportId();
		
			if(administrativeTechnicalProgress.getQtrIdJsp2() != null) {
				quarterId = administrativeTechnicalProgress.getQtrIdJsp2();
			}else
			
				quarterId = 1;
			
			List<Integer> postId1 = new ArrayList<>();
			for(int i=0;i<administrativeTechnicalProgresses.get(0).getSupportDetails().size();i++) {
					
				int id = administrativeTechnicalProgresses.get(0).getSupportDetails().get(i).getPostType().getPostId();
				postId1.add(id);
			}
		AdministrativeTechnicalProgress	fetchAdministrativeTechnicalProgress=progressReportService.fetchAdministrativeTechnicalProgress(postId1, administrativeTechnicalSupportId, quarterId);
				if(fetchAdministrativeTechnicalProgress != null) {
					
					
			model.addAttribute("Administrative_Technical_PROGRESS",fetchAdministrativeTechnicalProgress);
			
			}
			
			else {
				AdministrativeTechnicalProgress administrativeTechnicalProgress1 = progressReportService.fetchAdministrativeReportToGeReportId1(administrativeTechnicalSupportId);
				if(administrativeTechnicalProgress1 != null) {
				model.addAttribute("getAtsId", administrativeTechnicalProgress1.getAtsId());}
			}
			
		model.addAttribute("AdministrativeTechnicalSupportId", administrativeTechnicalSupportId);
		model.addAttribute("SetNewQtrId1", administrativeTechnicalProgress.getQtrIdJsp2());
		model.addAttribute("fetchAdministrativeTechnical",administrativeTechnicalProgresses.get(0));
		model.addAttribute("QUATER_DETAILS", progressReportService.getQuarterDurations());
			}
	else{
		model.addAttribute("approved",false);
		
	}
		return ADMIN_QUADERLY;
	}

	@RequestMapping(value="adminTechQuaderly",method=RequestMethod.POST)
	public String getAdminSupportPostQuaterly(@ModelAttribute("ADMIN_QUATER") AdministrativeTechnicalProgress administrativeTechnicalProgress, Model model ,HttpServletRequest request,RedirectAttributes re) 
	{
		//Integer Activity = satcomActivityProgress.getSatcomActivity().get(0).getSatcomActivityId();
		progressReportService.saveadministrativeTechnicalProgress(administrativeTechnicalProgress);
		re.addFlashAttribute(Message.SUCCESS_KEY, Message.SAVE_SUCCESS);
		return REDIRECT_ADMIN_QUADERLY;
	}
	
	@RequestMapping(value="additionalfacultyProgress",method=RequestMethod.GET)
	public String qprGetFormAdditionalFacalltyHr(@ModelAttribute("ADD_QUATER") AdditionalFacultyProgress additionalFacultyProgress, Model model ,HttpServletRequest request)
	{
		int quarterId = 1;
		model.addAttribute("approved",true);
		List<InstitueInfraHrActivity> institutionalInfraHRActivity =additionalFacultyAndMainService.fetchApprovedInstituteHrActivity();
		 if(institutionalInfraHRActivity!=null && !institutionalInfraHRActivity.isEmpty()){
			 int instituteInfraHrActivityId =institutionalInfraHRActivity.get(0).getInstituteInfraHrActivityId();
		        List<InstitueInfraHrActivityDetails> institueInfraHrActivityDetails =additionalFacultyAndMainService.fetchInstituteHrActivityApprovedDetails(instituteInfraHrActivityId);
		       
			if(additionalFacultyProgress.getQtrIdJsp3() != null) {
				quarterId = additionalFacultyProgress.getQtrIdJsp3();
			}
			else
				
				quarterId = 1;
			
			
			AdditionalFacultyProgress	fetchAdditionalFacultyProgress =progressReportService.fetchAdditionalFacultyProgress(instituteInfraHrActivityId, quarterId);
				if(fetchAdditionalFacultyProgress != null) {
					
					
			model.addAttribute("Additional_Faculty_PROGRESS",fetchAdditionalFacultyProgress);
			model.addAttribute("adtnlfacltyDtlsList", fetchAdditionalFacultyProgress.getAdditionalFacultyProgressDetail());
			}
			
			else {
				AdditionalFacultyProgress	fetchAdditionalFacultyProgress1 =progressReportService.fetchAdditionalFacultyProgressToGeReportId1(instituteInfraHrActivityId);
				if(fetchAdditionalFacultyProgress1 != null) {
				model.addAttribute("qprInstInfraHrId", fetchAdditionalFacultyProgress1.getQprInstInfraHrId());
			}
			}
				List<InstituteInfraHrActivityType> params=new ArrayList<>();
				params=additionalFacultyAndMainService.fetchHrActvityType();
				model.addAttribute("LIST_OF_ACTIVITY_HR_TYPE", params);
			model.addAttribute("instituteInfraHrActivityId", instituteInfraHrActivityId);
			model.addAttribute("SetNewQtrId1", additionalFacultyProgress.getQtrIdJsp3());
			model.addAttribute("fetchinstitueInfraHrActivityDetails",institueInfraHrActivityDetails);
			model.addAttribute("QUATER_DETAILS", progressReportService.getQuarterDurations());
        	
        }
		 else{
				model.addAttribute("approved",false);
				
			}
		return ADDITIONAL_FACULTY_QUADERLY;
		
	}
	@RequestMapping(value="additionalfacultyProgress1",method=RequestMethod.POST)
	public String getAdditionalFacalltyHr1(@ModelAttribute("ADD_QUATER") AdditionalFacultyProgress additionalFacultyProgress, Model model ,HttpServletRequest request)
	{
		int quarterId = 1;
		model.addAttribute("approved",true);
		List<InstitueInfraHrActivity> institutionalInfraHRActivity =additionalFacultyAndMainService.fetchApprovedInstituteHrActivity();
		 if(institutionalInfraHRActivity!=null && !institutionalInfraHRActivity.isEmpty()){
			 int instituteInfraHrActivityId =institutionalInfraHRActivity.get(0).getInstituteInfraHrActivityId();
		        List<InstitueInfraHrActivityDetails> institueInfraHrActivityDetails =additionalFacultyAndMainService.fetchInstituteHrActivityApprovedDetails(instituteInfraHrActivityId);
		       
			if(additionalFacultyProgress.getQtrIdJsp3() != null) {
				quarterId = additionalFacultyProgress.getQtrIdJsp3();
			}
			else
				
				quarterId = 1;
			
			
			AdditionalFacultyProgress	fetchAdditionalFacultyProgress =progressReportService.fetchAdditionalFacultyProgress(instituteInfraHrActivityId, quarterId);
				if(fetchAdditionalFacultyProgress != null) {
					
					
			model.addAttribute("Additional_Faculty_PROGRESS",fetchAdditionalFacultyProgress);
			model.addAttribute("adtnlfacltyDtlsList", fetchAdditionalFacultyProgress.getAdditionalFacultyProgressDetail());
			}
			
			else {
				AdditionalFacultyProgress	fetchAdditionalFacultyProgress1 =progressReportService.fetchAdditionalFacultyProgressToGeReportId1(instituteInfraHrActivityId);
				if(fetchAdditionalFacultyProgress1 != null) {
				model.addAttribute("qprInstInfraHrId", fetchAdditionalFacultyProgress1.getQprInstInfraHrId());
			}
			}
				List<InstituteInfraHrActivityType> params=new ArrayList<>();
				params=additionalFacultyAndMainService.fetchHrActvityType();
				model.addAttribute("LIST_OF_ACTIVITY_HR_TYPE", params);
			model.addAttribute("instituteInfraHrActivityId", instituteInfraHrActivityId);
			model.addAttribute("SetNewQtrId1", additionalFacultyProgress.getQtrIdJsp3());
			model.addAttribute("fetchinstitueInfraHrActivityDetails",institueInfraHrActivityDetails);
			model.addAttribute("QUATER_DETAILS", progressReportService.getQuarterDurations());
        	
        }
		 else{
				model.addAttribute("approved",false);
				
			}
		return ADDITIONAL_FACULTY_QUADERLY;
		
	}
	@RequestMapping(value="additionalfacultyProgress",method=RequestMethod.POST)
	public String getAdditionalFacalltyHrPost(@ModelAttribute("ADD_QUATER") AdditionalFacultyProgress additionalFacultyProgress, Model model ,HttpServletRequest request,RedirectAttributes re) 
	{
		//Integer Activity = satcomActivityProgress.getSatcomActivity().get(0).getSatcomActivityId();
		progressReportService.saveAdditionalFacultyProgress(additionalFacultyProgress);
		re.addFlashAttribute(Message.SUCCESS_KEY, Message.SAVE_SUCCESS);
		return REDIRECT_ADDITIONAL_QUADERLY;
	}
	
	@RequestMapping(value="pmuProgresReport",method=RequestMethod.GET)
	public String qprGetFormPmuActivityMethodQuaterly(@ModelAttribute("PMU_ACTIVITY_QUATERLY") PmuProgress pmuProgress, Model model ,HttpServletRequest request)
	{
		int quarterId = 1;
		model.addAttribute("approved",true);
		List<PmuActivity> pmuActivities =pmuActivityService.fetchApprovedPmu();
		 if(pmuActivities!=null && !pmuActivities.isEmpty()){
			 int pmuActivityId =pmuActivities.get(0).getPmuActivityId();
		        //List<PmuActivityDetails> pmuActivityDetails =pmuActivityService.fetchPmuApprovedDetails(pmuActivityId);
		       
			if(pmuProgress.getQtrIdJsp6() != null) {
				quarterId = pmuProgress.getQtrIdJsp6();
			}
			else
				
				quarterId = 1;
			
			
			PmuProgress	fetchPmuProgress =progressReportService.fetchPmu(pmuActivityId, quarterId);
				if(fetchPmuProgress != null) {
					
					
			model.addAttribute("PMU_PROGRESS",fetchPmuProgress);
			model.addAttribute("PMUDtlsList", fetchPmuProgress.getPmuProgressDetails());
			}
			
			else {
				PmuProgress	fetchPmuProgress1 =progressReportService.fetchPmuProgressToGeReportId(pmuActivityId);
				if(fetchPmuProgress1 != null) {
				model.addAttribute("qprInstInfraHrId", fetchPmuProgress1.getQprPmuId());
			}
			}
				List<PmuActivityType> params=new ArrayList<>();
				params=pmuActivityService.fetchPmuActvityType();
				model.addAttribute("LIST_OF_PMU_TYPE", params);
			model.addAttribute("pmuActivityId", pmuActivityId);
			model.addAttribute("pmuActivityTypeId", pmuActivities.get(0).getPmuActivityDetails().get(0).getPmuActivityType().getPmuActivityTypeId());
			model.addAttribute("SetNewQtrId1", pmuProgress.getQtrIdJsp6());
			model.addAttribute("fetchPmuActivityDetails",pmuActivities.get(0));
			model.addAttribute("QUATER_DETAILS", progressReportService.getQuarterDurations());
        	
        }
		 else{
				model.addAttribute("approved",false);
				
			}
		return TRAINING_PROGRESS_PMU;
		
	}


	@RequestMapping(value="pmuProgresReport",method=RequestMethod.POST)
	public String getPmuActivityPost(@ModelAttribute("PMU_ACTIVITY_QUATERLY") PmuProgress pmuProgress, Model model ,HttpServletRequest request,RedirectAttributes re) 
	{
		//Integer Activity = satcomActivityProgress.getSatcomActivity().get(0).getSatcomActivityId();
		progressReportService.savePmu(pmuProgress);
		re.addFlashAttribute(Message.SUCCESS_KEY, Message.SAVE_SUCCESS);
		return REDIRECT_TRAINING_PROGRESS_PMU;
	}


@RequestMapping(value="enablementQuaterly" , method=RequestMethod.GET)
public String qprGetFormEnablementQuaderly(@ModelAttribute("Enablement") QprEnablement qprEnablement, Model model ,RedirectAttributes re) {
	
	int quarterId = 1;
	model.addAttribute("approved",true);
	List<EEnablement> eEnablementsApproved =eEnablementOfPanchayatService.getApprovedEEnablement();
	
	 if(eEnablementsApproved!=null && !eEnablementsApproved.isEmpty()){
		 Integer id =eEnablementsApproved.get(0).geteEnablementId();
		 Integer eEnablementDetailsId =eEnablementsApproved.get(0).geteEnablementDetails().get(0).geteEnablementDetailId();
			List<EEnablementGPs> eEnablementGPs = eEnablementOfPanchayatService.fetchCapacityBuildingActivityGPsList(eEnablementDetailsId);
			int district =eEnablementGPs.get(0).getDistrictCode();
			if(qprEnablement.getDistrictId()!=null)
			{
				 district =qprEnablement.getDistrictId();
			}
			else
					district =eEnablementGPs.get(0).getDistrictCode();
			
			List<EEnablementReportDto> eEnablementReportDto = eEnablementOfPanchayatService.getEEnablementReportDto(district);
			model.addAttribute("eEnablementReportDto", eEnablementReportDto);
			
				if(qprEnablement.getQrtId() != null) {
		       quarterId = qprEnablement.getQrtId();
	       }
	        else
			  quarterId = 1;
			if(eEnablementReportDto.size() == 0){
				/*re.addFlashAttribute(Message.ERROR_KEY, "No. record found of that district");*/
				/*model.addAttribute("record", eEnablementReportDto.size());*/
				/*  model.addAttribute("SetNewQtrId1", qprEnablement.getQrtId());
				    model.addAttribute("SetNewDistrictId", qprEnablement.getDistrictId());
*/
				model.addAttribute("record",false);
				return ENABLEMENT_PROGRESS_REPORT;
			}
			int eEnablementId = eEnablementReportDto.get(0).geteEnablementId(); 
			
			int localbodyCode =eEnablementReportDto.get(0).getLocalBodyCode();
			List<QprEnablementDetails> fetchDetails =eEnablementOfPanchayatService.getEEnablementReport(localbodyCode ,qprEnablement.getQprEEnablementId());
			model.addAttribute("fetchDetails", fetchDetails);
	
			
			QprEnablement	fetchQprEnablement =progressReportService.fetchQprEnablement(eEnablementId, quarterId);
			if(fetchQprEnablement != null) {
				
				
		model.addAttribute("Qpr_Enablement",fetchQprEnablement);
		model.addAttribute("EnablementDtlsList", fetchQprEnablement.getQprEnablementDetails());
		}
		
		else {
			QprEnablement	fetchQprEnablement1 =progressReportService.fetchEEnablementProgressToGeReportId1(id);
			if(fetchQprEnablement1 != null) {
			model.addAttribute("qprEEnablementId", fetchQprEnablement1.getQprEEnablementId());
		}
		}
			model.addAttribute("eEnablementGPs",eEnablementGPs);
			model.addAttribute("idEEnablement", id);
		    model.addAttribute("SetNewQtrId1", qprEnablement.getQrtId());
		    model.addAttribute("SetNewDistrictId", qprEnablement.getDistrictId());
		    model.addAttribute("QUATER_DETAILS", progressReportService.getQuarterDurations());
		    model.addAttribute("LGD_DISTRICT",lgdService.getAllDistrictBasedOnState(userPreference.getStateCode()));
		    }
	
	 else{
			model.addAttribute("approved",false);
			
		}
	
	return ENABLEMENT_PROGRESS_REPORT;
}

@RequestMapping(value="enablementQuaterly",method=RequestMethod.POST)
public String getEnablementQuaterlyPost(@ModelAttribute("Enablement") QprEnablement qprEnablement, Model model ,HttpServletRequest request,RedirectAttributes re) 
{
	//Integer Activity = satcomActivityProgress.getSatcomActivity().get(0).getSatcomActivityId();
	progressReportService.saveEnablement(qprEnablement);
	re.addFlashAttribute(Message.SUCCESS_KEY, Message.SAVE_SUCCESS);
	return REDIRECT_ENABLEMENT_PROGRESS_REPORT;
}

@RequestMapping(value="innovativeActivityQpr",method=RequestMethod.GET)
public String qprGetFormInnovativeActivityQpr(@ModelAttribute("INNOVATIVE_ACTIVITY_QUATER") QprInnovativeActivity qprInnovativeActivity, Model model ,HttpServletRequest request)
{
	
	int quarterId = 1;
	model.addAttribute("approved",true);
	List<InnovativeActivity> innovativeActivityApproved =innovativeActivityService.fetchApprovedInnovative();

	if(innovativeActivityApproved!=null && !innovativeActivityApproved.isEmpty()){
		Integer id = innovativeActivityApproved.get(0).getInnovativeActivityId();
		if(qprInnovativeActivity.getQtrId() != null) {
			quarterId = qprInnovativeActivity.getQtrId();
		}else
		
			quarterId = 1;
		
		/*List<Integer> activityDetailsId = new ArrayList<>();
		for(int i=0;i<approvedTraining.get(0).getTrainingActivityDetailsList().size();i++) {
			int id = approvedTraining.get(0).getTrainingActivityDetailsList().get(i).getTrainingActivityDetailsId();
			activityDetailsId.add(id);
		}*/
		QprInnovativeActivity	fetchInnovativeQuaterProgressReport =progressReportService.getInnovative(id, quarterId);
			if(fetchInnovativeQuaterProgressReport != null) {
				
				
		model.addAttribute("INNOVATIVE_ACTIVITY_PROGRESS",fetchInnovativeQuaterProgressReport);
		//model.addAttribute("satcomActivityProgressDetails", satcomActivityProgressDetails);
		}
		
		else {
			QprInnovativeActivity qprInnovativeActivity1 = progressReportService.getfetchInnovativeProgressReportToGeReportId(id);
			if(qprInnovativeActivity1 != null) {
			model.addAttribute("getIecId", qprInnovativeActivity1.getQprIaId());}
		}
		
	model.addAttribute("innovativeActivityId", id);
	model.addAttribute("SetNewQtrId1", qprInnovativeActivity.getQtrId());
	model.addAttribute("fetchInnovativeActivity",innovativeActivityApproved.get(0));
	model.addAttribute("QUATER_DETAILS", progressReportService.getQuarterDurations());
		}
else{
	model.addAttribute("approved",false);
}

	return INNOVATIVE_PROGRESS_REPORT;
}

@RequestMapping(value="innovativeActivityQpr",method=RequestMethod.POST)
public String innovativeQtrProgressReport(@ModelAttribute("INNOVATIVE_ACTIVITY_QUATER") QprInnovativeActivity qprInnovativeActivity, Model model ,HttpServletRequest request ,RedirectAttributes re) 
{
	//Integer Activity = satcomActivityProgress.getSatcomActivity().get(0).getSatcomActivityId();
	progressReportService.saveInnovative(qprInnovativeActivity);
	re.addFlashAttribute(Message.SUCCESS_KEY, Message.SAVE_SUCCESS);

	return REDIRECT_INNOVATIVE_PROGRESS_REPORT;
}

@RequestMapping(value = "adminDataFinQuaterlyGet", method = RequestMethod.GET)
public String qprGetFormAdminDataFinQuaterly(@ModelAttribute("QPR_ADMIN_DATA_FIN") QprAdminAndFinancialDataActivity qprAdminAndFinancialDataActivity, Model model) {
	QprAdminAndFinancialDataActivity activity =progressReportService.fetchQprAdminFin(1);
	/*QprIncomeEnhancement qprEnhancement = progressReportService.fetchQprIncmEnhncmnt(1);*/
	if(activity !=null)
	
	Collections.sort(activity.getQprAdminAndFinancialDataActivityDetails(), Comparator.comparing(QprAdminAndFinancialDataActivityDetails::getQprAfpDetailsId));
	List<AdminAndFinancialDataActivity> ApproveandFinancialDataActivities =adminAndFinancialDataCellService.fetchAdminAndFinancialActivity(null);
	
	if(!CollectionUtils.isEmpty(ApproveandFinancialDataActivities)) {
		model.addAttribute("ApproveandFinancialDataActivities", ApproveandFinancialDataActivities.get(0));
		}
		model.addAttribute("activity", activity);
	model.addAttribute("quarter_duration", progressReportService.getQuarterDurations());
	
	return ADMIN_DATA_FIN_QUATERLY;
}

@RequestMapping(value = "adminDataFinQuaterlyQuaterSelect", method = RequestMethod.POST)
public String adminDataFinQuaterly1(@ModelAttribute("QPR_ADMIN_DATA_FIN") QprAdminAndFinancialDataActivity qprAdminAndFinancialDataActivity, Model model) {
	QprAdminAndFinancialDataActivity activity =progressReportService.fetchQprAdminFin(qprAdminAndFinancialDataActivity.getShowQqrtrId());
	/*QprIncomeEnhancement qprEnhancement = progressReportService.fetchQprIncmEnhncmnt(1);*/
	if(activity !=null)
	
	Collections.sort(activity.getQprAdminAndFinancialDataActivityDetails(), Comparator.comparing(QprAdminAndFinancialDataActivityDetails::getQprAfpDetailsId));
	List<AdminAndFinancialDataActivity> ApproveandFinancialDataActivities =adminAndFinancialDataCellService.fetchAdminAndFinancialActivity(null);
	
	if(!CollectionUtils.isEmpty(ApproveandFinancialDataActivities)) {
		model.addAttribute("ApproveandFinancialDataActivities", ApproveandFinancialDataActivities.get(0));
		}
		model.addAttribute("activity", activity);
	model.addAttribute("quarter_duration", progressReportService.getQuarterDurations());
		//model.addAttribute("districtList", lgdService.getAllDistrictBasedOnState(userPreference.getStateCode()));
	model.addAttribute("SetNewQtrId", qprAdminAndFinancialDataActivity.getShowQqrtrId());
	return ADMIN_DATA_FIN_QUATERLY;
}

@RequestMapping(value = "adminDataFinQuaterlyGet", method = RequestMethod.POST)
public String saveadminDataFinQuaterly(@ModelAttribute("QPR_ADMIN_DATA_FIN") QprAdminAndFinancialDataActivity qprAdminAndFinancialDataActivity, Model model,RedirectAttributes redirectAttributes){
	progressReportService.saveAdminDataFinQuaterly(qprAdminAndFinancialDataActivity);
	redirectAttributes.addFlashAttribute(Message.SUCCESS_KEY, Message.SAVE_SUCCESS);
	return REDIRECT_ADMIN_DATA_FIN_QUATERLY;
}

}