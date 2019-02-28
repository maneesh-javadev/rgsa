package gov.in.rgsa.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import gov.in.rgsa.entity.Subjects;
import gov.in.rgsa.model.SubjectTrainingModel;
import gov.in.rgsa.service.SubjectTrainingService;
import gov.in.rgsa.user.preference.UserPreference;
import gov.in.rgsa.utils.Message;

@Controller
public class SubjectTrainingController {

	public static final String SUBJECT_TRAINING = "addSubjectTraining";
	public static final String MANAGE_VIEW = "subject.manage";
	public static final String REDIRECT_SUBJECT_TRAINING = "redirect:addsubjects.html";
	private static final String VIEW_SUBJECTS = "subject.view";
	private static final String MODIFY_SUBJECTS = "subject.modify";
	private static final String REDIRECT_MANAGE_VIEW = "redirect:managesubjects.html";
	private static final String DELETE_SUBJECTS = "subjects.delete";

	@Autowired
	private SubjectTrainingService service;
	@Autowired
	public UserPreference user;

	@RequestMapping(value = "addsubjects", method = RequestMethod.GET)
	public String addSubjTraining(@ModelAttribute("SUBJECT_TRAINING_MODEL") SubjectTrainingModel form, Model model) {
		model.addAttribute("TRAINING_CATEGORIES_LIST", service.findAllCategory());

		return SUBJECT_TRAINING;
	}

	@RequestMapping(value = "addsubjects", method = RequestMethod.POST)
	public String addSubjectTrainingPost(@ModelAttribute("SUBJECT_TRAINING_MODEL") SubjectTrainingModel form,
			Model model, RedirectAttributes re) {
		service.save(form);
		re.addFlashAttribute(Message.SUCCESS_KEY, Message.SAVE_SUCCESS);
		return REDIRECT_SUBJECT_TRAINING;
	}

	@RequestMapping(value = "managesubjects", method = RequestMethod.GET)
	public String manageGet(Model model) {

		model.addAttribute("SUBJECTS", service.findSubjects(user.getFinYearId()));

		return MANAGE_VIEW;
	}

	@RequestMapping(value = "viewsubjects", method = RequestMethod.GET)
	public String viewGet(@ModelAttribute("SUBJECT_TRAINING_MODEL") SubjectTrainingModel form,
			@RequestParam(value = "id", required = false) Integer subjectId, Model model) {

		Subjects subject = service.findSubjectById(subjectId);
		form.setTrainingSubject(subject.getSubjectName());
		model.addAttribute("TRAINING_CATEGORIES_LIST", service.findAllCategory());
		return VIEW_SUBJECTS;
	}

	@RequestMapping(value = "modifysubjects", method = RequestMethod.GET)
	public String modifyGet(@ModelAttribute("SUBJECT_TRAINING_MODEL") SubjectTrainingModel form,
			@RequestParam(value = "id", required = false) Integer subjectId, Model model) {
		Subjects subject = service.findSubjectById(subjectId);
		form.setTrainingSubject(subject.getSubjectName());
		form.setSubjectId(subjectId);
		model.addAttribute("TRAINING_CATEGORIES_LIST", service.findAllCategory());
		return MODIFY_SUBJECTS;
	}

	@RequestMapping(value = "modifysubjects", method = RequestMethod.POST)
	public String modifyPost(@ModelAttribute("SUBJECT_TRAINING_MODEL") SubjectTrainingModel form, Model model,
			RedirectAttributes re) {

		service.update(form);
		re.addFlashAttribute(Message.UPDATE_KEY, Message.UPDATE_SUCCESS);

		return REDIRECT_MANAGE_VIEW;
	}
	
	@RequestMapping(value = "deletesubjects", method = RequestMethod.GET)
	public String deleteGet(@ModelAttribute("SUBJECT_TRAINING_MODEL") SubjectTrainingModel form,@RequestParam(value = "id", required = false) Integer subjectId, Model model,
			RedirectAttributes re) {

		Subjects subject = service.findSubjectById(subjectId);
		form.setTrainingSubject(subject.getSubjectName());
		form.setSubjectId(subjectId);
		model.addAttribute("TRAINING_CATEGORIES_LIST", service.findAllCategory());
		return DELETE_SUBJECTS;
	}
	
	
	@RequestMapping(value = "deletesubjects", method = RequestMethod.POST)
	public String deletePost(@ModelAttribute("SUBJECT_TRAINING_MODEL") SubjectTrainingModel form, Model model,
			RedirectAttributes re) {

		service.delete(form);
		re.addFlashAttribute(Message.DELETE_KEY, Message.DELETE_SUCCESS);

		return REDIRECT_MANAGE_VIEW;
	}

}
