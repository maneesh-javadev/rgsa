package gov.in.rgsa.service;

import java.util.List;

import gov.in.rgsa.dto.UploadDocumentDTO;
import gov.in.rgsa.entity.UploadDocument;
import gov.in.rgsa.entity.UploadDocumentType;
import gov.in.rgsa.model.CmsModel;





public interface CMSService {

	public  List<UploadDocumentType> getDocumentType() throws Exception;
	
	public Boolean saveCms(CmsModel form) throws Exception;
	
	//public  List<UploadDocumentDTO> getDocumentList(Integer stateId) throws Exception;
	public  List<UploadDocumentDTO> getDocumentList(Integer createdBy) throws Exception;
	
	public  List<UploadDocumentDTO> getDocumentListForState(Integer stateCode) throws Exception;
	
	public  List<UploadDocumentDTO> getDocumentListforCenter() throws Exception;
	
	
	public  UploadDocument findDocument(Integer uploaddocumentId) throws Exception;
	
	//public  List<UploadDocument> getDocumentList() throws Exception;
	
	public Boolean modifyCms(CmsModel form) throws Exception;
	
	
	
}
