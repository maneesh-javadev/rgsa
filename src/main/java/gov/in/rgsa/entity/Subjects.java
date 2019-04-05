package gov.in.rgsa.entity;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;
/**
 * @author Mohammad Ayaz 06/09/2018
 *
 */

@Entity
@Table(name = "subjects", schema = "rgsa")
@NamedQueries({@NamedQuery(name = "FIND_SUBJECT_BY_FIN_YEAR_ID", 
	query = "SELECT S FROM Subjects S WHERE S.finYearId=:finYearId ORDER BY S.subjectName"),
	@NamedQuery(name = "FIND_SUBJECT_ID", 
	query = "SELECT S FROM Subjects S WHERE S.subjectId=:subjectId"),
	@NamedQuery(name="FETCH_SUBJECT_LIST",
	query="From Subjects where isActive=true and finYearId=:finYearId and subjectId=:subjectId ORDER BY subjectName"),
	@NamedQuery(name="DELETE_BY_SUBJECT_ID",
	query="delete from Subjects where subjectId=:subjectId"),
	@NamedQuery(name="FETCH_SUBJECT_LIST_by_CATEGORY",
	query="From Subjects where isActive=true and trainingCtgId.trainingCategoryId=:trainingCategoryId ORDER BY subjectName")
})
public class Subjects implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "subject_id")
	private Integer subjectId;

	@ManyToOne
	@JoinColumn(name = "training_category_id" , referencedColumnName="training_category_id")
	private TrainingCategories trainingCtgId;

	@Column(name = "parent_subject_id")
	private Integer parentSubjectId;

	@Column(name = "subject_name")
	private String subjectName;

	@Column(name = "created_by")
	private Integer createdBy;

	@Column(name = "state_code")
	private Integer stateCode;

	@Column(name = "fin_year")
	private Integer finYearId;

	@Column(name = "is_active")
	private Boolean isActive;

	@Column(name = "created_on")
	private Date createdOn;

	@Column(name = "user_type")
	private String userType;

	public Integer getSubjectId() {
		return subjectId;
	}

	public void setSubjectId(Integer subjectId) {
		this.subjectId = subjectId;
	}

	public TrainingCategories getTrainingCtgId() {
		return trainingCtgId;
	}

	public void setTrainingCtgId(TrainingCategories trainingCtgId) {
		this.trainingCtgId = trainingCtgId;
	}

	public Integer getParentSubjectId() {
		return parentSubjectId;
	}

	public void setParentSubjectId(Integer parentSubjectId) {
		this.parentSubjectId = parentSubjectId;
	}

	public String getSubjectName() {
		return subjectName;
	}

	public void setSubjectName(String subjectName) {
		this.subjectName = subjectName;
	}

	public Integer getCreatedBy() {
		return createdBy;
	}

	public void setCreatedBy(Integer createdBy) {
		this.createdBy = createdBy;
	}

	public Integer getStateCode() {
		return stateCode;
	}

	public void setStateCode(Integer stateCode) {
		this.stateCode = stateCode;
	}

	public Integer getFinYearId() {
		return finYearId;
	}

	public void setFinYearId(Integer finYearId) {
		this.finYearId = finYearId;
	}

	public Boolean getIsActive() {
		return isActive;
	}

	public void setIsActive(Boolean isActive) {
		this.isActive = isActive;
	}

	public Date getCreatedOn() {
		return createdOn;
	}

	public void setCreatedOn(Date createdOn) {
		this.createdOn = createdOn;
	}

	public String getUserType() {
		return userType;
	}

	public void setUserType(String userType) {
		this.userType = userType;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((subjectId == null) ? 0 : subjectId.hashCode());
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
		Subjects other = (Subjects) obj;
		if (subjectId == null) {
			if (other.subjectId != null)
				return false;
		} else if (!subjectId.equals(other.subjectId))
			return false;
		return true;
	}



	
}
