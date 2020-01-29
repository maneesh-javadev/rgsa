package gov.in.rgsa.entity;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;

@Entity
@Table(name="training_categories",schema="rgsa")
@NamedQueries({
@NamedQuery(name="FETCH_ALL_TRAINING_CATEGORIES",query="From TrainingCategories where isActive=true  ORDER BY trainingCategoryName"),
@NamedQuery(name="Fetch_Training_Categories",query="select p from TrainingCategories p"),
@NamedQuery(name="Fetch_Training_Categories_BY_Id",query="from TrainingCategories where trainingCategoryId=:trainingCategoryId")
})
public class TrainingCategories implements Serializable{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "training_category_id",updatable = false, nullable = false)
	private Integer trainingCategoryId;
	
	@Column(name="training_category_name")
	private String trainingCategoryName;
	
	@Column(name="state_code")
	private int stateCode;
	
	@Column(name="is_active")
	private Boolean isActive;
	
	@Column(name = "fin_year")
	private Integer finYear;
	
	@Column(name="created_on")
	private Date createdOn;
	
	@Column(name="created_by")
	private int createdBy;
	
	
	@Column(name="user_type")
	private String userType;

	public Integer getTrainingCategoryId() {
		return trainingCategoryId;
	}

	public void setTrainingCategoryId(Integer trainingCategoryId) {
		this.trainingCategoryId = trainingCategoryId;
	}

	public String getTrainingCategoryName() {
		return trainingCategoryName;
	}

	public void setTrainingCategoryName(String trainingCategoryName) {
		this.trainingCategoryName = trainingCategoryName;
	}

	public int getStateCode() {
		return stateCode;
	}

	public void setStateCode(int stateCode) {
		this.stateCode = stateCode;
	}

	public Boolean getIsActive() {
		return isActive;
	}

	public void setIsActive(Boolean isActive) {
		this.isActive = isActive;
	}

	public Integer getFinYear() {
		return finYear;
	}

	public void setFinYear(Integer finYear) {
		this.finYear = finYear;
	}

	public Date getCreatedOn() {
		return createdOn;
	}

	public void setCreatedOn(Date createdOn) {
		this.createdOn = createdOn;
	}

	public int getCreatedBy() {
		return createdBy;
	}

	public void setCreatedBy(int createdBy) {
		this.createdBy = createdBy;
	}

	public String getUserType() {
		return userType;
	}

	public void setUserType(String userType) {
		this.userType = userType;
	}

	
}
