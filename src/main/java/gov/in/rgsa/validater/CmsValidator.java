package gov.in.rgsa.validater;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.validation.Errors;
import org.springframework.validation.Validator;
import org.springframework.web.multipart.commons.CommonsMultipartFile;

import gov.in.rgsa.model.CmsModel;



@Component()
public class CmsValidator implements Validator{

	@Override
	public boolean supports(Class<?> arg0) {
		// TODO Auto-generated method stub
		return false;
	}

	@Autowired
	private CommonValidator commonValidatorUtil;
	
	@Override
	public void validate(Object obj, Errors errors) {
		
		CmsModel form=(CmsModel)obj;
		if(form.getDocumentType() == null|| form.getDocumentType().equals(0)) {
			errors.rejectValue("userType","Error.Required");
		}
		if(form.getFileTitle() == null || form.getFileTitle().equals("")) {
			errors.rejectValue("userId","Error.Required");
		}	
		
		 if(form.getAttach()!=null && form.getAttach().getSize()>0){			
			CommonsMultipartFile multipartFile = form.getAttach();
			String fileNameOriginal = multipartFile.getOriginalFilename();			
			
			Integer indexOfDot = fileNameOriginal.lastIndexOf(".");
		
			String fileExtension = fileNameOriginal.substring(indexOfDot, fileNameOriginal.length());
			if(fileExtension!=null && (!fileExtension.equalsIgnoreCase(".pdf") 
					&& !fileExtension.equalsIgnoreCase(".ppt") && !fileExtension.equalsIgnoreCase(".pptx") 
					&& !fileExtension.equalsIgnoreCase(".jpeg") && !fileExtension.equalsIgnoreCase(".png")
					&& !fileExtension.equalsIgnoreCase(".docx") && !fileExtension.equalsIgnoreCase(".doc") 
					&& !fileExtension.equalsIgnoreCase(".zip")))
			{
				errors.rejectValue("attach","Error.fileextension");
			}
			/*long sizeofFile=(multipartFile.getSize()) / 1024;
			if(sizeofFile>2048){
				errors.rejectValue("attach","Error.size");
			}	*/		 
		}else{
			errors.rejectValue("attach","Error.Required");
		}
	}

	public void validateModify(Object obj, Errors errors) {
		
		CmsModel form=(CmsModel)obj;
		if(form.getDocumentType() == null|| form.getDocumentType().equals(0)) {
			errors.rejectValue("userType","Error.Required");
		}
		if(form.getFileTitle() == null || form.getFileTitle().equals("")) {
			errors.rejectValue("userId","Error.Required");
		}	
		
		 if(form.getAttach()!=null && form.getAttach().getSize()>0){			
			CommonsMultipartFile multipartFile = form.getAttach();
			String fileNameOriginal = multipartFile.getOriginalFilename();			
			
			Integer indexOfDot = fileNameOriginal.lastIndexOf(".");
		
			String fileExtension = fileNameOriginal.substring(indexOfDot, fileNameOriginal.length());
			if(fileExtension!=null && (!fileExtension.equalsIgnoreCase(".pdf") 
					&& !fileExtension.equalsIgnoreCase(".ppt") && !fileExtension.equalsIgnoreCase(".pptx") 
					&& !fileExtension.equalsIgnoreCase(".jpeg") && !fileExtension.equalsIgnoreCase(".png")
					&& !fileExtension.equalsIgnoreCase(".docx") && !fileExtension.equalsIgnoreCase(".doc")))
			{
				errors.rejectValue("attach","Error.fileextension");
			}
			/*long sizeofFile=(multipartFile.getSize()) / 1024;
			if(sizeofFile>2048){
				errors.rejectValue("attach","Error.size");
			}	*/		 
		}
	}
}
