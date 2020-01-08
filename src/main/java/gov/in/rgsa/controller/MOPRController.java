package gov.in.rgsa.controller;

import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Collections;
import java.util.Comparator;
import java.util.Date;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.io.FilenameUtils;
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
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import gov.in.rgsa.entity.AttachmentMaster;
import gov.in.rgsa.entity.FinYear;
import gov.in.rgsa.entity.InnovativeActivity;
import gov.in.rgsa.entity.InnovativeActivityDetails;
import gov.in.rgsa.entity.QprAdminAndFinancialDataActivity;
import gov.in.rgsa.entity.QprEnablement;
import gov.in.rgsa.entity.QuarterTrainings;
import gov.in.rgsa.entity.ReleaseIntallment;
import gov.in.rgsa.entity.SanctionOrderCompomentAmount;
import gov.in.rgsa.entity.SanctionOrderComponent;
import gov.in.rgsa.entity.State;
import gov.in.rgsa.model.Response;
import gov.in.rgsa.model.SnactionOrderModel;
import gov.in.rgsa.service.CommonService;
import gov.in.rgsa.service.FileUploadService;
import gov.in.rgsa.service.IncomeEnhancementService;
import gov.in.rgsa.service.InnovativeActivityService;
import gov.in.rgsa.service.MOPRService;
import gov.in.rgsa.user.preference.UserPreference;
import gov.in.rgsa.utils.Message;

@Controller
public class MOPRController {
	
   @Autowired
   private MOPRService moprService;
   
   @Autowired
   private CommonService commonService;
   
	 @Autowired
	private InnovativeActivityService innovativeActivityService;
	 
	 @Autowired
	private IncomeEnhancementService enhancementService;
	 
	 @Autowired
	 private FileUploadService fileUploadService;
	 
	 @Autowired
	 private UserPreference userPreference;
		   
   
   public static final String SANCTION_ORDER = "sanctionOrder";
   
   public static final Integer SANCTION_ORDER_FILE_LOC_ID =2;
  
   public static final String SANCTION_ORDER_NEW = "senctionOrderForm";
   
	public static final String REDIRECT_SANCTION_ORDER_NEW = "redirect:senctionOrderForm.html";
   
	
	@RequestMapping(value="sanctionOrder",method=RequestMethod.GET)
	public String showGISStatewisePlanStatus( Model model, RedirectAttributes re) {
		model.addAttribute("yearId",userPreference.getFinYearId());
		return SANCTION_ORDER;
	}
	
	@ResponseBody
	@RequestMapping(value="allStateList",method=RequestMethod.GET)
	public List<State>  allStateList(@RequestParam("yearId") Integer yearId){
		return moprService.getStateListApprovedbyCEC(yearId);
	}
	
	@ResponseBody
	@RequestMapping(value="allFinYearList",method=RequestMethod.GET)
	public List<FinYear>  allFinYearList(){
		return commonService.findAllFinYear();
	}
	
	@ResponseBody
	@RequestMapping(value="fetchAllSanctionOrderComponent",method=RequestMethod.GET)
	public List<SanctionOrderComponent>  fetchAllSanctionOrderComponent(){
		return moprService.fetchAllSanctionOrderComponent();
	}
	
	
	@ResponseBody
	@RequestMapping(value="fetchAllSanctionOrderCompomentAmount",method=RequestMethod.GET)
	public List<SanctionOrderCompomentAmount>  fetchAllSanctionOrderCompomentAmount(Integer planCode,Integer installmentNo){
		return moprService.fetchAllSanctionOrderCompomentAmount(planCode,installmentNo);
	}
	
