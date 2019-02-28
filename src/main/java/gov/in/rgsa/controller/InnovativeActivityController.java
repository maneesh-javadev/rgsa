package gov.in.rgsa.controller;

import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Collections;
import java.util.Comparator;
import java.util.Date;
import java.util.List;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.collections.CollectionUtils;
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
import gov.in.rgsa.entity.InnovativeActivity;
import gov.in.rgsa.entity.InnovativeActivityDetails;
import gov.in.rgsa.service.BasicInfoService;
import gov.in.rgsa.service.InnovativeActivityService;
import gov.in.rgsa.user.preference.UserPreference;
import gov.in.rgsa.utils.Message;
@Controller
public class InnovativeActivityController {
	
	@Autowired
	InnovativeActivityService innovativeActivityService;
	@Autowired
	UserPreference userPreference;
	@Autowired
	BasicInfoService basicInfoService;
	
	
	public static final String INNOVATIVE_ACTIVITY = "innovativeActivity";
	public static final String REDIRECT_INNOVATIVE_ACTIVITY = "redirect:innovativeActivity.html";
	public static final String INNOVATIVE_ACTIVITY_CEC = "innovativeActivityForCEC";
	public static final String REDIRECT_INN_ACT_CEC = "redirect:innovativeActivityForCEC.html";
	public static final String REDIRECT_BAISC_INFO_DETAILS = "redirect:basicinfo.add.html";
	public static final String REDIRECT_MODIFY_BAISC_INFO_DETAILS = "redirect:managebasicInfoDetails.html";
	
	@RequestMapping(value = "innovativeActivity", method = RequestMethod.GET)
	private String administrativeTechSupportStaff(@ModelAttribute("INNOVATIVE_ACTIVITY") InnovativeActivity innovativeActivity, Model model,RedirectAttributes redirectAttributes) {
		
		String status = basicInfoService.fillFirstBasicInfo();
		if(status.equals("create")) {
			redirectAttributes.addFlashAttribute(Message.EXCEPTION_KEY, "Please fill the Basic Info Details first");
			return REDIRECT_BAISC_INFO_DETAILS;
		}
		else if(status.equals("modify")) {
			redirectAttributes.addFlashAttribute(Message.EXCEPTION_KEY, "Please fill the Required Basic Info Details");
			return REDIRECT_MODIFY_BAISC_INFO_DETAILS;
		}
		
		List<InnovativeActivity> innovativeAcitivityList = innovativeActivityService.findAllActivity(userPreference.getUserType().charAt(0));
		
		if(!CollectionUtils.isEmpty(innovativeAcitivityList)) {
			if(userPreference.getUserType().equalsIgnoreCase("M") && innovativeAcitivityList.get(0).getUserType().equals('S')){
				innovativeAcitivityList.get(0).setIsFreeze(false);
				model.addAttribute("innovativeAcitivityList",innovativeAcitivityList);
			}else {
				Collections.sort(innovativeAcitivityList.get(0).getInnovativeActivityDetails(), Comparator.comparing(InnovativeActivityDetails::getId));
				model.addAttribute("innovativeAcitivityList",innovativeAcitivityList);
			}
		}
		
		if(userPreference.getUserType().equalsIgnoreCase("C"))
		{
			List<InnovativeActivity> innovativeAcitivityListForState =innovativeActivityService.findAllActivity('S');
			List<InnovativeActivity> innovativeAcitivityListForMopr =innovativeActivityService.findAllActivity('M');
			List<InnovativeActivityDetails> innovativeActivityDetailState =	innovativeAcitivityListForState.get(0).getInnovativeActivityDetails();
			List<InnovativeActivityDetails> innovativeActivityDetailsMopr =	innovativeAcitivityListForMopr.get(0).getInnovativeActivityDetails();

			long totalFundState = 0;
			long  totalFundMopr=0;
		for (int i = 0; i < innovativeActivityDetailState.size(); i++) {
			totalFundState =totalFundState +innovativeActivityDetailState.get(i).getFundsName();
			
		}
		for (int i = 0; i < innovativeActivityDetailsMopr.size(); i++) {
			totalFundMopr =totalFundMopr +innovativeActivityDetailsMopr.get(i).getFundsName();
			
		} 
		                
        		        long grandTotalForState = innovativeAcitivityListForState.get(0).getAdditioinalRequirements() +totalFundState;
		              model.addAttribute("TOTALFUNDForMopr", totalFundMopr);
		       	     model.addAttribute("innovativeAcitivityListForMopr", innovativeAcitivityListForMopr);
		       	  model.addAttribute("TOTALFUND", totalFundState);
		       	     model.addAttribute("GRANDTOTAL", grandTotalForState);
		       	
		       	  model.addAttribute("innovativeAcitivityListForState", innovativeAcitivityListForState);
	       	         model.addAttribute("innovativeActivityDetailState", innovativeActivityDetailState);
	                 model.addAttribute("innovativeActivityDetailsMopr", innovativeActivityDetailsMopr);
	        
	        return INNOVATIVE_ACTIVITY_CEC;
		}
		Integer planStatus=userPreference.getPlanStatus();	
	    Boolean flag= false;
        if(planStatus!=null && planStatus==1 && userPreference.getUserType().equalsIgnoreCase("S")) {
        	flag = true;
		}else if(planStatus!=null && planStatus==2 && userPreference.getUserType().equalsIgnoreCase("M")) {
			flag = true;
		}
      	else {
      		flag= false;
      	}
		model.addAttribute("Plan_Status", flag);
		
		model.addAttribute("INNOVATIVE_ACTIVITY", innovativeActivity);
		model.addAttribute("userTypeSwitch", userPreference.getUserType().charAt(0));
		return INNOVATIVE_ACTIVITY ;
	}
	
