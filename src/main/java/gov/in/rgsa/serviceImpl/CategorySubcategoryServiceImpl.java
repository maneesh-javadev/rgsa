package gov.in.rgsa.serviceImpl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import gov.in.rgsa.dao.CommonRepository;
import gov.in.rgsa.entity.CommonMaster;
import gov.in.rgsa.model.CategorySubCategoryModel;
import gov.in.rgsa.service.CategorySubcategoryService;
import gov.in.rgsa.user.preference.UserPreference;

@Service
public  class CategorySubcategoryServiceImpl implements CategorySubcategoryService {

	@Autowired
	private CommonRepository dao;

	@Autowired
	private UserPreference userPreference;

	@Override
	public void save(CategorySubCategoryModel categorySubCategoryModel) {

		CommonMaster commonMaster = new CommonMaster();

		commonMaster.setParentId(categorySubCategoryModel.getParentId());
		commonMaster.setCategoryDescription(categorySubCategoryModel.getCategoryDescription());
		commonMaster.setStateCode(userPreference.getStateCode());
		commonMaster.setFinYear(userPreference.getFinYearId());
		commonMaster.setUserId(userPreference.getUserId());
		commonMaster.setAmount(0.0);

		dao.save(commonMaster);
	}

	@Override
	public List<CommonMaster> findAllCategory() {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("active", true);
		return dao.findAll("FIND_All_SUB_CATEGORY", params);
	}

	@Override
	public List<CommonMaster> findCategoryByFinYearId(Integer finYearId) {

		Map<String, Object> params = new HashMap<String, Object>();
		params.put("finYear", finYearId);
		return dao.findAll("FIND_CATEGORY_BY_FIN_YEAR_ID", params);
	}

	@Override
	public List<CommonMaster> findCategoryByUserTypeAndStateType(String stateType) {

		Map<String, Object> params = new HashMap<String, Object>();
		if (stateType.equals("-1")) {
			params.put("categoryId", 160);

			return dao.findAll("FIND_CATEGORY_BY_CATEGORYID_ID", params);
		} else {
			params.put("parentId", 0);
			return dao.findAll("FIND_CATEGORY_BY_PARENT_ID", params);
		}

	}

	public CommonMaster findCatagoryById(Integer categoryId) {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("categoryId", categoryId);

		return dao.find("FIND_CATEGORY_BY_CATEGORYID_ID", params);
	}

	@Override
	public void update(CategorySubCategoryModel categorySubCategoryModel) {

		CommonMaster commonMaster = new CommonMaster();
		commonMaster.setCategoryId(categorySubCategoryModel.getCategoryId());
		commonMaster.setParentId(categorySubCategoryModel.getParentId());
		commonMaster.setCategoryDescription(categorySubCategoryModel.getCategoryDescription());
		commonMaster.setStateCode(userPreference.getStateCode());
		commonMaster.setFinYear(userPreference.getFinYearId());
		commonMaster.setUserId(userPreference.getUserId());
		commonMaster.setAmount(0.0);

		dao.update(commonMaster);

	}

	/*@Override
	public void delete(CategorySubCategoryModel categorySubCategoryModel) {
			CommonMaster commonMaster = new CommonMaster();
			commonMaster.setCategoryId(categorySubCategoryModel.getCategoryId());
			commonMaster.setParentId(categorySubCategoryModel.getParentId());
			commonMaster.setCategoryDescription(categorySubCategoryModel.getCategoryDescription());
			commonMaster.setStateCode(userPreference.getStateCode());
			commonMaster.setFinYear(userPreference.getFinYearId());
			commonMaster.setUserId(userPreference.getUserId());
			commonMaster.setAmount(0.0);

			dao.delete(commonMaster,CategoryId );

		
	}*/
	


}