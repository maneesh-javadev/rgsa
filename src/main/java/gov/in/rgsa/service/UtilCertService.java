package gov.in.rgsa.service;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ViewResolver;

import gov.in.rgsa.entity.FileNode;
import gov.in.rgsa.entity.UtilCert;
import gov.in.rgsa.model.multipart.FileNodeMultipart;
import gov.in.rgsa.model.multipart.StringMultiPartFile;
import gov.in.rgsa.utils.FileNodeUtils;

public interface UtilCertService {

	Map<Integer, String> getYearMap();

	Map<Integer, String> getInstallmentMap(Integer finYearId);
	
	FileNodeUtils uploadFile(MultipartFile multipartFile, Integer finYearId, Integer releaseInstallmentId);
	
	StringMultiPartFile generateFile(HttpServletRequest request, ViewResolver viewResolver, Integer finYearId, Integer releaseInstallmentId) throws Exception;
	
	FileNodeMultipart getUploadedFile(Integer finYearId, Integer releaseInstallmentId);

	String getNameForFile(Integer finYearId, Integer releaseInstallmentId, String extension);
	
	UtilCert getUtilCert(Integer finYearId, Integer releaseInstallmentId);

}