	/*@RequestMapping(value = "innovativeActivityForCEC", method = RequestMethod.GET)
	private String innovativeActivityForCEC(@ModelAttribute("INNOVATIVE_ACTIVITY") InnovativeActivity innovativeActivity, Model model) {
		
		List<InnovativeActivity> innovativeAcitivityListForState =innovativeActivityService.findAllActivity(userPreference.getUserType().charAt(0));
		//List<InnovativeActivity> innovativeAcitivityListForMoPR = innovativeActivityService.findAllActivity('M');
		
		if(!CollectionUtils.isEmpty(innovativeAcitivityListForState) && !CollectionUtils.isEmpty(innovativeAcitivityListForMoPR)) {
			model.addAttribute("innovativeAcitivityListForState",innovativeAcitivityListForState);
			model.addAttribute("innovativeAcitivityListForMoPR",innovativeAcitivityListForMoPR);
		}
		return INNOVATIVE_ACTIVITY_CEC ;
	}*/
	@RequestMapping(value="innovativeActivityDetails", method=RequestMethod.POST)
	private String saveInnovativeActivityDetails(@ModelAttribute("INNOVATIVE_ACTIVITY") InnovativeActivity innovativeActivity, Model model,RedirectAttributes redirectAttributes) throws IOException{
		
		Integer totalFund=00;
		Integer twentyFivePercntgOfTotalFund;
		
		for(int k =0;k<innovativeActivity.getInnovativeActivityDetails().size();k++) {
			if(innovativeActivity.getInnovativeActivityDetails().get(k).getFundsName() > 0) {
			totalFund += innovativeActivity.getInnovativeActivityDetails().get(k).getFundsName();}
		}
			twentyFivePercntgOfTotalFund = (25*totalFund)/100;
		
		if(innovativeActivity.getAdditioinalRequirements() > twentyFivePercntgOfTotalFund) {
			redirectAttributes.addFlashAttribute(Message.ERROR_KEY,"Additional Requirement can't be greater than 25% of Total Fund");
			/* if(userPreference.getUserType().charAt(0) == 'C') {
				 return REDIRECT_INN_ACT_CEC;
			 }else {*/
				 return REDIRECT_INNOVATIVE_ACTIVITY;
				 }
		
			for(int i =0;i<innovativeActivity.getInnovativeActivityDetails().size();i++) { 
			if(innovativeActivity.getInnovativeActivityDetails().get(i).getFile() != null && innovativeActivity.getInnovativeActivityDetails().get(i).getFile().getSize()!=0) {
				
				MultipartFile file =innovativeActivity.getInnovativeActivityDetails().get(i).getFile();
				
			String filename = file.getOriginalFilename();
			String filenameWithoutExtnsn = FilenameUtils.removeExtension(filename); 
			String extnsn = FilenameUtils.getExtension(filename);
			
			AttachmentMaster attachmentMaster = innovativeActivityService.findfilePath();
			
			String path = attachmentMaster.getFileLocation();
			if(file.isEmpty()) {
				redirectAttributes.addFlashAttribute(Message.ERROR_KEY,"File Upload Required");
				return REDIRECT_INNOVATIVE_ACTIVITY;
			}
			else if(!file.getContentType().equals("application/pdf")) {
				redirectAttributes.addFlashAttribute(Message.ERROR_KEY,"File Upload Type Required(Pdf)");
				return REDIRECT_INNOVATIVE_ACTIVITY;
			}
			else if(file.getSize() > 2097152) {
				redirectAttributes.addFlashAttribute(Message.ERROR_KEY,"Max File Size is 2MB");
				return REDIRECT_INNOVATIVE_ACTIVITY;
			}
			
			Date date = new Date() ;
			SimpleDateFormat dateFormat = new SimpleDateFormat("yyyyMMddHHmmss") ;
			String newFilename = filenameWithoutExtnsn + "_" + dateFormat.format(date) + "." + extnsn;
			
			/*......................File Delete code.................*/
			
			File deleteFile = new File(innovativeActivity.getPath() + "/" + innovativeActivity.getDbFileName() );
				if(deleteFile.exists()) {
					deleteFile.delete();
				}
				/*......................File Delete code.................*/
				
			byte[] bytes = file.getBytes();
			File dir = new File(path + File.separator + "innovativeActivityFiles");
			if(!dir.exists())
			dir.mkdir();
			BufferedOutputStream stream = new BufferedOutputStream(new FileOutputStream(dir+"/"+newFilename));
			stream.write(bytes);
			stream.close();
			
			innovativeActivity.getInnovativeActivityDetails().get(i).setFileContentType(file.getContentType());
			innovativeActivity.getInnovativeActivityDetails().get(i).setFileLocation(path);
			innovativeActivity.getInnovativeActivityDetails().get(i).setFileName(newFilename);
			}
		}
				innovativeActivityService.saveDetailsWithUsertype(innovativeActivity);
				
		/* model.addAttribute("innovativeAcitivityList",innovativeActivityService.findAllActivity(userPreference.getUserType().charAt(0)));
		 model.addAttribute("INNOVATIVE_ACTIVITY",innovativeActivity);
		 model.addAttribute("userTypeSwitch", userPreference.getUserType().charAt(0));*/
		 redirectAttributes.addFlashAttribute(Message.SUCCESS_KEY, Message.SAVE_SUCCESS);
		/* if(userPreference.getUserType().charAt(0) == 'C') {
			 return REDIRECT_INN_ACT_CEC;
		 }else {*/
			 return REDIRECT_INNOVATIVE_ACTIVITY;
			 
	}
	
