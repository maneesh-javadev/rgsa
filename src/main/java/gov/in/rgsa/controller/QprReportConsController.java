package gov.in.rgsa.controller;

import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpRequest;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import gov.in.rgsa.dao.CommonRepository;
import gov.in.rgsa.entity.CapacityBuildingActivity;
import gov.in.rgsa.entity.QprPlanFunds;
import gov.in.rgsa.entity.State;
import gov.in.rgsa.model.QprReportConsModel;
import gov.in.rgsa.service.CommonService;
import gov.in.rgsa.service.QprReportConService;
import gov.in.rgsa.user.preference.UserPreference;

@Controller
public class QprReportConsController {

    private static String VIEW_PAGE= "qprReportConsolidated";
    private static String VIEW_QPR_REPORT= "viewQprReportPage";
    private static String VIEW_QPR_REPORT_PUBLIC= "viewQprReportPublic";
    private static String VIEW_QPR_REPORT_WITHOUT_QUARTER= "viewQprReportPageWithoutQuarter";  
    
    private static String VIEW_QPR_REPORT_PUBLIC_YEAR_WISE= "viewQprReportPublicYearWise"; 
    

    
    @Autowired
    private UserPreference userPreference;
    @Autowired
    private CommonRepository commonRepository;
    @Autowired
    private CommonService commonService;
   
    @Autowired
    QprReportConService qprReportConService;

//    public QprReportConsController(UserPreference userPreference,
//                                   CommonRepository commonRepository,
//                                   CommonService commonService){
//        this.userPreference = userPreference;
//        this.commonRepository = commonRepository;
//        this.commonService = commonService;
//    }

    @GetMapping(value = "qprConsolidatedReport")
    public String getQprConsReport(Model model){
        QprReportConsModel qprReportConsModel = getBasicModel(null, null, null);
        model.addAttribute("command", qprReportConsModel);
        model.addAttribute("userPreference", userPreference);
        return VIEW_PAGE;
    }

    @PostMapping("qprConsolidatedReport")
    public String viewQprReportState(@ModelAttribute("command")QprReportConsModel qprReportConsModel, Model model){
        qprReportConsModel = getBasicModel(qprReportConsModel,
                userPreference.isMOPR() ? qprReportConsModel.getStateCode() : userPreference.getStateCode(),
                qprReportConsModel.getYearId());
        model.addAttribute("command", qprReportConsModel);
        model.addAttribute("userPreference", userPreference);
        return VIEW_PAGE;
    }

    private QprReportConsModel getBasicModel(QprReportConsModel qprReportConsModel, Integer stateCode, Integer yearId) {
        if (qprReportConsModel == null)
            qprReportConsModel = new QprReportConsModel();
        boolean hasYear = !(yearId == null || yearId == 0) ;
        boolean hasState = !(stateCode == null || stateCode == 0) ;

        Integer chosenYearId = hasYear? yearId : commonService.findActiveFinYear().getYearId() ;

        qprReportConsModel.setYearId(chosenYearId);

        qprReportConsModel.setYearMap(commonService.getYearMap());
        qprReportConsModel.setStateMap(getStateMap(chosenYearId));

        if(hasState) {
            List<QprPlanFunds> qprPlanFundsList = getWithTotal(getQprPlanFunds(chosenYearId, stateCode));
            qprReportConsModel.setStateCode(stateCode);
            qprReportConsModel.setQprPlanFundsList(qprPlanFundsList);
        }

        return qprReportConsModel;

    }

    private Map<Integer, String> getStateMap(Integer yearId) {
        Map<Integer, String> stateMap = new HashMap<>();

        stateMap.put(0, " --- Select --- ");
        for (State state : commonService.getStateListApprovedByCEC(yearId)) {
            stateMap.put(state.getStateCode(), state.getStateNameEnglish());
        }
        return stateMap;
    }

    private List<QprPlanFunds> getQprPlanFunds(Integer yearId, Integer stateCode){
        Map<String, Object> conditionMap = new HashMap<>(2);
        conditionMap.put("yearId", yearId);
        conditionMap.put("stateCode", stateCode);
        return commonRepository.findAllByCondition(QprPlanFunds.class, conditionMap);
    }

