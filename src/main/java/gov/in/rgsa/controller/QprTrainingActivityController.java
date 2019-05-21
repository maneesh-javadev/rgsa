package gov.in.rgsa.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

import javax.servlet.http.HttpServletResponse;

import org.apache.commons.collections.CollectionUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import gov.in.rgsa.entity.CBMaster;
import gov.in.rgsa.entity.CapacityBuildingActivity;
import gov.in.rgsa.entity.FileNode;
import gov.in.rgsa.entity.QprCbActivity;
import gov.in.rgsa.entity.QprCbActivityDetails;
import gov.in.rgsa.entity.QprHandholdingGpdp;
import gov.in.rgsa.entity.QprPanchayatLearningCenter;
import gov.in.rgsa.entity.QprTnaTrgEvaluation;
import gov.in.rgsa.entity.QuaterWiseFund;
import gov.in.rgsa.entity.StateAllocation;
import gov.in.rgsa.model.multipart.FileNodeMultipart;
import gov.in.rgsa.service.CBMasterService;
import gov.in.rgsa.service.CapacityBuildingService;
import gov.in.rgsa.service.InnovativeActivityService;
import gov.in.rgsa.service.ProgressReportService;
import gov.in.rgsa.service.TrainingActivityService;
import gov.in.rgsa.user.preference.UserPreference;
import gov.in.rgsa.utils.FileNodeUtils;
import gov.in.rgsa.utils.Message;


@Controller
public class QprTrainingActivityController {
	static Logger logger = LoggerFactory.getLogger(QprTrainingActivityController.class);
	
	public static final String QPR_CAPACITY_BUILDING ="qprCapacityBuilding";
	public static final String REDIRECT_QPR_CAPACITY_BUILDING ="redirect:qprCapacityBuilding.html";
	private static final String NO_FUND_ALLOCATED_JSP = "noFundAlloctedJsp";
	
	@Autowired
	private ProgressReportService progressReportService;
	
	@Autowired
	private CapacityBuildingService capacityBuildingService;
	
	@Autowired
	private CBMasterService cbMasterService;
	
	@Autowired
	private TrainingActivityService trainingActivityService;
	
	@Autowired
	InnovativeActivityService innovativeActivityService;
	
	@Autowired
	UserPreference userPreference;
	
