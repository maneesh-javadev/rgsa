package gov.in.rgsa.controller;

import java.io.IOException;
import java.math.BigDecimal;
import java.math.BigInteger;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import gov.in.rgsa.dto.GramPanchayatProgressReportDTO;
import gov.in.rgsa.dto.SubcomponentwiseQuaterBalance;
import gov.in.rgsa.entity.District;
import gov.in.rgsa.entity.QprPanchayatBhawan;
import gov.in.rgsa.entity.QprPanhcayatBhawanDetails;
import gov.in.rgsa.entity.StateAllocation;
import gov.in.rgsa.model.Response;
import gov.in.rgsa.service.IncomeEnhancementService;
import gov.in.rgsa.service.LGDService;
import gov.in.rgsa.service.PanchayatBhawanService;
import gov.in.rgsa.service.PlanAllocationService;
import gov.in.rgsa.service.ProgressReportService;
import gov.in.rgsa.user.preference.UserPreference;
import gov.in.rgsa.utils.Message;

@Controller
public class QprGramPanchayatController {
	
	@Autowired
	private PanchayatBhawanService panchayatBhawanService;
	
	@Autowired
	private ProgressReportService progressReportService;
	
	@Autowired
	private UserPreference userPreference;
	
	
	public static final String GRAM_PANCHAYAT_PROGRESS_REPORT = "panchayatBhawanQuaterlyReport";
	
	public static final String REDIRECT_GRAM_PANCHAYAT_PROGRESS_REPORT = "redirect:panchayatBhawanQuaterlyReport.html";
	
    public static final String REDIRECT_PLAN_ALLOCATION = "redirect:planAllocation.html";
    
    public static final String GRAM_PANCHAYAT_PROGRESS_REPORT_WITHOUT_QUATER ="panchayatBhawanQuaterlyReportWithoutQuarter";
    
    public static final String REDIRECT_GRAM_PANCHAYAT_PROGRESS_REPORT_WITHOUT_QUATER = "redirect:panchayatBhawanQuaterlyReportWithoutQuarter.html";
	
    private static final String NO_FUND_ALLOCATED_JSP = "noFundAlloctedJsp";
    
	@Autowired
	private LGDService lgdService;
	
	@Autowired
	private IncomeEnhancementService enhancementService;
	
	
	@Autowired
	private PlanAllocationService planAllocationService;
	
	
	
	@RequestMapping(value="panchayatBhawanQuaterlyReport",method = RequestMethod.GET)
	public String getQprgGramPanchayat(@ModelAttribute("QPR_PANCHAYAT_BHAWAN") QprPanchayatBhawan qprPanchayatBhawan ,Model model,RedirectAttributes redirectAttributes)
	{
		
		 List<StateAllocation> stateAllocationList = planAllocationService.fetchStateAllocationListMaxINSTALLMENTNO();
         if (!(stateAllocationList != null && !stateAllocationList.isEmpty())) {
             redirectAttributes.addFlashAttribute("isPlanAllocationNotExist", Boolean.TRUE);
             return REDIRECT_PLAN_ALLOCATION;
         }
		model.addAttribute("quarterDuration", progressReportService.getQuarterDurations());
		model.addAttribute("panchayatActivity", panchayatBhawanService.fetchPanchayatBhawanActivity());
		//model.addAttribute("districtList", lgdService.getAllDistrictBasedOnState(userPreference.getStateCode()));
		
		return GRAM_PANCHAYAT_PROGRESS_REPORT;
	}
	
