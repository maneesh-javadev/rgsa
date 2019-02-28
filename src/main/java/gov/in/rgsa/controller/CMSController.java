package gov.in.rgsa.controller;

import java.util.List;
import java.util.ResourceBundle;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
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
import gov.in.rgsa.service.CMSService;
import gov.in.rgsa.service.LGDService;
import gov.in.rgsa.user.preference.UserPreference;
import gov.in.rgsa.utils.CommonConstant;
import gov.in.rgsa.utils.Message;
import gov.in.rgsa.validater.CmsValidator;




@Controller
public class CMSController {
	public static final String ADD_CMS = "CMS.add";
	public static final String MANAGE_CMS = "CMS.manage";
	public static final String MODIFY_CMS = "CMS.modify";

	@Autowired
	private LGDService lgdService;

	@Autowired
	private CMSService cmsService;

    @Autowired
	private CmsValidator validator;

	@Autowired
	private UserPreference userPreference;

	private static final String FILE_LOCATION = ResourceBundle.getBundle("application")
			.getString("upload.file.location.officeorder").trim();

	@RequestMapping(value = "addCms", method = RequestMethod.GET)
	public String addCms(@ModelAttribute("Cms_Model") CmsModel form, Model model, RedirectAttributes re)
			throws Exception {
		try {
			List<State> statelist = lgdService.getAllStateList();
			model.addAttribute("STATE_LIST", statelist);
			Integer StateId = userPreference.getStateCode();
			model.addAttribute("StateId", StateId);

			List<UploadDocumentType> list = cmsService.getDocumentType();
			model.addAttribute("DOCUMENT_TYPE_LIST", list);

			return ADD_CMS;
		} catch (Exception e) {
			throw e;
		}
	}

