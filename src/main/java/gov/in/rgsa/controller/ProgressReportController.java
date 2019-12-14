package gov.in.rgsa.controller;

import gov.in.rgsa.dto.EEnablementReportDto;
import gov.in.rgsa.dto.GramPanchayatProgressReportDTO;
import gov.in.rgsa.dto.InstitutionalInfraProgressReportDTO;
import gov.in.rgsa.dto.SubcomponentwiseQuaterBalance;
import gov.in.rgsa.entity.*;
import gov.in.rgsa.outbound.MsgReply;
import gov.in.rgsa.service.*;
import gov.in.rgsa.user.preference.UserPreference;
import gov.in.rgsa.utils.FileNodeUtils;
import gov.in.rgsa.utils.Message;
import org.apache.commons.collections.CollectionUtils;
import org.codehaus.jettison.json.JSONObject;
import org.owasp.esapi.util.CollectionsUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.configurationprocessor.json.JSONArray;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.*;

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
    public static final String REDIRECT_PLAN_ALLOCATION = "redirect:planAllocation.html";
    public static final String INSTITUTIONAL_INFRA_REPORT_LOAD = "redirect:institutionalInfraQuaterlyReport.html";
    public static final String TRAINING_DETAILS_PROGRESS_REPORT = "trainingDetailsProgressReport";
    public static final String REDIRECT_TRAINING_DETAILS_PROGRESS_REPORT = "redirect:trainingProgressReportGETData.html";

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

    @Autowired
    PlanAllocationService planAllocationService;



    @RequestMapping(value = "gramPanchayatProgressReport", method = RequestMethod.GET)
    public String qprGetFormGramPanchayatProgressReport() {
        return GRAM_PANCHAYAT_PROGRESS_REPORT;
    }

    @RequestMapping(value = "fetchDetailsForGramPanchayatProgressReport", method = RequestMethod.GET)
    private @ResponseBody  Map<String, Object> fetchDetailsForGramPanchayatProgressReport() {
        Map<String, Object> detailsMaps = new HashMap<>();
        try {
        detailsMaps.put("quarterDuration", progressReportService.getQuarterDurations());
        detailsMaps.put("panchayatActivity", panchayatBhawanService.fetchPanchayatBhawanActivity());
        detailsMaps.put("districtList", lgdService.getAllDistrictBasedOnState(userPreference.getStateCode()));
		} catch (Exception e) {
			e.printStackTrace();
		}
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

  /* @ResponseBody
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
*/
    @ResponseBody
    @RequestMapping(value = "saveQprPanchayatBhawanData", method = RequestMethod.POST)
    private QprPanchayatBhawan saveQprPanchayatBhawanData(@RequestBody final QprPanchayatBhawan qprPanchayatBhawan,   @RequestParam(value = "file", required = false) MultipartFile filepath) {
        panchayatBhawanService.saveQprPanchayatBhawanData(qprPanchayatBhawan);
        return qprPanchayatBhawan;
    }

    @RequestMapping(value = "capacityBuildingOneQtrProgressReport", method = RequestMethod.GET)
    public String capacityBuildingOneQtrProgressReportGet(@RequestParam(value = "menuId") int menuId) {
        userPreference.setMenuId(menuId);
        return CAPACITY_BUILDING__PROGRESS_REPORT;
    }

    @RequestMapping(value = "iecQtrProgressReport", method = RequestMethod.GET)
    public String qprGetFormIecQtrProgressReport1(@ModelAttribute("IEC_ACTIVITY_QUATER") IecQuater iecQuater,  Model model) {
        int quarterId = 0;
        if (iecQuater.getQtrId() != null) {
            quarterId = iecQuater.getQtrId();
        } else {
            quarterId = 0;
        }
        int installmentNo = quarterId < 3 ? 1 : 2; // installment number for qtrId 1 & 2 = 1 and 3 & 4 = 2
        model.addAttribute("QUATER_DETAILS", progressReportService.getQuarterDurations());
        List<QuaterWiseFund> totalQuatorWiseFund = new ArrayList<>();
        List<IecActivity> iecActivitiesApproved = iecService.fetchApprovedIec();// this gives CEC approved data.
        List<StateAllocation> stateAllocation = progressReportService.fetchStateAllocationData(11, installmentNo,progressReportService.getCurrentPlanCode());
        if (quarterId == 3 || quarterId == 4) {
            stateAllocation.add(progressReportService.fetchStateAllocationData(11, 1,progressReportService.getCurrentPlanCode()).get(0)); // total fund allocated in first installment
            totalQuatorWiseFund = progressReportService.fetchTotalQuaterWiseFundData(userPreference.getStateCode(), 11);
            double fund_used_in_one_two_qtr=calTotalFundUsedInQtr1And2(totalQuatorWiseFund);
            if(fund_used_in_one_two_qtr == 0) {
            	model.addAttribute("QTR_ID", 0);
				model.addAttribute("QTR_ONE_TWO_FILLED", false);
				return IEC_PROGRESS_REPORT;
            }
            model.addAttribute("TOTAL_FUND_USED_IN_QTR_1_AND_2", fund_used_in_one_two_qtr);
        }
        if (CollectionUtils.isNotEmpty(stateAllocation) && CollectionUtils.isNotEmpty(iecActivitiesApproved)) {
            if (stateAllocation.size() > 1) {
                model.addAttribute("FUND_ALLOCATED_BY_STATE_PREVIOUS", stateAllocation.get(1).getFundsAllocated()); // we will use this in jsp to calculate the total remaining field
            }
			
            // list to get total number of unit in all quator except current one
            List<IecQuaterDetails> detailForTotalNoOfUnit = new ArrayList<>();
            List<IecQuaterDetails> iecReportDetailOfRestQuater = iecService.getIecQprActBasedOnActIdAndQtrId(iecActivitiesApproved.get(0).getId(), quarterId);
            if (iecReportDetailOfRestQuater != null) {
                Collections.sort(iecReportDetailOfRestQuater,
                        (o1, o2) -> o1.getQprIecDetailsId() - o2.getQprIecDetailsId());
                detailForTotalNoOfUnit = getTotalUnitAndExpIncurredInAllQtrIec(detailForTotalNoOfUnit,
                		iecReportDetailOfRestQuater);
                		model.addAttribute("DEATIL_FOR_TOTAL_NO_OF_UNIT", detailForTotalNoOfUnit.get(0));
            } else {
                model.addAttribute("DEATIL_FOR_TOTAL_NO_OF_UNIT", null);
            }
            /*----------------------------end here-------------------------------------------------- */
            
            model.addAttribute("CEC_APPROVED_ACTIVITY", iecActivitiesApproved.get(0));
            model.addAttribute("CEC_APPROVED_ACT_ID", iecActivitiesApproved.get(0).getId());
            IecQuater iecQuaterProgressReport = progressReportService.getSatcomProgress(iecActivitiesApproved.get(0).getId(), quarterId);
                model.addAttribute("IEC_ACTIVITY_PROGRESS", iecQuaterProgressReport);
                if(iecQuaterProgressReport != null) {
                	model.addAttribute("DISABLE_FREEZE", false);
                }else {
                	model.addAttribute("DISABLE_FREEZE", true);
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
            model.addAttribute("QTR_ONE_TWO_FILLED", true);
            return IEC_PROGRESS_REPORT;
        } else {
            return NO_FUND_ALLOCATED_JSP;
        }
    }

    private List<IecQuaterDetails> getTotalUnitAndExpIncurredInAllQtrIec(List<IecQuaterDetails> detailForTotalNoOfUnit,
			List<IecQuaterDetails> iecReportDetailOfRestQuater) {
    	int count = 0;
  		  detailForTotalNoOfUnit.add(new IecQuaterDetails());  
            
        for (int j = 0; j < iecReportDetailOfRestQuater.size(); j++) {
            if (count == 1 ) {
                count = 0;
            }
            for (int i = count; i < count + 1; i++) {
                if (detailForTotalNoOfUnit.get(i).getExpenditureIncurred() != null && iecReportDetailOfRestQuater.get(j).getExpenditureIncurred() != null) {
                    detailForTotalNoOfUnit.get(i)
                            .setExpenditureIncurred(detailForTotalNoOfUnit.get(i).getExpenditureIncurred()
                                    + iecReportDetailOfRestQuater.get(j).getExpenditureIncurred());
                } else if((detailForTotalNoOfUnit.get(i).getExpenditureIncurred() == null || detailForTotalNoOfUnit.get(i).getExpenditureIncurred() == 0 ) && iecReportDetailOfRestQuater.get(j).getExpenditureIncurred() == null) {
                	 detailForTotalNoOfUnit.get(i).setExpenditureIncurred(0);
                }else {
                	if(iecReportDetailOfRestQuater.get(j).getExpenditureIncurred() != null)
                    detailForTotalNoOfUnit.get(i).setExpenditureIncurred(iecReportDetailOfRestQuater.get(j).getExpenditureIncurred() + 0);
                }
            }
            ++count;
        }
        return detailForTotalNoOfUnit;
	}

	@RequestMapping(value = "iecQtrProgressReportPost", method = RequestMethod.POST)
    public String iecQtrProgressReportPostQuaterly(@ModelAttribute("IEC_ACTIVITY_QUATER") IecQuater iecQuater,
                                                   Model model, HttpServletRequest request, RedirectAttributes re) {
    	if (!iecQuater.getOrigin().equalsIgnoreCase("save")) {
            return qprGetFormIecQtrProgressReport1(iecQuater, model);
        }
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
        List<StateAllocation> stateAllocation = progressReportService.fetchStateAllocationData(10,
                installmentNo,progressReportService.getCurrentPlanCode());
        model.addAttribute("QUATER_DETAILS", progressReportService.getQuarterDurations());
        if (quarterId == 3 || quarterId == 4) {
            stateAllocation.add(progressReportService.fetchStateAllocationData(10, 1,progressReportService.getCurrentPlanCode()).get(0)); // total fund allocated in first quator
            totalQuatorWiseFund = progressReportService.fetchTotalQuaterWiseFundData(userPreference.getStateCode(), 10);
            double fund_used_in_one_two_qtr=calTotalFundUsedInQtr1And2(totalQuatorWiseFund);
            if(fund_used_in_one_two_qtr == 0) {
            	model.addAttribute("QTR_ID", 0);
				model.addAttribute("QTR_ONE_TWO_FILLED", false);
				return INCOMEENHANCEMENT_QUATERLY;
            }
            model.addAttribute("TOTAL_FUND_USED_IN_QTR_1_AND_2", fund_used_in_one_two_qtr);
        }

        if (CollectionUtils.isNotEmpty(stateAllocation) && CollectionUtils.isNotEmpty(incomeEnhancementActApproved)) {
            if (stateAllocation.size() > 1) {
                model.addAttribute("FUND_ALLOCATED_BY_STATE_PREVIOUS", stateAllocation.get(1).getFundsAllocated()); // we will use this in jsp to calculate the total remaining field
            }
            
         // list to get total number of unit in all quator except current one
            List<QprIncomeEnhancementDetails> detailForTotalNoOfUnit = new ArrayList<>();
            List<QprIncomeEnhancementDetails> inchomeEnhanceReportDetailOfRestQuater = enhancementService.getIncomeEnhanceQprActBasedOnActIdAndQtrId(incomeEnhancementActApproved.get(0).getIncomeEnhancementId(), quarterId);
            if (inchomeEnhanceReportDetailOfRestQuater != null) {
                Collections.sort(inchomeEnhanceReportDetailOfRestQuater,
                        (o1, o2) -> o1.getQprIncomeEnhancementDetailsId() - o2.getQprIncomeEnhancementDetailsId());
                detailForTotalNoOfUnit = getTotalUnitAndExpIncurredInAllQtrIncomeEnhance(detailForTotalNoOfUnit,
                		inchomeEnhanceReportDetailOfRestQuater,incomeEnhancementActApproved.get(0).getIncomeEnhancementDetails().size());
                		model.addAttribute("DEATIL_FOR_TOTAL_NO_OF_UNIT", detailForTotalNoOfUnit);
            } else {
                model.addAttribute("DEATIL_FOR_TOTAL_NO_OF_UNIT", null);
            }
            /*----------------------------end here-------------------------------------------------- */
            
            QprIncomeEnhancement qprEnhancement = progressReportService.fetchQprIncmEnhncmnt(incomeEnhancementActApproved.get(0).getIncomeEnhancementId(), quarterId);
            if (qprEnhancement != null) {
                Collections.sort(qprEnhancement.getQprIncomeEnhancementDetails(),
                        (o1, o2) -> o1.getQprIncomeEnhancementDetailsId() - o1.getQprIncomeEnhancementDetailsId());
                model.addAttribute("QPR_ENHANCEMENT", qprEnhancement);
                model.addAttribute("DISABLE_FREEZE", false);
            } else {
                if (qprIncomeEnhancement.getQprIncomeEnhancementDetails() != null) {
                    qprIncomeEnhancement.getQprIncomeEnhancementDetails().clear();
                }
                model.addAttribute("DISABLE_FREEZE", true);
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
            model.addAttribute("QTR_ONE_TWO_FILLED", true);
            model.addAttribute("CEC_APPROVED_ACTIVITY", incomeEnhancementActApproved.get(0));
            model.addAttribute("FUND_ALLOCATED_BY_STATE", stateAllocation.get(0).getFundsAllocated());
            model.addAttribute("DISTRICT_LIST", lgdService.getAllDistrictBasedOnState(userPreference.getStateCode()));
            if(quarterId !=0) 
				model.addAttribute("REMAINING_ADD_REQ", Integer.parseInt(progressReportService.getBalanceAdditionalReqiurment(10,quarterId)));
            return INCOMEENHANCEMENT_QUATERLY;
        } else {
            return NO_FUND_ALLOCATED_JSP;
        }
    }

    private List<QprIncomeEnhancementDetails> getTotalUnitAndExpIncurredInAllQtrIncomeEnhance(
			List<QprIncomeEnhancementDetails> detailForTotalNoOfUnit,
			List<QprIncomeEnhancementDetails> inchomeEnhanceReportDetailOfRestQuater, int size) {
     	int count = 0;
    	  for(int i=0;i< size;i++) {
    		  detailForTotalNoOfUnit.add(new QprIncomeEnhancementDetails());  
    	  }
              
          for (int j = 0; j < inchomeEnhanceReportDetailOfRestQuater.size(); j++) {
              if (count == size ) {
                  count = 0;
              }
              for (int i = count; i < count + 1; i++) {
                  if (detailForTotalNoOfUnit.get(i).getExpenditureIncurred() != null && inchomeEnhanceReportDetailOfRestQuater.get(j).getExpenditureIncurred() != null) {
                      detailForTotalNoOfUnit.get(i)
                              .setExpenditureIncurred(detailForTotalNoOfUnit.get(i).getExpenditureIncurred()
                                      + inchomeEnhanceReportDetailOfRestQuater.get(j).getExpenditureIncurred());
                  } else if((detailForTotalNoOfUnit.get(i).getExpenditureIncurred() == null || detailForTotalNoOfUnit.get(i).getExpenditureIncurred() == 0 ) && inchomeEnhanceReportDetailOfRestQuater.get(j).getExpenditureIncurred() == null) {
                  	 detailForTotalNoOfUnit.get(i).setExpenditureIncurred(0);
                  }else {
                  	if(inchomeEnhanceReportDetailOfRestQuater.get(j).getExpenditureIncurred() != null)
                      detailForTotalNoOfUnit.get(i).setExpenditureIncurred(inchomeEnhanceReportDetailOfRestQuater.get(j).getExpenditureIncurred() + 0);
                  }
              }
              ++count;
          }
          return detailForTotalNoOfUnit;
	}

	@RequestMapping(value = "incomeEnhancementQuaterly", method = RequestMethod.POST)
    public String saveIncomeEnhancementQuaterly(@ModelAttribute("QPR_INCOME_ENHANCEMENT") QprIncomeEnhancement qprIncomeEnhancement, RedirectAttributes redirectAttributes,Model model) {
    	if (!qprIncomeEnhancement.getOrigin().equalsIgnoreCase("save")) {
            return qprGetFormIncomeEnhancementDetailsQuaterly(qprIncomeEnhancement, model);
        }
    	progressReportService.saveQprIncomeEnhancement(qprIncomeEnhancement);
        redirectAttributes.addFlashAttribute(Message.SUCCESS_KEY, Message.SAVE_SUCCESS);
        return REDIRECT_INCOMEENHANCEMENT_QUATERLY;
    }

    /* new method starts from here */
    @RequestMapping(value = "currentUsageSatcomQuaterly", method = RequestMethod.GET)
    public String qprGetFormcurrentUsageSatcomGetQuaterlyNew(
            @ModelAttribute("SATCOM_QUATER") SatcomActivityProgress satcomActivityProgress, Model model) {
        int quarterId = 0;
        if (satcomActivityProgress.getQtrIdJsp1() != null) {
            quarterId = satcomActivityProgress.getQtrIdJsp1();
        }
        int installmentNo = (quarterId < 3) ? 1 : 2; // installment number for qtrId 1 & 2 = 1 and 3 & 4 = 2
        List<QuaterWiseFund> totalQuatorWiseFund = new ArrayList<>();
        List<SatcomActivity> satcomActivityApproved = satcomFacilityService.getApprovedSatcomActivity();// this will give us the data that was approved by the CEC
        List<StateAllocation> stateAllocation = progressReportService.fetchStateAllocationData(7,
                installmentNo,progressReportService.getCurrentPlanCode());
        model.addAttribute("QUATER_DETAILS", progressReportService.getQuarterDurations());
        if (quarterId == 3 || quarterId == 4) {
            stateAllocation.add(progressReportService.fetchStateAllocationData(7, 1,progressReportService.getCurrentPlanCode()).get(0)); // total fund allocated in first quator
            totalQuatorWiseFund = progressReportService.fetchTotalQuaterWiseFundData(userPreference.getStateCode(), 7);
            double fund_used_in_one_two_qtr=calTotalFundUsedInQtr1And2(totalQuatorWiseFund);
            if(fund_used_in_one_two_qtr == 0) {
            	model.addAttribute("QTR_ID", 0);
				model.addAttribute("QTR_ONE_TWO_FILLED", false);
				return CURRENT_SATCOM_QUATERLY;
            }
            model.addAttribute("TOTAL_FUND_USED_IN_QTR_1_AND_2", fund_used_in_one_two_qtr);
        }

        if (CollectionUtils.isNotEmpty(stateAllocation) && CollectionUtils.isNotEmpty(satcomActivityApproved) ) {
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
                    model.addAttribute("DISABLE_FREEZE", false);
                } else {
                    if (satcomActivityProgress.getSatcomActivityProgressDetails() != null) {
                        satcomActivityProgress.getSatcomActivityProgressDetails().clear();
                    }
                    model.addAttribute("PROGRESS_REPORT_ACT_ID", satcomActivityProgress.getSatcomActivityProgressId());// when record is not found then it take the id previous record
                    model.addAttribute("DISABLE_FREEZE", true);
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
                model.addAttribute("QTR_ONE_TWO_FILLED", true);
                model.addAttribute("satcomActivityId", satcomActivityApproved.get(0).getSatcomActivityId());
                if(quarterId !=0) 
    				model.addAttribute("REMAINING_ADD_REQ", Integer.parseInt(progressReportService.getBalanceAdditionalReqiurment(7,quarterId)));
            
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
                if (deatilForTotalNoOfUnit.get(i).getNoOfUnitCompleted() != null && detailsBasedOnActIdAndQtrId.get(j).getNoOfUnitCompleted() != null) {
                    deatilForTotalNoOfUnit.get(i)
                            .setNoOfUnitCompleted(deatilForTotalNoOfUnit.get(i).getNoOfUnitCompleted()
                                    + detailsBasedOnActIdAndQtrId.get(j).getNoOfUnitCompleted());
                } else if(deatilForTotalNoOfUnit.get(i).getNoOfUnitCompleted() == null && detailsBasedOnActIdAndQtrId.get(j).getNoOfUnitCompleted() == null) {
               	 deatilForTotalNoOfUnit.get(i).setNoOfUnitCompleted(0);
                }else {
                	if(detailsBasedOnActIdAndQtrId.get(j).getNoOfUnitCompleted() != null)
                    deatilForTotalNoOfUnit.get(i).setNoOfUnitCompleted(0 + detailsBasedOnActIdAndQtrId.get(j).getNoOfUnitCompleted());
                }
                if (deatilForTotalNoOfUnit.get(i).getExpenditureIncurred() != null && detailsBasedOnActIdAndQtrId.get(j).getExpenditureIncurred() != null) {
                    deatilForTotalNoOfUnit.get(i)
                            .setExpenditureIncurred(deatilForTotalNoOfUnit.get(i).getExpenditureIncurred()
                                    + detailsBasedOnActIdAndQtrId.get(j).getExpenditureIncurred());
                } else if(deatilForTotalNoOfUnit.get(i).getExpenditureIncurred()== null && detailsBasedOnActIdAndQtrId.get(j).getExpenditureIncurred() == null) {
                	deatilForTotalNoOfUnit.get(i).setExpenditureIncurred(0);
                	}	else {
                		if(detailsBasedOnActIdAndQtrId.get(j).getExpenditureIncurred() != null)
                    deatilForTotalNoOfUnit.get(i).setExpenditureIncurred(detailsBasedOnActIdAndQtrId.get(j).getExpenditureIncurred() + 0);
                }
            }
            ++count;
        }
        return deatilForTotalNoOfUnit;
    }

    /* new method ends here */

    @RequestMapping(value = "currentUsageSatcomQuaterlyPost", method = RequestMethod.POST)
    public String currentUsageSatcomPostQuaterly1( @ModelAttribute("SATCOM_QUATER") SatcomActivityProgress satcomActivityProgress, Model model, RedirectAttributes re) {
    	if (!satcomActivityProgress.getOrigin().equalsIgnoreCase("save")) {
            return qprGetFormcurrentUsageSatcomGetQuaterlyNew(satcomActivityProgress, model);
        }
        satcomActivityProgressService.savesatcomProgress(satcomActivityProgress);
        re.addFlashAttribute(Message.SUCCESS_KEY, Message.SAVE_SUCCESS);
        return REDIRECT_CURRENT_SATCOM_QUATERLY;
    }

    @RequestMapping(value = "adminTechQuaderly", method = RequestMethod.GET)
    public String qprGetFormAdminSupportQuaderly(
            @ModelAttribute("ADMIN_QUATER") AdministrativeTechnicalProgress administrativeTechnicalProgress,
            Model model) {
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
        List<StateAllocation> stateAllocation = progressReportService.fetchStateAllocationData(4,
                installmentNo,progressReportService.getCurrentPlanCode());
        model.addAttribute("QUATER_DETAILS", progressReportService.getQuarterDurations());
        if (quarterId == 3 || quarterId == 4) {
            stateAllocation.add(progressReportService.fetchStateAllocationData(4, 1,progressReportService.getCurrentPlanCode()).get(0)); // total fund allocated in first quator
            totalQuatorWiseFund = progressReportService.fetchTotalQuaterWiseFundData(userPreference.getStateCode(), 4);
            double fund_used_in_one_two_qtr=calTotalFundUsedInQtr1And2(totalQuatorWiseFund);
            if(fund_used_in_one_two_qtr == 0) {
            	model.addAttribute("QTR_ID", 0);
				model.addAttribute("QTR_ONE_TWO_FILLED", false);
				return ADMIN_QUADERLY;
            }
            model.addAttribute("TOTAL_FUND_USED_IN_QTR_1_AND_2", fund_used_in_one_two_qtr);
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
                model.addAttribute("DISABLE_FREEZE", false);
            } else {
                if (administrativeTechnicalProgress.getAdministrativeTechnicalDetailProgress() != null) {
                    administrativeTechnicalProgress.getAdministrativeTechnicalDetailProgress().clear();
                }
                model.addAttribute("DISABLE_FREEZE", true);
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
            model.addAttribute("QTR_ONE_TWO_FILLED", true);
            model.addAttribute("APPROVED_ADMIN_TECH_ACT", administrativeTechnicalApproved.get(0));
            if(quarterId !=0) 
				model.addAttribute("REMAINING_ADD_REQ", Integer.parseInt(progressReportService.getBalanceAdditionalReqiurment(4,quarterId)));
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
                if (deatilForTotalNoOfUnit.get(i).getNoOfUnitCompleted() != null && detailsBasedOnActIdAndQtrId.get(j).getNoOfUnitCompleted() != null) {
                    deatilForTotalNoOfUnit.get(i)
                            .setNoOfUnitCompleted(deatilForTotalNoOfUnit.get(i).getNoOfUnitCompleted()
                                    + detailsBasedOnActIdAndQtrId.get(j).getNoOfUnitCompleted());
                } else if((deatilForTotalNoOfUnit.get(i).getNoOfUnitCompleted() == null || deatilForTotalNoOfUnit.get(i).getNoOfUnitCompleted() == 0) && detailsBasedOnActIdAndQtrId.get(j).getNoOfUnitCompleted() == null) {
                	 deatilForTotalNoOfUnit.get(i).setNoOfUnitCompleted(0);
                }else {
                	if(detailsBasedOnActIdAndQtrId.get(j).getNoOfUnitCompleted() != null)
                    deatilForTotalNoOfUnit.get(i).setNoOfUnitCompleted(0 + detailsBasedOnActIdAndQtrId.get(j).getNoOfUnitCompleted());
                }
                if (deatilForTotalNoOfUnit.get(i).getExpenditureIncurred() != null && detailsBasedOnActIdAndQtrId.get(j).getExpenditureIncurred() != null) {
                    deatilForTotalNoOfUnit.get(i)
                            .setExpenditureIncurred(deatilForTotalNoOfUnit.get(i).getExpenditureIncurred()
                                    + detailsBasedOnActIdAndQtrId.get(j).getExpenditureIncurred());
                } else if((deatilForTotalNoOfUnit.get(i).getExpenditureIncurred()== null || deatilForTotalNoOfUnit.get(i).getExpenditureIncurred()== 0) && detailsBasedOnActIdAndQtrId.get(j).getExpenditureIncurred() == null) {
                	deatilForTotalNoOfUnit.get(i).setExpenditureIncurred(0);
                	}	else {
                		if(detailsBasedOnActIdAndQtrId.get(j).getExpenditureIncurred()  != null)
                    deatilForTotalNoOfUnit.get(i).setExpenditureIncurred(detailsBasedOnActIdAndQtrId.get(j).getExpenditureIncurred() + 0);
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
            Model model, RedirectAttributes re) {
    	if (!administrativeTechnicalProgress.getOrigin().equalsIgnoreCase("save")) {
            return qprGetFormAdminSupportQuaderly(administrativeTechnicalProgress, model);
        }
        progressReportService.saveadministrativeTechnicalProgress(administrativeTechnicalProgress);
        re.addFlashAttribute(Message.SUCCESS_KEY, Message.SAVE_SUCCESS);
        return REDIRECT_ADMIN_QUADERLY;
    }

    @RequestMapping(value = "additionalfacultyProgress", method = RequestMethod.GET)
    public String qprGetFormAdditionalFacalltyHr(@ModelAttribute("HR_SUPPORT_SPRC_DPRC_QUATER") AdditionalFacultyProgress additionalFacultyProgress, Model model) {
        int quarterId = 0;
        int installmentNo = (quarterId < 3) ? 1 : 2; // installment number for qtrId 1 & 2 = 1 and 3 & 4 = 2
        Map<String, Object> map = new HashMap<String, Object>();
        if (additionalFacultyProgress.getQtrIdJsp3() != null) {
            quarterId = additionalFacultyProgress.getQtrIdJsp3();
        } else {
            quarterId = 0;
        }
        
        List<Domains> domains=new ArrayList<>();
        List<District> districtName=new ArrayList<>();
        List<StateAllocation> stateAllocation = new ArrayList<>();
        List<QuaterWiseFund> totalQuatorWiseFund = new ArrayList<>();
        domains=additionalFacultyAndMainService.fetchDomains();
        districtName=lgdService.getAllDistrictBasedOnState(userPreference.getStateCode());
        List<InstitueInfraHrActivity> institueInfraHrActivityApproved = additionalFacultyAndMainService.fetchApprovedInstituteHrActivity();
        stateAllocation = progressReportService.fetchStateAllocationData(14, installmentNo,progressReportService.getCurrentPlanCode());
        model.addAttribute("LIST_OF_DOMAINS", domains);
        model.addAttribute("LIST_OF_DOMAINS_LENGTH", domains.size()/2);
        model.addAttribute("LIST_OF_DISTRICT", districtName);
        model.addAttribute("QUATER_DETAILS", progressReportService.getQuarterDurations());
        if (quarterId == 3 || quarterId == 4) {
            totalQuatorWiseFund = progressReportService.fetchTotalQuaterWiseFundData(userPreference.getStateCode(), 14);
            if (CollectionUtils.isNotEmpty(totalQuatorWiseFund)) {
                map = calTotalFundUsedInFirstInstallHRSprcDprc(totalQuatorWiseFund);
                if(((Integer)map.get("total_sprc_subcomp") + (Integer)map.get("total_dprc_subcomp")) == 0) {
                	model.addAttribute("QTR_ID", 0);
    				model.addAttribute("QTR_ONE_TWO_FILLED", false);
    				return ADDITIONAL_FACULTY_QUADERLY;
                }else {
                	model.addAttribute("TOTAL_SPRC_FUND_USED_IN_QTR_1_AND_2", map.get("total_sprc_subcomp"));
                    model.addAttribute("TOTAL_DPRC_FUND_USED_IN_QTR_1_AND_2", map.get("total_dprc_subcomp"));
                }
            }
        }

        if (CollectionUtils.isNotEmpty(stateAllocation) && CollectionUtils.isNotEmpty(institueInfraHrActivityApproved)) {
            if (quarterId > 2) {
                List<StateAllocation> stateAllocationPreQuater = progressReportService.fetchStateAllocationData(14, 1,progressReportService.getCurrentPlanCode());
                for (StateAllocation allocation : stateAllocationPreQuater) {
                    if (allocation.getSubcomponentId() == 10) {
                        model.addAttribute("PRE_INSTALLMENT_FUND_SPRC", allocation.getFundsAllocated());
                    } else {
                        model.addAttribute("PRE_INSTALLMENT_FUND_DPRC", allocation.getFundsAllocated());
                    }
                }

            }
            
            // list to get total number of unit in all quator except current one
            List<AdditionalFacultyProgressDetail> detailForTotalNoOfUnit = new ArrayList<>();
            List<AdditionalFacultyProgressDetail> hrSprcDprcReportDetailOfRestQuater = additionalFacultyAndMainService.getAdditionalFacultyProgressBasedOnActIdAndQtrId(institueInfraHrActivityApproved.get(0).getInstituteInfraHrActivityId(),
                    quarterId);
            if (hrSprcDprcReportDetailOfRestQuater != null) {
                Collections.sort(hrSprcDprcReportDetailOfRestQuater,
                        (o1, o2) -> o1.getQprInstInfraHrDetailsId() - o2.getQprInstInfraHrDetailsId());
                detailForTotalNoOfUnit = getTotalUnitAndExpIncurredInAllQtrHrSupport(detailForTotalNoOfUnit,
                        hrSprcDprcReportDetailOfRestQuater);
                model.addAttribute("DEATIL_FOR_TOTAL_NO_OF_UNIT", detailForTotalNoOfUnit);
            } else {
                model.addAttribute("DEATIL_FOR_TOTAL_NO_OF_UNIT", null);
            }

            AdditionalFacultyProgress qprAdditionalFaculty = progressReportService.fetchAdditionalFacultyProgress(institueInfraHrActivityApproved.get(0).getInstituteInfraHrActivityId(), quarterId);
            if (qprAdditionalFaculty != null) {
                Collections.sort(qprAdditionalFaculty.getAdditionalFacultyProgressDetail(), (o1, o2) -> o1.getQprInstInfraHrDetailsId() - o2.getQprInstInfraHrDetailsId());
                Collections.sort(qprAdditionalFaculty.getQprTiWiseDomainExpert(), (o1, o2) -> o1.getQprTiWiseProposedDomainExpertsId()- o2.getQprTiWiseProposedDomainExpertsId());
                additionalFacultyProgress.setQprTiWiseDomainExpert(qprAdditionalFaculty.getQprTiWiseDomainExpert());
                model.addAttribute("QPR_ACTIVITY", qprAdditionalFaculty);
                model.addAttribute("DISABLE_FREEZE", false);
            } else {
                if (additionalFacultyProgress.getAdditionalFacultyProgressDetail() != null) {
                	additionalFacultyProgress.getAdditionalFacultyProgressDetail().clear();
                }
                if (additionalFacultyProgress.getQprTiWiseDomainExpert() != null) {
                	additionalFacultyProgress.getQprTiWiseDomainExpert().clear();
                }
                model.addAttribute("DISABLE_FREEZE", true);
            }
            
            /* used to get previous data stored which is then use to validate the expenditure incurred */

            List<QuaterWiseFund> quaterWiseFund = new ArrayList<>();
            if (quarterId == 1 || quarterId == 3) {
                quaterWiseFund = progressReportService.fetchQuaterWiseFundData(userPreference.getStateCode(),
                        (quarterId + 1), 14);
            } else {
                quaterWiseFund = progressReportService.fetchQuaterWiseFundData(userPreference.getStateCode(),
                        (quarterId - 1), 14);
            }

            if (CollectionUtils.isNotEmpty(quaterWiseFund)) {
                for (QuaterWiseFund quaterWise : quaterWiseFund) {
                    if (quaterWise.getSubcomponentId() == 10) {
                        model.addAttribute("FUND_USED_IN_OTHER_QTR_SPRC", quaterWise.getFunds());
                    } else {
                        model.addAttribute("FUND_USED_IN_OTHER_QTR_DPRC", quaterWise.getFunds());
                    }
                }
            }

            /*----------------------------end here-------------------------------------------------- */

            for (StateAllocation allocation : stateAllocation) {
                if (allocation.getSubcomponentId() == 10) {
                    model.addAttribute("FUND_ALLOCATED_SPRC", allocation.getFundsAllocated());
                } else {
                    model.addAttribute("FUND_ALLOCATED_DPRC", allocation.getFundsAllocated());
                }
            }

            List<InstitueInfraHrActivityDetails> institueInfraHrActivityDetails = additionalFacultyAndMainService.fetchInstituteHrActivityDetails(institueInfraHrActivityApproved.get(0).getInstituteInfraHrActivityId());
            List<InstituteInfraHrActivityType> params = additionalFacultyAndMainService.fetchHrActvityType();
            map.putAll(additionalFacultyAndMainService.getTotalAddReqBesidesCurrentQtr(institueInfraHrActivityApproved.get(0).getInstituteInfraHrActivityId(), quarterId));
            model.addAttribute("TOTAL_ADD_REQ_SPRC", map.get("total_add_req_sprc"));
            model.addAttribute("TOTAL_ADD_REQ_DPRC", map.get("total_add_req_dprc"));
            model.addAttribute("LIST_OF_ACTIVITY_HR_TYPE", params);
            model.addAttribute("CEC_APPROVED_ACTIVITY_DETAILS", institueInfraHrActivityDetails);
            model.addAttribute("CEC_APPROVED_ACTIVITY", institueInfraHrActivityApproved.get(0));
            model.addAttribute("QTR_ID", quarterId);
            model.addAttribute("QTR_ONE_TWO_FILLED", true);
            return ADDITIONAL_FACULTY_QUADERLY;
        } else {
            return NO_FUND_ALLOCATED_JSP;
        }
    }

    private Map<String, Object> calTotalFundUsedInFirstInstallHRSprcDprc(
            List<QuaterWiseFund> fetchTotalQuaterWiseFundData) {
        Map<String, Object> returningMap = new HashMap<String, Object>();
        Double total_sprc_subcomp = 0d;
        Double total_dprc_subcomp = 0d;
        for (QuaterWiseFund quaterWiseFund : fetchTotalQuaterWiseFundData) {
            if (quaterWiseFund.getQuarter_id() < 3) {
                if (quaterWiseFund.getSubcomponentId() == 10) {
                    if (quaterWiseFund.getFunds() != null)
                        total_sprc_subcomp += quaterWiseFund.getFunds();
                } else {
                    if (quaterWiseFund.getFunds() != null)
                        total_dprc_subcomp += quaterWiseFund.getFunds();
                }
            }
        }
        returningMap.put("total_sprc_subcomp", total_sprc_subcomp);
        returningMap.put("total_dprc_subcomp", total_dprc_subcomp);
        return returningMap;
    }

    /* method for Hr support report */
    private List<AdditionalFacultyProgressDetail> getTotalUnitAndExpIncurredInAllQtrHrSupport(
            List<AdditionalFacultyProgressDetail> deatilForTotalNoOfUnit, List<AdditionalFacultyProgressDetail> detailsBasedOnActIdAndQtrId) {
        int count = 0;
        for (int i = 0; i < 6; i++) {
            deatilForTotalNoOfUnit.add(new AdditionalFacultyProgressDetail());
        }
        for (int j = 0; j < detailsBasedOnActIdAndQtrId.size(); j++) {
            if (count == 6) {
                count = 0;
            }
            for (int i = count; i < count + 1; i++) {
                if (j != 2 && j != 5) {
                    if (deatilForTotalNoOfUnit.get(i).getNoOfUnitsFilled() != null && detailsBasedOnActIdAndQtrId.get(j).getNoOfUnitsFilled() != null) {
                        deatilForTotalNoOfUnit.get(i).setNoOfUnitsFilled(deatilForTotalNoOfUnit.get(i).getNoOfUnitsFilled()
                                + detailsBasedOnActIdAndQtrId.get(j).getNoOfUnitsFilled());
                    }else if((deatilForTotalNoOfUnit.get(i).getNoOfUnitsFilled() == null || deatilForTotalNoOfUnit.get(i).getNoOfUnitsFilled() == 0) && detailsBasedOnActIdAndQtrId.get(j).getNoOfUnitsFilled() == null) {
                    	deatilForTotalNoOfUnit.get(i).setNoOfUnitsFilled(0);
                    }
                    else {
                    	if(detailsBasedOnActIdAndQtrId.get(j).getNoOfUnitsFilled() != null)
                        deatilForTotalNoOfUnit.get(i).setNoOfUnitsFilled(0 + detailsBasedOnActIdAndQtrId.get(j).getNoOfUnitsFilled());
                    }
                }
                if (deatilForTotalNoOfUnit.get(i).getExpenditureIncurred() != null && detailsBasedOnActIdAndQtrId.get(j).getExpenditureIncurred() != null) {
                    deatilForTotalNoOfUnit.get(i)
                            .setExpenditureIncurred(deatilForTotalNoOfUnit.get(i).getExpenditureIncurred()
                                    + detailsBasedOnActIdAndQtrId.get(j).getExpenditureIncurred());
                }else if((deatilForTotalNoOfUnit.get(i).getExpenditureIncurred() == null || deatilForTotalNoOfUnit.get(i).getExpenditureIncurred() == null) && detailsBasedOnActIdAndQtrId.get(j).getExpenditureIncurred() == null) {
                	deatilForTotalNoOfUnit.get(i).setNoOfUnitsFilled(0);
                } 
                else {
                	if(detailsBasedOnActIdAndQtrId.get(j).getExpenditureIncurred() !=null)
                    deatilForTotalNoOfUnit.get(i).setExpenditureIncurred(detailsBasedOnActIdAndQtrId.get(j).getExpenditureIncurred() + 0);
                }
            }
            ++count;
        }
        return deatilForTotalNoOfUnit;
    }

    /* new method ends here */

    @RequestMapping(value = "additionalfacultyProgress", method = RequestMethod.POST)
    public String getAdditionalFacalltyHrPost(@ModelAttribute("HR_SUPPORT_SPRC_DPRC_QUATER") AdditionalFacultyProgress additionalFacultyProgress, Model model, RedirectAttributes re) {
        if (!additionalFacultyProgress.getOrigin().equalsIgnoreCase("save")) {
            return qprGetFormAdditionalFacalltyHr(additionalFacultyProgress, model);
        }
        progressReportService.saveAdditionalFacultyProgress(additionalFacultyProgress);
        re.addFlashAttribute(Message.SUCCESS_KEY, Message.SAVE_SUCCESS);
        return REDIRECT_ADDITIONAL_QUADERLY;
    }

    @RequestMapping(value = "pmuProgresReport", method = RequestMethod.GET)
    public String qprGetFormPmuActivityMethodQuaterly(@ModelAttribute("PMU_ACTIVITY_QUATERLY") PmuProgress pmuProgress,
                                                      Model model) {
        int quarterId = 0;
        int installmentNo = (quarterId < 3) ? 1 : 2; // installment number for qtrId 1 & 2 = 1 and 3 & 4 = 2
        if (pmuProgress.getQtrIdJsp6() != null) {
            quarterId = pmuProgress.getQtrIdJsp6();
        } else {
            quarterId = 0;
        }

        List<StateAllocation> stateAllocation = new ArrayList<>();
        List<QuaterWiseFund> totalQuatorWiseFund = new ArrayList<>();
        List<PmuDomain> domainList = pmuActivityService.fetchPmuDomains();
        List<PmuActivity> pmuCecApprovedActivities = pmuActivityService.fetchApprovedPmu();
        stateAllocation = progressReportService.fetchStateAllocationData(12, installmentNo,progressReportService.getCurrentPlanCode());
        model.addAttribute("QUATER_DETAILS", progressReportService.getQuarterDurations());
        model.addAttribute("LIST_OF_PMU_DOMAINS", domainList);
        model.addAttribute("LIST_OF_PMU_DOMAINS_LIST", domainList.size()/2);
        model.addAttribute("LIST_OF_DISTRICT", pmuActivityService.fetchDistrictName());
        if (quarterId == 3 || quarterId == 4) {
            stateAllocation.add(progressReportService.fetchStateAllocationData(12, 1,progressReportService.getCurrentPlanCode()).get(0)); // total fund allocated in first quator
            totalQuatorWiseFund = progressReportService.fetchTotalQuaterWiseFundData(userPreference.getStateCode(), 12);
            double fund_used_in_one_two_qtr=calTotalFundUsedInQtr1And2(totalQuatorWiseFund);
            if(fund_used_in_one_two_qtr == 0) {
            	model.addAttribute("QTR_ID", 0);
				model.addAttribute("QTR_ONE_TWO_FILLED", false);
				return TRAINING_PROGRESS_PMU;
            }
            model.addAttribute("TOTAL_FUND_USED_IN_QTR_1_AND_2", fund_used_in_one_two_qtr);
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
                pmuProgressActivity.getQprPmuWiseProposedDomainExperts().sort((o1,o2) -> o1.getQprPmuWiseProposedDomainExpertsId() -o2.getQprPmuWiseProposedDomainExpertsId());
                pmuProgress.setQprPmuWiseProposedDomainExperts(pmuProgressActivity.getQprPmuWiseProposedDomainExperts());
                model.addAttribute("PMU_PROGRESS", pmuProgressActivity);
                model.addAttribute("DISABLE_FREEZE", false);
            } else {
                if (pmuProgress.getPmuProgressDetails() != null) {
                    pmuProgress.getPmuProgressDetails().clear();
                }
                if (pmuProgress.getQprPmuWiseProposedDomainExperts() != null) {
                    pmuProgress.getQprPmuWiseProposedDomainExperts().clear();
                }
                model.addAttribute("DISABLE_FREEZE", true);
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
            model.addAttribute("QTR_ONE_TWO_FILLED", true);
            return TRAINING_PROGRESS_PMU;
        } else {
            return NO_FUND_ALLOCATED_JSP;
        }
    }

    @RequestMapping(value = "pmuProgresReport", method = RequestMethod.POST)
    public String getPmuActivityPost(@ModelAttribute("PMU_ACTIVITY_QUATERLY") PmuProgress pmuProgress, Model model, RedirectAttributes re) {
    	if (!pmuProgress.getOrigin().equalsIgnoreCase("save")) {
            return qprGetFormPmuActivityMethodQuaterly(pmuProgress, model);
        }
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
                if (deatilForTotalNoOfUnit.get(i).getNoOfUnitsFilled() != null && detailsBasedOnActIdAndQtrId.get(j).getNoOfUnitsFilled() != null) {
                    deatilForTotalNoOfUnit.get(i).setNoOfUnitsFilled(deatilForTotalNoOfUnit.get(i).getNoOfUnitsFilled()
                            + detailsBasedOnActIdAndQtrId.get(j).getNoOfUnitsFilled());
                }else if((deatilForTotalNoOfUnit.get(i).getNoOfUnitsFilled() == null || deatilForTotalNoOfUnit.get(i).getNoOfUnitsFilled() == 0) && detailsBasedOnActIdAndQtrId.get(j).getNoOfUnitsFilled() == null) {
                	deatilForTotalNoOfUnit.get(i).setNoOfUnitsFilled(0);
                }else {
                	if(detailsBasedOnActIdAndQtrId.get(j).getNoOfUnitsFilled() != null)
                    deatilForTotalNoOfUnit.get(i).setNoOfUnitsFilled(0 + detailsBasedOnActIdAndQtrId.get(j).getNoOfUnitsFilled());
                }
                if (deatilForTotalNoOfUnit.get(i).getExpenditureIncurred() != null && detailsBasedOnActIdAndQtrId.get(j).getExpenditureIncurred() != null) {
                    deatilForTotalNoOfUnit.get(i)
                            .setExpenditureIncurred(deatilForTotalNoOfUnit.get(i).getExpenditureIncurred()
                                    + detailsBasedOnActIdAndQtrId.get(j).getExpenditureIncurred());
                }else if((deatilForTotalNoOfUnit.get(i).getExpenditureIncurred() == null || deatilForTotalNoOfUnit.get(i).getExpenditureIncurred() == 0) && detailsBasedOnActIdAndQtrId.get(j).getExpenditureIncurred() == null) {
                	deatilForTotalNoOfUnit.get(i).setExpenditureIncurred(0);
                }else {
                	if(detailsBasedOnActIdAndQtrId.get(j).getExpenditureIncurred() !=  null)
                    deatilForTotalNoOfUnit.get(i).setExpenditureIncurred(detailsBasedOnActIdAndQtrId.get(j).getExpenditureIncurred() + 0);
                }
            }
            ++count;
        }
        return deatilForTotalNoOfUnit;
    }

    /* new method ends here */

    @RequestMapping(value = "enablementQuaterly", method = RequestMethod.GET)
    public String qprGetFormEnablementQuaderly(@ModelAttribute("Enablement") QprEnablement qprEnablement, Model model,RedirectAttributes re) {
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
        stateAllocation = progressReportService.fetchStateAllocationData(5, 16, installmentNo,progressReportService.getCurrentPlanCode());
        if (quarterId == 3 || quarterId == 4) {
            stateAllocation.add(progressReportService.fetchStateAllocationData(5, 16, 1,progressReportService.getCurrentPlanCode()).get(0)); // total fund allocated in first quator
            totalQuatorWiseFund = progressReportService.fetchTotalQuaterWiseFundData(userPreference.getStateCode(), 5);
            double fund_used_in_one_two_qtr=calTotalFundUsedInQtr1And2(totalQuatorWiseFund);
            if(fund_used_in_one_two_qtr == 0) {
            	model.addAttribute("QTR_ID", 0);
				model.addAttribute("QTR_ONE_TWO_FILLED", false);
				return ENABLEMENT_PROGRESS_REPORT;
            }
            model.addAttribute("TOTAL_FUND_USED_IN_QTR_1_AND_2",fund_used_in_one_two_qtr);
        }
        if (CollectionUtils.isNotEmpty(stateAllocation) && CollectionUtils.isNotEmpty(eEnablementsApproved)) {
            model.addAttribute("FUND_ALLOCATED_BY_STATE", stateAllocation.get(0).getFundsAllocated());
            if (stateAllocation.size() > 1) {
                model.addAttribute("FUND_ALLOCATED_BY_STATE_PREVIOUS", stateAllocation.get(1).getFundsAllocated()); // we will  use this in jsp to calculate the total remaining field
            }
            Integer id = eEnablementsApproved.get(0).geteEnablementId();
            Integer eEnablementDetailsId = eEnablementsApproved.get(0).geteEnablementDetails().get(0).geteEnablementDetailId();
            List<EEnablementGPs> eEnablementGPs = eEnablementOfPanchayatService.fetchCapacityBuildingActivityGPsList(eEnablementDetailsId);
            model.addAttribute("eEnablementGPs", eEnablementGPs);
            model.addAttribute("idEEnablement", id);
            model.addAttribute("SetNewQtrId1", qprEnablement.getQrtId());
            model.addAttribute("SetNewDistrictId", qprEnablement.getDistrictId());
            model.addAttribute("quarterId", quarterId);
            model.addAttribute("QTR_ONE_TWO_FILLED", true);
            model.addAttribute("eEnablementsApproved", eEnablementsApproved.get(0));
            if(quarterId !=0) 
				model.addAttribute("REMAINING_ADD_REQ", progressReportService.getBalanceAdditionalReqiurment(5,quarterId));
            List<EEnablementReportDto> eEnablementReportDto=new ArrayList<EEnablementReportDto>();
            int district =(CollectionUtils.isNotEmpty(eEnablementGPs)) ? eEnablementGPs.get(0).getDistrictCode() : 0;
            if(district != 0) {
            	eEnablementReportDto = eEnablementOfPanchayatService.getEEnablementReportDto(district);
            	model.addAttribute("eEnablementReportDto", eEnablementReportDto);
            	 if (qprEnablement.getDistrictId() != null) {
                     district = qprEnablement.getDistrictId();
                 } else {
                     district = eEnablementGPs.get(0).getDistrictCode();
                 }
            }
            
            if (eEnablementReportDto.size() == 0) {
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

            // list to get total number of unit in all quator except current one
            List<QprEnablementDetails> detailForTotalNoOfUnit = new ArrayList<>();
            List<QprEnablementDetails> enablementReportDetailOfRestQuater = eEnablementOfPanchayatService.getEnablementQprActBasedOnActIdAndQtrId(eEnablementsApproved.get(0).geteEnablementId(), quarterId);
            if (enablementReportDetailOfRestQuater != null) {
                Collections.sort(enablementReportDetailOfRestQuater,
                        (o1, o2) -> o1.getQprEEenablementDetailsId() - o2.getQprEEenablementDetailsId());
                detailForTotalNoOfUnit = getTotalUnitAndExpIncurredInAllQtrEnablement(detailForTotalNoOfUnit,
                		enablementReportDetailOfRestQuater,eEnablementReportDto.size());
                model.addAttribute("DEATIL_FOR_TOTAL_NO_OF_UNIT", detailForTotalNoOfUnit);
            } else {
                model.addAttribute("DEATIL_FOR_TOTAL_NO_OF_UNIT", null);
            }
            /*----------------------------end here-------------------------------------------------- */
            model.addAttribute("fetchDetails", fetchDetails);
            if (fetchQprEnablement != null) {
                model.addAttribute("Qpr_Enablement", fetchQprEnablement);
                qprEnablementDetails = progressReportService
                        .fetchQprEnablementDetails(fetchQprEnablement.getQprEEnablementId());
                model.addAttribute("EnablementDtlsList", qprEnablementDetails);
                model.addAttribute("DISABLE_FREEZE", false);
            } else {
                QprEnablement fetchQprEnablement1 = progressReportService.fetchEEnablementProgressToGeReportId1(id);
                if (fetchQprEnablement1 != null) {
                    model.addAttribute("qprEEnablementId", fetchQprEnablement1.getQprEEnablementId());
                }
                model.addAttribute("DISABLE_FREEZE", true);
            }
        } else {
            return NO_FUND_ALLOCATED_JSP;
        }
        return ENABLEMENT_PROGRESS_REPORT;
    }

    private List<QprEnablementDetails> getTotalUnitAndExpIncurredInAllQtrEnablement(
			List<QprEnablementDetails> detailForTotalNoOfUnit,
			List<QprEnablementDetails> enablementReportDetailOfRestQuater, int size) {
    	  int count = 0;
    	  for(int i=0;i< size;i++) {
    		  detailForTotalNoOfUnit.add(new QprEnablementDetails());  
    	  }
              
          for (int j = 0; j < enablementReportDetailOfRestQuater.size(); j++) {
              if (count == size ) {
                  count = 0;
              }
              for (int i = count; i < count + 1; i++) {
                  if (detailForTotalNoOfUnit.get(i).getExpenditureIncurred() != null && enablementReportDetailOfRestQuater.get(j).getExpenditureIncurred() != null) {
                      detailForTotalNoOfUnit.get(i)
                              .setExpenditureIncurred(detailForTotalNoOfUnit.get(i).getExpenditureIncurred()
                                      + enablementReportDetailOfRestQuater.get(j).getExpenditureIncurred());
                  } else if((detailForTotalNoOfUnit.get(i).getExpenditureIncurred() == null || detailForTotalNoOfUnit.get(i).getExpenditureIncurred() == 0 )&& enablementReportDetailOfRestQuater.get(j).getExpenditureIncurred() == null) {
                  	 detailForTotalNoOfUnit.get(i).setExpenditureIncurred(0);
                  }else {
                  	if(enablementReportDetailOfRestQuater.get(j).getExpenditureIncurred() != null)
                      detailForTotalNoOfUnit.get(i).setExpenditureIncurred(enablementReportDetailOfRestQuater.get(j).getExpenditureIncurred() + 0);
                  }
              }
              ++count;
          }
          return detailForTotalNoOfUnit;
	}

	public double calTotalFundUsedInQtr1And2(List<QuaterWiseFund> obj) {
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
    	if (!qprEnablement.getOrigin().equalsIgnoreCase("save")) {
            return qprGetFormEnablementQuaderly(qprEnablement, model,re);
        }
    	progressReportService.saveEnablement(qprEnablement);
        re.addFlashAttribute(Message.SUCCESS_KEY, Message.SAVE_SUCCESS);
        return REDIRECT_ENABLEMENT_PROGRESS_REPORT;
    }

    @RequestMapping(value = "innovativeActivityQpr", method = RequestMethod.GET)
    public String qprGetFormInnovativeActivityQpr(
            @ModelAttribute("INNOVATIVE_ACTIVITY_QUATERLY_REPORT") QprInnovativeActivity qprInnovativeActivity, Model model) {

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
        List<InnovativeActivity> innovativeActApproved = innovativeActivityService.fetchApprovedInnovative();
        List<StateAllocation> stateAllocation = progressReportService.fetchStateAllocationData(9, installmentNo,progressReportService.getCurrentPlanCode());
        if (quarterId == 3 || quarterId == 4) {
            stateAllocation.add(progressReportService.fetchStateAllocationData(9, 1,progressReportService.getCurrentPlanCode()).get(0)); // total fund allocated in first quator
            totalQuatorWiseFund = progressReportService.fetchTotalQuaterWiseFundData(userPreference.getStateCode(), 9);
            double fund_used_in_one_two_qtr=calTotalFundUsedInQtr1And2(totalQuatorWiseFund);
            if(fund_used_in_one_two_qtr == 0) {
            	model.addAttribute("QTR_ID", 0);
				model.addAttribute("QTR_ONE_TWO_FILLED", false);
				return INNOVATIVE_PROGRESS_REPORT;
            }
            model.addAttribute("TOTAL_FUND_USED_IN_QTR_1_AND_2", fund_used_in_one_two_qtr);
        }

        if (CollectionUtils.isNotEmpty(stateAllocation) && CollectionUtils.isNotEmpty(innovativeActApproved)) {
            if (stateAllocation.size() > 1) {
                model.addAttribute("FUND_ALLOCATED_BY_STATE_PREVIOUS", stateAllocation.get(1).getFundsAllocated()); // we will use this in jsp to calculate the total remaining field
            }
            // list to get total number of unit in all quator except current one
            List<QprInnovativeActivityDetails> detailForTotalNoOfUnit = new ArrayList<>();
            List<QprInnovativeActivityDetails>innovativeReportDetailOfRestQuater = innovativeActivityService.getInnovativeQprActBasedOnActIdAndQtrId(innovativeActApproved.get(0).getInnovativeActivityId(), quarterId);
            if (innovativeReportDetailOfRestQuater != null) {
                Collections.sort(innovativeReportDetailOfRestQuater,
                        (o1, o2) -> o1.getQprIaDetailsId() - o2.getQprIaDetailsId());
                detailForTotalNoOfUnit = getTotalUnitAndExpIncurredInAllQtrInnovative(detailForTotalNoOfUnit,
                		innovativeReportDetailOfRestQuater,innovativeActApproved.get(0).getInnovativeActivityDetails().size());
                		model.addAttribute("DEATIL_FOR_TOTAL_NO_OF_UNIT", detailForTotalNoOfUnit);
            } else {
                model.addAttribute("DEATIL_FOR_TOTAL_NO_OF_UNIT", null);
            }
            /*----------------------------end here-------------------------------------------------- */

            QprInnovativeActivity qprInnovativeAct = progressReportService.getInnovative(innovativeActApproved.get(0).getInnovativeActivityId(), quarterId);
            if (qprInnovativeAct != null) {
                Collections.sort(qprInnovativeAct.getQprInnovativeActivityDetails(), (o1, o2) -> o1.getQprIaDetailsId() - o2.getQprIaDetailsId());
                model.addAttribute("QPR_INNOVATIVE_ACTIVITY", qprInnovativeAct);
                model.addAttribute("DISABLE_FREEZE", false);
            } else {
                if (qprInnovativeActivity.getQprInnovativeActivityDetails() != null) {
                    qprInnovativeActivity.getQprInnovativeActivityDetails().clear();
                }
                model.addAttribute("DISABLE_FREEZE", true);
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
            model.addAttribute("QTR_ONE_TWO_FILLED", true);
            if(quarterId !=0) 
				model.addAttribute("REMAINING_ADD_REQ", Integer.parseInt(progressReportService.getBalanceAdditionalReqiurment(9,quarterId)));
            return INNOVATIVE_PROGRESS_REPORT;
        } else {
            return NO_FUND_ALLOCATED_JSP;
        }

    }

    private List<QprInnovativeActivityDetails> getTotalUnitAndExpIncurredInAllQtrInnovative(
			List<QprInnovativeActivityDetails> detailForTotalNoOfUnit,
			List<QprInnovativeActivityDetails> innovativeReportDetailOfRestQuater, int size) {
    	int count = 0;
  	  for(int i=0;i< size;i++) {
  		  detailForTotalNoOfUnit.add(new QprInnovativeActivityDetails());  
  	  }
            
        for (int j = 0; j < innovativeReportDetailOfRestQuater.size(); j++) {
            if (count == size ) {
                count = 0;
            }
            for (int i = count; i < count + 1; i++) {
                if (detailForTotalNoOfUnit.get(i).getExpenditureIncurred() != null && innovativeReportDetailOfRestQuater.get(j).getExpenditureIncurred() != null) {
                    detailForTotalNoOfUnit.get(i)
                            .setExpenditureIncurred(detailForTotalNoOfUnit.get(i).getExpenditureIncurred()
                                    + innovativeReportDetailOfRestQuater.get(j).getExpenditureIncurred());
                } else if((detailForTotalNoOfUnit.get(i).getExpenditureIncurred() == null || detailForTotalNoOfUnit.get(i).getExpenditureIncurred() == 0 )&& innovativeReportDetailOfRestQuater.get(j).getExpenditureIncurred() == null) {
                	 detailForTotalNoOfUnit.get(i).setExpenditureIncurred(0);
                }else {
                	if(innovativeReportDetailOfRestQuater.get(j).getExpenditureIncurred() != null)
                    detailForTotalNoOfUnit.get(i).setExpenditureIncurred(innovativeReportDetailOfRestQuater.get(j).getExpenditureIncurred() + 0);
                }
            }
            ++count;
        }
        return detailForTotalNoOfUnit;
	}

	@RequestMapping(value = "innovativeActivityQpr", method = RequestMethod.POST)
    public String innovativeQtrProgressReport(@ModelAttribute("INNOVATIVE_ACTIVITY_QUATERLY_REPORT") QprInnovativeActivity qprInnovativeActivity,Model model ,RedirectAttributes re) {
    	if (!qprInnovativeActivity.getOrigin().equalsIgnoreCase("save")) {
            return qprGetFormInnovativeActivityQpr(qprInnovativeActivity, model);
        }
    	progressReportService.saveInnovative(qprInnovativeActivity);
        re.addFlashAttribute(Message.SUCCESS_KEY, Message.SAVE_SUCCESS);
        return REDIRECT_INNOVATIVE_PROGRESS_REPORT;
    }

    @RequestMapping(value = "adminDataFinQuaterlyGet", method = RequestMethod.GET)
    public String qprGetFormAdminDataFinQuaterly(@ModelAttribute("QPR_ADMIN_DATA_FIN") QprAdminAndFinancialDataActivity qprAdminAndFinancialDataActivity, Model model) {

        int quarterId = 0;
        if (qprAdminAndFinancialDataActivity.getShowQqrtrId() != null) {
            quarterId = qprAdminAndFinancialDataActivity.getShowQqrtrId();
        } else {
            quarterId = 0;
        }

        int installmentNo = (quarterId < 3) ? 1 : 2; // installment number for qtrId 1 & 2 = 1 and 3 & 4 = 2
        List<QuaterWiseFund> totalQuatorWiseFund = new ArrayList<>();
        List<AdminAndFinancialDataActivity> adminAndFinancialDataActivityApproved = adminAndFinancialDataCellService.fetchApprovedActivity();
        List<StateAllocation> stateAllocation = progressReportService.fetchStateAllocationData(8, installmentNo,progressReportService.getCurrentPlanCode());
        model.addAttribute("quarter_duration", progressReportService.getQuarterDurations());
        if (quarterId == 3 || quarterId == 4) {
            stateAllocation.add(progressReportService.fetchStateAllocationData(8, 1,progressReportService.getCurrentPlanCode()).get(0)); // total fund allocated in first quator
            totalQuatorWiseFund = progressReportService.fetchTotalQuaterWiseFundData(userPreference.getStateCode(), 8);
            double fund_used_in_one_two_qtr=calTotalFundUsedInQtr1And2(totalQuatorWiseFund);
            if(fund_used_in_one_two_qtr == 0) {
            	model.addAttribute("QTR_ID", 0);
				model.addAttribute("QTR_ONE_TWO_FILLED", false);
				return ADMIN_DATA_FIN_QUATERLY;
            }
            model.addAttribute("TOTAL_FUND_USED_IN_QTR_1_AND_2", fund_used_in_one_two_qtr);
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
                model.addAttribute("DISABLE_FREEZE", false);
            } else {
                if (qprAdminAndFinancialDataActivity.getQprAdminAndFinancialDataActivityDetails() != null) {
                    qprAdminAndFinancialDataActivity.getQprAdminAndFinancialDataActivityDetails().clear();
                }
                model.addAttribute("DISABLE_FREEZE", true);
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
            model.addAttribute("QTR_ONE_TWO_FILLED", true);
            if(quarterId !=0) 
				model.addAttribute("REMAINING_ADD_REQ", Integer.parseInt(progressReportService.getBalanceAdditionalReqiurment(8,quarterId)));
            return ADMIN_DATA_FIN_QUATERLY;
        } else {
            return NO_FUND_ALLOCATED_JSP;
        }
    }

    @RequestMapping(value = "adminDataFinQuaterlyGet", method = RequestMethod.POST)
    public String saveadminDataFinQuaterly(
            @ModelAttribute("QPR_ADMIN_DATA_FIN") QprAdminAndFinancialDataActivity qprAdminAndFinancialDataActivity,
            Model model, RedirectAttributes redirectAttributes) {
    	if (!qprAdminAndFinancialDataActivity.getOrigin().equalsIgnoreCase("save")) {
            return qprGetFormAdminDataFinQuaterly(qprAdminAndFinancialDataActivity, model);
        }
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
                if (deatilForTotalNoOfUnit.get(i).getNoOfUnitsFilled() != null && detailsBasedOnActIdAndQtrId.get(j).getNoOfUnitsFilled() != null) {
                    deatilForTotalNoOfUnit.get(i).setNoOfUnitsFilled(deatilForTotalNoOfUnit.get(i).getNoOfUnitsFilled()
                            + detailsBasedOnActIdAndQtrId.get(j).getNoOfUnitsFilled());
                }else if((deatilForTotalNoOfUnit.get(i).getNoOfUnitsFilled() == null  || deatilForTotalNoOfUnit.get(i).getNoOfUnitsFilled() ==  0 )&& detailsBasedOnActIdAndQtrId.get(j).getNoOfUnitsFilled() == null) {
                	 deatilForTotalNoOfUnit.get(i).setNoOfUnitsFilled(0);
                }else {
                	if(detailsBasedOnActIdAndQtrId.get(j).getNoOfUnitsFilled() != null)
                    deatilForTotalNoOfUnit.get(i).setNoOfUnitsFilled(0 + detailsBasedOnActIdAndQtrId.get(j).getNoOfUnitsFilled());
                }
                if (deatilForTotalNoOfUnit.get(i).getExpenditureIncurred() != null && detailsBasedOnActIdAndQtrId.get(j).getExpenditureIncurred() != null) {
                    deatilForTotalNoOfUnit.get(i)
                            .setExpenditureIncurred(deatilForTotalNoOfUnit.get(i).getExpenditureIncurred()
                                    + detailsBasedOnActIdAndQtrId.get(j).getExpenditureIncurred());
                } else if((deatilForTotalNoOfUnit.get(i).getExpenditureIncurred() == null || deatilForTotalNoOfUnit.get(i).getExpenditureIncurred() == 0 )&& detailsBasedOnActIdAndQtrId.get(j).getExpenditureIncurred() == null) {
                	 deatilForTotalNoOfUnit.get(i).setExpenditureIncurred(0);
                }else {
                	if(detailsBasedOnActIdAndQtrId.get(j).getExpenditureIncurred() != null)
                    deatilForTotalNoOfUnit.get(i).setExpenditureIncurred(detailsBasedOnActIdAndQtrId.get(j).getExpenditureIncurred() + 0);
                }
            }
            ++count;
        }
        return deatilForTotalNoOfUnit;
    }

    /* new method ends here */

    //@RequestMapping(value="institutionalInfraQuaterlyReport",method = RequestMethod.GET)
    public String getQprgGramPanchayat(
            @ModelAttribute("QPR_INSTITUTIONALINFRAQUATERLY") QprInstitutionalInfrastructure qprInstitutionalInfrastructure,
            Model model, RedirectAttributes redirectAttributes) {
        model.addAttribute("quarterDuration", progressReportService.getQuarterDurations());
        model.addAttribute("buildingType", institutionalInfraActivityPlanService.fetchTrainingInstituteTypeId());
        List<StateAllocation> stateAllocationList = planAllocationService.fetchStateAllocationListMaxINSTALLMENTNO();
        if (!(stateAllocationList != null && !stateAllocationList.isEmpty())) {
            redirectAttributes.addFlashAttribute("isPlanAllocationNotExist", Boolean.TRUE);
            return REDIRECT_PLAN_ALLOCATION;
        }
        model.addAttribute("stateAllocationList", stateAllocationList);

        return INSTITUTIONAL_INFRA_REPORT;
    }

    /*
     * @RequestMapping(value = "institutionalInfraQuaterlyReport", method =
     * RequestMethod.POST) private String
     * getQprgGramPanchayatActivity(@ModelAttribute(
     * "QPR_INSTITUTIONALINFRAQUATERLY") QprInstitutionalInfrastructure
     * qprInstitutionalInfrastructure , Model model) { int quatorId
     * =qprInstitutionalInfrastructure.getQuaterId(); int
     * institutionalInfraActivivtyId = 0; int instituteInfrsaHrActivityDetailsId =
     * 0; Integer TrainingInstituteTypeId=null; String workType=null; Integer
     * institutionalInfraActivivtyId
     * =qprInstitutionalInfrastructure.getInstitutionalInfraActivivtyId()
     * if(trainingInstituteTypeIddetails!=null &&
     * trainingInstituteTypeIddetails.length()>2 ) { String
     * trainingInstituteTypeId[]= trainingInstituteTypeIddetails.split(",");
     * TrainingInstituteTypeId=Integer.parseInt(trainingInstituteTypeId[0]);
     * workType=trainingInstituteTypeId[1]; } Set
     * <InstitutionalInfraProgressReportDTO> set =new HashSet<>();
     * List<InstitutionalInfraProgressReportDTO> institutionalInfraProgressReportDTO
     * =null;//institutionalInfraActivityPlanService.
     * fetchInstInfraStateDataForProgressReport(TrainingInstituteTypeId,workType);
     * Iterator itr= institutionalInfraProgressReportDTO.iterator();
     * while(itr.hasNext()) {
     *
     * InstitutionalInfraProgressReportDTO obj=(InstitutionalInfraProgressReportDTO)
     * itr.next();
     *
     * if(obj!=null) { set.add(obj);
     *
     * } institutionalInfraActivivtyId =obj.getInstitutionalInfraActivityId();
     * instituteInfrsaHrActivityDetailsId=obj.getInstitutionalInfraActivityDetailId(
     * ); }
     *
     * //List<InstInfraStatus> qprInstitutionalInfra =
     * institutionalInfraActivityPlanService.fetchInstInfraStatus(
     * TrainingInstituteTypeId); List<QprInstitutionalInfrastructure>
     * qprInstitutionalInfra=institutionalInfraActivityPlanService.
     * fetchDataAccordingToQuator(quatorId,institutionalInfraActivivtyId);
     *
     *
     * if(!qprInstitutionalInfra.isEmpty()) { for(int i=0
     * ;i<qprInstitutionalInfra.get(0).getQprInstitutionalInfraDetails().size()
     * ;i++) { if(TrainingInstituteTypeId== 2) { List<QprInstitutionalInfraDetails>
     * qprInstitutionalInfraDetailsForType2 =
     * institutionalInfraActivityPlanService.fetchDataOfDetailAccordingToQuator(
     * TrainingInstituteTypeId, qprInstitutionalInfra.get(0).getQprInstInfraId());
     * model.addAttribute("QPR_INSTITUTIONAL_INFRA_DETAILS",
     * qprInstitutionalInfraDetailsForType2);
     *
     * } else if(TrainingInstituteTypeId== 4) { List<QprInstitutionalInfraDetails>
     * qprInstitInfraDetailsForType4 =
     * institutionalInfraActivityPlanService.fetchDataOfDetailAccordingToQuator(
     * TrainingInstituteTypeId, qprInstitutionalInfra.get(0).getQprInstInfraId());
     *
     * model.addAttribute("QPR_INSTITUTIONAL_INFRA_DETAILS",
     * qprInstitInfraDetailsForType4); }
     *
     * } model.addAttribute("QPRPANCHAYATBHAWAN", qprInstitutionalInfra.get(0));
     *
     *
     * }
     * //Collections.sort(QprPanchayatBhawan.get(0).getQprPanhcayatBhawanDetails(),
     * Comparator.comparing(QprPanhcayatBhawanDetails::
     * getQprPanhcayatBhawanDetailsId));
     *
     * model.addAttribute("INSTITUTIONAL_INFRA_REPORT_DTO", set);
     * model.addAttribute("subcomponentwiseQuaterBalance",
     * progressReportService.fetchSubcomponentwiseQuaterBalance(15, quatorId));
     * //model.addAttribute("GPBhawanStatus",
     * panchayatBhawanService.fetchGPBhawanStatus(TrainingInstituteTypeId));
     * model.addAttribute("panchayatActivity",institutionalInfraActivityPlanService.
     * fetchTrainingInstituteTypeId());
     * model.addAttribute("buildingType",institutionalInfraActivityPlanService.
     * fetchTrainingInstituteTypeId()); model.addAttribute("InstInfraStatus",
     * institutionalInfraActivityPlanService.fetchInstInfraStatus(
     * TrainingInstituteTypeId));
     * model.addAttribute("institutionalInfraActivivtyId",
     * institutionalInfraActivivtyId);
     * model.addAttribute("instituteInfrsaHrActivityDetailsId",
     * instituteInfrsaHrActivityDetailsId);
     *
     * model.addAttribute("quarterDuration",
     * progressReportService.getQuarterDurations());
     * model.addAttribute("SetActivityId",
     * qprInstitutionalInfrastructure.getTrainingInstituteTypeId());
     *
     * model.addAttribute("SetQuaterId",
     * qprInstitutionalInfrastructure.getQuaterId());
     *
     * return INSTITUTIONAL_INFRA_REPORT; }
     */

    /*
     * @RequestMapping(value="saveQprInstitutionalInfrastructureData" ,
     * method=RequestMethod.POST) private String
     * saveQprInstInfraData(@ModelAttribute("QPR_INSTITUTIONALINFRAQUATERLY")
     * QprInstitutionalInfrastructure qprInstitutionalInfrastructure,Model model
     * ,RedirectAttributes redirectAttributes) throws IOException{
     *
     * for(int i=0;
     * i<qprInstitutionalInfrastructure.getQprInstitutionalInfraDetails().size();i++
     * ) {
     * if(qprInstitutionalInfrastructure.getQprInstitutionalInfraDetails().get(i).
     * getFile() != null &&
     * qprInstitutionalInfrastructure.getQprInstitutionalInfraDetails().get(i).
     * getFile().getSize()!=0) {
     *
     * MultipartFile file =
     * qprInstitutionalInfrastructure.getQprInstitutionalInfraDetails().get(i).
     * getFile();
     *
     * String filename = file.getOriginalFilename(); String filenameWithoutExtnsn =
     * FilenameUtils.removeExtension(filename); String extnsn =
     * FilenameUtils.getExtension(filename);
     *
     * AttachmentMaster attachmentMaster =
     * enhancementService.findDetailsofAttachmentMaster();
     *
     * String path = attachmentMaster.getFileLocation();
     *
     * if(file.isEmpty()) {
     * redirectAttributes.addFlashAttribute(Message.ERROR_KEY,"File Upload Required"
     * ); return REDIRECT_INSTITUTIONAL_INFRA_REPORT; } else
     * if(!file.getContentType().equals("application/pdf")) {
     * redirectAttributes.addFlashAttribute(Message.
     * ERROR_KEY,"File Upload Type Required(Pdf)"); return
     * REDIRECT_INSTITUTIONAL_INFRA_REPORT; } else if(file.getSize() > 2097152) {
     * redirectAttributes.addFlashAttribute(Message.ERROR_KEY,"Max File Size is 2MB"
     * ); return REDIRECT_INSTITUTIONAL_INFRA_REPORT; }
     *
     * Date date = new Date() ; SimpleDateFormat dateFormat = new
     * SimpleDateFormat("yyyyMMddHHmmss") ; String newFilename =
     * filenameWithoutExtnsn + "_" + dateFormat.format(date) + "." + extnsn;
     *
     * ......................File Delete code.................
     *
     * File deleteFile = new File(qprInstitutionalInfrastructure.getPath() + "/" +
     * qprInstitutionalInfrastructure.getDbFileName() ); if(deleteFile.exists()) {
     * deleteFile.delete(); } ......................File Delete
     * code.................
     *
     * byte[] bytes = file.getBytes(); File dir = new File(path + File.separator +
     * "qprInstitutionalInfrastructure");
     *
     * BufferedOutputStream stream = new BufferedOutputStream(new
     * FileOutputStream(dir+"/"+newFilename)); stream.write(bytes); stream.close();
     *
     *
     * qprInstitutionalInfrastructure.getQprInstitutionalInfraDetails().get(i).
     * setFileContentType(file.getContentType());
     * qprInstitutionalInfrastructure.getQprInstitutionalInfraDetails().get(i).
     * setFileLocation(path);
     * qprInstitutionalInfrastructure.getQprInstitutionalInfraDetails().get(i).
     * setFileName(newFilename);
     *
     * } } institutionalInfraActivityPlanService.saveQprInstInfraData(
     * qprInstitutionalInfrastructure);
     * redirectAttributes.addFlashAttribute(Message.SUCCESS_KEY,
     * Message.SAVE_SUCCESS);
     *
     *
     * return REDIRECT_INSTITUTIONAL_INFRA_REPORT; }
     */

    @RequestMapping(value = "institutionalInfraQuaterlyReport", method = RequestMethod.GET)
    private String institutionalInfraActivityPlanMOPR(
            @ModelAttribute("QPR_INSTITUTIONALINFRAQUATERLY") QprInstitutionalInfrastructure qprInstitutionalInfrastructure,
            Model model, RedirectAttributes redirectAttributes) {
        List<StateAllocation> stateAllocationList = planAllocationService.fetchStateAllocationListMaxINSTALLMENTNO();
        if (!(stateAllocationList != null && !stateAllocationList.isEmpty())) {
            redirectAttributes.addFlashAttribute("isPlanAllocationNotExist", Boolean.TRUE);
            return REDIRECT_PLAN_ALLOCATION;
        }
        model.addAttribute("quarterDuration", progressReportService.getQuarterDurations());
        return INSTITUTIONAL_INFRA_REPORT;
    }

    @RequestMapping(value = "fetchquarterDuration", method = RequestMethod.GET)
    private @ResponseBody
    Map<String, Object> fetchquarterDuration() {
        Map<String, Object> detailsMaps = new HashMap<>();
        detailsMaps.put("quarterDuration", progressReportService.getQuarterDurations());
        return detailsMaps;
    }

    @RequestMapping(value = "fetchDetailsForInstitutionalInfraProgressReport", method = RequestMethod.POST)
    private String fetchDetailsForInstitutionalInfraProgressReport(
            @ModelAttribute("QPR_INSTITUTIONALINFRAQUATERLY") QprInstitutionalInfrastructure qprInstitutionalInfrastructure,
            Model model) {
    	try{
    		Integer activityId = null;
        Integer additionalRequirement = null;
        Integer additionalRequirementDPRC = null;
        Integer quaterId = qprInstitutionalInfrastructure.getQtrId();
        List<InstitutionalInfraProgressReportDTO> institutionalInfraProgressReportDTOList = institutionalInfraActivityPlanService.fetchInstInfraStateDataForProgressReport();
        if (institutionalInfraProgressReportDTOList != null && !institutionalInfraProgressReportDTOList.isEmpty()) {
            activityId = institutionalInfraProgressReportDTOList.get(0).getInstitutionalInfraActivityId();
            additionalRequirement = institutionalInfraProgressReportDTOList.get(0).getAdditionalRequirement();
            additionalRequirementDPRC = institutionalInfraProgressReportDTOList.get(0).getAdditionalRequirementDprc();
            List<QprInstitutionalInfrastructure> qprInstitutionalInfrastructureList = institutionalInfraActivityPlanService.fetchDataAccordingToQuator(quaterId, activityId);

            if (qprInstitutionalInfrastructureList != null && !qprInstitutionalInfrastructureList.isEmpty()) {
                qprInstitutionalInfrastructure = qprInstitutionalInfrastructureList.get(0);
                model.addAttribute("DISABLE_FREEZE", false);
            } else {
                qprInstitutionalInfrastructure = new QprInstitutionalInfrastructure();
                qprInstitutionalInfrastructure.setQtrId(quaterId);
                model.addAttribute("DISABLE_FREEZE", true);
            }
            qprInstitutionalInfrastructure.setInstitutionalInfraActivivtyId(activityId);
            model.addAttribute("additionalRequirement", additionalRequirement);
            model.addAttribute("additionalRequirementDPRC", additionalRequirementDPRC);
            model.addAttribute("quarterDuration", progressReportService.getQuarterDurations());
            model.addAttribute("instInfraStateDataForProgressReport", institutionalInfraProgressReportDTOList);
            model.addAttribute("InstInfraStatus", institutionalInfraActivityPlanService.fetchALLInstInfraStatus());
            model.addAttribute("quaterIdExist", Boolean.TRUE);
            model.addAttribute("QPR_INSTITUTIONALINFRAQUATERLY", qprInstitutionalInfrastructure);
            List<SubcomponentwiseQuaterBalance> subcomponentwiseQuaterBalanceList = progressReportService.fetchSubcomponentwiseQuaterBalance(2, quaterId);
            if (subcomponentwiseQuaterBalanceList != null && !subcomponentwiseQuaterBalanceList.isEmpty()) {
                model.addAttribute("subcomponentwiseQuaterBalanceList", subcomponentwiseQuaterBalanceList);
                model.addAttribute("installementExist", Boolean.TRUE);
                String addReqirmentDetails=progressReportService.getBalanceAdditionalReqiurment(2, quaterId);
                if(addReqirmentDetails!=null && addReqirmentDetails.indexOf(",")>0) {
                	String addReqirmentArr[]=addReqirmentDetails.split(",");
                	 model.addAttribute("balAddiReqSPRC", Integer.parseInt(addReqirmentArr[0]));
                	 model.addAttribute("balAddiReqDPRC", Integer.parseInt(addReqirmentArr[1]));
                	 model.addAttribute("installementExist", Boolean.TRUE);
                }
            } else {
                model.addAttribute("isError", "Please fill progress report of quater 1 and 2.");
                model.addAttribute("installementExist", Boolean.FALSE);
            }
        } else {
            model.addAttribute("isError", "Data not Found");
        }
    } catch(Exception e)
 	{
		e.printStackTrace();
 	}

        return INSTITUTIONAL_INFRA_REPORT;
    }

    @RequestMapping(value = "saveInstitutionalInfraProgressReport", method = RequestMethod.POST)
    private String saveInstitutionalInfraProgressReport(
            @ModelAttribute("QPR_INSTITUTIONALINFRAQUATERLY") QprInstitutionalInfrastructure qprInstitutionalInfrastructure,
            Model model, RedirectAttributes redirectAttributes) {
        progressReportService.saveInstitutionalInfraProgressReport(qprInstitutionalInfrastructure);
        redirectAttributes.addAttribute("isError", "Data save successfully");
        return INSTITUTIONAL_INFRA_REPORT_LOAD;
    }

    @RequestMapping(value = "downloadFileNew", method = RequestMethod.GET)
    private void downloadFileNew(Integer fileNodeId, HttpServletResponse response) {
      try { 
    	FileNode fileNode = progressReportService.getUploadedFile(fileNodeId);
        if (fileNode == null)
            throw new RuntimeException("No file exists in databse.");
        FileNodeUtils.streamFileNode(fileNode, response);
		} catch (Exception e) {
			e.printStackTrace();
		}
    }
    
   // @RequestMapping(value = "trainingProgressReport", method = RequestMethod.GET)
    public String qprGetFormTrainingProgressReport(
            @ModelAttribute("TRAINING_DETAILS") TrainingProgressReport progressReportJsp, Model model) {
    	try {
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
            } else {
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
        
    } catch(Exception e)
 	{
		e.printStackTrace();
 	}
        return TRAINING_PROGRESS_REPORT;
    }

    @RequestMapping(value = "trainingProgressRptQtr", method = RequestMethod.POST)
    public String trainingProgressReportByQtr(
            @ModelAttribute("TRAINING_DETAILS") TrainingProgressReport progressReportJsp, Model model) {
       
    	try{/*
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
            } else {
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
        } catch(Exception e)
     	{
    		e.printStackTrace();
     	}
        return TRAINING_PROGRESS_REPORT;
    }

    @RequestMapping(value = "trainingProgressReport", method = RequestMethod.GET)
    public String trainingProgressReport(@ModelAttribute("QPR_TRAINING_DETAILS") QuarterTrainings quarterTrainings, Model model, RedirectAttributes redirectAttributes) {
    	try {
    	List<StateAllocation> stateAllocationList = planAllocationService.fetchStateAllocationListMaxINSTALLMENTNO();
         if (!(stateAllocationList != null && !stateAllocationList.isEmpty())) {
             redirectAttributes.addFlashAttribute("isPlanAllocationNotExist", Boolean.TRUE);
             return REDIRECT_PLAN_ALLOCATION;
         }
         model.addAttribute("quarterDuration", progressReportService.getQuarterDurations());
    	} catch(Exception e)
     	{
    		e.printStackTrace();
     	}
    	return TRAINING_DETAILS_PROGRESS_REPORT;
    }
    
    
    @SuppressWarnings("unchecked")
	@RequestMapping(value = "trainingProgressReportGETData",method = { RequestMethod.GET, RequestMethod.POST })
    public String trainingProgressReportGETData(@ModelAttribute("QPR_TRAINING_DETAILS") QuarterTrainings quarterTrainings, Model model, RedirectAttributes redirectAttributes) {
    	try {
    	Integer qtrId=quarterTrainings.getQtrId();
    	
    	Map<String,Object> data =progressReportService.fetchTrainingDetailsCEC(qtrId);
    	model.addAttribute("fetchTrainingCEC",data.get("fetchTrainingCEC"));
    	model.addAttribute("fetchTrainingDetailsListCEC",data.get("fetchTrainingDetailsListCEC"));
    	model.addAttribute("TARGET_GROUP_MASTER", trainingActivityService.targetGroupMastersList());
    	List<TargetGroupMaster> list=trainingActivityService.targetGroupMastersList();
    	System.out.println(list.size());
    	Map<Object,Object> map=new LinkedHashMap();
    	for(TargetGroupMaster obj: list) {
    		map.put(obj.getTargetGroupMasterId(),obj.getTargetGroupMasterName());
    		//alist.add(jsObj); 
    	}
    	JSONObject jsObj = new JSONObject(map);
    	model.addAttribute("test", jsObj);
    	List<QuarterTrainings> quarterTrainingsList=(List<QuarterTrainings>)data.get("quarterTrainings");
    	if(quarterTrainingsList!=null && !quarterTrainingsList.isEmpty()) {
    		quarterTrainings=quarterTrainingsList.get(0);
    		List<QuarterTrainingsDetails> details = new ArrayList<QuarterTrainingsDetails>();
    		details=quarterTrainings.getQuarterTrainingsDetailsList();
    		for(QuarterTrainingsDetails detail : details) {
    			if(CollectionUtils.isNotEmpty(detail.getQprTrainingBreakup())) {
    				int total_participants=0;
    				List<QprTrainingBreakup> trainingBreakUpList=detail.getQprTrainingBreakup();
    				for(QprTrainingBreakup breakUp : trainingBreakUpList) {
    					if(breakUp.getScMales() != null) {
    						total_participants += breakUp.getScMales();
    					}
    					if(breakUp.getScFemales() != null) {
    						total_participants += breakUp.getScFemales();
    					}
    					if(breakUp.getStMales() != null) {
    						total_participants += breakUp.getStMales();
    					}
    					if(breakUp.getStFemales() != null) {
    						total_participants += breakUp.getStFemales();
    					}
    					if(breakUp.getOthersMales() != null) {
    						total_participants += breakUp.getOthersMales();
    					}
    					if(breakUp.getOthersFemales() != null) {
    						total_participants += breakUp.getOthersFemales();
    					}
    				}
    				detail.setTotalParticipantsEnter(total_participants);
    			}
    		}
    		model.addAttribute("DISABLE_FREEZE", false);
    	}else {
    		 quarterTrainings=new QuarterTrainings();
    		 quarterTrainings.setQtrId(qtrId);
    		 model.addAttribute("DISABLE_FREEZE", true);
    	}
    	model.addAttribute("quarterDuration", progressReportService.getQuarterDurations());
    	
    	  List<SubcomponentwiseQuaterBalance> subcomponentwiseQuaterBalanceList = progressReportService.fetchSubcomponentwiseQuaterBalance(1, qtrId);
          if (subcomponentwiseQuaterBalanceList != null && !subcomponentwiseQuaterBalanceList.isEmpty()) {
              model.addAttribute("subcomponentwiseQuaterBalanceList", subcomponentwiseQuaterBalanceList);
              model.addAttribute("installementExist", Boolean.TRUE);
              String addReqirmentDetails=progressReportService.getBalanceAdditionalReqiurment(1, qtrId);
              if(addReqirmentDetails!=null && addReqirmentDetails.length()>0) {
              	 model.addAttribute("balAddiReq", Integer.parseInt(addReqirmentDetails));
              	}
          } else {
              model.addAttribute("isError", "2nd installement not released");
              model.addAttribute("installementExist", Boolean.FALSE);
          }
          model.addAttribute("QPR_TRAINING_DETAILS", quarterTrainings);
        
    }catch(Exception e)
    	{
    	e.printStackTrace();
    	}
    	 return TRAINING_DETAILS_PROGRESS_REPORT;
    }
    
	/*
	 * @ResponseBody
	 * 
	 * @PostMapping(value = "fetchTrainingBreakUpData", produces =
	 * MediaType.APPLICATION_JSON_VALUE) public Map<String, Object>
	 * fetchTrainingBreakUpData(
	 * 
	 * @RequestParam(value = "detailId", required = false) Integer detailId) {
	 * Map<String, Object> result = new HashMap<String, Object>(); try {
	 * System.out.println("In Java side function fetch training breakup data.");
	 * List<QprTrainingBreakup> breakUpList = new ArrayList<QprTrainingBreakup>();
	 * breakUpList = progressReportService.fetchTrainingBreakUpData(detailId);
	 * result.put("breakUpData", breakUpList); } catch (Exception ex) {
	 * ex.printStackTrace(); } return result; }
	 */
 
	@ResponseBody
	@RequestMapping(value = "trainingBreakUpData", method = RequestMethod.POST, produces = MediaType.APPLICATION_JSON_VALUE, consumes = MediaType.APPLICATION_JSON_VALUE)
	public Map<String, Object> fetchTrainingBreakUpData(
			@RequestParam(value = "detailId", required = false) Integer detailId) {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			//System.out.println("In Java side function fetch training breakup data.");
			List<QprTrainingBreakup> breakUpList = new ArrayList<QprTrainingBreakup>();
			breakUpList = progressReportService.fetchTrainingBreakUpData(detailId);
			result.put("breakUpData", breakUpList);
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		return result;
	}
    
    
    
    @RequestMapping(value = "savetrainingProgressReport", method = RequestMethod.POST)
    public String savetrainingProgressReport(@ModelAttribute("QPR_TRAINING_DETAILS") QuarterTrainings quarterTrainings, Model model, RedirectAttributes redirectAttributes) {
		try {
			if (quarterTrainings.getMsg().equalsIgnoreCase("modalSave")) {
				progressReportService.savetrainingBreakUpData(quarterTrainings);
			} else {
				progressReportService.savetrainingProgressReport(quarterTrainings);
			}
			redirectAttributes.addAttribute("isError", "Data save successfully");
			redirectAttributes.addAttribute("qtrId", quarterTrainings.getQtrId());
			} catch (Exception e) {
				e.printStackTrace();
			}
         return REDIRECT_TRAINING_DETAILS_PROGRESS_REPORT;
    }
    
    @PostMapping(value="freezeAndUnfreezeReport")
    public String freezeAndUnfreezeReport(@RequestParam(name = "componentId") Integer componentId,@RequestParam(name = "qprActivityId") Integer qprActivityId
    		,@RequestParam(name = "quaterId") Integer quaterId,@RequestParam(name = "msg") String msg,Model model, RedirectAttributes redirectAttributes) {
    	// this function will take 3 input as arguments 
    	// 1. component_id
    	// 2. activity_id
    	// 3. quater_id
    	// 4. msg
    	Boolean isFreeze =false;
    	 
    	if(msg.contains(",")) // for sometime msg contains comma 
    	{
    		isFreeze= msg.equalsIgnoreCase(",freeze")? true : false;	
    	}else {
    		isFreeze= msg.equalsIgnoreCase("freeze")? true : false;
    	}
    	
    		String view = null;
    		try {
    	switch (componentId) {
    	case 1 :
    		progressReportService.freezeAndUnfreezeReport(QuarterTrainings.class, qprActivityId, isFreeze);
    		//view = trainingProgressReport(new QuarterTrainings(),model,redirectAttributes);
    		view=REDIRECT_TRAINING_PROGRESS_REPORT;
			break;
		case 2 :
			progressReportService.freezeAndUnfreezeReport(QprInstitutionalInfrastructure.class, qprActivityId, isFreeze);
			view =REDIRECT_INSTITUTIONAL_INFRA_REPORT;	
			break;
		case 3 : 
			progressReportService.freezeAndUnfreezeReport(QprPanchayatBhawan.class, qprActivityId, isFreeze);
			view = "redirect:panchayatBhawanQuaterlyReport.html";
			break;
		case 4 :
			progressReportService.freezeAndUnfreezeReport(AdministrativeTechnicalProgress.class, qprActivityId, isFreeze);
			view = REDIRECT_ADMIN_QUADERLY;
			break;
		case 5 :
			progressReportService.freezeAndUnfreezeReport(QprEnablement.class, qprActivityId, isFreeze);
			view = REDIRECT_ENABLEMENT_PROGRESS_REPORT;
			break;
		case 7 :
			progressReportService.freezeAndUnfreezeReport(SatcomActivityProgress.class, qprActivityId, isFreeze);
			view = REDIRECT_CURRENT_SATCOM_QUATERLY;
			break;
		case 8 :
			progressReportService.freezeAndUnfreezeReport(QprAdminAndFinancialDataActivity.class, qprActivityId, isFreeze);
			view = REDIRECT_ADMIN_DATA_FIN_QUATERLY;
			break;
		case 9 :
			progressReportService.freezeAndUnfreezeReport(QprInnovativeActivity.class, qprActivityId, isFreeze);
			view = REDIRECT_INNOVATIVE_PROGRESS_REPORT;
			break;
		case 10 :
			progressReportService.freezeAndUnfreezeReport(QprIncomeEnhancement.class, qprActivityId, isFreeze);
			view = REDIRECT_INCOMEENHANCEMENT_QUATERLY;
			break;
		case 11 :
			progressReportService.freezeAndUnfreezeReport(IecQuater.class, qprActivityId, isFreeze);
			IecQuater iecQuater=new IecQuater();
			iecQuater.setQtrId(quaterId);
			view = qprGetFormIecQtrProgressReport1(iecQuater, model);
			break;
		case 12 :
			progressReportService.freezeAndUnfreezeReport(PmuProgress.class, qprActivityId, isFreeze);
			view = REDIRECT_TRAINING_PROGRESS_PMU;
			break;	
		case 13 :
			progressReportService.freezeAndUnfreezeReport(QprCbActivity.class, qprActivityId, isFreeze);
			view = "redirect:qprCapacityBuilding.html";
			break;
		case 14 :
			progressReportService.freezeAndUnfreezeReport(AdditionalFacultyProgress.class, qprActivityId, isFreeze);
			view = REDIRECT_ADDITIONAL_QUADERLY;
			break;
    	}
    	
    	if(isFreeze) {
			redirectAttributes.addFlashAttribute(Message.SUCCESS_KEY, Message.FRIZEE_SUCESS);
		}else {
			redirectAttributes.addFlashAttribute(Message.SUCCESS_KEY, "Unfreeze successfully");
		}
    		}catch(Exception e) {e.printStackTrace();}
    	return view;
    }
}
