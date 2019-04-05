package gov.in.rgsa.serviceImpl;

import gov.in.rgsa.dao.CommonRepository;
import gov.in.rgsa.entity.FileNode;
import gov.in.rgsa.entity.FinYear;
import gov.in.rgsa.entity.ReleaseIntallment;
import gov.in.rgsa.entity.UtilCert;
import gov.in.rgsa.model.multipart.FileNodeMultipart;
import gov.in.rgsa.model.multipart.StringMultiPartFile;
import gov.in.rgsa.service.UtilCertService;
import gov.in.rgsa.user.preference.UserPreference;
import gov.in.rgsa.utils.FileNodeUtils;
import gov.in.rgsa.utils.FileNodeUtils.UPLOAD_STATUS;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mock.web.MockHttpServletResponse;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.View;
import org.springframework.web.servlet.ViewResolver;

import javax.servlet.http.HttpServletRequest;
import java.util.*;

@Service
public class UtilCertServiceImpl implements UtilCertService {
	@Autowired
	private CommonRepository commonRepository;
	
	@Autowired
	private UserPreference userPreference;
	
	public Map<Integer, String> getYearMap() {
		Map<Integer, String> yearMap = new HashMap<>();
		
		yearMap.put(0, " --- Select --- ");
		for (FinYear finYear : commonRepository.findAll(FinYear.class)) {
			yearMap.put(finYear.getYearId(), finYear.getFinYear());
		}
		return yearMap;
	}
	
	public Map<Integer, String> getInstallmentMap(Integer finYearId) {
		Map<Integer, String> installmentMap = new HashMap<>();
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("yearId", finYearId);
		params.put("stateCode", userPreference.getStateCode());
		List<ReleaseIntallment> installments = commonRepository.findAll("ReleaseInstallmentByYearState", params);
		for (ReleaseIntallment ri : installments) {
			installmentMap.put(ri.getReleaseIntallmentSno(), Integer.toString(ri.getInstallmentNo()));
		}
		return installmentMap;
	}
	
	public FileNodeUtils uploadFile(MultipartFile multipartFile, Integer finYearId, Integer releaseInstallmentId) {
		UtilCert utilCert = getUtilCert(finYearId, releaseInstallmentId);
    	FileNodeUtils uploadReport;
    	uploadReport = utilCert == null ? new FileNodeUtils(multipartFile) : new FileNodeUtils(multipartFile, utilCert.getUploadFile());
    	if(utilCert == null) {
    		uploadReport.setUploadStatus(UPLOAD_STATUS.NEVER_DOWNLOADED);
    		return uploadReport;
    	}
    	if(!utilCert.getUploadAllowed()) {
    		uploadReport.setUploadStatus(UPLOAD_STATUS.UPDATE_PROHIBITED);
    		return uploadReport;
    	}
    	FileNode fileNode = utilCert.getUploadFile();
    	
		if(fileNode != null) {
			uploadReport = FileNodeUtils.updateFile(multipartFile, fileNode);
			if(uploadReport.getUploadStatus() == FileNodeUtils.UPLOAD_STATUS.REQUESTED_FAILED)
				return uploadReport;			
		} else {
			String uploadPath=ResourceBundle.getBundle("application").getString("rgsa.filepath.util_cert_upload");
			uploadReport = FileNodeUtils.createNewFile(multipartFile, uploadPath, getNameForFile(finYearId, releaseInstallmentId, "pdf"));
			if(uploadReport.getUploadStatus() == FileNodeUtils.UPLOAD_STATUS.REQUESTED_FAILED)
				return uploadReport;
		}
		commonRepository.save(uploadReport.getFileNode());
		utilCert.setUploadFile(uploadReport.getFileNode());
		commonRepository.save(utilCert);
		return uploadReport;
	}
	