	@RequestMapping(value = "addCms", method = RequestMethod.POST)
	public String saveCms(@ModelAttribute("Cms_Model") CmsModel form, Model model, BindingResult br,
			HttpSession session, RedirectAttributes re) throws Exception {
		try {

			if (userPreference.getUserId() == null)
				return CommonConstant.REDIRECT_INDEX_VIEW;

			validator.validate(form, br);
			boolean resultStatus = br.hasErrors();
			if (resultStatus) {
				List<State> statelist = lgdService.getAllStateList();
				model.addAttribute("STATE_LIST", statelist);

				List<UploadDocumentType> list = cmsService.getDocumentType();
				model.addAttribute("DOCUMENT_TYPE_LIST", list);

				Integer documentType = form.getDocumentType();
				String fileTitle = form.getFileTitle();

				form.setDocumentType(documentType);
				form.setFileTitle(fileTitle);

				model.addAttribute("documentType", documentType);
				model.addAttribute("fileTitle", fileTitle);

				Integer StateId = userPreference.getStateCode();
				model.addAttribute("StateId", StateId);

				return ADD_CMS;
			}
			Integer StateId = 0;
			if (form.getStateCode() != null) {
				if (form.getStateCode() == 0) {
					StateId = userPreference.getStateCode();
					form.setStateCode(StateId);
				} else {
					form.setStateCode(form.getStateCode());
				}
			} else {
				StateId = userPreference.getStateCode();
				form.setStateCode(StateId);
			}

			Boolean status = cmsService.saveCms(form);

			if (status) {
				List<State> statelist = lgdService.getAllStateList();
				model.addAttribute("STATE_LIST", statelist);

				Integer userId = userPreference.getUserId();

				List<UploadDocumentDTO> uploadDocumentList = cmsService.getDocumentList(userId);
				model.addAttribute("DOCUMENT_LIST", uploadDocumentList);

				List<UploadDocumentType> list = cmsService.getDocumentType();
				model.addAttribute("DOCUMENT_TYPE_LIST", list);

				form.setDocumentType(0);
				form.setFileTitle("");
				model.addAttribute("fileTitle", "");
				model.addAttribute("documentType", "0");
				model.addAttribute("SUCCESS", Message.SAVE_SUCCESS);
				re.addFlashAttribute(Message.SUCCESS_KEY, Message.SAVE_SUCCESS);
			} else {
				re.addFlashAttribute(Message.ERROR_KEY, Message.ERROR_SUCCESS);
			}
			return MANAGE_CMS;
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@RequestMapping(value = "manageCms", method = RequestMethod.GET)
	public String manageUserGet(@ModelAttribute("Cms_Model") CmsModel form, Model model, RedirectAttributes re)
			throws Exception {
		try {

			if (userPreference.getUserId() == null)
				return CommonConstant.REDIRECT_INDEX_VIEW;

			Integer userId = userPreference.getUserId();
			model.addAttribute("userId", userId);

			List<UploadDocumentDTO> uploadDocumentList = cmsService.getDocumentList(userId);
			model.addAttribute("DOCUMENT_LIST", uploadDocumentList);

			List<UploadDocumentType> list = cmsService.getDocumentType();
			model.addAttribute("DOCUMENT_TYPE_LIST", list);
			return MANAGE_CMS;
		} catch (Exception e) {
			throw e;
		}
	}

	@RequestMapping(value = "modifyCms", method = RequestMethod.GET)
	public String modifyGet(@ModelAttribute("Cms_Model") CmsModel form, Model model,
			@RequestParam(value = "uploadDocumentId", required = false) Integer uploadDocumentId, RedirectAttributes re)
			throws Exception {
		try {
			List<State> statelist = lgdService.getAllStateList();
			model.addAttribute("STATE_LIST", statelist);

			List<UploadDocumentType> list = cmsService.getDocumentType();
			model.addAttribute("DOCUMENT_TYPE_LIST", list);

			UploadDocument documentDetails = cmsService.findDocument(uploadDocumentId);
			model.addAttribute("documentDetails", documentDetails);

			model.addAttribute("fileTitle", documentDetails.getFileTitle());
			form.setFileTitle(documentDetails.getFileTitle());
			form.setUploadDocumentId(documentDetails.getUploadDocumentId());

			model.addAttribute("documentType", documentDetails.getTypeId());
			model.addAttribute("stateCode", documentDetails.getStateCode());

			Integer StateId = userPreference.getStateCode();
			model.addAttribute("StateId", StateId);

			return MODIFY_CMS;
		} catch (Exception e) {
			throw e;
		}
	}

	@RequestMapping(value = "modifyCms", method = RequestMethod.POST)
	public String modifyPOST(@ModelAttribute("Cms_Model") CmsModel form, Model model,
			@RequestParam(value = "uploadDocumentId", required = false) Integer uploadDocumentId, BindingResult br,
			RedirectAttributes re) throws Exception {
		try {

			if (userPreference.getUserId() == null)
				return CommonConstant.REDIRECT_INDEX_VIEW;

			Integer userId = userPreference.getUserId();

			validator.validateModify(form, br);
			boolean resultStatus = br.hasErrors();
			if (resultStatus) {
				List<State> statelist = lgdService.getAllStateList();
				model.addAttribute("STATE_LIST", statelist);

				List<UploadDocumentType> list = cmsService.getDocumentType();
				model.addAttribute("DOCUMENT_TYPE_LIST", list);

				Integer documentType = form.getDocumentType();
				String fileTitle = form.getFileTitle();

				form.setDocumentType(documentType);
				form.setFileTitle(fileTitle);

				UploadDocument documentDetails = cmsService.findDocument(uploadDocumentId);
				model.addAttribute("documentDetails", documentDetails);
				model.addAttribute("stateCode", documentDetails.getStateCode());
				model.addAttribute("fileName", documentDetails.getFileName());

				Integer StateId = userPreference.getStateCode();
				model.addAttribute("StateId", StateId);

				return MODIFY_CMS;
			}
			UploadDocument documentDetails = cmsService.findDocument(uploadDocumentId);
			model.addAttribute("documentDetails", documentDetails);

			if (form.getFileName() == null) {
				form.setFileName(documentDetails.getFileName());
			}
			Integer StateId = 0;
			if (form.getStateCode() != null) {
				if (form.getStateCode() == 0) {
					StateId = userPreference.getStateCode();
					form.setStateCode(StateId);
				} else {
					form.setStateCode(form.getStateCode());
				}
			} else {
				StateId = userPreference.getStateCode();
				form.setStateCode(StateId);
			}

			Boolean status = cmsService.modifyCms(form);

			if (status) {
				List<UploadDocumentType> list = cmsService.getDocumentType();
				model.addAttribute("DOCUMENT_TYPE_LIST", list);

				model.addAttribute("SUCCESS", Message.UPDATE_SUCCESS);
				re.addFlashAttribute(Message.SUCCESS_KEY, Message.UPDATE_SUCCESS);

				List<UploadDocumentDTO> uploadDocumentList = cmsService.getDocumentList(userId);
				model.addAttribute("DOCUMENT_LIST", uploadDocumentList);

			} else {
				re.addFlashAttribute(Message.ERROR_KEY, Message.ERROR_SUCCESS);
			}

			return MANAGE_CMS;
		} catch (Exception e) {
			throw e;
		}
	}

}
