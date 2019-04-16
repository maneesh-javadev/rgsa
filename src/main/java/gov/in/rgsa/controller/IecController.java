package gov.in.rgsa.controller;



import javax.servlet.http.HttpServletRequest;

import gov.in.rgsa.entity.IecDetailsDropdown;
import gov.in.rgsa.entity.Users;
import gov.in.rgsa.model.IecFormModel;
import gov.in.rgsa.utils.PlanUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import gov.in.rgsa.entity.IecActivity;
import gov.in.rgsa.entity.IecActivityDetails;
import gov.in.rgsa.model.IecModel;
import gov.in.rgsa.service.BasicInfoService;
import gov.in.rgsa.service.IecService;
import gov.in.rgsa.user.preference.UserPreference;
import gov.in.rgsa.utils.Message;

import java.util.List;
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

        IecActivity iecActivity = updateIecFormModel(iecFormModel);

        model.addAttribute("NATURE_IEC_LIST", iecService.findAllActivityById());
        model.addAttribute("user_type", userPreference.getUserType().charAt(0));

        if (iecActivity != null) {
            /*iecModel.put("iecId", iecId);*/
            model.addAttribute("IEC_LIST", iecActivity);
            model.addAttribute("IEC_LIST_DETAILS", iecActivity.getIecActivityDetails());
        }

//        if (userPreference.isCEC()) {
//            IecActivity iecActivityForState = iecService.fetchIecDetail(Users.getTypeForState());
//            IecActivity iecActivityForMopr = iecService.fetchIecDetail(Users.getTypeForMOPR());
//            long totalAmount = 0;
//            java.util.List<IecActivityDetails> iecActivityDetails = iecActivityForState.getIecActivityDetails();
//            for (int i = 0; i < iecActivityDetails.size(); i++) {
//                totalAmount = totalAmount + iecActivityDetails.get(i).getTotalAmountProposed();
//            }
//            model.addAttribute("totalAmountProposedState", totalAmount);
//            model.addAttribute("IEC_LIST_FOR_STATE", iecActivityForState.getIecActivityDetails());
//            model.addAttribute("IEC_LIST_FOR_MOPR", iecActivityForMopr.getIecActivityDetails());
//            return IEC_CEC;
//        }

        return IEC;
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


    private IecActivity updateIecFormModel(IecFormModel iecFormModel){
        IecActivity iecActivity = iecService.fetchIecDetail();
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
            iecFormModel.setFreeze(iecActivity.getIsFreez());
        }
        return iecActivity;
    }

    /*

    @RequestMapping(value = "iec", method = RequestMethod.POST)
    private String saveIec(@ModelAttribute("IEC_ACTIVITY") IecFormModel iecFormModel, Model model ,  RedirectAttributes redirectAttributes)  {
        // Check Added deleted updated

        iecService.save(iecModel.getIecActivity());
        if(userPreference.isState()) {

            if(iecModel!=null && iecModel.getIdToDeleteStr()!=null && iecModel.getIdToDeleteStr().length()>0)
            {
                String idArr[]=iecModel.getIdToDeleteStr().split(",");
                for(int i=0;i<idArr.length;i++) {
                    iecService.delete(Integer.parseInt((idArr[i])));
                }

            }
        }

        redirectAttributes.addFlashAttribute(Message.SUCCESS_KEY, Message.SAVE_SUCCESS);


        return REDIRECT_IEC_ACTIVITY;

    }

    @RequestMapping(value="deleteIecActivity", method=RequestMethod.POST)
    public String deleteInnovactivityMethod(@ModelAttribute("IEC_ACTIVITY")  IecActivity iecActivity ,Model model,RedirectAttributes redirectAttributes) {
        if(iecActivity.getIdToDelete() != null || iecActivity.getIdToDelete() !=0) {
            int idMain = Integer.valueOf(iecActivity.getIdToDelete());
            iecService.delete(idMain);

            redirectAttributes.addFlashAttribute(Message.DELETE_KEY,Message.DELETE_SUCCESS);
        }
        model.addAttribute("iecActivity", iecService.fetchIecDetail(userPreference.getUserType()));


        return REDIRECT_IEC_ACTIVITY;
    }

    @RequestMapping(value="freezAndUnfreezIEC" , method=RequestMethod.POST)
    public String freezeUnfreezemethod(@ModelAttribute("IEC_ACTIVITY")IecModel iecModel,Model model ,RedirectAttributes redirectAttributes) {
        iecService.freezeAndUnfreeze(iecModel.getIecActivity());
        if(iecModel.getIecActivity().getDbFileName().equals("freeze"))
        {
            redirectAttributes.addFlashAttribute(Message.SUCCESS_KEY, "Freezed Successfully");
        }
        else {
            redirectAttributes.addFlashAttribute(Message.SUCCESS_KEY, "UnFreezed Successfully");
        }


        return  REDIRECT_IEC_ACTIVITY;
    }
    */
}