package gov.in.rgsa.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.mock.web.MockHttpServletResponse;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.View;
import org.springframework.web.servlet.ViewResolver;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import gov.in.rgsa.dao.CommonRepository;
import gov.in.rgsa.entity.FileNode;
import gov.in.rgsa.entity.FinYear;
import gov.in.rgsa.entity.ReleaseIntallment;
import gov.in.rgsa.entity.UtilCert;
import gov.in.rgsa.model.UcertModel;
import gov.in.rgsa.model.multipart.FileNodeMultipart;
import gov.in.rgsa.model.multipart.StringMultiPartFile;
import gov.in.rgsa.service.UtilCertService;
import gov.in.rgsa.utils.FileNodeUtils;
import gov.in.rgsa.utils.Message;

@Controller
public class UtilizationCertController {
	
	@Autowired
	private UtilCertService utilCertService;
	
	@Autowired
	private ViewResolver viewResolver;
	
	@RequestMapping(value = "getUtilCerPage", method = RequestMethod.GET)
	public String getUtilCerPage(Model model) {
		UcertModel ucertModel = getBasicModel(null, null, null);
		model.addAttribute("command", ucertModel);
		return "UtilizationCertificatePage";
	}
	
	@RequestMapping(value = "getUtilCerPage", method = RequestMethod.POST)
	public String procUtilCerPage(@RequestParam(value="file", required=false) MultipartFile multipartFile, 
			@ModelAttribute("command")UcertModel ucertModel, 
			BindingResult result, 
			Model model) {
		// https://www.mkyong.com/spring-mvc/spring-mvc-form-handling-example/
		// https://www.baeldung.com/spring-mvc-form-tutorial
		
		ucertModel = getBasicModel(ucertModel, ucertModel.getSelectedYear(), ucertModel.getSelectedInstallment());
		if(ucertModel.isProcessed() && multipartFile != null) {
			// this is upload state
			return uploadUtilCertification(multipartFile, ucertModel, model);
		} else {
			model.addAttribute("command", ucertModel);
			return "UtilizationCertificatePage";
		}
	}
	
//	@RequestMapping(value = "uploadUtilCertification", method = RequestMethod.POST)
//	public String uploadUtilCertification(@RequestParam("file") MultipartFile multipartFile,
//			@ModelAttribute("command")UcertModel ucertModel, Model model) 
	private String uploadUtilCertification(MultipartFile multipartFile, UcertModel ucertModel, Model model)
	{
		final String allowedMime = "application/pdf";
		final String ERROR_KEY="alert-danger", SUCCESS_KEY="alert-success";
		final Long ALLOWED_SIZE = 5*1024*1024L;
		Integer finYearId = ucertModel.getSelectedYear();
		Integer releaseInstallmentId = ucertModel.getSelectedInstallment();
		
		if(! multipartFile.getContentType().equals(allowedMime)) {
			return uploadReply(ucertModel, ERROR_KEY, "Only PDF File is allowed", model);
		}
		
		if(multipartFile.getSize() > ALLOWED_SIZE) {
			return uploadReply(ucertModel, ERROR_KEY, "Exceeds file limit: " + FileUtils.byteCountToDisplaySize(ALLOWED_SIZE), model);
		}
		
		FileNodeUtils fileNodeUtils = utilCertService.uploadFile(multipartFile, finYearId, releaseInstallmentId);
		String uploadMessage = "";
		String messageKey = "hidden";
		switch(fileNodeUtils.getUploadStatus()) {
		case NEVER_DOWNLOADED:
			uploadMessage = "The file was never downloaded. Please download, sign and then upload.";
			messageKey = ERROR_KEY;
			break;
			
		case NOT_REQUESTED:
			uploadMessage = "No file uploaded";
			messageKey = ERROR_KEY;
			break;
		case REQUESTED_FAILED:
			uploadMessage = String.format("File %s uploading failed", multipartFile.getOriginalFilename());
			messageKey = ERROR_KEY;
			break;
		case UPDATE_PROHIBITED:
			messageKey = ERROR_KEY;
			uploadMessage = "Uploading not allowed";
			break;			
		case REQUESTED_SUCCESS:
			messageKey = SUCCESS_KEY;
			uploadMessage = String.format("File %s Successfully uploaded", multipartFile.getOriginalFilename());
			break;
		}
		// ucertModel = getBasicModel(ucertModel, finYearId, releaseInstallmentId);
		return uploadReply(ucertModel, messageKey, uploadMessage, model);
		
	}
	
