package gov.in.rgsa.controller;

import java.io.IOException;
import java.math.BigDecimal;
import java.math.BigInteger;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.Arrays;
import java.util.HashMap;
import java.util.HashSet;

import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.ArrayUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import gov.in.rgsa.dto.GramPanchayatProgressReportDTO;
import gov.in.rgsa.dto.SubcomponentwiseQuaterBalance;
import gov.in.rgsa.entity.QprPanchayatBhawan;
import gov.in.rgsa.entity.QprPanhcayatBhawanDetails;
import gov.in.rgsa.service.IncomeEnhancementService;
import gov.in.rgsa.service.LGDService;
import gov.in.rgsa.service.PanchayatBhawanService;
import gov.in.rgsa.service.ProgressReportService;
import gov.in.rgsa.user.preference.UserPreference;

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
	
	
	@Autowired
	private LGDService lgdService;
	
	@Autowired
	private IncomeEnhancementService enhancementService;
	
	
	
	@RequestMapping(value="panchayatBhawanQuaterlyReport",method = RequestMethod.GET)
	public String getQprgGramPanchayat(@ModelAttribute("QPR_PANCHAYAT_BHAWAN") QprPanchayatBhawan qprPanchayatBhawan ,Model model,HttpServletResponse httpResponse)
	{
		
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
		Integer curDistBal=0;
		List <GramPanchayatProgressReportDTO> gramPanchayatProgressReportDTO =new ArrayList<GramPanchayatProgressReportDTO>();
		List<QprPanchayatBhawan> QprPanchayatBhawan=new ArrayList<QprPanchayatBhawan>();
		
		if(activityId>0) {
			model.addAttribute("districtList",progressReportService.getDistrictBasedOnPNCHAYATBHAWANnState(activityId));
			if(districtCode>0) {
			
				List<GramPanchayatProgressReportDTO> gramPanchayatProgressReportDTOAll =panchayatBhawanService.fetchGPBhawanData(activityId,districtCode);
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
				
				QprPanchayatBhawan = panchayatBhawanService.fetchDataAccordingToQuator(quatorId,activityId,panchayatBhawanActivityId);
				List<QprPanhcayatBhawanDetails> qprPanhcayatBhawanDetailsList=new  ArrayList<QprPanhcayatBhawanDetails>();
				if(QprPanchayatBhawan!=null && !QprPanchayatBhawan.isEmpty() && QprPanchayatBhawan.get(0).getQprPanhcayatBhawanDetails().size()>0) {
					int temp=0;
					for(QprPanhcayatBhawanDetails obj: QprPanchayatBhawan.get(0).getQprPanhcayatBhawanDetails()) {
						if(districtCode.equals(obj.getDistrictCode())) {
							qprPanhcayatBhawanDetailsList.add(obj);
							temp=obj.getExpenditureIncurred()!=null && obj.getExpenditureIncurred()>0?obj.getExpenditureIncurred():0;
							curDistBal=	curDistBal+ temp;
						}else {
							temp=obj.getExpenditureIncurred()!=null && obj.getExpenditureIncurred()>0?obj.getExpenditureIncurred():0;
							otherDistBal=	otherDistBal+ temp;
						}
					}
					
					qprPanchayatBhawan=QprPanchayatBhawan.get(0);
					qprPanchayatBhawan.setSelectDistrictId(districtCode);
					qprPanchayatBhawan.setQprPanhcayatBhawanDetails(qprPanhcayatBhawanDetailsList);
					
					
					if(activityId==QprPanchayatBhawan.get(0).getActivityId())
					{
						model.addAttribute("QPR_PANCHAYAT_BHAWAN", QprPanchayatBhawan.get(0));
						model.addAttribute("QPRPANHCAYATBHAWANDETAILS", qprPanhcayatBhawanDetailsList);

					}
				}
				
				qprPanchayatBhawan.setPanchayatBhawanActivityId(panchayatBhawanActivityId);
				
				List<SubcomponentwiseQuaterBalance> subcomponentwiseQuaterBalanceList = progressReportService.fetchSubcomponentwiseQuaterBalance(3, quatorId);
		        if (subcomponentwiseQuaterBalanceList != null && !subcomponentwiseQuaterBalanceList.isEmpty() && (subcomponentwiseQuaterBalanceList.size()>=activityId-1)) {
		        	SubcomponentwiseQuaterBalance subcomponentwiseQuaterBalance=subcomponentwiseQuaterBalanceList.get(activityId-1);
		        	model.addAttribute("subcomponentwiseQuaterBalance", subcomponentwiseQuaterBalance.getBalanceAmount()-otherDistBal);
		        }
				BigDecimal otherSubtotal =progressReportService.subTOTALofOTHERQPRPANCHAYATBHAWAN();
				Double remainOthertotal=otherSubtotal.longValue()-curDistBal.doubleValue();
		        model.addAttribute("otherSubtotal",remainOthertotal);
				
			}
			
		}
		
		model.addAttribute("GPBhawanStatus", panchayatBhawanService.fetchGPBhawanStatus(activityId));
		model.addAttribute("quarterDuration", progressReportService.getQuarterDurations());
		model.addAttribute("panchayatActivity", panchayatBhawanService.fetchPanchayatBhawanActivity());
		
		

		return GRAM_PANCHAYAT_PROGRESS_REPORT;
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
	private String saveQprPanchayatBhawanData(@ModelAttribute("QPR_GRAM_PANCHAYAT") QprPanchayatBhawan qprPanchayatBhawan,Model model ,RedirectAttributes redirectAttributes) throws IOException{
		progressReportService.saveQprPanchayatBhawan(qprPanchayatBhawan);
		redirectAttributes.addAttribute("isError", "Data save successfully");
		return REDIRECT_GRAM_PANCHAYAT_PROGRESS_REPORT;
	}
	
	

}
