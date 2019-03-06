package gov.in.rgsa.controller;

import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Collections;
import java.util.Comparator;
import java.util.Date;
import java.util.List;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.io.FilenameUtils;
import org.hibernate.Session;
import org.hibernate.event.spi.EvictEvent;
import org.owasp.esapi.util.CollectionsUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import gov.in.rgsa.entity.AttachmentMaster;
import gov.in.rgsa.entity.Block;
import gov.in.rgsa.entity.IncomeEnhancementActivity;
import gov.in.rgsa.entity.IncomeEnhancementDetails;
import gov.in.rgsa.service.BasicInfoService;
import gov.in.rgsa.model.BasicInfoModel;
import gov.in.rgsa.entity.InnovativeActivity;
import gov.in.rgsa.service.IncomeEnhancementService;
import gov.in.rgsa.service.LGDService;
import gov.in.rgsa.user.preference.UserPreference;
import gov.in.rgsa.utils.Message;

@Controller
public class IncomeEnhancementController {
	
	@Autowired
	private LGDService lgdService;
	@Autowired
	private IncomeEnhancementService enhancementService;
	@Autowired
	private UserPreference userPreference;
	@Autowired
	BasicInfoService basicInfoService;
             public static final String REDIRECT_HOME_VIEW = "redirect:home.html";
	
	public static final String INCOME_ENHANCEMENT_PROJECT = "incomeEnhancement.add";
	public static final String INCOME_ENHANCEMENT_PROJECT_FOR_CEC = "incomeEnhancementCec";
	public static final String REDIRECT_INCOME_ENHANCEMENT_PROJECT = "redirect:incomeEnhancement.html";
	public static final String REDIRECT_BAISC_INFO_DETAILS = "redirect:basicinfo.add.html";
	public static final String REDIRECT_MODIFY_BAISC_INFO_DETAILS = "redirect:managebasicInfoDetails.html";

