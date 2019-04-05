package gov.in.rgsa.controller;

import java.io.DataInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.util.List;
import java.util.ResourceBundle;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import gov.in.rgsa.dto.UploadDocumentDTO;
import gov.in.rgsa.entity.State;
import gov.in.rgsa.entity.UploadDocument;
import gov.in.rgsa.entity.UploadDocumentType;
import gov.in.rgsa.model.CmsModel;
import gov.in.rgsa.model.FacadeModel;
import gov.in.rgsa.service.CMSService;
import gov.in.rgsa.service.LGDService;


@Controller
public class DocumentController {

	public static final String DOWNLOAD_FILE = "document.download";
	public static final String DOWNLOAD_FILE_USERWISE = "document.downloadUserWise";
	public static final String DOWNLOAD_FILE_USERWISE_DISPLAY = "document.downloadUserWise.display";
	
	private static String FILE_LOCATION ; //= ResourceBundle.getBundle("application").getString("upload.file.location.officeorder").trim();
	
	@Autowired
	private LGDService lgdService;
	
	@Autowired
	private CMSService cmsService;

	@Value("${upload.file.location.officeorder}")
	public void setOfficeOrderUploadLocation(String uploadLocation) {
		FILE_LOCATION = uploadLocation;
	}
	
	@RequestMapping(value="downloadFiles")
	public String downloadFile(){		
		return DOWNLOAD_FILE;
	}
	
