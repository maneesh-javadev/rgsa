package gov.in.rgsa.service;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.multipart.commons.CommonsMultipartFile;

import gov.in.rgsa.entity.FileUpload;
import gov.in.rgsa.entity.StatewiseEntitiesCount;
import gov.in.rgsa.entity.UploadDocument;
import gov.in.rgsa.entity.ViewImage;
import gov.in.rgsa.model.FileUploadModel;



public interface FileUploadService {
	
	public Integer uploadFile(FileUploadModel fileUploadModel) throws Exception;

	public Integer uploadFile(CommonsMultipartFile multipartFile, FileUploadModel model) throws Exception;
	
	public FileUpload findFileDetails(Integer fileId);

	public void uploadFileWeb(FileUploadModel model) throws Exception;

	public void uploadFileService(FileUploadModel file) throws Exception;

	List<ViewImage> findLatestSixImage();

	public List<UploadDocument> findNew();
	
	public List<StatewiseEntitiesCount> rgsaEntitiesCountFn(boolean isCenter);
	
	public StatewiseEntitiesCount getDataFromJsonFile(); 
	
	public String downloadFiles(HttpServletRequest request,HttpServletResponse response,String filePath) throws IOException ;


	
}