	@RequestMapping(value = "incomeEnhancement", method = RequestMethod.GET)
	private String incomeEnhancementDetails(@ModelAttribute("Income_Enhancement") IncomeEnhancementActivity incomeEnhancementActivity, Model model,RedirectAttributes redirectAttributes) {

		String status = basicInfoService.fillFirstBasicInfo();
		if(status.equals("create")) {
			redirectAttributes.addFlashAttribute(Message.EXCEPTION_KEY, "Please fill the Basic Info Details first");
			return REDIRECT_BAISC_INFO_DETAILS;
		}
		else if(status.equals("modify")) {
			redirectAttributes.addFlashAttribute(Message.EXCEPTION_KEY, "Please fill the Required Basic Info Details");
			return REDIRECT_MODIFY_BAISC_INFO_DETAILS;
		}
		
		List<IncomeEnhancementActivity> dbActivitiesList = enhancementService.fetchAllIncmEnhncmntActvty(userPreference.getUserType().charAt(0));
 		if(!CollectionUtils.isEmpty(dbActivitiesList)) {
			for(int i=0;i<dbActivitiesList.get(0).getIncomeEnhancementDetails().size();i++) {
				
					int distrctId = dbActivitiesList.get(0).getIncomeEnhancementDetails().get(i).getDistrictCode();
					List<Block> blockFromDb = fetchBlockListBasedOnDistrict(distrctId);
					dbActivitiesList.get(0).getIncomeEnhancementDetails().get(i).setBlockListFromDb(blockFromDb);
			}
			Collections.sort(dbActivitiesList.get(0).getIncomeEnhancementDetails(), Comparator.comparing(IncomeEnhancementDetails::getIncomeEnhancementDetailsId));
			
			List<IncomeEnhancementActivity> incomeEnhancementActivities ;
			if(dbActivitiesList.get(0).getUserType()=='S' && userPreference.getUserType().equals("M")) {
				incomeEnhancementActivities= new ArrayList<>(dbActivitiesList);
				incomeEnhancementActivities.get(0).setIncomeEnhancementId(null);
				incomeEnhancementActivities.get(0).getIncomeEnhancementDetails().iterator().next().setIncomeEnhancementDetailsId(null);
				incomeEnhancementActivities.get(0).setIsFreeze(false);
				incomeEnhancementActivities.get(0).setUserType('M');
				model.addAttribute("dbActivitiesList", incomeEnhancementActivities.get(0));
			}
			
			/*else if(dbActivitiesList.get(0).getUserType()=='S' && userPreference.getUserType().equals("C")) {
				incomeEnhancementActivities= new ArrayList<>(dbActivitiesList);
				incomeEnhancementActivities.get(0).setIncomeEnhancementId(null);
				incomeEnhancementActivities.get(0).getIncomeEnhancementDetails().iterator().next().setIncomeEnhancementDetailsId(null);
				incomeEnhancementActivities.get(0).setIsFreeze(false);
				incomeEnhancementActivities.get(0).setUserType('C');
				model.addAttribute("dbActivitiesList", incomeEnhancementActivities.get(0));
			}*/
			else if(userPreference.getUserType().equalsIgnoreCase("C")){
			
				List<IncomeEnhancementActivity> incomeEnhancementState= enhancementService.fetchAllIncmEnhncmntActvty('S');

			List<IncomeEnhancementDetails> incomeEnhancementDetailState= incomeEnhancementState.get(0).getIncomeEnhancementDetails();
			model.addAttribute("INCOMEENHANCEMENTDETAIL_STATE", incomeEnhancementDetailState);
			model.addAttribute("INCOMEENHANCEMENT_STATE", incomeEnhancementState);
			
			List<IncomeEnhancementActivity> incomeEnhancementMOPR= enhancementService.fetchAllIncmEnhncmntActvty('M');
			List<IncomeEnhancementDetails> incomeEnhancementDetailMOPR= incomeEnhancementMOPR.get(0).getIncomeEnhancementDetails();
			model.addAttribute("INCOMEENHANCEMENTDETAIL_MOPR", incomeEnhancementDetailMOPR);
			model.addAttribute("INCOMEENHANCEMENT_MOPR", incomeEnhancementMOPR.get(0));
			for(int i=0; i< incomeEnhancementDetailMOPR.size(); i++)
			{
				List<Block> block =fetchBlockListBasedOnDistrict(incomeEnhancementDetailMOPR.get(i).getDistrictCode());
				model.addAttribute("BLOCK", block);
				
			}
			model.addAttribute("dbActivitiesList", dbActivitiesList.get(0));
                             return INCOME_ENHANCEMENT_PROJECT_FOR_CEC;			
		}else{
 		Integer planStatus=userPreference.getPlanStatus();	
	    Boolean flag= false;
        if(planStatus!=null && planStatus==1 && userPreference.getUserType().equalsIgnoreCase("S")) {
        	flag = true;
		}else if(planStatus!=null && planStatus==2 && userPreference.getUserType().equalsIgnoreCase("M")) {
			flag = true;
		}
      	else {
      		flag= false;}
        model.addAttribute("Plan_Status", flag);
      	}
 		}
		model.addAttribute("schemeMasterList", enhancementService.schemeMasterList());
		model.addAttribute("districtList", lgdService.getAllDistrictBasedOnState(userPreference.getStateCode()));
		model.addAttribute("STATE_CODE", userPreference.getStateCode());
		
		if(dbActivitiesList!=null && !dbActivitiesList.isEmpty())
		{
		model.addAttribute("dbActivitiesList", dbActivitiesList.get(0));
		}
		else {
			model.addAttribute("dbActivitiesList", dbActivitiesList);
		}
 		
		return INCOME_ENHANCEMENT_PROJECT;

	}
	
	@RequestMapping(value="getBlockBasedOnDistrictCode",method=RequestMethod.GET)
	private @ResponseBody List<Block> fetchBlockListBasedOnDistrict(@RequestParam(value="setBlockId") int setBlockId){
		return lgdService.getAllBlockBasedOnDistrict(setBlockId);
	}
	
