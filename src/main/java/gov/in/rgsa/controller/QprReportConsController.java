package gov.in.rgsa.controller;

import gov.in.rgsa.dao.CommonRepository;
import gov.in.rgsa.entity.FinYear;
import gov.in.rgsa.entity.QprPlanFunds;
import gov.in.rgsa.entity.State;
import gov.in.rgsa.model.QprReportConsModel;
import gov.in.rgsa.service.CommonService;
import gov.in.rgsa.user.preference.UserPreference;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class QprReportConsController {

    private static String VIEW_PAGE= "qprReportConsolidated";

    @Autowired
    private UserPreference userPreference;
    @Autowired
    private CommonRepository commonRepository;
    @Autowired
    private CommonService commonService;

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

}