	public StringMultiPartFile generateFile(HttpServletRequest request, ViewResolver viewResolver, Integer finYearId, Integer releaseInstallmentId) throws Exception {
		UtilCert utilCert = getUtilCert(finYearId, releaseInstallmentId);
		if(utilCert != null) { 
			FileNode gfNode = utilCert.getGeneratedFile();
			if(gfNode != null && FileNodeUtils.fileExists(gfNode.getFilePath(), gfNode.getFileName())) {
				String content = FileNodeUtils.readFile(gfNode.getFilePath(), gfNode.getFileName());
				StringMultiPartFile exMultiPartFile = StringMultiPartFile.createMultiPartFile(gfNode.getFileName(), content, gfNode.getFileMime());
				exMultiPartFile.setAttachment(utilCert);
				return exMultiPartFile;
			}
		}
		if(utilCert == null) {
			utilCert = new UtilCert();
			setUCAttributes(utilCert, finYearId, releaseInstallmentId);
		}
		// Generate file
		String fileContent = getCertContent(request, viewResolver, finYearId, releaseInstallmentId);
		String uploadPath=ResourceBundle.getBundle("application").getString("rgsa.filepath.util_cert_generated");
		String fileName = getNameForFile(finYearId, releaseInstallmentId, "html");
		StringMultiPartFile multipartFile =  StringMultiPartFile.createMultiPartFile(fileName, fileContent) ;
		FileNodeUtils downloadReport = FileNodeUtils.createNewFile(multipartFile, uploadPath, fileName);
		commonRepository.save(downloadReport.getFileNode());
		utilCert.setGeneratedFile(downloadReport.getFileNode());
		commonRepository.save(utilCert);
		multipartFile.setAttachment(utilCert);
		return multipartFile;
	}
	
	private String getCertContent(HttpServletRequest request, ViewResolver viewResolver, Integer finYearId, Integer releaseInstallmentId) throws Exception {
		// @TODO: Complete all
		FinYear finYear = commonRepository.find(FinYear.class, finYearId);
		Map<String, Object> model = new HashMap<>();
		model.put("total_sanction", 2900000);
		model.put("financial_year", finYear.getFinYear());
		model.put("payee", "XYZ");
		model.put("past_unspent", 200000);
		model.put("spent", 3000000);
		model.put("purpose", "Development");
		model.put("not_utilized", 100000);
		model.put("letter_number", "ABC/123/XYZ");
		model.put("letter_date", "01-01-19");
		model.put("next_fin_year", "2019-20");
		MockHttpServletResponse mockResp = new MockHttpServletResponse();
		View resolvedView = viewResolver.resolveViewName("UtilizationCertificateTmpl", Locale.getDefault());
		resolvedView.render(model, request, mockResp);
		return  mockResp.getContentAsString();
	}
	
	public FileNodeMultipart getUploadedFile(Integer finYearId, Integer releaseInstallmentId) {
		UtilCert utilCert = getUtilCert(finYearId, releaseInstallmentId);
		if(utilCert == null)
			return null;
		return new FileNodeMultipart(utilCert.getUploadFile());
	}
	
	public String getNameForFile(Integer finYearId, Integer releaseInstallmentId, String extension) {
		// @TODO: inject user service
		int stateCode = userPreference.getStateCode();
		return String.format("Uploaded_UtilCert_%d_%d_%d.%s", stateCode, finYearId, releaseInstallmentId, extension);
	}
	
	public UtilCert getUtilCert(Integer finYearId, Integer releaseInstallmentId) {
		Map<String, Object> passParams = new HashMap<>();
    	passParams.put("stateCode", userPreference.getStateCode());
    	passParams.put("finYear", finYearId);
    	passParams.put("releaseInstallment", releaseInstallmentId);
    	return commonRepository.find(UtilCert.class, passParams);
	}
	
	private UtilCert setUCAttributes(UtilCert utilCert, Integer finYearId, Integer releaseInstallmentId) {
//		throw new NotImplementedException();
		utilCert.setStateCode(userPreference.getStateCode());
		utilCert.setFinYear(commonRepository.find(FinYear.class, finYearId));
		utilCert.setReleaseInstallment(commonRepository.find(ReleaseIntallment.class, releaseInstallmentId));
		utilCert.setCreatedBy(userPreference.getUserId());
		utilCert.setLastUpdatedBy(userPreference.getUserId());
		return utilCert;
	}
	
}