	@RequestMapping(value = "panchayatBhawanQuaterlyReportOnQtr", method = RequestMethod.POST)
	private String getQprgGramPanchayatActivity(@ModelAttribute("QPR_PANCHAYAT_BHAWAN") QprPanchayatBhawan qprPanchayatBhawan , Model model) {
		Integer quatorId =qprPanchayatBhawan.getQtrId();
		Integer activityId =qprPanchayatBhawan.getActivityId();
		Integer districtCode =qprPanchayatBhawan.getSelectDistrictId();
		Integer panchayatBhawanActivityId=null;
		Integer otherDistBal=0;
		Double curDistBal=0D;
		List <GramPanchayatProgressReportDTO> gramPanchayatProgressReportDTO =new ArrayList<GramPanchayatProgressReportDTO>();
		List<QprPanchayatBhawan> qprPanchayatBhawanList=new ArrayList<QprPanchayatBhawan>();
		qprPanchayatBhawan.setQprPanhcayatBhawanDetails(null);
		
		if(activityId>0) {
			List<District> districtList = progressReportService.getDistrictBasedOnPNCHAYATBHAWANnState(activityId);
			model.addAttribute("districtList",districtList);
			if(districtCode>0 && !districtList.isEmpty() ) {
				List<GramPanchayatProgressReportDTO> gramPanchayatProgressReportDTOAll =panchayatBhawanService.fetchGPBhawanData(activityId,districtCode ,districtList.get(0).getPanhcayatBhawanActivityId());
				if(gramPanchayatProgressReportDTOAll!=null && !gramPanchayatProgressReportDTOAll.isEmpty()) {
					panchayatBhawanActivityId=gramPanchayatProgressReportDTOAll.get(0).getPanchayatBhawanActivityId();	
				for(GramPanchayatProgressReportDTO obj:gramPanchayatProgressReportDTOAll) {
					if(obj!=null) {
						gramPanchayatProgressReportDTO.add(obj);
					}
					}
				}
				
				model.addAttribute("QprPanchayatBhawanDto", gramPanchayatProgressReportDTO);
				model.addAttribute("isExistQprPanchayatBhawan",Boolean.TRUE);
				if(gramPanchayatProgressReportDTO.size()<1) {
					model.addAttribute("isExistQprPanchayatBhawan",Boolean.FALSE);
				}
				
				qprPanchayatBhawanList = panchayatBhawanService.fetchDataAccordingToQuator(quatorId,activityId,districtCode,panchayatBhawanActivityId );
				List<QprPanhcayatBhawanDetails> qprPanhcayatBhawanDetailsList=new  ArrayList<QprPanhcayatBhawanDetails>();
				if(qprPanchayatBhawanList!=null && !qprPanchayatBhawanList.isEmpty() && qprPanchayatBhawanList.get(0).getQprPanhcayatBhawanDetails().size()>0) {
					int temp=0;
					for(QprPanhcayatBhawanDetails obj: qprPanchayatBhawanList.get(0).getQprPanhcayatBhawanDetails()) {
						if(districtCode.equals(obj.getDistrictCode())) {
							qprPanhcayatBhawanDetailsList.add(obj);
							temp=obj.getExpenditureIncurred()!=null && obj.getExpenditureIncurred()>0?obj.getExpenditureIncurred():0;
							curDistBal=	curDistBal+ temp;
						}else {
							temp=obj.getExpenditureIncurred()!=null && obj.getExpenditureIncurred()>0?obj.getExpenditureIncurred():0;
							otherDistBal=	otherDistBal+ temp;
						}
					}
					
					qprPanchayatBhawan=qprPanchayatBhawanList.get(0);
					qprPanchayatBhawan.setSelectDistrictId(districtCode);
					qprPanchayatBhawan.setQprPanhcayatBhawanDetails(qprPanhcayatBhawanDetailsList);
					
					if(qprPanchayatBhawanList.get(0) != null) {
						model.addAttribute("DISABLE_FREEZE", false);
					}else {
						model.addAttribute("DISABLE_FREEZE", true);
					}
					if(activityId==qprPanchayatBhawanList.get(0).getActivityId())
					{
						model.addAttribute("QPR_PANCHAYAT_BHAWAN", qprPanchayatBhawanList.get(0));
						model.addAttribute("QPRPANHCAYATBHAWANDETAILS", qprPanhcayatBhawanDetailsList);
					}
				}
				
				qprPanchayatBhawan.setPanchayatBhawanActivityId(panchayatBhawanActivityId);
				
			}
			
			List<SubcomponentwiseQuaterBalance> subcomponentwiseQuaterBalanceList = progressReportService
					.fetchSubcomponentwiseQuaterBalance(3, quatorId);
			if (subcomponentwiseQuaterBalanceList != null && !subcomponentwiseQuaterBalanceList.isEmpty()) {
				model.addAttribute("subcomponentwiseQuaterBalance", subcomponentwiseQuaterBalanceList.get(activityId-1).getBalanceAmount());
				model.addAttribute("installementExist", Boolean.TRUE);
				String addReqirmentDetails = progressReportService.getBalanceAdditionalReqiurment(3, quatorId);
				if (addReqirmentDetails != null && addReqirmentDetails.length() > 0) {
					model.addAttribute("balAddiReq", Integer.parseInt(addReqirmentDetails));
				}
			} else {
				// model.addAttribute("isError", "2nd installement not released");
				// model.addAttribute("installementExist", Boolean.FALSE);
			}
			
			BigDecimal otherSubtotal =quatorId==0?progressReportService.subTOTALofOTHERQPRPANCHAYATBHAWANYEARWISE(activityId):progressReportService.subTOTALofOTHERQPRPANCHAYATBHAWAN();
			Double remainOthertotal=otherSubtotal.longValue()-curDistBal;
	        model.addAttribute("otherSubtotal",remainOthertotal.longValue());
			
		}
		
		model.addAttribute("GPBhawanStatus", panchayatBhawanService.fetchGPBhawanStatus(activityId));
		model.addAttribute("quarterDuration", progressReportService.getQuarterDurations());
		model.addAttribute("panchayatActivity", panchayatBhawanService.fetchPanchayatBhawanActivity());
		
		if(quatorId==0) {
			return GRAM_PANCHAYAT_PROGRESS_REPORT_WITHOUT_QUATER;
		}
		else {
			return GRAM_PANCHAYAT_PROGRESS_REPORT;
		}
		
	}
	
	
	