	@RequestMapping(value="qprCapacityBuilding" , method=RequestMethod.GET)
	public String qprGetFormCapacityBuilding(@ModelAttribute("QPR_CAPACITY_BUILDING")QprCbActivity qprCbActivity,Model model){
		int quarterId = qprCbActivity.getShowQqrtrId();
		int installmentNo = (quarterId < 3) ? 1 : 2; // installment number for qtrId 1 & 2 = 1 and 3 & 4 = 2
		model.addAttribute("quarter_duration", progressReportService.getQuarterDurations());
		List<QuaterWiseFund> totalQuatorWiseFund = new ArrayList<>();
		CapacityBuildingActivity cbActivityApproved= capacityBuildingService.fetchCapacityBuildingActivity('C');
		List<StateAllocation> stateAllocation = progressReportService.fetchStateAllocationData(13,installmentNo,progressReportService.getCurrentPlanCode());
		if (quarterId == 3 || quarterId == 4) {
			stateAllocation.add(progressReportService.fetchStateAllocationData(13, 1,progressReportService.getCurrentPlanCode()).get(0)); // total fund allocated in first installment
			totalQuatorWiseFund = progressReportService.fetchTotalQuaterWiseFundData(userPreference.getStateCode(), 13);
			model.addAttribute("TOTAL_FUND_USED_IN_QTR_1_AND_2", new ProgressReportController().calTotalFundUsedInQtr1And2(totalQuatorWiseFund));
		}
		
		if(CollectionUtils.isNotEmpty(stateAllocation) && cbActivityApproved != null) {
			if (stateAllocation.size() > 1) {
				model.addAttribute("FUND_ALLOCATED_BY_STATE_PREVIOUS", stateAllocation.get(1).getFundsAllocated()); // we will use this in jsp to calculate the total remaining field
			}
			
			// list to get total number of unit in all quator except current one
			List<QprCbActivityDetails> detailForTotalNoOfUnit = new ArrayList<>();
			List<QprCbActivityDetails> qprCbActivityDetailsOfRestQuater = progressReportService.getQprTrainActBasedOnActIdAndQtrId(cbActivityApproved.getCbActivityId(), quarterId);
			if (qprCbActivityDetailsOfRestQuater != null) {
				Collections.sort(qprCbActivityDetailsOfRestQuater,(o1, o2) -> o1.getQprCbActivityDetailsId()- o2.getQprCbActivityDetailsId());
				detailForTotalNoOfUnit = getTotalUnitAndExpIncurredInAllQtrTrainAct(detailForTotalNoOfUnit,qprCbActivityDetailsOfRestQuater);
				model.addAttribute("DEATIL_FOR_TOTAL_NO_OF_UNIT", detailForTotalNoOfUnit);
			} else {
				model.addAttribute("DEATIL_FOR_TOTAL_NO_OF_UNIT", null);
			}
			
			List<CBMaster> cbMasters = cbMasterService.fetchCBMasters();
			QprCbActivity qprCapacityBuildingActivity =progressReportService.fetchQprCapcityBuilding(cbActivityApproved.getCbActivityId(),qprCbActivity.getShowQqrtrId());
			if(qprCapacityBuildingActivity != null) {
				Collections.sort(qprCapacityBuildingActivity.getQprCbActivityDetails(), (o1,o2) -> o1.getQprCbActivityDetailsId() -o2.getQprCbActivityDetailsId());
				model.addAttribute("QPR_CB_ACT_DATA", qprCapacityBuildingActivity);
			}else {
				if(qprCbActivity.getQprCbActivityDetails() != null) {
					qprCbActivity.getQprCbActivityDetails().clear();
				}
			}
			
			/* used to get previous data stored which is then use to validate the  expenditure incurred */
			List<QuaterWiseFund> quaterWiseFund = new ArrayList<>();
			if (quarterId == 1 || quarterId == 3) {
				quaterWiseFund = progressReportService.fetchQuaterWiseFundData(userPreference.getStateCode(),
						(quarterId + 1), 13);
			} else {
				quaterWiseFund = progressReportService.fetchQuaterWiseFundData(userPreference.getStateCode(),
						(quarterId - 1), 13);
			}
			if (CollectionUtils.isNotEmpty(quaterWiseFund)) {
				model.addAttribute("FUND_USED_IN_OTHER_QUATOR", quaterWiseFund.get(0).getFunds());
			}
			/*----------------------------end here-------------------------------------------------- */
			if(quarterId !=0) 
				model.addAttribute("REMAINING_ADD_REQ", Integer.parseInt(progressReportService.getBalanceAdditionalReqiurment(13,quarterId)));
			model.addAttribute("CB_MASTERS", cbMasters);
			model.addAttribute("QTR_ID", quarterId);
			model.addAttribute("FUND_ALLOCATED_BY_STATE", stateAllocation.get(0).getFundsAllocated());
			model.addAttribute("CEC_APPROVED_ACTIVITY", cbActivityApproved);
			model.addAttribute("SUBJECTS_LIST",trainingActivityService.subjectsList()); 
			return QPR_CAPACITY_BUILDING;
		}else {
			return NO_FUND_ALLOCATED_JSP;
		}
	}
	
