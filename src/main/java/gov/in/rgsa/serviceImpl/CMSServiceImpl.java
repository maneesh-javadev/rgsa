package gov.in.rgsa.serviceImpl;

import java.io.File;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.ResourceBundle;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.commons.CommonsMultipartFile;

import gov.in.rgsa.dao.CommonRepository;
import gov.in.rgsa.dto.UploadDocumentDTO;
import gov.in.rgsa.entity.UploadDocument;
import gov.in.rgsa.entity.UploadDocumentType;
import gov.in.rgsa.model.CmsModel;
import gov.in.rgsa.service.CMSService;
import gov.in.rgsa.user.preference.UserPreference;
import gov.in.rgsa.validater.CommonValidator;




@Service
public class CMSServiceImpl implements CMSService{
	
	@Autowired
	private CommonRepository dao;
	
	@Autowired
	private UserPreference userPreference;
	
	@Autowired
	private CommonValidator commonValidatorUtil;
	
	private static String FILE_LOCATION; // = ResourceBundle.getBundle("application").getString("upload.file.location.officeorder").trim();

	@Value("${upload.file.location.officeorder}")
	public void setOfficeOrderUploadLocation(String uploadLocation) {
		FILE_LOCATION = uploadLocation;
	}
	
	@Override
	public List<UploadDocumentType> getDocumentType() throws Exception {		
		List<UploadDocumentType> documentTypeList =  dao.findAll("DOCUMENT_TYPE_LIST", null);
		return  documentTypeList;
	}
	
	/*public  List<UploadDocumentDTO> getDocumentList(Integer stateId) throws Exception{		
		List<UploadDocumentDTO> documentList =  dao.findAll("GET_DOCUMENT_LIST", null);
		return  documentList;
	}*/
	public  List<UploadDocumentDTO> getDocumentList(Integer createdBy) throws Exception{
		Map<String, Object> docParam = new HashMap<String, Object>();
		docParam.put("createdBy", createdBy);	
		List<UploadDocumentDTO> documentList =  dao.findAll("GET_DOCUMENT_LIST", docParam);
		return  documentList;
	}
	public  List<UploadDocumentDTO> getDocumentListForState(Integer stateCode) throws Exception{
		Map<String, Object> docParam = new HashMap<String, Object>();
		docParam.put("stateCode", stateCode);		
		List<UploadDocumentDTO> documentList =  dao.findAll("GET_STATE_DOCUMENT_LIST", docParam);
		return  documentList;
	}
	
	public  List<UploadDocumentDTO> getDocumentListforCenter() throws Exception{
		List<UploadDocumentDTO> documentList =  dao.findAll("GET_CENTER_DOCUMENT_LIST", null);
		return  documentList;
	}
	public  UploadDocument findDocument(Integer uploadDocumentId) throws Exception{
		Map<String, Object> docParam = new HashMap<String, Object>();
		docParam.put("uploadDocumentId", uploadDocumentId);		
		UploadDocument document=dao.find("GET_DOCUMENT", docParam);
		return document;
	}
	