	@RequestMapping(value="qprgGramPanchayatDistrict",method = RequestMethod.POST)
	public String getQprgGramPanchayatDistrict()
	{
		return GRAM_PANCHAYAT_PROGRESS_REPORT;
	}
	@RequestMapping(value="qprgGramPanchayatReport",method = RequestMethod.POST)
	public String getQprgGramPanchayatReport()
	{
		return GRAM_PANCHAYAT_PROGRESS_REPORT;
	}
	
	@RequestMapping(value="saveQprPanchayatBhawanData1" , method=RequestMethod.POST)
	private String saveQprPanchayatBhawanData(@ModelAttribute("QPR_GRAM_PANCHAYAT") QprPanchayatBhawan qprPanchayatBhawan,Model model ,RedirectAttributes redirectAttributes) {
		
		Response response = new Response();
		try {
		progressReportService.saveQprPanchayatBhawan(qprPanchayatBhawan);
		 
		redirectAttributes.addFlashAttribute(Message.SUCCESS_KEY, Message.SAVE_SUCCESS);
		}catch(Exception e) {
			redirectAttributes.addAttribute("msg", "Oop's There are Some Error!");
		}
		if(qprPanchayatBhawan.getQtrId()==0) {
			return REDIRECT_GRAM_PANCHAYAT_PROGRESS_REPORT_WITHOUT_QUATER;
		}
		else {
			return REDIRECT_GRAM_PANCHAYAT_PROGRESS_REPORT;
		}
	}
	
	
	/*---------------------------------------------------------------------------------------------------------------
	 *    Maneesh 8June2020  QPR Form Without Quater
	 ------------------------------------------------------------------------------------------------------
	 */
	@RequestMapping(value="panchayatBhawanQuaterlyReportWithoutQuarter",method = RequestMethod.GET)
	public String getQprgGramPanchayatWithoutQuarter(@ModelAttribute("QPR_PANCHAYAT_BHAWAN") QprPanchayatBhawan qprPanchayatBhawan ,Model model,RedirectAttributes redirectAttributes)
	{
		int quarterId=0;
		 List<StateAllocation> stateAllocation =progressReportService.fetchStateAllocationData(3, 1, progressReportService.getCurrentPlanCode());
		 List<StateAllocation> stateAllocation2nd =progressReportService.fetchStateAllocationData(3, 2, progressReportService.getCurrentPlanCode());
		 if((stateAllocation!=null && !stateAllocation.isEmpty()) || (stateAllocation2nd!=null && !stateAllocation2nd.isEmpty())) {
			 
			 Double fundAllocate=0D;
				if(stateAllocation!=null && !stateAllocation.isEmpty()) {
					fundAllocate=fundAllocate+stateAllocation.get(0).getFundsAllocated();
				}
				if(stateAllocation2nd!=null && !stateAllocation2nd.isEmpty()) {
					fundAllocate=fundAllocate+stateAllocation2nd.get(0).getFundsAllocated();
				}
			 model.addAttribute("quarterDuration", quarterId);
			 model.addAttribute("panchayatActivity", panchayatBhawanService.fetchPanchayatBhawanActivity());
			 model.addAttribute("FUND_ALLOCATED_BY_STATE", fundAllocate);
			 return GRAM_PANCHAYAT_PROGRESS_REPORT_WITHOUT_QUATER;  
         }
		 else
		 {
			 return NO_FUND_ALLOCATED_JSP;
		 }		
	}
	/*---------------------------------------------------------------------------------------------------------------
	 *    Maneesh 8June2020  QPR Form Without ENd
	 ------------------------------------------------------------------------------------------------------
	 */
	

}