	@RequestMapping(value="incomeEnhancementAdd" ,method=RequestMethod.POST)
	private String saveIncomeEnhancementMethod(@ModelAttribute("Income_Enhancement") IncomeEnhancementActivity incomeEnhancementActivity, Model model,RedirectAttributes redirectAttributes) throws IOException {
		
		for(int i=0; i<incomeEnhancementActivity.getIncomeEnhancementDetails().size();i++) {
			if(incomeEnhancementActivity.getIncomeEnhancementDetails().get(i).getFile() != null && incomeEnhancementActivity.getIncomeEnhancementDetails().get(i).getFile().getSize()!=0) {
				
				MultipartFile file = incomeEnhancementActivity.getIncomeEnhancementDetails().get(i).getFile();
				
				String filename = file.getOriginalFilename();
				String filenameWithoutExtnsn = FilenameUtils.removeExtension(filename); 
				String extnsn = FilenameUtils.getExtension(filename);
				
				AttachmentMaster attachmentMaster = enhancementService.findDetailsofAttachmentMaster();
				
				String path = attachmentMaster.getFileLocation();
				
				if(file.isEmpty()) {
					redirectAttributes.addFlashAttribute(Message.ERROR_KEY,"File Upload Required");
					return REDIRECT_INCOME_ENHANCEMENT_PROJECT;
				}
				else if(!file.getContentType().equals("application/pdf")) {
					redirectAttributes.addFlashAttribute(Message.ERROR_KEY,"File Upload Type Required(Pdf)");
					return REDIRECT_INCOME_ENHANCEMENT_PROJECT;
				}
				else if(file.getSize() > 2097152) {
					redirectAttributes.addFlashAttribute(Message.ERROR_KEY,"Max File Size is 2MB");
					return REDIRECT_INCOME_ENHANCEMENT_PROJECT;
				}
				
				Date date = new Date() ;
				SimpleDateFormat dateFormat = new SimpleDateFormat("yyyyMMddHHmmss") ;
				String newFilename = filenameWithoutExtnsn + "_" + dateFormat.format(date) + "." + extnsn;
				
				/*......................File Delete code.................*/
				
				File deleteFile = new File(incomeEnhancementActivity.getPath() + "/" + incomeEnhancementActivity.getDbFileName() );
					if(deleteFile.exists()) {
						deleteFile.delete();
					}
					/*......................File Delete code.................*/
					
				byte[] bytes = file.getBytes();
				File dir = new File(path + File.separator + "incomeEnhancementActivityFiles");
				
				BufferedOutputStream stream = new BufferedOutputStream(new FileOutputStream(dir+"/"+newFilename));
				stream.write(bytes);
				stream.close();
				
				incomeEnhancementActivity.getIncomeEnhancementDetails().get(i).setFileContentType(file.getContentType());
				incomeEnhancementActivity.getIncomeEnhancementDetails().get(i).setFileLocation(path);
				incomeEnhancementActivity.getIncomeEnhancementDetails().get(i).setFileName(newFilename);
			}
		}
		enhancementService.saveDetailsWithUsertype(incomeEnhancementActivity);
		redirectAttributes.addFlashAttribute(Message.SUCCESS_KEY, "Save Successfully");
		
		return REDIRECT_INCOME_ENHANCEMENT_PROJECT;
	}
	
	@RequestMapping(value="frzUnfrzIncomeEnhancementActivity" , method=RequestMethod.POST)
	public String frzUnfrzIncomeEnhncmntMethod(@ModelAttribute("Income_Enhancement") IncomeEnhancementActivity incomeEnhancementActivity,HttpServletResponse httpResponse,Model model,RedirectAttributes redirectAttributes) {
		enhancementService.FrzUnfrz(incomeEnhancementActivity);
		if(incomeEnhancementActivity.getIsFreeze() == false) {
		redirectAttributes.addFlashAttribute(Message.SUCCESS_KEY, "Freeze Successfully");
		}else
		{
			redirectAttributes.addFlashAttribute(Message.SUCCESS_KEY, "Unfreeze Successfully");
		}
		
		return REDIRECT_INCOME_ENHANCEMENT_PROJECT;
	}
	
	@RequestMapping(value="deleteIncomeEnhancementDtls",method=RequestMethod.POST)
	public String deleteIncomeEnhancementDtlsMethod(@ModelAttribute("Income_Enhancement") IncomeEnhancementActivity incomeEnhancementActivity,Model model,HttpServletResponse httpResponse,RedirectAttributes redirectAttributes) {
		
		if(incomeEnhancementActivity.getIdToDelete() != null) {
			enhancementService.deleteIncmEnhncmntDtls(incomeEnhancementActivity.getIdToDelete());
			
			File deleteFile = new File(incomeEnhancementActivity.getPath() + "/" + "incomeEnhancementActivityFiles" + "/" + incomeEnhancementActivity.getDbFileName());
			if(deleteFile.exists()) {
				deleteFile.delete();
			}
			/*......................File Delete code.................*/
		redirectAttributes.addFlashAttribute(Message.DELETE_KEY,Message.DELETE_SUCCESS);
		}
		return REDIRECT_INCOME_ENHANCEMENT_PROJECT;
	}
	
	
	@RequestMapping(value="/viewFileOfIncmEnhncmntActivity", method=RequestMethod.POST)
	public String viewFileOfIncomeEnhancementActivityMethod(@ModelAttribute("Income_Enhancement") IncomeEnhancementActivity incomeEnhancementActivity,HttpServletResponse httpResponse) throws IOException {

		String filename="",fileNameReal="",extnsn ="", path="";
		
		path = incomeEnhancementActivity.getPath();
		filename=incomeEnhancementActivity.getDbFileName();
		
				String fileUploadLocation = incomeEnhancementActivity.getPath();
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
				
				String dirPath=rootPath + File.separator + "incomeEnhancementActivityFiles";
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