	private List<QprCbActivityDetails> getTotalUnitAndExpIncurredInAllQtrTrainAct(List<QprCbActivityDetails> detailForTotalNoOfUnit,List<QprCbActivityDetails> qprCbActivityDetailsOfRestQuater) {
		int count = 0;
		for (int i = 0; i < 8; i++) {
			detailForTotalNoOfUnit.add(new QprCbActivityDetails());
		}
		for (int j = 0; j < qprCbActivityDetailsOfRestQuater.size(); j++) {
			if (count == 8) {
				count = 0;
			}
			for (int i = count; i < count + 1; i++) {
				if (detailForTotalNoOfUnit.get(i).getNoOfUnitsCompleted() != null && qprCbActivityDetailsOfRestQuater.get(j).getNoOfUnitsCompleted() != null) {
					detailForTotalNoOfUnit.get(i).setNoOfUnitsCompleted(detailForTotalNoOfUnit.get(i).getNoOfUnitsCompleted()
							+ qprCbActivityDetailsOfRestQuater.get(j).getNoOfUnitsCompleted());
				}else if((detailForTotalNoOfUnit.get(i).getNoOfUnitsCompleted() == null  || detailForTotalNoOfUnit.get(i).getNoOfUnitsCompleted() ==  0 ) && qprCbActivityDetailsOfRestQuater.get(j).getNoOfUnitsCompleted() == null) {
					detailForTotalNoOfUnit.get(i).setNoOfUnitsCompleted(0);
               	 }else {
               		 if( qprCbActivityDetailsOfRestQuater.get(j).getNoOfUnitsCompleted() != null)
					detailForTotalNoOfUnit.get(i).setNoOfUnitsCompleted(0 + qprCbActivityDetailsOfRestQuater.get(j).getNoOfUnitsCompleted());
				}
				if (detailForTotalNoOfUnit.get(i).getExpenditureIncurred() != null && qprCbActivityDetailsOfRestQuater.get(j).getExpenditureIncurred() != null) {
					detailForTotalNoOfUnit.get(i)
							.setExpenditureIncurred(detailForTotalNoOfUnit.get(i).getExpenditureIncurred()
									+ qprCbActivityDetailsOfRestQuater.get(j).getExpenditureIncurred());
				}else if((detailForTotalNoOfUnit.get(i).getExpenditureIncurred() == null  || detailForTotalNoOfUnit.get(i).getExpenditureIncurred() ==  0 ) && qprCbActivityDetailsOfRestQuater.get(j).getExpenditureIncurred() == null) {
					detailForTotalNoOfUnit.get(i).setExpenditureIncurred(0);
              	 } else {
              		 if( qprCbActivityDetailsOfRestQuater.get(j).getExpenditureIncurred() != null)
					detailForTotalNoOfUnit.get(i).setExpenditureIncurred(qprCbActivityDetailsOfRestQuater.get(j).getExpenditureIncurred() + 0);
				}
			}
			++count;
		}
		return detailForTotalNoOfUnit;
	}

