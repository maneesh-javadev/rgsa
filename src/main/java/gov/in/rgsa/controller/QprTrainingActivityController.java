package gov.in.rgsa.controller;

import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.Date;
import java.util.List;

import org.apache.commons.io.FilenameUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import gov.in.rgsa.entity.AttachmentMaster;
import gov.in.rgsa.entity.CBMaster;
import gov.in.rgsa.entity.CapacityBuildingActivity;
import gov.in.rgsa.entity.QprCbActivity;
import gov.in.rgsa.entity.QprCbActivityDetails;
import gov.in.rgsa.service.CBMasterService;
import gov.in.rgsa.service.CapacityBuildingService;
import gov.in.rgsa.service.InnovativeActivityService;
import gov.in.rgsa.service.ProgressReportService;
import gov.in.rgsa.service.TrainingActivityService;
import gov.in.rgsa.user.preference.UserPreference;
import gov.in.rgsa.utils.Message;


@Controller
public class QprTrainingActivityController {
	
	public static final String QPR_CAPACITY_BUILDING ="qprCapacityBuilding";
	public static final String REDIRECT_QPR_CAPACITY_BUILDING ="redirect:qprCapacityBuilding.html";
	
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
	
	@RequestMapping(value="qprCapacityBuilding" , method=RequestMethod.GET)
	public String qprGetFormCapacityBuilding(@ModelAttribute("Qpr_Capacity_Building")QprCbActivity qprCbActivity,Model model){
		
		Integer qrtrId = qprCbActivity.getShowQqrtrId();
		QprCbActivity qprCbActivities =null;
		
		if(qrtrId != null){
		 qprCbActivities =progressReportService.fetchQprCapcityBuilding(qprCbActivity.getShowQqrtrId());
		 if(qprCbActivities !=null)
				Collections.sort(qprCbActivities.getQprCbActivityDetails(), Comparator.comparing(QprCbActivityDetails::getQprCbActivityDetailsId));
		}
		
		else{
		 qprCbActivities =progressReportService.fetchQprCapcityBuilding(1);
		 if(qprCbActivities !=null)
				Collections.sort(qprCbActivities.getQprCbActivityDetails(), Comparator.comparing(QprCbActivityDetails::getQprCbActivityDetailsId));
		}
		
		//CapacityBuildingActivity capacityBuildingActivity = capacityBuildingService.fetchCapacityBuildingActivity("M");
		List<CBMaster> cbMasters = new ArrayList<CBMaster>();
		
		cbMasters = cbMasterService.fetchCBMasters();
		model.addAttribute("SetNewQtrId", qprCbActivity.getShowQqrtrId());
		model.addAttribute("cbMasters", cbMasters);
		model.addAttribute("subjectsList",trainingActivityService.subjectsList()); 
		model.addAttribute("qprCbActivities", qprCbActivities);
		model.addAttribute("quarter_duration", progressReportService.getQuarterDurations());
		/*model.addAttribute("capacityBuildingActivity" , capacityBuildingActivity);
		model.addAttribute("capacityBuildingDetails", capacityBuildingActivity.getCapacityBuildingActivityDetails());
		*/
		return QPR_CAPACITY_BUILDING;
}
	
	@RequestMapping(value="qprCapacityBuildingBasedOnQtr" , method=RequestMethod.POST)
	private String qprCapacityBuildingBasedOnQtr(@ModelAttribute("Qpr_Capacity_Building")QprCbActivity qprCbActivity,Model model){
		
		Integer qrtrId = qprCbActivity.getShowQqrtrId();
		QprCbActivity qprCbActivities =null;
		
		if(qrtrId != null){
		 qprCbActivities =progressReportService.fetchQprCapcityBuilding(qprCbActivity.getShowQqrtrId());
		 if(qprCbActivities !=null)
				Collections.sort(qprCbActivities.getQprCbActivityDetails(), Comparator.comparing(QprCbActivityDetails::getQprCbActivityDetailsId));
		}
		
		else{
		 qprCbActivities =progressReportService.fetchQprCapcityBuilding(1);
		 if(qprCbActivities !=null)
				Collections.sort(qprCbActivities.getQprCbActivityDetails(), Comparator.comparing(QprCbActivityDetails::getQprCbActivityDetailsId));
		}
		
		//CapacityBuildingActivity capacityBuildingActivity = capacityBuildingService.fetchCapacityBuildingActivity();
		List<CBMaster> cbMasters = new ArrayList<CBMaster>();
		
		cbMasters = cbMasterService.fetchCBMasters();
		model.addAttribute("SetNewQtrId", qprCbActivity.getShowQqrtrId());
		model.addAttribute("cbMasters", cbMasters);
		model.addAttribute("subjectsList",trainingActivityService.subjectsList()); 
		model.addAttribute("qprCbActivities", qprCbActivities);
		model.addAttribute("quarter_duration", progressReportService.getQuarterDurations());
		//model.addAttribute("capacityBuildingActivity" , capacityBuildingActivity);
		//model.addAttribute("capacityBuildingDetails", capacityBuildingActivity.getCapacityBuildingActivityDetails());
		
		return QPR_CAPACITY_BUILDING;
	}
	
