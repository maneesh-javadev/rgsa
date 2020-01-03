package gov.in.rgsa.controller;

import java.io.File;
import java.io.FileInputStream;
import java.util.Iterator;
import java.util.List;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
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
	
	@ResponseBody
	@RequestMapping(value="saveSanctionOrder",method=RequestMethod.POST)
	public Response  saveSanctionOrder(@RequestBody final SnactionOrderModel snactionOrderModel,HttpServletRequest request, HttpServletResponse httpServletResponse){
		return moprService.saveSanctionOrderDetails(snactionOrderModel);
	}
	
	@ResponseBody
	@RequestMapping(value="fetchSanctionOrderData",method=RequestMethod.GET)
	public SnactionOrderModel  fetchSanctionOrderData(Integer planCode,Integer installmentNo){
		return moprService.fetchSanctionOrderData(planCode,installmentNo);
	}
	
	@RequestMapping(value="downloadSanctionOrder")
	public String  downloadSanctionOrder(String fileName,HttpServletRequest request,HttpServletResponse response) throws Exception{
		AttachmentMaster attachmentMaster = enhancementService.findDetailsofAttachmentMaster();
		String uploadLocation = attachmentMaster.getFileLocation();
		//String filePath = uploadLocation + File.separator +fileName;
		//fileUploadService.downloadFiles(request, response, filePath);
		
		//File file1 = new File(filePath);
		
	
				
				/*String mimeType= URLConnection.guessContentTypeFromName(file.getName());
				if(mimeType==null){
					System.out.println("mimetype is not detectable, will take default");
					mimeType = "application/octet-stream";
				}
				
				System.out.println("mimetype : "+mimeType);
				
		        response.setContentType(mimeType);
		        
		         "Content-Disposition : inline" will show viewable types [like images/text/pdf/anything viewable by browser] right on browser 
		            while others(zip e.g) will be directly downloaded [may provide save as popup, based on your browser setting.]
		        response.setHeader("Content-Disposition", String.format("inline; filename=\"" + file.getName() +"\""));

		        
		         "Content-Disposition : attachment" will be directly download, may provide save as popup, based on your browser setting
		        //response.setHeader("Content-Disposition", String.format("attachment; filename=\"%s\"", file.getName()));
		        
		        response.setContentLength((int)file.length());

				InputStream inputStream = new BufferedInputStream(new FileInputStream(file));

		        //Copy bytes from source to destination(outputstream in this example), closes both streams.
		        FileCopyUtils.copy(inputStream, response.getOutputStream());
				 
				
		        }else{
		        	
		        	 }*/
		ServletOutputStream sos =response.getOutputStream();
			
			
			String dispatchHeader="attachment;filename=\""+fileName+"\"";
			response.setHeader("Content-Disposition",dispatchHeader);
			response.setContentType("application/pdf");
			uploadLocation=uploadLocation.replace("\\\\", "/");
			String rootPath = uploadLocation.replace("\\", "/");
			
			File file1 = new File(rootPath, fileName);
			FileInputStream fis=new FileInputStream(file1);
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
