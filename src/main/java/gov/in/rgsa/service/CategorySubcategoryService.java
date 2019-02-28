package gov.in.rgsa.service;

import java.util.List;

import gov.in.rgsa.entity.CommonMaster;

import gov.in.rgsa.model.CategorySubCategoryModel;
public interface CategorySubcategoryService {

	public void save(CategorySubCategoryModel categorySubCategoryModel);
	public List<CommonMaster> findCategoryByFinYearId(Integer finYearId);

	public List<CommonMaster> findCategoryByUserTypeAndStateType(String stateType);
	public List<CommonMaster> findAllCategory();
	public CommonMaster findCatagoryById(Integer categoryId);
	
	public void update(CategorySubCategoryModel categorySubCategoryModel);
	
/*public void delete(CategorySubCategoryModel categorySubCategoryModel);*/

}