    private List<QprPlanFunds> getWithTotal(List<QprPlanFunds> qprPlanFundsList) {
        QprPlanFunds qprPlanFunds = new QprPlanFunds();
        qprPlanFunds.setQtr1Expenditure(0.0);
        qprPlanFunds.setQtr2Expenditure(0.0);
        qprPlanFunds.setQtr3Expenditure(0.0);
        qprPlanFunds.setQtr4Expenditure(0.0);
        qprPlanFunds.setQtr1AdditionalFund(0.0);
        qprPlanFunds.setQtr2AdditionalFund(0.0);
        qprPlanFunds.setQtr3AdditionalFund(0.0);
        qprPlanFunds.setQtr4AdditionalFund(0.0);
        qprPlanFunds.setPlanComponentName("Total");
        for (QprPlanFunds qprPlanFundsSingle: qprPlanFundsList){
            qprPlanFunds.setQtr1Expenditure(qprPlanFunds.getQtr1Expenditure() + qprPlanFundsSingle.getQtr1Expenditure());
            qprPlanFunds.setQtr2Expenditure(qprPlanFunds.getQtr2Expenditure() + qprPlanFundsSingle.getQtr2Expenditure());
            qprPlanFunds.setQtr3Expenditure(qprPlanFunds.getQtr3Expenditure() + qprPlanFundsSingle.getQtr3Expenditure());
            qprPlanFunds.setQtr4Expenditure(qprPlanFunds.getQtr4Expenditure() + qprPlanFundsSingle.getQtr4Expenditure());
            qprPlanFunds.setQtr1AdditionalFund(qprPlanFunds.getQtr1AdditionalFund() + qprPlanFundsSingle.getQtr1AdditionalFund());
            qprPlanFunds.setQtr2AdditionalFund(qprPlanFunds.getQtr2AdditionalFund() + qprPlanFundsSingle.getQtr2AdditionalFund());
            qprPlanFunds.setQtr3AdditionalFund(qprPlanFunds.getQtr3AdditionalFund() + qprPlanFundsSingle.getQtr3AdditionalFund());
            qprPlanFunds.setQtr4AdditionalFund(qprPlanFunds.getQtr4AdditionalFund() + qprPlanFundsSingle.getQtr4AdditionalFund());
        }
        qprPlanFundsList.add(qprPlanFunds);
        return qprPlanFundsList;
    }
    
    
    // fetch all Qpr report for all level
    @GetMapping(value = "qprReportInstallmentWise")
    private String fetchAllQprreport(  Model model) {
    	try {
    		model.addAttribute("FIN_YEAR_LIST", qprReportConService.fetchFinYearList());
    		model.addAttribute("STATE", qprReportConService.fetchStateList());
    		model.addAttribute("QUARTER", qprReportConService.fetchQuarterList());
    		model.addAttribute("userType",userPreference.getUserType());
    		}catch(Exception e) {
    			e.printStackTrace();
    		}
    	return VIEW_QPR_REPORT;
    }
    
    // fetch all Qpr report for public domain
    @GetMapping(value = "qprReportInstallmentWiseForPublic")
    private String fetchAllQprreportForPublic(  Model model) {
    	try {
    		model.addAttribute("FIN_YEAR_LIST", qprReportConService.fetchFinYearList());
    		model.addAttribute("STATE", qprReportConService.fetchStateList());
    		model.addAttribute("QUARTER", qprReportConService.fetchQuarterList());
    		}catch(Exception e) {
    			e.printStackTrace();
    		}
    	return VIEW_QPR_REPORT_PUBLIC;
    } 
    
    
 
    
    
    
    
    
    
    
    