	@ResponseBody
	@RequestMapping(value="uploadFiletoServer",method=RequestMethod.POST)
	public Response  uploadFiletoServer(HttpServletRequest request, HttpServletResponse response){
		  MultipartHttpServletRequest mRequest;
		  Response response1=new Response();
			try {
			   mRequest = (MultipartHttpServletRequest) request;
			   mRequest.getParameterMap();
			   Iterator itr = mRequest.getFileNames();
			   while (itr.hasNext()) {
			        MultipartFile mFile = mRequest.getFile(itr.next().toString());
			        AttachmentMaster attachmentMaster = innovativeActivityService.findfilePath(SANCTION_ORDER_FILE_LOC_ID);
					
					String path = attachmentMaster.getFileLocation();
					if(mFile.isEmpty()) {
						response1.setResponseMessage("File Upload Required");
						response1.setResponseCode(500);
						return response1;
					}
					 
					else if(!mFile.getContentType().equalsIgnoreCase("application/pdf") ) {
						response1.setResponseMessage("File Upload Type Required(PDF)");
						response1.setResponseCode(500);
						return response1;
					}
					else if(mFile.getSize() > 2097152) {
						response1.setResponseMessage("Max File Size is 5MB");
						response1.setResponseCode(500);
						return response1;
					}
			        
					String fileArr[]=moprService.saveAttachment(mFile, path).split("@");
					
					if(fileArr[1].equals("Sucess")) {
						response1.setResponseMessage("File Upload Sucessfully");
						response1.setResponseResult(fileArr[0]);
						response1.setResponseCode(200);
						return response1;
					}else {
						response1.setResponseMessage("File Upload Unsucessfully");
						response1.setResponseCode(500);
						return response1;
					}				 }
			}catch(Exception e) {
				e.printStackTrace();
			}
			return response1;
	}
	
	/*@ResponseBody
	@RequestMapping(value="saveSanctionOrder",method=RequestMethod.POST)
	public Response  saveSanctionOrder(@RequestBody final SnactionOrderModel snactionOrderModel,HttpServletRequest request, HttpServletResponse httpServletResponse){
		return moprService.saveSanctionOrderDetails(snactionOrderModel);
	}*/
	
	@ResponseBody
	@RequestMapping(value="fetchSanctionOrderData",method=RequestMethod.GET)
	public SnactionOrderModel  fetchSanctionOrderData(Integer planCode,Integer installmentNo){
		return moprService.fetchSanctionOrderData(planCode,installmentNo);
	}
	
