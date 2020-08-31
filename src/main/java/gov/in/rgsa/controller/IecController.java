package gov.in.rgsa.controller;



import gov.in.rgsa.entity.IecActivity;
import gov.in.rgsa.entity.IecActivityDetails;
import gov.in.rgsa.entity.Users;
import gov.in.rgsa.model.IecFormModel;
import gov.in.rgsa.service.BasicInfoService;
import gov.in.rgsa.service.IecService;
import gov.in.rgsa.user.preference.UserPreference;
import gov.in.rgsa.utils.Message;
import gov.in.rgsa.utils.PlanUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletRequest;

import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@Controller
public class IecController {

    private static final String IEC = "iec",
            REDIRECT_IEC_ACTIVITY = "redirect:iec.html",
            IEC_CEC = "iecCEC",
            REDIRECT_BASIC_INFO_DETAILS = "redirect:basicinfo.add.html",
            REDIRECT_MODIFY_BASIC_INFO_DETAILS = "redirect:managebasicInfoDetails.html";

    @Autowired
    private IecService iecService;

    @Autowired
    BasicInfoService basicInfoService;

    @Autowired
    private UserPreference userPreference;
@CrossOrigin(origins ="http://localhost:9090/rgsa")
    @RequestMapping(value = "iec", method = RequestMethod.GET)
    private String IecGet(@ModelAttribute("IEC_ACTIVITY") IecFormModel iecFormModel, Model model, HttpServletRequest request, @RequestParam(value = "iecId", required = false) Integer iecId, RedirectAttributes redirectAttributes) {

        PlanUtil planUtil = userPreference.getPlanStatusEnum();
        boolean flag = (planUtil.isNotSubmitted() && userPreference.isState())
                || (planUtil.pendingAtMOPR() && userPreference.isMOPR());

       
        model.addAttribute("Plan_Status", flag);
        model.addAttribute("STATE_CODE", userPreference.getStateCode());
        switch (basicInfoService.fillFirstBasicInfo()) {
            case "create":
                redirectAttributes.addFlashAttribute(Message.EXCEPTION_KEY, "Please fill the Basic Info Details first");
                return REDIRECT_BASIC_INFO_DETAILS;
            case "modify":
                redirectAttributes.addFlashAttribute(Message.EXCEPTION_KEY, "Please fill the Required Basic Info Details");
                return REDIRECT_MODIFY_BASIC_INFO_DETAILS;
            default:
                break;
        }
        model.addAttribute("planUtil", planUtil);
        model.addAttribute("userPreference", userPreference);
        model.addAttribute("iecActivityComponents", iecService.findAllActivityById());
        if(userPreference.isCEC()){
        	  IecActivity iecActivityForState = iecService.fetchIecDetail(Users.getTypeForState());
            IecActivity iecActivityForMopr = iecService.fetchIecDetail(Users.getTypeForMOPR());
            model.addAttribute("totalAmountProposedState", iecActivityForState.getIecActivityDetails().getTotalAmountProposed());
            model.addAttribute("IEC_ACTIVITY_STATE", iecActivityForState.getIecActivityDetails());
            model.addAttribute("IEC_ACTIVITY_MOPR", iecActivityForMopr.getIecActivityDetails());
            return updateFormData(iecFormModel, IEC_CEC);

        }else {
        	String redirectString = updateFormData(iecFormModel, IEC);
        	Map<String, List<List<String>>> map = basicInfoService.fetchStateAndMoprPreComments(1,11);
        	model.addAttribute("STATE_PRE_COMMENTS", map.get("statePreviousComments"));
			model.addAttribute("MOPR_PRE_COMMENTS", map.get("moprPreviousComments"));
            return redirectString; 
        }
    }

    private String updateFormData(@ModelAttribute("IEC_ACTIVITY") IecFormModel iecFormModel, String redirectPage) {
    	 IecActivity iecActivity = updateIecFormModel(iecFormModel, userPreference.getUserType());
        if (iecActivity == null && (userPreference.isMOPR() || userPreference.isCEC())) {
        	 updateIecFormModel(iecFormModel, Users.getTypeForState());
            iecFormModel.setOwnDataCascade(false);
        }
       return redirectPage;
    }

    @RequestMapping(value = "iec", method = RequestMethod.POST)
    private String saveIec(@ModelAttribute("IEC_ACTIVITY") IecFormModel iecFormModel, Model model ,  RedirectAttributes redirectAttributes)  {

        try {
            redirectAttributes.addFlashAttribute(Message.SUCCESS_KEY, performSave(iecFormModel));
        }catch (RuntimeException runtimeException){
            redirectAttributes.addFlashAttribute(Message.ERROR_KEY, runtimeException.getMessage());
        }
        return REDIRECT_IEC_ACTIVITY;
    }

    private String performSave(IecFormModel iecFormModel){
        switch (iecFormModel.getAction()){
            case IecFormModel.SAVE:
                iecService.save(iecFormModel);
                return Message.SAVE_SUCCESS;
            case IecFormModel.FREEZE:
                iecService.freeze(iecFormModel);
                return "Successfully frozen";
            case IecFormModel.UNFREEZE:
                iecService.unfreeze(iecFormModel);
                return "Successfully unfrozen";
            default:
                throw new RuntimeException("Unknown Command");
        }
    }


    private IecActivity updateIecFormModel(IecFormModel iecFormModel, String userType){
    	IecActivity iecActivity = iecService.fetchIecDetail(userType);
        if(iecActivity == null){
        	 iecFormModel.setIecId(0);
            iecFormModel.getSelectedId().clear();
            iecFormModel.setAmount(0);
            iecFormModel.setFreeze(false);
        }else{
        	 iecFormModel.setIecId(iecActivity.getId());
            IecActivityDetails iecActivityDetails = iecActivity.getIecActivityDetails();
            iecFormModel.setSelectedIdInteger(iecActivityDetails.getIecDetailsDropdownSet()
                    .stream().map(item -> item.getIecActivityDropdown().getIecId())
                    .collect(Collectors.toSet()));
            iecFormModel.setAmount(iecActivityDetails.getTotalAmountProposed());
            iecFormModel.setRemarks(iecActivityDetails.getRemarks());
            iecFormModel.setFreeze(iecActivity.getIsFreez());
            if(userType.equalsIgnoreCase("M"))
            	iecFormModel.setIsApproved(iecActivityDetails.getIsApproved());
        }
       return iecActivity;
    }

}