	public Boolean saveCms(CmsModel form) throws Exception{

		UploadDocument uploadDocument=new UploadDocument();
		
		uploadDocument.setStateCode(form.getStateCode());
		uploadDocument.setFileTitle(form.getFileTitle());
		uploadDocument.setTypeId(form.getDocumentType());
		uploadDocument.setCreatedBy(userPreference.getUserId());
		uploadDocument.setCreatedOn(new Date());	
	
		if(form.getAttach()!=null && form.getAttach().getSize()>0){
			
			CommonsMultipartFile multipartFile = form.getAttach();
			String fileNameOriginal = multipartFile.getOriginalFilename();
			
			StringBuilder filePath = new StringBuilder();
			StringBuffer uploadFileName = new StringBuffer();
			Integer indexOfDot = fileNameOriginal.lastIndexOf(".");
			String prefixNameOfFile = fileNameOriginal.substring(0, indexOfDot);
			String fileExtension = fileNameOriginal.substring(indexOfDot, fileNameOriginal.length());
			uploadFileName.append(prefixNameOfFile).append("_").append(new Date().getTime()).append(fileExtension);
			final String ATTACH_FILE_LOCATION = FILE_LOCATION;
			filePath.append(ATTACH_FILE_LOCATION.toString()).append(File.separator).append(uploadFileName.toString());
		
			//if(commonValidatorUtil.validateAlphaNumericForFilePath(filePath.toString())){	
				File serverFile = new File(filePath.toString());  
				multipartFile.transferTo(serverFile);
				uploadDocument.setFileLocation(filePath.toString());
			//}
			//if(commonValidatorUtil.validateAlphaNumericForFileName(uploadFileName.toString())){
				uploadDocument.setFileName(uploadFileName.toString());
				form.setFileName(uploadFileName.toString());				
			//} 
		}	
		try {
			dao.save(uploadDocument);
		} catch (Exception e) {			
			return false;
		}    
		
		return true;	
	}
	
	public Boolean modifyCms(CmsModel form) throws Exception{

		UploadDocument uploadDocument=new UploadDocument();
		
		uploadDocument.setUploadDocumentId(form.getUploadDocumentId());
		uploadDocument.setStateCode(form.getStateCode());
		uploadDocument.setFileTitle(form.getFileTitle());
		uploadDocument.setTypeId(form.getDocumentType());
		uploadDocument.setCreatedBy(userPreference.getUserId());
		uploadDocument.setCreatedOn(new Date());	
		
	
		if(form.getAttach()!=null && form.getAttach().getSize()>0){
			
			CommonsMultipartFile multipartFile = form.getAttach();
			String fileNameOriginal = multipartFile.getOriginalFilename();
			
			StringBuilder filePath = new StringBuilder();
			StringBuffer uploadFileName = new StringBuffer();
			Integer indexOfDot = fileNameOriginal.lastIndexOf(".");
			String prefixNameOfFile = fileNameOriginal.substring(0, indexOfDot);
			String fileExtension = fileNameOriginal.substring(indexOfDot, fileNameOriginal.length());
			uploadFileName.append(prefixNameOfFile).append("_").append(new Date().getTime()).append(fileExtension);
			final String ATTACH_FILE_LOCATION = FILE_LOCATION;
			filePath.append(ATTACH_FILE_LOCATION.toString()).append(File.separator).append(uploadFileName.toString());
		
			/*if(commonValidatorUtil.validateAlphaNumericForFilePath(filePath.toString())){*/	
				File serverFile = new File(filePath.toString());  
				multipartFile.transferTo(serverFile);
				uploadDocument.setFileLocation(filePath.toString());
				uploadDocument.setFileName(uploadFileName.toString());
				form.setFileName(uploadFileName.toString());	
			/*}
			if(commonValidatorUtil.validateAlphaNumericForFileName(uploadFileName.toString())){
				uploadDocument.setFileName(uploadFileName.toString());
				form.setFileName(uploadFileName.toString());				
			} */
		}
		else{
			String fileNameOriginal = form.getFileName();
			StringBuilder filePath = new StringBuilder();
			StringBuffer uploadFileName = new StringBuffer();
			final String ATTACH_FILE_LOCATION = FILE_LOCATION;
			uploadFileName.append(fileNameOriginal);
			filePath.append(ATTACH_FILE_LOCATION.toString()).append(File.separator).append(uploadFileName.toString());
		
			if(commonValidatorUtil.validateAlphaNumericForFilePath(filePath.toString())){				
				uploadDocument.setFileLocation(filePath.toString());
			}
			if(commonValidatorUtil.validateAlphaNumericForFileName(uploadFileName.toString())){
				uploadDocument.setFileName(uploadFileName.toString());
				form.setFileName(uploadFileName.toString());				
			} 
		}
		try {
			dao.update(uploadDocument);
		} catch (Exception e) {			
			return false;
		}    
		
		return true;	
	}
}