	@RequestMapping(value="downloadSanctionOrder")
	public String  downloadSanctionOrder(@ModelAttribute("SnactionOrderModel") SnactionOrderModel snactionOrderModel ,HttpServletRequest request,HttpServletResponse response) throws Exception{
		
		
	String filename="",fileNameReal="",extnsn ="", path="";
		
		//path = innovativeActivity.getPath();
		filename=snactionOrderModel.getDbFileName().replace(",", "");
		
		AttachmentMaster attachmentMaster = enhancementService.findDetailsofAttachmentMaster();
		String uploadLocation = attachmentMaster.getFileLocation();
			// = fileUploadLocation.replace(",", "");
					extnsn = FilenameUtils.getExtension(filename);
					fileNameReal=filename;
					fileNameReal=fileNameReal.substring(0, filename.length()-4);
					fileNameReal=fileNameReal.substring(0,filename.indexOf("_")) + "."+ extnsn;
					response.setContentType("application/octet-stream");
				
				ServletOutputStream sos =response.getOutputStream();
				String dispatchHeader="attachment;filename=\""+fileNameReal+"\"";
				response.setHeader("Content-Disposition",dispatchHeader);
				uploadLocation=uploadLocation.replace("\\\\", "/");
				String rootPath = uploadLocation.replace("\\", "/");
				
				String dirPath=rootPath;
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
	
	@RequestMapping(value="senctionOrderForm",method=RequestMethod.GET)
	public String  senctionOrderForm(@ModelAttribute("SnactionOrderModel") SnactionOrderModel snactionOrderModel, Model model){
		
		try {
		if(snactionOrderModel.getPlanCode() != null && snactionOrderModel.getInstallmentNo() != null ) {
		List<SanctionOrderCompomentAmount> sanctionOrderCompomentAmount = fetchAllSanctionOrderCompomentAmount(snactionOrderModel.getPlanCode(), snactionOrderModel.getInstallmentNo());
		model.addAttribute("sanctionOrderCompomentAmount",sanctionOrderCompomentAmount);
		model.addAttribute("stateList", moprService.getStateListApprovedbyCEC(userPreference.getFinYearId())); 
		model.addAttribute("yearId", userPreference.getFinYearId()); 
		model.addAttribute("InstallmentNo",snactionOrderModel.getInstallmentNo() ); 
		model.addAttribute("PlanCode",snactionOrderModel.getPlanCode()); 
		SnactionOrderModel fetchReleaseInstalment =   moprService.fetchSanctionOrderData(snactionOrderModel.getPlanCode(),snactionOrderModel.getInstallmentNo());
		if(fetchReleaseInstalment != null) {
			model.addAttribute("fetchReleaseInstalment",fetchReleaseInstalment); 
			String date = fetchReleaseInstalment.getReleaseIntallment().getReleaseDate().toString().split(" ")[0];
			   model.addAttribute("date",date); 
		}
		}else {
			model.addAttribute("stateList", moprService.getStateListApprovedbyCEC(userPreference.getFinYearId())); 
			model.addAttribute("InstallmentNo",snactionOrderModel.getInstallmentNo() ); 
			model.addAttribute("PlanCode",snactionOrderModel.getPlanCode());
		}
		model.addAttribute("msgFlag",snactionOrderModel.getFlag());
		//model.addAttribute("stateList", moprService.getStateListApprovedbyCEC(snactionOrderModel.getYearId())); 
		
		}catch(Exception e) {
			e.printStackTrace();
		}
		 return SANCTION_ORDER_NEW;
		
		
	}
	
	
	@RequestMapping(value = "senctionOrderForm", method = RequestMethod.POST)
	public String saveadminDataFinQuaterly(
			@ModelAttribute("SnactionOrderModel") SnactionOrderModel snactionOrderModel,
			Model model, RedirectAttributes redirectAttributes)throws IOException {
		if (snactionOrderModel.getOrigin().equalsIgnoreCase("onclick")) {
			return senctionOrderForm(snactionOrderModel, model);
		}
		if("".equals(snactionOrderModel.getSactionDate()) ) {
			snactionOrderModel.setFlag(true);
			return senctionOrderForm(snactionOrderModel, model);
		}
		for(int i =0;i<snactionOrderModel.getSanctionOrderCompomentAmountList().size();i++) { 
			if(snactionOrderModel.getSanctionOrderCompomentAmountList().get(i).getFile() != null && snactionOrderModel.getSanctionOrderCompomentAmountList().get(i).getFile().getSize()!=0) {
				
				MultipartFile file =snactionOrderModel.getSanctionOrderCompomentAmountList().get(i).getFile();
				
			String filename = file.getOriginalFilename();
			String filenameWithoutExtnsn = FilenameUtils.removeExtension(filename); 
			String extnsn = FilenameUtils.getExtension(filename);
			
			 AttachmentMaster attachmentMaster = innovativeActivityService.findfilePath(SANCTION_ORDER_FILE_LOC_ID);
			
			String path = attachmentMaster.getFileLocation();
			if(file.isEmpty()) {
				redirectAttributes.addFlashAttribute(Message.ERROR_KEY,"File Upload Required");
				return REDIRECT_SANCTION_ORDER_NEW;
			}
			else if(!file.getContentType().equals("application/pdf")) {
				redirectAttributes.addFlashAttribute(Message.ERROR_KEY,"File Upload Type Required(Pdf)");
				return REDIRECT_SANCTION_ORDER_NEW;
			}
			else if(file.getSize() > 2097152) {
				redirectAttributes.addFlashAttribute(Message.ERROR_KEY,"Max File Size is 2MB");
				return REDIRECT_SANCTION_ORDER_NEW;
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
			File dir = new File(path);
			if(!dir.exists())
			dir.mkdir();
			BufferedOutputStream stream = new BufferedOutputStream(new FileOutputStream(dir+"/"+newFilename));
			stream.write(bytes);
			stream.close();
			
			/*snactionOrderModel.getSanctionOrderCompomentAmountList().get(i).setFileContentType(file.getContentType());
			snactionOrderModel.getSanctionOrderCompomentAmountList().get(i).setFileLocation(path);*/
			snactionOrderModel.getSanctionOrderCompomentAmountList().get(i).setFilePath(newFilename);
			}
		}
		Boolean flag =moprService.saveSanctionOrderDetails(snactionOrderModel);
		if(flag) {
		redirectAttributes.addFlashAttribute(Message.SUCCESS_KEY, Message.SAVE_SUCCESS);
		}else {
			redirectAttributes.addFlashAttribute(Message.ERROR_KEY,"Saction Order Plan not ready");
		}
		
		return REDIRECT_SANCTION_ORDER_NEW;
	}

	
	
	
}