	@RequestMapping(value="saveQprCapacityBuilding" ,  method=RequestMethod.POST )
	public String saveQprCapacityBuilding(@ModelAttribute("Qpr_Capacity_Building")QprCbActivity qprCbActivity,Model model,RedirectAttributes redirectAttributes) throws IOException{
		/*-------------file upload code-------------------*/
		int x[] = {0,3};
		for(int i : x){
			MultipartFile file = qprCbActivity.getQprCbActivityDetails().get(i).getQprTnaTrgEvaluation().get(0).getFile();
		if(file != null && !file.isEmpty()){
			
		String filename = file.getOriginalFilename();
		String filenameWithoutExtnsn = FilenameUtils.removeExtension(filename); 
		String extnsn = FilenameUtils.getExtension(filename);
		
		AttachmentMaster attachmentMaster = innovativeActivityService.findfilePath();
		
		String path = attachmentMaster.getFileLocation();
		if(file.isEmpty()) {
			redirectAttributes.addFlashAttribute(Message.ERROR_KEY,"File Upload Required");
			return REDIRECT_QPR_CAPACITY_BUILDING;
		}
		else if(!file.getContentType().equals("application/pdf")) {
			redirectAttributes.addFlashAttribute(Message.ERROR_KEY,"File Upload Type Required(Pdf)");
			return REDIRECT_QPR_CAPACITY_BUILDING;
		}
		else if(file.getSize() > 2097152) {
			redirectAttributes.addFlashAttribute(Message.ERROR_KEY,"Max File Size is 2MB");
			return REDIRECT_QPR_CAPACITY_BUILDING;
		}
		
		Date date = new Date() ;
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyyMMddHHmmss") ;
		String newFilename = filenameWithoutExtnsn + "_" + dateFormat.format(date) + "." + extnsn;
		
		/*......................File Delete code.................
		
		File deleteFile = new File(innovativeActivity.getPath() + "/" + innovativeActivity.getDbFileName() );
			if(deleteFile.exists()) {
				deleteFile.delete();
			}
			......................File Delete code.................
			*/
		byte[] bytes = file.getBytes();
		File dir = new File(path + File.separator + "qprFiles");
		if(!dir.exists())
		dir.mkdir();
		BufferedOutputStream stream = new BufferedOutputStream(new FileOutputStream(dir+"/"+newFilename));
		stream.write(bytes);
		stream.close();
		
		qprCbActivity.getQprCbActivityDetails().get(i).getQprTnaTrgEvaluation().get(0).setFileContentType(file.getContentType());
		qprCbActivity.getQprCbActivityDetails().get(i).getQprTnaTrgEvaluation().get(0).setFileLocation(path);
		qprCbActivity.getQprCbActivityDetails().get(i).getQprTnaTrgEvaluation().get(0).setFileName(newFilename);
		} 
		
	}
		MultipartFile filegpdp = qprCbActivity.getQprCbActivityDetails().get(6).getQprHandholdingGpdp().getFile();
		if(filegpdp != null && !filegpdp.isEmpty()){
			
			String filename = filegpdp.getOriginalFilename();
			String filenameWithoutExtnsn = FilenameUtils.removeExtension(filename); 
			String extnsn = FilenameUtils.getExtension(filename);
			
			AttachmentMaster attachmentMaster = innovativeActivityService.findfilePath();
			
			String path = attachmentMaster.getFileLocation();
			if(filegpdp.isEmpty()) {
				redirectAttributes.addFlashAttribute(Message.ERROR_KEY,"File Upload Required");
				return REDIRECT_QPR_CAPACITY_BUILDING;
			}
			else if(!filegpdp.getContentType().equals("application/pdf")) {
				redirectAttributes.addFlashAttribute(Message.ERROR_KEY,"File Upload Type Required(Pdf)");
				return REDIRECT_QPR_CAPACITY_BUILDING;
			}
			else if(filegpdp.getSize() > 2097152) {
				redirectAttributes.addFlashAttribute(Message.ERROR_KEY,"Max File Size is 2MB");
				return REDIRECT_QPR_CAPACITY_BUILDING;
			}
			
			Date date = new Date() ;
			SimpleDateFormat dateFormat = new SimpleDateFormat("yyyyMMddHHmmss") ;
			String newFilename = filenameWithoutExtnsn + "_" + dateFormat.format(date) + "." + extnsn;
			
			byte[] bytes = filegpdp.getBytes();
			File dir = new File(path + File.separator + "qprFiles");
			if(!dir.exists())
			dir.mkdir();
			BufferedOutputStream stream = new BufferedOutputStream(new FileOutputStream(dir+"/"+newFilename));
			stream.write(bytes);
			stream.close();
			
			qprCbActivity.getQprCbActivityDetails().get(6).getQprHandholdingGpdp().setFileContentType(filegpdp.getContentType());
			qprCbActivity.getQprCbActivityDetails().get(6).getQprHandholdingGpdp().setFileLocation(path);
			qprCbActivity.getQprCbActivityDetails().get(6).getQprHandholdingGpdp().setFileName(newFilename);
			}
		
		MultipartFile filePanchayat = qprCbActivity.getQprCbActivityDetails().get(7).getQprPanchayatLearningCenter().getFile();
		if(filePanchayat != null && !filePanchayat.isEmpty()){
			
			String filename = filePanchayat.getOriginalFilename();
			String filenameWithoutExtnsn = FilenameUtils.removeExtension(filename); 
			String extnsn = FilenameUtils.getExtension(filename);
			
			AttachmentMaster attachmentMaster = innovativeActivityService.findfilePath();
			
			String path = attachmentMaster.getFileLocation();
			if(filePanchayat.isEmpty()) {
				redirectAttributes.addFlashAttribute(Message.ERROR_KEY,"File Upload Required");
				return REDIRECT_QPR_CAPACITY_BUILDING;
			}
			else if(!filePanchayat.getContentType().equals("application/pdf")) {
				redirectAttributes.addFlashAttribute(Message.ERROR_KEY,"File Upload Type Required(Pdf)");
				return REDIRECT_QPR_CAPACITY_BUILDING;
			}
			else if(filePanchayat.getSize() > 2097152) {
				redirectAttributes.addFlashAttribute(Message.ERROR_KEY,"Max File Size is 2MB");
				return REDIRECT_QPR_CAPACITY_BUILDING;
			}
			
			Date date = new Date() ;
			SimpleDateFormat dateFormat = new SimpleDateFormat("yyyyMMddHHmmss") ;
			String newFilename = filenameWithoutExtnsn + "_" + dateFormat.format(date) + "." + extnsn;
			
			byte[] bytes = filePanchayat.getBytes();
			File dir = new File(path + File.separator + "qprFiles");
			if(!dir.exists())
			dir.mkdir();
			BufferedOutputStream stream = new BufferedOutputStream(new FileOutputStream(dir+"/"+newFilename));
			stream.write(bytes);
			stream.close();
			
			qprCbActivity.getQprCbActivityDetails().get(7).getQprPanchayatLearningCenter().setFileContentType(filePanchayat.getContentType());
			qprCbActivity.getQprCbActivityDetails().get(7).getQprPanchayatLearningCenter().setFileLocation(path);
			qprCbActivity.getQprCbActivityDetails().get(7).getQprPanchayatLearningCenter().setFileName(newFilename);
			}
		
		/*-------------file upload code-------------------*/
		progressReportService.saveQprCbActivity(qprCbActivity);
		redirectAttributes.addFlashAttribute(Message.SUCCESS_KEY, Message.SAVE_SUCCESS);
		return REDIRECT_QPR_CAPACITY_BUILDING;
	}
}
