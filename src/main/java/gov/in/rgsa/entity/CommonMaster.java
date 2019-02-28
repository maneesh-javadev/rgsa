package gov.in.rgsa.entity;

import java.io.Serializable;

import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;

@Entity
@Table(name = "common_master", schema = "rgsa")
@NamedQueries({
		@NamedQuery(name = "FIND_CATEGORY_BY_PARENT_ID",query = "SELECT C FROM CommonMaster C WHERE C.parentId=:parentId"),
		@NamedQuery(name = "FIND_CATEGORY_BY_CATEGORYID_ID", query = "SELECT C FROM CommonMaster C WHERE C.categoryId=:categoryId"),
		@NamedQuery(name = "FIND_CATEGORY_BY_FIN_YEAR_ID", query = "SELECT C FROM CommonMaster C WHERE C.finYear=:finYear ORDER BY C.categoryDescription")})

public class CommonMaster implements Serializable {

	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Basic(optional = false)
	@Column(name = "category_id")
	private  Integer categoryId;

	@Column(name = "parent_id")
	private Integer parentId;

	@Column(name = "sort_order")
	private Integer sortOrder;

	@Column(name = "finyear")
	private Integer finYear;

	@Column(name = "statecode")
	private Integer stateCode;

	@Column(name = "user_id")
	private Integer userId;

	@Column(name = "amount")
	private Double amount;
	
	
	@Column(name="category_description")
	private String categoryDescription;
	

	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	public  Integer getCategoryId() {
		return categoryId;
	}

	public void setCategoryId(Integer categoryId) {
		this.categoryId = categoryId;
	}

	public Integer getParentId() {
		return parentId;
	}

	public void setParentId(Integer parentId) {
		this.parentId = parentId;
	}

	transient String category_desc;

	public String getCategory_desc() {
		return category_desc;
	}

	public void setCategory_desc(String category_desc) {
		this.category_desc = category_desc;
	}

	transient Integer subCategoryId;

	public Integer getSubCategoryId() {
		return subCategoryId;
	}

	public void setSubCategoryId(Integer subCategoryId) {
		this.subCategoryId = subCategoryId;
	}

	public Double getAmount() {
		return amount;
	}

	public void setAmount(Double amount) {
		this.amount = amount;
	}

	public Integer getFinYear() {
		return finYear;
	}

	public void setFinYear(Integer finYear) {
		this.finYear = finYear;
	}

	public Integer getStateCode() {
		return stateCode;
	}

	public void setStateCode(Integer stateCode) {
		this.stateCode = stateCode;
	}

	public Integer getUserId() {
		return userId;
	}

	public void setUserId(Integer userId) {
		this.userId = userId;
	}

	transient private String categoryActivity;

	public String getCategoryActivity() {
		return categoryActivity;
	}

	public void setCategoryActivity(String categoryActivity) {
		this.categoryActivity = categoryActivity;
	}

	public Integer getSortOrder() {
		return sortOrder;
	}

	public void setSortOrder(Integer sortOrder) {
		this.sortOrder = sortOrder;
	}
	
	

	public String getCategoryDescription() {
		return categoryDescription;
	}

	public void setCategoryDescription(String integer) {
		this.categoryDescription = integer;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((categoryId == null) ? 0 : categoryId.hashCode());
		return result;
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		CommonMaster other = (CommonMaster) obj;
		if (categoryId == null) {
			if (other.categoryId != null)
				return false;
		} else if (!categoryId.equals(other.categoryId))
			return false;
		return true;
	}

	

}