    @PostMapping(value = "qprReportDetails")
    @ResponseBody
    public Map<Object,List> fetchAllQprreportDetails( HttpServletRequest  request  ) {
    	Map<Object,List> dataMap=new LinkedHashMap<Object, List>();
    	try {
    	 	String stateCodeStr=request.getParameter("statecode");
    	 	Integer stateCode=null;
    	 	if(stateCodeStr!=null) {
    	 		stateCode=Integer.parseInt(stateCodeStr);
    	 	}
    	 	
    	 	stateCode=stateCode!=null && stateCode>0?stateCode:userPreference.getStateCode();
    	 	String statecode=String.valueOf(stateCode);
        	String yearId=request.getParameter("yearId");
        	String UserType="C";
        	String quarterId=request.getParameter("quarterId");
        	
        	if(statecode!=null && yearId!=null && quarterId!=null ) {
		    	dataMap.put("Training_Activities_Progress_Report", qprReportConService.fetchTrainingActivityList(statecode,yearId, UserType,quarterId));
		    	dataMap.put("Training_Details_Progress_Report", qprReportConService.fetchQprTrainingDetails(statecode,yearId, UserType,quarterId)) ;
		    	dataMap.put("Additional_Faculty_Maintenance_SPRC_DPRC",  qprReportConService.fetchQprHRsupportSprcDprc(statecode,yearId, UserType,quarterId));
		    	dataMap.put("e_Governance_Support_Group",  qprReportConService.fetchQprEgovProgressReport(statecode,yearId, UserType,quarterId));
		    	dataMap.put("EenablementProgressReportId",  qprReportConService.fetchQprEenablementProgressReport(statecode,yearId, UserType,quarterId));
		    	dataMap.put("pesa_Plan",  qprReportConService.fetchQprPesaReport(statecode,yearId, UserType,quarterId));
		     	dataMap.put("IncomeEnhancementId",  qprReportConService.fetchQprIncomeEnhancement(statecode,yearId, UserType,quarterId));
		    	dataMap.put("iecProgressReport",  qprReportConService.fetchQprIEC(statecode,yearId, UserType,quarterId));
		    	dataMap.put("pmuProgressReport",  qprReportConService.fetchQprPMU(statecode,yearId, UserType,quarterId));
		    	dataMap.put("administrativeAndTechnicalSupportId",  qprReportConService.fetchQprAdministrativeAndTechnicalSupport(statecode,yearId, UserType,quarterId));
		      	dataMap.put("panchyatbhawanProgressReport",  qprReportConService.fetchQprPanchayatBhawan(statecode,yearId, UserType,quarterId));
		    	dataMap.put("SATCOMIP",  qprReportConService.fetchQprSATCOM(statecode,yearId, UserType,quarterId));
		    	dataMap.put("InstitutionalInfrastructureId",  qprReportConService.fetchQprInstitutionalInfrastructure(statecode,yearId, UserType,quarterId));
		    	dataMap.put("InnovativeActiveId",  qprReportConService.fetchQprInnovativeActive(statecode,yearId, UserType,quarterId));
		    	dataMap.put("adminFinancialId",  qprReportConService.fetchQpradminFinancial(statecode,yearId, UserType,quarterId));
        	}
    		}catch(Exception e) {
    			e.printStackTrace();
    		}
    	 
    	 
    	return dataMap;
    }
    
