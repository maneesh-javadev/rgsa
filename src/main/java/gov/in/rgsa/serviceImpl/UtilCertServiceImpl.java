package gov.in.rgsa.serviceImpl;

import gov.in.rgsa.dao.CommonRepository;
import gov.in.rgsa.entity.*;
import gov.in.rgsa.model.multipart.FileNodeMultipart;
import gov.in.rgsa.model.multipart.StringMultiPartFile;
import gov.in.rgsa.service.UtilCertService;
import gov.in.rgsa.user.preference.UserPreference;
import gov.in.rgsa.utils.FileNodeUtils;
import gov.in.rgsa.utils.FileNodeUtils.UPLOAD_STATUS;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.env.Environment;
import org.springframework.mock.web.MockHttpServletResponse;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.View;
import org.springframework.web.servlet.ViewResolver;

import javax.persistence.NoResultException;
import javax.servlet.http.HttpServletRequest;
import java.util.*;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import java.util.stream.Collectors;

@Service
public class UtilCertServiceImpl implements UtilCertService {

	private static final String UTIL_CERT_UPLOAD_PATH = "rgsa.filepath.util_cert_upload";
	private static final String UTIL_CERT_GENERATE_PATH = "rgsa.filepath.util_cert_generated";

	@Autowired
	private CommonRepository commonRepository;
	
	@Autowired
	private UserPreference userPreference;

	@Autowired
	private Environment environment;
	
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
			String uploadPath = environment.getProperty(UTIL_CERT_UPLOAD_PATH);
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
		boolean isNew = false;
	    UtilCert utilCert = getUtilCert(finYearId, releaseInstallmentId);

        if(utilCert == null) {
            utilCert = new UtilCert();
            setUCAttributes(utilCert, finYearId, releaseInstallmentId);
            isNew = true;
        }

		if(utilCert != null) { 
			FileNode gfNode = utilCert.getGeneratedFile();
			if(gfNode != null && FileNodeUtils.fileExists(gfNode.getFilePath(), gfNode.getFileName())) {
				String content = FileNodeUtils.readFile(gfNode.getFilePath(), gfNode.getFileName());
				StringMultiPartFile exMultiPartFile = StringMultiPartFile.createMultiPartFile(gfNode.getFileName(), content, gfNode.getFileMime());
				exMultiPartFile.setAttachment(utilCert);
				return exMultiPartFile;
			}
		}
		// Generate file
		String fileContent = getCertContent(request, viewResolver, finYearId, releaseInstallmentId);
		// ResourceBundle bundle = ResourceBundle.getBundle("config/application");
		String uploadPath= environment.getProperty(UTIL_CERT_GENERATE_PATH); //bundle.getString("rgsa.filepath.util_cert_generated");
		String fileName = getNameForFile(finYearId, releaseInstallmentId, "html");
		StringMultiPartFile multipartFile =  StringMultiPartFile.createMultiPartFile(fileName, fileContent) ;
		FileNodeUtils downloadReport = FileNodeUtils.createNewFile(multipartFile, uploadPath, fileName);
		commonRepository.save(downloadReport.getFileNode());
		utilCert.setGeneratedFile(downloadReport.getFileNode());
		if (isNew)
		    commonRepository.save(utilCert);
		else
		    commonRepository.update(utilCert);
		multipartFile.setAttachment(utilCert);
		return multipartFile;
	}

	private Double getSanctionAmount(Integer yearId, Integer installmentNumber, Integer stateCode){
        Map<String, Object> params = new HashMap<String, Object>(){{
            put("stateCode", stateCode);
            put("installmentNumber", installmentNumber);
            put("yearId", yearId);
        }};
        try {
            return commonRepository.find("INSTALLMENT_SANCTION_AMOUNT", params);
        }catch (NoResultException ex){
            return 0.0;
        }

    }

	private Double getUnspentAmount(Integer yearId, Integer installmentNumber, Integer stateCode){
        Map<String, Object> params = new HashMap<String, Object>(){{
            put("stateCode", stateCode);
            put("installmentNumber", installmentNumber);
            put("yearId", yearId);
        }};
        try {
            return commonRepository.find("INSTALLMENT_UNSPENT_AMOUNT", params);
        } catch (NoResultException ex) {
            return 0.0;
        }
    }

	private Double getSpentAmount(Integer yearId, Integer installmentNumber, Integer stateCode){
        Map<String, Object> params = new HashMap<String, Object>(){{
            put("stateCode", stateCode);
            put("yearId", yearId);
        }};
        QprPlanFunds qprPlanFunds = commonRepository.find(QprPlanFunds.class, params);
        if(qprPlanFunds == null)
            return 0.0;
        if (installmentNumber == 1)
            return qprPlanFunds.getQtr1Expenditure() + qprPlanFunds.getQtr2Expenditure()
            + qprPlanFunds.getQtr1AdditionalFund() + qprPlanFunds.getQtr2AdditionalFund();
        else
            return qprPlanFunds.getQtr3Expenditure() + qprPlanFunds.getQtr4Expenditure()
                + qprPlanFunds.getQtr3AdditionalFund() + qprPlanFunds.getQtr4AdditionalFund();

    }

    private String nextYear(FinYear finYear){
	    String currentYear = finYear.getFinYear().trim();
        Pattern pattern = Pattern.compile("(\\d+)\\-(\\d+)");
        Matcher matcher = pattern.matcher(currentYear);
        if(matcher.matches()){
            List<String> years = Arrays.asList(matcher.group(1), matcher.group(2));
            return years.stream().map(Integer::parseInt).map(x -> x+1).map(String::valueOf).collect(Collectors.joining("-"));
        }else {
            throw new RuntimeException(String.format("Invalid year format: %s", currentYear));
        }
    }
	
	private String getCertContent(HttpServletRequest request, ViewResolver viewResolver, Integer finYearId, Integer releaseInstallmentId) throws Exception {
		// @TODO: Complete all

		FinYear finYear = commonRepository.find(FinYear.class, finYearId);
		ReleaseIntallment releaseInstallment = commonRepository.find(ReleaseIntallment.class, releaseInstallmentId);
		Integer stateCode = userPreference.getStateCode();

        Double sanctionAmount = getSanctionAmount(finYearId, releaseInstallment.getInstallmentNo(), stateCode),
                unspentAmount = getUnspentAmount(finYearId, releaseInstallment.getInstallmentNo(), stateCode),
                spentAmount   = getSpentAmount(finYearId, releaseInstallment.getInstallmentNo(), stateCode);

		Map<String, Object> model = new HashMap<>();
		model.put("total_sanction", sanctionAmount);
		model.put("financial_year", finYear.getFinYear());
		model.put("payee", userPreference.getUserName());
		model.put("past_unspent", unspentAmount);
		model.put("spent", spentAmount);
		model.put("purpose", "Development");
		model.put("not_utilized", sanctionAmount + unspentAmount - spentAmount);
		model.put("letter_number", "ABC/123/XYZ");
		model.put("letter_date", "01-01-19");
		model.put("next_fin_year", nextYear(finYear));
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
