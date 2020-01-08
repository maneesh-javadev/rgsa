package gov.in.rgsa.controller;

import java.util.Collections;
import java.util.Iterator;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import gov.in.rgsa.entity.FileNode;
import gov.in.rgsa.entity.FundReleased;
import gov.in.rgsa.entity.FundReleasedDetails;
import gov.in.rgsa.entity.QprCbActivity;
import gov.in.rgsa.entity.ReleaseIntallment;
import gov.in.rgsa.entity.State;
import gov.in.rgsa.entity.TrgOfHundredDaysProgramCh2;
import gov.in.rgsa.service.FundReleasedService;
import gov.in.rgsa.service.InnovativeActivityService;
import gov.in.rgsa.service.MOPRService;
import gov.in.rgsa.user.preference.UserPreference;
import gov.in.rgsa.utils.FileNodeUtils;
import gov.in.rgsa.utils.Message;

@Controller
public class FundReleasedController {
	
	private static final String FUND_SANCTION = "fundReleased";

	private static final String REDIRECT_FUND_SANCTION = "redirect:fundReleased.html";
	
	@Autowired
	private  MOPRService moprService;
	
	@Autowired
	private FundReleasedService fundReleasedService; 
	
	@Autowired
	private InnovativeActivityService innovativeActivityService;
	
	@Autowired
	private UserPreference userPreference;

	@GetMapping(value="fundReleased")
	private String fundReleased(@ModelAttribute("FUND_RELEASED") FundReleased fundReleased, Model model , RedirectAttributes re) {
		try {
		if(fundReleased.getFinYearId() != null) {
			List<State> stateList = moprService.getStateListApprovedbyCEC(fundReleased.getFinYearId());
			model.addAttribute("STATE_LIST", stateList);
			
			if(fundReleased.getStateCode() != null) {
				ReleaseIntallment releaseIntallment = fundReleasedService.validateReleaseInstallment(fundReleased.getStateCode(),fundReleased.getFinYearId());
				if(releaseIntallment != null) {
					model.addAttribute("RELEASE_INSTALLMENT", releaseIntallment);
					FundReleased fetchedEntity = fundReleasedService.fetchData(releaseIntallment.getPlanCode());
					if(fetchedEntity != null) {
						Collections.sort(fetchedEntity.getFundReleasedDetails() ,(o1,o2) -> o1.getFundReleasedDetailsId() - o2.getFundReleasedDetailsId());
						fetchedEntity.getFundReleasedDetails().forEach(obj ->{
							if(obj.getCentralShareDate() != null) {
								String startarr[]=obj.getCentralShareDate().toString().substring(0,10).split("-");
								obj.setDemoDate(startarr[2]+"-"+startarr[1]+"-"+startarr[0]);
							}
						});
					}else {
						if(fundReleased.getFundReleasedDetails() != null)
							fundReleased.getFundReleasedDetails().clear();
					}
					model.addAttribute("FETCHED_DATA", fetchedEntity); 
				}else {
					fundReleased.setStateCode(null);
					model.addAttribute("RELEASE_PRESENT", false);
					//re.addFlashAttribute(Message.EXCEPTION_KEY, "Fund is not sanctioned in for this state.");
				}
			}
		}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return FUND_SANCTION;
	}
	
	@PostMapping(value="fundReleased")
	private String fundReleasedPost(@ModelAttribute("FUND_RELEASED") FundReleased fundReleased, Model model,RedirectAttributes re) {
	try {
		if(fundReleased.getMsg().equalsIgnoreCase("save")) {
			System.out.println("in save block");
			String uploadPath =innovativeActivityService.findfilePath().getFileLocation();
			
			fundReleased.getFundReleasedDetails().forEach(obj ->{
				FileNodeUtils uploadReport=null;
				MultipartFile multipartFile=null;
				String installment = (obj.getInstallmentId().equals(1)) ? "installment_1" : "installment_2";
				if((obj.getFile() != null && !obj.getFile().getOriginalFilename().isEmpty()) || obj.getFileNode().getFileNodeId() != null) {
					multipartFile = obj.getFile();
					uploadReport = attemptUpload(obj.getFileNode(), multipartFile, uploadPath,installment);
					if(uploadReport != null)
							obj.setFileNode(uploadReport.getFileNode());
				}else {
					obj.setFileNode(null);
				}
			});
			fundReleasedService.save(fundReleased);
		}else {
			return fundReleased(fundReleased,model,re);
		}
	}catch(Exception e) {
			e.printStackTrace();
		}
		return REDIRECT_FUND_SANCTION;
	}
	
	private FileNodeUtils attemptUpload(FileNode fileNode, MultipartFile multipartFile, String uploadPath, String string) {
		FileNodeUtils uploadReport = null;
		
		if(fileNode != null) {
			// if file node is not loaded
			if(fileNode.getFileNodeId() != null) {
				fileNode = fundReleasedService.loadFileNode(fileNode.getFileNodeId());
				if(multipartFile != null) {
					uploadReport = FileNodeUtils.updateFile(multipartFile, fileNode);
				if(uploadReport.getUploadStatus() == FileNodeUtils.UPLOAD_STATUS.REQUESTED_FAILED) 
					throw new RuntimeException();	
				}
		} else {
			uploadReport = FileNodeUtils.createNewFile(multipartFile, uploadPath, getNameForFile(string, "pdf"));
			if(uploadReport.getUploadStatus() == FileNodeUtils.UPLOAD_STATUS.REQUESTED_FAILED)
				throw new RuntimeException();
		}
	}
	return uploadReport;
}
	
	private String getNameForFile( String formName, String extension) {
		return String.format("Uploaded_Fund_Released_%d_%d_%s.%s", userPreference.getStateCode(), userPreference.getFinYearId(),formName ,extension);
	}
	
	  @RequestMapping(value="getFundReleasedPdf" , method=RequestMethod.POST )
	  public void getQprCbActivityPdf(@ModelAttribute("QPR_CAPACITY_BUILDING")QprCbActivity qprCbActivity,
			  @RequestParam(value = "nodeId", required = false) Integer nodeId,  @RequestParam(value="inline", required=false) Boolean inline,
				HttpServletResponse response) {
		  FileNode fileNode = null;
		  fileNode= fundReleasedService.loadFileNode(nodeId);
		  
		if(inline==null)
			inline=true;
		FileNodeUtils.streamFileNode(fileNode, response, inline);
	  }

}
