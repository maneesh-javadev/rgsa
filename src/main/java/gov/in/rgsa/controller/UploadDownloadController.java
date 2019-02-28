package gov.in.rgsa.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import gov.in.rgsa.entity.UploadDocument;
import gov.in.rgsa.entity.ViewImage;
import gov.in.rgsa.model.FileUploadModel;
import gov.in.rgsa.service.FileUploadService;
import gov.in.rgsa.service.LGDService;
import gov.in.rgsa.utils.Message;




@SuppressWarnings("deprecation")
@Controller
public class UploadDownloadController {

	@Autowired
	FileUploadService service;
	
	@Autowired
	LGDService lgd;

	

	/*@SuppressWarnings("unchecked")
	@RequestMapping(value = "upload", method = RequestMethod.POST, consumes = { MediaType.APPLICATION_JSON_VALUE,
			MediaType.APPLICATION_FORM_URLENCODED_VALUE }, produces = { MediaType.APPLICATION_JSON_VALUE,
					MediaType.APPLICATION_FORM_URLENCODED_VALUE })
	public <T> T upload(@RequestBody FileUploadModel form, HttpSession session) {

		try {

			service.uploadFileService(form);

			return (T) new ResponseEntity<Boolean>(true, HttpStatus.OK);

		} catch (Exception e) {
			CustomError error = new CustomError();
			return (T) new ResponseEntity<CustomError>(error, HttpStatus.BAD_REQUEST);
		}
	}*/
	
	/*@RequestMapping(value = "pdf/{id}", method = RequestMethod.GET, produces = { })
	public byte[] downloadPdf(@PathVariable(value = "id") String id) {

		try {

			if (NumberUtils.isNumber(id)) {
				ProceedingFiles fileUpload = service.findProceedingFileDetails(Integer.parseInt(id));
				File initialFile = new File(fileUpload.getFileLocation() + File.separator + fileUpload.getFileName());
				if (initialFile.exists()) {
					InputStream in = FileUtils.openInputStream(initialFile);
					return IOUtils.toByteArray(in);
				} else
					return null;
			} else {
				return null;
			}

		} catch (Exception e) {
			if (e instanceof NoResultException) {
				return null;
			}
			e.printStackTrace();

			return null;
		}

	}*/
	

	@RequestMapping(value = "/uploadImage", method = RequestMethod.GET)
	public String uploadGet(@ModelAttribute("UPLOAD") FileUploadModel form, HttpSession session, Model model) {

	/*	Integer locatedAtLevel = userPreference.getLocatedAtLevel();
		Integer stateCode = userPreference.getStateCode();
		Integer entityCode = userPreference.getEntityCode();*/
		/*model.addAttribute("stateCode", stateCode);
		model.addAttribute("entityCode", entityCode);
		model.addAttribute("locatedAtLevel", locatedAtLevel);*/
		
		model.addAttribute("STATE", lgd.getAllStateList());
		
		return "uploadImage";

	}

	@RequestMapping(value = "/uploadImage", method = RequestMethod.POST)
	public String uploadPost(@ModelAttribute("UPLOAD") FileUploadModel model, HttpSession session,
			RedirectAttributes re) throws Exception {

		// FileUploadModel model=new FileUploadModel();
		// model.setUploadType(form.getUploadType());
	/*	if (userPreference.getStateCode() == null)
			return CommonConstant.REDIRECT_INDEX_VIEW;*/

	/*	model.setCreatedBy(userPreference.getUserId());
		model.setCategory(userPreference.getCategory());
		model.setStateCode(userPreference.getStateCode());
		model.setCreatedBy(userPreference.getUserId());
		model.setCategory(userPreference.getCategory());
		model.setLocalBodyCode(userPreference.getEntityCode());*/
		/*if(userPreference.getLocatedAtLevel() != null && userPreference.getLocatedAtLevel().equals(3)){
			model.setGpCode(userPreference.getEntityCode());
		}*/

		service.uploadFileWeb(model);

		re.addFlashAttribute(Message.SUCCESS_KEY, "Uploaded Successfully.");

		return "redirect:uploadImage.html";

	}
	
	
	@RequestMapping(value = "findImage", method = RequestMethod.GET, produces = MediaType.APPLICATION_JSON_VALUE)
	public @ResponseBody ResponseEntity<List<ViewImage>> findImage(HttpServletRequest request) {
		
			List<ViewImage> list = service.findLatestSixImage();
			return new ResponseEntity<List<ViewImage>>(list, HttpStatus.OK);
		
	}
	
	
	@RequestMapping(value = "findNew", method = RequestMethod.GET, produces = MediaType.APPLICATION_JSON_VALUE)
	public @ResponseBody ResponseEntity<List<UploadDocument>> findNew(HttpServletRequest request) {
		
			List<UploadDocument> list = service.findNew();
			return new ResponseEntity<List<UploadDocument>>(list, HttpStatus.OK);
		
	}


}