	@RequestMapping(value="/deleteInnovativeActivity", method=RequestMethod.POST)
	public String deleteInnovactivityMethod(@ModelAttribute("INNOVATIVE_ACTIVITY") InnovativeActivity innovativeActivity,Model model,RedirectAttributes redirectAttributes) {
		if(innovativeActivity.getIdToDelete() != null) {
			int id = Integer.valueOf(innovativeActivity.getIdToDelete());
		innovativeActivityService.delete(id);
			/*......................File Delete code.................*/
		File deleteFile = new File(innovativeActivity.getPath() + "/" + "innovativeActivityFiles" + "/" + innovativeActivity.getDbFileName());
			if(deleteFile.exists()) {
				deleteFile.delete();
			}
			/*......................File Delete code.................*/
		redirectAttributes.addFlashAttribute(Message.DELETE_KEY,Message.DELETE_SUCCESS);
		}
		return REDIRECT_INNOVATIVE_ACTIVITY;
	}
	@RequestMapping(value="/freezUnfreez" , method=RequestMethod.POST) 
	public String freezeUnfreezemethod(@ModelAttribute("INNOVATIVE_ACTIVITY") InnovativeActivity innovativeActivity,Model model,RedirectAttributes redirectAttributes) {
		innovativeActivityService.freezeUnfreeze(innovativeActivity);
		/* if(userPreference.getUserType().charAt(0) == 'C') {
			 return REDIRECT_INN_ACT_CEC;
		 }else {*/
			 if(innovativeActivity.getIsFreeze() == true) {
					redirectAttributes.addFlashAttribute(Message.SUCCESS_KEY, "Freeze Successfully");
					}else
					{
						redirectAttributes.addFlashAttribute(Message.SUCCESS_KEY, "Unfreeze Successfully");
					}
			 return REDIRECT_INNOVATIVE_ACTIVITY;
			 }
	
	
	@RequestMapping(value="/viewFileOfInnovativeActivity", method=RequestMethod.POST)
	public String viewFileOfInnovativeActivityDetailsMethod(@ModelAttribute("INNOVATIVE_ACTIVITY") InnovativeActivity innovativeActivity,HttpServletResponse httpResponse) throws IOException {

		String filename="",fileNameReal="",extnsn ="", path="";
		
		path = innovativeActivity.getPath();
		filename=innovativeActivity.getDbFileName().replace(",", "");
		
				String fileUploadLocation = innovativeActivity.getPath();
				fileUploadLocation = fileUploadLocation.replace(",", "");
					extnsn = FilenameUtils.getExtension(filename);
					fileNameReal=filename;
					fileNameReal=fileNameReal.substring(0, fileNameReal.length()-4);
					fileNameReal=fileNameReal.substring(0,fileNameReal.indexOf("_")) + "."+ extnsn;
					httpResponse.setContentType("application/octet-stream");
				
				ServletOutputStream sos =httpResponse.getOutputStream();
				String dispatchHeader="attachment;filename=\""+fileNameReal+"\"";
				httpResponse.setHeader("Content-Disposition",dispatchHeader);
				fileUploadLocation=fileUploadLocation.replace("\\\\", "/");
				String rootPath = fileUploadLocation.replace("\\", "/");
				
				String dirPath=rootPath + File.separator + "innovativeActivityFiles";
				File file=new File(dirPath,filename);
				FileInputStream fis=new FileInputStream(file);
				byte[] output=new byte[4096];
				while(fis.read(output,0,4096)!=-1){
					sos.write(output,0,4096);
				}
				sos.flush();
				sos.close();
				fis.close();
				
				return null;
				}
	}