	@RequestMapping(value="downloadNew" , method = RequestMethod.GET)
	public String downloadFileUserWise(@ModelAttribute("Cms_model") CmsModel form,
						Model model,RedirectAttributes re)throws Exception{		
		 model.addAttribute("FACADE_MODEL", new FacadeModel()); 
		List<State> statelist = lgdService.getAllStateList();		
		model.addAttribute("STATE_LIST", statelist);
		
		List<UploadDocumentType> list = cmsService.getDocumentType();			
		model.addAttribute("DOCUMENT_TYPE_LIST", list);
	
		List<UploadDocumentDTO> documentListCenter= cmsService.getDocumentListforCenter();
		model.addAttribute("DOCUMENT_LIST_CENTER", documentListCenter);
		
		/*List<UploadDocumentDTO> documentListState= cmsService.getDocumentListForState();
		model.addAttribute("DOCUMENT_LIST_STATE", documentListState);		*/
		
		Integer circularCount=0;
		Integer goCount=0;
		Integer presentationCount=0;
		Integer campMatCount=0;
		Integer campSche =0;
		Integer portalInfoCount=0;
		
		if(documentListCenter!=null && documentListCenter.size()>0){
			for(int i=0;i<documentListCenter.size();i++){
				if(documentListCenter.get(i).getTypeId()==1)
				{ 
					presentationCount=1;
				}
				if(documentListCenter.get(i).getTypeId()==2)
				{ 
					circularCount=1;
				}
				if(documentListCenter.get(i).getTypeId()==3)
				{ 
					goCount=1;
				}
				if(documentListCenter.get(i).getTypeId()==4)
				{ 
					campMatCount=1;
				}
				if(documentListCenter.get(i).getTypeId()==5)
				{ 
					campSche=1;
				}
				if(documentListCenter.get(i).getTypeId()==6)
				{ 
					portalInfoCount=1;
				}
			}			
		}
		model.addAttribute("presentationCount",presentationCount);
		model.addAttribute("circularCount",circularCount);
		model.addAttribute("goCount",goCount);
		model.addAttribute("campMatCount",campMatCount);
		model.addAttribute("campSche",campSche);
		model.addAttribute("portalInfoCount",portalInfoCount);
		
		//List<UploadDocumentDTO> documentListState= cmsService.getDocumentListForState();
		//model.addAttribute("DOCUMENT_LIST_STATE", documentListState);
		model.addAttribute("displayDiv", "center");
		
		return DOWNLOAD_FILE_USERWISE;
	}
	
	
	
	
	@RequestMapping(value="downloadNew1" , method = RequestMethod.GET)
	public String downloadFileUserWisePost(@ModelAttribute("Cms_model") CmsModel form,
			/*@RequestParam(value="stateId",required=false) Integer stateId,*/
			Model model,RedirectAttributes re)throws Exception{	
		 model.addAttribute("FACADE_MODEL", new FacadeModel()); 
		List<State> statelist = lgdService.getAllStateList();		
		model.addAttribute("STATE_LIST", statelist);
		
		List<UploadDocumentType> list = cmsService.getDocumentType();			
		model.addAttribute("DOCUMENT_TYPE_LIST", list);
	
		List<UploadDocumentDTO> documentListCenter= cmsService.getDocumentListforCenter();
		model.addAttribute("DOCUMENT_LIST_CENTER", documentListCenter);
		
		Integer circularCount=0;
		Integer goCount=0;
		Integer presentationCount=0;
		Integer campMatCount=0;
		Integer campSche =0;
		Integer portalInfoCount=0;
		Integer newCount = 0;
		
		if(documentListCenter!=null && documentListCenter.size()>0){
			for(int i=0;i<documentListCenter.size();i++){
				if(documentListCenter.get(i).getTypeId()==1)
				{ 
					presentationCount=1;
				}
				if(documentListCenter.get(i).getTypeId()==2)
				{ 
					circularCount=1;
				}
				if(documentListCenter.get(i).getTypeId()==3)
				{ 
					goCount=1;
				}
				if(documentListCenter.get(i).getTypeId()==4)
				{ 
					campMatCount=1;
				}
				if(documentListCenter.get(i).getTypeId()==5)
				{ 
					campSche=1;
				}
				if(documentListCenter.get(i).getTypeId()==6)
				{ 
					portalInfoCount=1;
				}
				
				if(documentListCenter.get(i).getTypeId()==7)
				{ 
					newCount=1;
				}
			}			
		}
		
		model.addAttribute("presentationCount",presentationCount);
		model.addAttribute("circularCount",circularCount);
		model.addAttribute("goCount",goCount);
		model.addAttribute("campMatCount",campMatCount);
		model.addAttribute("campSche",campSche);
		model.addAttribute("portalInfoCount",portalInfoCount);
		
		List<UploadDocumentDTO> documentListState= cmsService.getDocumentListForState(form.getStateCode());
		model.addAttribute("DOCUMENT_LIST_STATE", documentListState);		
		
		Integer circularCountS=0;
		Integer goCountS=0; 
		Integer presentationCountS=0;
		Integer campMatCountS=0;
		Integer campScheS =0;
		Integer portalInfoCountS=0;
		Integer newCountS = 0;
		
		if(documentListState!=null && documentListState.size()>0){
			for(int i=0;i<documentListState.size();i++){
				if(documentListState.get(i).getTypeId()==1)
				{ 
					presentationCountS=1;
				}
				if(documentListState.get(i).getTypeId()==2)
				{ 
					circularCountS=1;
				}
				if(documentListState.get(i).getTypeId()==3)
				{ 
					goCountS=1;
				}
				if(documentListState.get(i).getTypeId()==4)
				{ 
					campMatCountS=1;
				}
				if(documentListState.get(i).getTypeId()==5)
				{ 
					campScheS=1;
				}
				if(documentListState.get(i).getTypeId()==6)
				{ 
					portalInfoCountS=1;
				}
				if(documentListState.get(i).getTypeId()==7)
				{ 
					newCountS=1;
				}
			}			
		}
		model.addAttribute("presentationCountS",presentationCountS);
		model.addAttribute("circularCountS",circularCountS);
		model.addAttribute("goCountS",goCountS);
		model.addAttribute("campMatCountS",campMatCountS);
		model.addAttribute("campScheS",campScheS);
		model.addAttribute("portalInfoCountS",portalInfoCountS);
		form.setStateCode(form.getStateCode());
		model.addAttribute("stateCode", form.getStateCode());
		//List<UploadDocumentDTO> documentListState= cmsService.getDocumentListForState();
		//model.addAttribute("DOCUMENT_LIST_STATE", documentListState);
		model.addAttribute("displayDiv", "state");
		
		return DOWNLOAD_FILE_USERWISE;
	}
	
	
	
	
	@RequestMapping(value="downloadFilesUserWise" , method = RequestMethod.POST)
	public String downloadFileUserWisePost( Model model,RedirectAttributes re) throws Exception{		
		List<State> statelist = lgdService.getAllStateList();		
		model.addAttribute("STATE_LIST", statelist);
		
		List<UploadDocumentType> list = cmsService.getDocumentType();			
		model.addAttribute("DOCUMENT_TYPE_LIST", list);
		
		
		return DOWNLOAD_FILE_USERWISE;
	}
	