	private String uploadReply(UcertModel ucertModel, String messageKey, String uploadMessage, Model model) {
		model.addAttribute("command", ucertModel);
		model.addAttribute("msg_class", messageKey);
		model.addAttribute("msg", uploadMessage);
		return "UtilizationCertificatePage";
	}
	
	// wkhtmltopdf  -T 0 -B 0 -L 0 -R 0 "http://localhost:8080/rgsa/viewUtilCerTpl.html?installmentId=2" form.pdf
	// wget -qO- http://localhost:8080/rgsa/viewUtilCerTpl.html?installmentId=2 | wkhtmltopdf  -T 0 -B 0 -L 0 -R 0 - form.pdf
	@GetMapping("viewUtilCerTpl")
	public ResponseEntity<String> viewUtilCertTemplate(@RequestParam("finYearId") Integer finYearId, 
			@RequestParam("installmentId") Integer installmentId, 
			HttpServletRequest request, HttpServletResponse response, Model model) {
		HttpHeaders httpHeaders = new HttpHeaders();
		// httpHeaders.setContentType(org.springframework.http.MediaType.APPLICATION_XHTML_XML);
		try {
			StringMultiPartFile multiPartFile = utilCertService.generateFile(request, this.viewResolver, finYearId, installmentId);
			return new ResponseEntity<String>(multiPartFile.getContent(), httpHeaders, HttpStatus.OK);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return new ResponseEntity<String>("Failed building response: " + e.getMessage(), httpHeaders, HttpStatus.FAILED_DEPENDENCY);
		}
		
	}
	
	@GetMapping("viewUploadedUtilCertficate")
	public void viewUploadedUtilCertficate(@RequestParam("finYearId") Integer finYearId, 
			@RequestParam("installmentId") Integer installmentId, @RequestParam(value="inline", required=false) Boolean inline,
			HttpServletResponse response) {
		if(inline==null)
			inline=true;
		MultipartFile uploadedFile = utilCertService.getUploadedFile(finYearId, installmentId);
		if(uploadedFile == null) {
			setTextResponse("No file has been uploaded", response);
			return;
		}
		response.setContentType(uploadedFile.getContentType());
        String disposition = String.format("%s; filename=\"%s\"", inline ? "inline" : "attachment", uploadedFile.getOriginalFilename());
        response.setHeader("Content-Disposition", disposition);
        response.setContentLength((int) uploadedFile.getSize());

        //Copy bytes from source to destination(outputstream in this example), closes both streams.
        try {
			FileCopyUtils.copy(uploadedFile.getInputStream(), response.getOutputStream());
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			setTextResponse("Some error occured while reading file.", response);
		}
		
	}
	
	private UcertModel getBasicModel(UcertModel ucertModel, Integer finYearId, Integer releaseInstallmentId) {
		if(ucertModel == null)
			ucertModel = new UcertModel();
		
		ucertModel.setYearMap(utilCertService.getYearMap());		
		if(finYearId == null || finYearId == 0)
			return ucertModel;
		
		ucertModel.setSelectedYear(finYearId);
		ucertModel.setInstallmentMap(utilCertService.getInstallmentMap(ucertModel.getSelectedYear()));
		// @TODO: remove to make it work for production <remove-alpha>
		Map<Integer, String> installmentMap = new HashMap<>();
		installmentMap.put(0, " --- Select --- ");
		installmentMap.put(1, " First Installment ");
		installmentMap.put(2, " Second Installment ");
		ucertModel.setInstallmentMap(installmentMap);
		// </remove-alpha>
		if(releaseInstallmentId == null || releaseInstallmentId == 0)
			return ucertModel;
		
		ucertModel.setSelectedInstallment(releaseInstallmentId);
		UtilCert utilCert = utilCertService.getUtilCert(finYearId, releaseInstallmentId);
		if(utilCert != null) {
			ucertModel.setHasDownload(utilCert.getGeneratedFile()!=null);
			ucertModel.setHasUpload(utilCert.getUploadFile()!=null);
		}
		ucertModel.setProcessed(true);
		return ucertModel;
	}
	
	private void setTextResponse(String content, HttpServletResponse response) {
		response.setContentType("text/plain;charset=UTF-8");
		response.setContentLength(content.length());
		response.setHeader("Content-Disposition", "inline");
        ServletOutputStream sout;
		try {
			sout = response.getOutputStream();
			sout.print(content);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}        
	}
}