	@RequestMapping(value="qprCapacityBuilding" ,  method=RequestMethod.POST )
	public String saveQprCapacityBuilding(@ModelAttribute("QPR_CAPACITY_BUILDING")QprCbActivity qprCbActivity,Model model,RedirectAttributes redirectAttributes) throws IOException{
		
		if (qprCbActivity.getShowQqrtrId() == 0 || qprCbActivity.getOrigin() == null) {
			logger.info("Reverting with new select.");
			return  qprGetFormCapacityBuilding( qprCbActivity, model);
		} else {
			logger.info("Save procedure started");
			List<QprCbActivityDetails> detailList = qprCbActivity.getQprCbActivityDetails();
			if(detailList == null) {
				throw new RuntimeException("list is empty");
			}
			for (QprCbActivityDetails qprCbActivityDetail : detailList) {
				QprTnaTrgEvaluation qprTnaTrgEvaluation = qprCbActivityDetail.getQprTnaTrgEvaluation();
				QprPanchayatLearningCenter qprPanchayatLearningCenter = qprCbActivityDetail.getQprPanchayatLearningCenter();
				QprHandholdingGpdp qprHandholdingGpdp = qprCbActivityDetail.getQprHandholdingGpdp();
				String uploadPath =innovativeActivityService.findfilePath().getFileLocation();
				FileNodeUtils uploadReport=null;
				MultipartFile multipartFile=null;
				
				if(qprTnaTrgEvaluation != null) {
					multipartFile = qprTnaTrgEvaluation.getFile();
					uploadReport = attemptUpload(qprTnaTrgEvaluation.getFileNode(), multipartFile, uploadPath, qprCbActivity.getQuarterDuration().getQtrId(),"trntrgeval");
					qprTnaTrgEvaluation.setFileNode(uploadReport.getFileNode());
					
				}
				if(qprPanchayatLearningCenter != null) {
					multipartFile = qprPanchayatLearningCenter.getFile();
					uploadReport = attemptUpload(qprPanchayatLearningCenter.getFileNode(), multipartFile, uploadPath, qprCbActivity.getQuarterDuration().getQtrId(),"panchlearncenter");
					qprPanchayatLearningCenter.setFileNode(uploadReport.getFileNode());
				}
				if(qprHandholdingGpdp != null) {
					multipartFile = qprHandholdingGpdp.getFile();
					uploadReport = attemptUpload(qprHandholdingGpdp.getFileNode(), multipartFile, uploadPath, qprCbActivity.getQuarterDuration().getQtrId(),"handHoldinggpdp");
					qprHandholdingGpdp.setFileNode(uploadReport.getFileNode());
				}
			}
			
			progressReportService.saveQprCbActivity(qprCbActivity);
			redirectAttributes.addFlashAttribute(Message.SUCCESS_KEY, Message.SAVE_SUCCESS);
			return REDIRECT_QPR_CAPACITY_BUILDING;
		}
	}
	
	
	  @RequestMapping(value="getQprCbActivityPdf" , method=RequestMethod.POST )
	  public void getQprCbActivityPdf(@ModelAttribute("QPR_CAPACITY_BUILDING")QprCbActivity qprCbActivity,@RequestParam(value = "tableName", required = false) String tableName,
			  @RequestParam(value = "tableId", required = false) Integer tableId,  @RequestParam(value="inline", required=false) Boolean inline,
				HttpServletResponse response) {
		  FileNode fileNode = null;
		  if(tableName.equalsIgnoreCase("TnaTrgEvaluation")) {
			  fileNode= trainingActivityService.fetchQprTnaTrgEvaluation(tableId);
		  }else if(tableName.equalsIgnoreCase("HandholdingGpdp")) {
			  fileNode= trainingActivityService.fetchQprHandholdingGpdp(tableId);
		  }else if(tableName.equalsIgnoreCase("PanchayatLearningCenter")) {
			  fileNode= trainingActivityService.fetchQprPanchayatLearningCenter(tableId);
		  }
		  
		if(inline==null)
			inline=true;
		FileNodeUtils.streamFileNode(fileNode, response, inline);
	  }
	 
		
	private FileNodeUtils attemptUpload(FileNode fileNode, MultipartFile multipartFile, String uploadPath,Integer quarterId, String string) {
		FileNodeUtils uploadReport;
		
		if(fileNode.getFileNodeId() != null) {
			// if file node is not loaded
			if(fileNode.getFileName() == null)
				fileNode = trainingActivityService.loadFileNode(fileNode);
			uploadReport = FileNodeUtils.updateFile(multipartFile, fileNode);
			if(uploadReport.getUploadStatus() == FileNodeUtils.UPLOAD_STATUS.REQUESTED_FAILED) 
				throw new RuntimeException();		
		} else {
			uploadReport = FileNodeUtils.createNewFile(multipartFile, uploadPath, getNameForFile(quarterId,string, "pdf"));
			if(uploadReport.getUploadStatus() == FileNodeUtils.UPLOAD_STATUS.REQUESTED_FAILED)
				throw new RuntimeException();
		}
		return uploadReport;		
	}


	private String getNameForFile(Integer quarterId, String formName, String extension) {
		return String.format("Uploaded_QprCbActivity_%d_%d_%d_%s.%s", userPreference.getStateCode(), userPreference.getFinYearId(), quarterId,formName ,extension);
	}
	
	
}


	