	@RequestMapping(value = "downloadFile", method = RequestMethod.GET)
	public String downloadFile(
			@RequestParam(value = "fileName", required = false) String fileName,						 
							 HttpServletResponse response,RedirectAttributes re, Model model) throws Exception {
		
		try{		
			StringBuffer filePath = new StringBuffer();		
			String filePathname=FILE_LOCATION.toString();
			filePath.append(filePathname).append(File.separator).append(fileName);

			File file=new File(filePath.toString());
			if(file.exists()){
				
				int length = 0;
				ServletOutputStream outputStream = response.getOutputStream();
				response.setContentType("application/octet-stream");											
				response.setContentLength((int) file.length());	
				if(fileName!=null)
				response.setHeader("Content-Disposition", "attachment; filename=\""+fileName+ "\"");            
				byte[] bbuf = new byte[4 * 1024];
				
				@SuppressWarnings("resource")
				DataInputStream dataStream=null;
				try{
					dataStream = new DataInputStream(new FileInputStream(file));  //Unreleased Resource: Streams
				    while ((dataStream != null) && ((length = dataStream.read(bbuf)) != -1)) {
					outputStream.write(bbuf, 0, length);//					
				};
				return null;
			}finally{try{
				if(dataStream!=null){
				dataStream.close();
				outputStream.flush();
				outputStream.close();
				}}catch(Exception e){e.printStackTrace();
				}}
				
			}
			else{				
				List<UploadDocumentType> list = cmsService.getDocumentType();			
				model.addAttribute("DOCUMENT_TYPE_LIST", list);
				
				List<UploadDocumentDTO> documentListCenter= cmsService.getDocumentListforCenter();
				
				/*List<UploadDocumentDTO> documentListState= cmsService.getDocumentListForState();
				*/
				model.addAttribute("DOCUMENT_LIST_CENTER", documentListCenter);
				//model.addAttribute("DOCUMENT_LIST_STATE", documentListState);
				return DOWNLOAD_FILE_USERWISE;
			}
		}catch(Exception e){
			throw e;
		}
	}
	
	@RequestMapping(value = "docs", method = RequestMethod.GET)
	public String downloadFileById(
			@RequestParam(value = "fileId", required = true) Integer fileId,						 
							 HttpServletResponse response,RedirectAttributes re, Model model) throws Exception {
		
		try{	
			
			UploadDocument doc=cmsService.findDocument(fileId);
			/*StringBuffer filePath = new StringBuffer();		
			String filePathname=FILE_LOCATION.toString();
			filePath.append(filePathname).append(File.separator).append(fileName);*/

			File file=new File(doc.getFileLocation());
			if(file.exists()){
				
				int length = 0;
				ServletOutputStream outputStream = response.getOutputStream();
				response.setContentType("application/octet-stream");											
				response.setContentLength((int) file.length());	
				if(doc.getFileName()!=null)
				response.setHeader("Content-Disposition", "attachment; filename=\""+doc.getFileName()+ "\"");            
				byte[] bbuf = new byte[4 * 1024];
				
				@SuppressWarnings("resource")
				DataInputStream dataStream=null;
				try{
					dataStream = new DataInputStream(new FileInputStream(file));  //Unreleased Resource: Streams
				    while ((dataStream != null) && ((length = dataStream.read(bbuf)) != -1)) {
					outputStream.write(bbuf, 0, length);//					
				};
				return null;
			}finally{try{
				if(dataStream!=null){
				dataStream.close();
				outputStream.flush();
				outputStream.close();
				}}catch(Exception e){e.printStackTrace();
				}}
				
			}
			return null;
			
		}catch(Exception e){
			throw e;
		}
	}
}
