package gov.in.rgsa.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import gov.in.rgsa.entity.CommonMaster;
import gov.in.rgsa.model.CategorySubCategoryModel;
import gov.in.rgsa.service.CategorySubcategoryService;
import gov.in.rgsa.user.preference.UserPreference;
import gov.in.rgsa.utils.Message;

@Controller
public class CategorySubcategoryController {

	public static final String ADD_VIEW = "categorySubcategory";
	public static final String REDIRECT_ADD_VIEW = "redirect:categorySubcategory.html";
	public static final String MANAGE_VIEW = "category.manage";

	public static final String VIEW_CATEGORY = "category.view";
	public static final String UPDATE_CATEGORY = "category.update";
	public static final String DELETE_CATEGORY = "category.delete";

	public static final String REDIRECT_MANAGE_VIEW = "redirect:manageCategory.html";

	@Autowired
	private UserPreference userPreference;

	@Autowired
	private CategorySubcategoryService service;

	@RequestMapping(value = "categorySubcategory", method = RequestMethod.GET)

	private String addCategoryGet(
			@ModelAttribute("CATEGORY_SUBCATEGORY") CategorySubCategoryModel categorySubCategoryModel, Model model) {

		model.addAttribute("CATEGORY_LIST", categoryList());

		return ADD_VIEW;
	}

	@RequestMapping(value = "categorySubcategory", method = RequestMethod.POST)
	private String addCategoryPost(
			@ModelAttribute("CATEGORY_SUBCATEGORY") CategorySubCategoryModel categorySubCategoryModel, Model model,
			RedirectAttributes re) {

		service.save(categorySubCategoryModel);
		re.addFlashAttribute(Message.SUCCESS_KEY, Message.SAVE_SUCCESS);

		return REDIRECT_ADD_VIEW;
	}

	@RequestMapping(value = "manageCategory", method = RequestMethod.GET)
	public String manageGet(Model model) {

		model.addAttribute("CATEGORYS", service.findCategoryByFinYearId(userPreference.getFinYearId()));

		return MANAGE_VIEW;
	}

	@RequestMapping(value = "viewCategory", method = RequestMethod.GET)
	public String viewGet(@ModelAttribute("CATEGORY_SUBCATEGORY") CategorySubCategoryModel categorySubCategoryModel,
			@RequestParam(value = "id", required = false) Integer CategoryId, Model model) {

		CommonMaster category = service.findCatagoryById(CategoryId);
		categorySubCategoryModel.setCategoryId(category.getCategoryId());
		categorySubCategoryModel.setParentId(category.getParentId());
		categorySubCategoryModel.setCategoryDescription(category.getCategoryDescription());

		model.addAttribute("CATEGORY_LIST", categoryList());

		return VIEW_CATEGORY;
	}

	@RequestMapping(value = "updateCategory", method = RequestMethod.GET)
	public String updateGet(@ModelAttribute("CATEGORY_SUBCATEGORY") CategorySubCategoryModel categorySubCategoryModel,
			@RequestParam(value = "id", required = false) Integer CategoryId, Model model) {

		CommonMaster category = service.findCatagoryById(CategoryId);
		categorySubCategoryModel.setCategoryId(category.getCategoryId());
		categorySubCategoryModel.setParentId(category.getParentId());
		categorySubCategoryModel.setCategoryDescription(category.getCategoryDescription());

		model.addAttribute("CATEGORY_LIST", categoryList());

		return UPDATE_CATEGORY;
	}

	@RequestMapping(value = "updateCategory", method = RequestMethod.POST)
	public String updatePost(@ModelAttribute("CATEGORY_SUBCATEGORY") CategorySubCategoryModel categoryModel,
			RedirectAttributes re, Model model) {

		service.update(categoryModel);
		re.addFlashAttribute(Message.UPDATE_KEY, Message.UPDATE_SUCCESS);

		return REDIRECT_MANAGE_VIEW;
	}

	@RequestMapping(value = "deleteCategory", method = RequestMethod.GET)
	public String deleteGet(@ModelAttribute("CATEGORY_SUBCATEGORY") CategorySubCategoryModel categorySubCategoryModel,
			@RequestParam(value = "id", required = false) Integer CategoryId, Model model) {

		CommonMaster category = service.findCatagoryById(CategoryId);
		categorySubCategoryModel.setCategoryId(category.getCategoryId());
		categorySubCategoryModel.setParentId(category.getParentId());
		categorySubCategoryModel.setCategoryDescription(category.getCategoryDescription());

		model.addAttribute("CATEGORY_LIST", categoryList());

		return DELETE_CATEGORY;
	}

	@RequestMapping(value = "deleteCategory", method = RequestMethod.POST)
	public String deletePost(@ModelAttribute("CATEGORY_SUBCATEGORY") CategorySubCategoryModel categorySubCategoryModel,
			Model model) {

		return REDIRECT_MANAGE_VIEW;
	}

	private List<CommonMaster> categoryList() {

		List<CommonMaster> categoryList = null;
		if (userPreference.getStateCode() != 0)
			categoryList = service.findCategoryByUserTypeAndStateType("-1");
		else
			categoryList = service.findCategoryByUserTypeAndStateType("0");

		return categoryList;
	}

}