 // fetch all Qpr report without quarter for all level
    @GetMapping(value = "qprReportWithoutQuarter")
    private String fetchAllQprreportWithoutQuarter(  Model model) {
    	try {
    		model.addAttribute("FIN_YEAR_LIST", qprReportConService.fetchTwoFinYear());
    		model.addAttribute("STATE", qprReportConService.fetchStateList());
    		}catch(Exception e) {
    			e.printStackTrace();
    		}
    	return VIEW_QPR_REPORT_WITHOUT_QUARTER;
    }
    
    
    // fetch all Qpr report for public domain
    @GetMapping(value = "qprReportYearWiseForPublic")
    private String fetchAllQprreportForPublicYearWise(Model model) {
    	try {
    		model.addAttribute("FIN_YEAR_LIST", qprReportConService.fetchFinYearList());
    		model.addAttribute("STATE", qprReportConService.fetchStateList());
    		model.addAttribute("QUARTER", qprReportConService.fetchQuarterList());
    		}catch(Exception e) {
    			e.printStackTrace();
    		}
    	return VIEW_QPR_REPORT_PUBLIC_YEAR_WISE;
    } 
    
    
    @PostMapping(value="qprReportDetailsYearWise")
    @ResponseBody
    public Map<Object,List> fetchAllQprreportDetailsYearWise( HttpServletRequest  request  ) {
    	Map<Object,List> dataMap=new LinkedHashMap<Object, List>();
    	try {
    	 	String stateCodeStr=request.getParameter("statecode");
    	 	Integer stateCode=null;
    	 	if(stateCodeStr!=null) {
    	 		stateCode=Integer.parseInt(stateCodeStr);
    	 	}
    	 	
    	 	stateCode=stateCode!=null && stateCode>0?stateCode:userPreference.getStateCode();
    	 	String statecode=String.valueOf(stateCode);
        	String yearId=request.getParameter("yearId");
        	String UserType="C";
        	String quarterId=request.getParameter("quarterId");
        	
        	if(statecode!=null && yearId!=null && quarterId!=null ) {
                dataMap.put("Training_Activities_Progress_Report_Year_Wise_New",qprReportConService.fetchTrainingActivityListYearWiseNew(statecode,yearId, UserType,quarterId));
		        dataMap.put("Training_Details_Progress_Report_Year_Wise_New", qprReportConService.fetchQprTrainingDetailsYearWiseNew(statecode,yearId, UserType,quarterId)) ;
		    	dataMap.put("Additional_Faculty_Maintenance_SPRC_DPRC_Year_Wise_New",  qprReportConService.fetchQprHRsupportSprcDprcYearWiseNew(statecode,yearId, UserType,quarterId));
		    	dataMap.put("e_Governance_Support_Group_Year_Wise_New",  qprReportConService.fetchQprEgovProgressReportYearWiseNew(statecode,yearId, UserType,quarterId));
		    	dataMap.put("EenablementProgressReportIdYearWiseNew",  qprReportConService.fetchQprEenablementProgressReportYearWiseNew(statecode,yearId, UserType,quarterId));
		    	dataMap.put("pesa_Plan_Year_Wise_New",  qprReportConService.fetchQprPesaReportYearWiseNew(statecode,yearId, UserType,quarterId));
		     	dataMap.put("IncomeEnhancementIdYearWiseNew",  qprReportConService.fetchQprIncomeEnhancementYearWiseNew(statecode,yearId, UserType,quarterId));
		    	dataMap.put("iecProgressReportYearWiseNew",  qprReportConService.fetchQprIECYearWiseNew(statecode,yearId, UserType,quarterId));
		    	dataMap.put("pmuProgressReportYearWiseNew",  qprReportConService.fetchQprPMUYearWiseNew(statecode,yearId, UserType,quarterId));
		    	dataMap.put("administrativeAndTechnicalSupportIdYearWiseNew",  qprReportConService.fetchQprAdministrativeAndTechnicalSupportYearWiseNew(statecode,yearId, UserType,quarterId));
		      	dataMap.put("panchyatbhawanProgressReportYearWiseNew",  qprReportConService.fetchQprPanchayatBhawanYearWiseNew(statecode,yearId, UserType,quarterId));
		    	dataMap.put("SATCOMIPYEARWISENEW",  qprReportConService.fetchQprSATCOMYearWiseNew(statecode,yearId, UserType,quarterId));
		    	dataMap.put("InstitutionalInfrastructureIdYearWiseNew",  qprReportConService.fetchQprInstitutionalInfrastructureYearWiseNew(statecode,yearId, UserType,quarterId));
		    	dataMap.put("InnovativeActiveIdYearWiseNew",  qprReportConService.fetchQprInnovativeActiveYearWiseNew(statecode,yearId, UserType,quarterId));
		    	dataMap.put("adminFinancialIdYearWiseNew",  qprReportConService.fetchQpradminFinancialYearWiseNew(statecode,yearId, UserType,quarterId));
        	
        	
		    	/*Institutional Infrastructure
		    	A dministrative and Technical Activity
		    	E-enablement
		    	P ESA Plan
		    	Distance Learning Facility through SATCOM/IP
		    	Administrative and Financial Data Analysis and Planning Cell*/

        	
        	
        	
        	}
    		}catch(Exception e) {
    			e.printStackTrace();
    		}
    	 
    	 
    	return dataMap;
    }
    
    
}
