package gov.in.rgsa.entity;

import java.sql.Timestamp;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Transient;

import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.DynamicUpdate;
import org.hibernate.annotations.UpdateTimestamp;

/**
 * @author Mohammad Ayaz 06/09/2018
 *
 */

@Entity
@Table(name="training_activity",schema="rgsa" )
@NamedQueries({@NamedQuery(name="UPDATE_ADDTNL_REQRMNT",query="UPDATE TrainingActivity SET additionalRequirement =:additionalRequirement where trainingActivityId=:trainingActivityId") ,
@NamedQuery(name="FIND_ALL_TRAINING_ACTIVITY_WITH_DETAILS",query="SELECT TA from TrainingActivity TA LEFT OUTER JOIN FETCH TA.trainingActivityDetailsList TAD where TA.yearId=:yearId and TAD.isActive='TRUE' and TA.userType=:userType and TA.stateCode=:stateCode"),
@NamedQuery(name="FIND_ALL_TRAINING_ACTIVITY",query="from TrainingActivity TA WHERE TA.yearId=:yearId and TA.stateCode=:stateCode and TA.userType=:userType"),
@NamedQuery(name="UPDATE_FRZUNFRZ_STATUS",query="UPDATE TrainingActivity SET  isFreeze=:isFreeze where trainingActivityId=:trainingActivityId"),
@NamedQuery(name="GET_APPROVED_TRAINING", 
query="SELECT TA from TrainingActivity TA RIGHT OUTER JOIN FETCH TA.trainingActivityDetailsList TAD where TA.yearId=:yearId and TAD.isActive='TRUE' and TA.userType=:userType and TA.stateCode=:stateCode and TAD.isApproved='TRUE' "),
@NamedQuery(name="FIND_ALL_TRAINING_ACTIVITY_BY_ID",query="FROM TrainingActivity  where trainingActivityId=:trainingActivityId"),
@NamedQuery(name="UPDATE_Training_Activity",query="UPDATE TrainingActivity SET  isFreeze=:isFreeze,additionalRequirement =:additionalRequirement where trainingActivityId=:trainingActivityId"),
@NamedQuery(name="FIND_ALL_TRAINING_ACTIVITY_BY_ID",query="from TrainingActivity WHERE trainingActivityId=:trainingActivityId")
})
public class TrainingActivity {

	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	@Column(name="training_activity_id",nullable=false,updatable=false)
	private Integer trainingActivityId;
	
	@OneToMany(cascade=CascadeType.ALL,mappedBy="trainingActivity",fetch=FetchType.EAGER)
	private List<TrainingActivityDetails> trainingActivityDetailsList;
	
	@Column(name="state_code")
	private Integer stateCode;
	
	@Column(name="year_id")
	private Integer yearId;
	
	@Column(name="version_no")
	private Integer versionId;
	
	@Column(name="user_type")
	private Character userType;
	
	@Column(name="additional_requirement")
	private Integer additionalRequirement;
	
	@Column(name="created_by",updatable=false)
	private Integer createdBy;
	
	@Column(name="created_on",updatable=false)
	@CreationTimestamp
	private Timestamp createdOn;
	
	@Column(name="last_updated_by")
	private Integer lastUpdatedBy;
	
	@Column(name="last_updated_on")
	@UpdateTimestamp
	private Timestamp lastUpdatedOn;
	
	@Column(name="is_Freeze")
	private Boolean isFreeze;
	
	@Column(name="menu_id")
	private Integer menuId;
	
	@Column(name="is_active")
	private Boolean isActive;
	
	@Transient
	private Integer idToEdit;
	
	@Transient
	private String idToDelete;
	
	@Transient
	private Integer catgryId;
	
	public Integer getTrainingActivityId() {
		return trainingActivityId;
	}

	public void setTrainingActivityId(Integer trainingActivityId) {
		this.trainingActivityId = trainingActivityId;
	}

	public Integer getStateCode() {
		return stateCode;
	}

	public void setStateCode(Integer stateCode) {
		this.stateCode = stateCode;
	}

	public Integer getYearId() {
		return yearId;
	}

	public void setYearId(Integer yearId) {
		this.yearId = yearId;
	}

	public Integer getVersionId() {
		return versionId;
	}

	public void setVersionId(Integer versionId) {
		this.versionId = versionId;
	}

	public Character getUserType() {
		return userType;
	}

	public void setUserType(Character userType) {
		this.userType = userType;
	}

	public Integer getAdditionalRequirement() {
		return additionalRequirement;
	}

	public void setAdditionalRequirement(Integer additionalRequirement) {
		this.additionalRequirement = additionalRequirement;
	}

	public Integer getCreatedBy() {
		return createdBy;
	}

	public void setCreatedBy(Integer createdBy) {
		this.createdBy = createdBy;
	}

	public Timestamp getCreatedOn() {
		return createdOn;
	}

	public void setCreatedOn(Timestamp createdOn) {
		this.createdOn = createdOn;
	}

	public Integer getLastUpdatedBy() {
		return lastUpdatedBy;
	}

	public void setLastUpdatedBy(Integer lastUpdatedBy) {
		this.lastUpdatedBy = lastUpdatedBy;
	}

	public Timestamp getLastUpdatedOn() {
		return lastUpdatedOn;
	}

	public void setLastUpdatedOn(Timestamp lastUpdatedOn) {
		this.lastUpdatedOn = lastUpdatedOn;
	}
	
	public Boolean getIsFreeze() {
		return isFreeze;
	}

	public void setIsFreeze(Boolean isFreeze) {
		this.isFreeze = isFreeze;
	}

	public List<TrainingActivityDetails> getTrainingActivityDetailsList() {
		return trainingActivityDetailsList;
	}

	public void setTrainingActivityDetailsList(List<TrainingActivityDetails> trainingActivityDetailsList) {
		this.trainingActivityDetailsList = trainingActivityDetailsList;
	}

	public Integer getIdToEdit() {
		return idToEdit;
	}

	public void setIdToEdit(Integer idToEdit) {
		this.idToEdit = idToEdit;
	}

	public Integer getCatgryId() {
		return catgryId;
	}

	public void setCatgryId(Integer catgryId) {
		this.catgryId = catgryId;
	}

	public Integer getMenuId() {
		return menuId;
	}

	public void setMenuId(Integer menuId) {
		this.menuId = menuId;
	}

	public String getIdToDelete() {
		return idToDelete;
	}

	public void setIdToDelete(String idToDelete) {
		this.idToDelete = idToDelete;
	}

	public Boolean getIsActive() {
		return isActive;
	}

	public void setIsActive(Boolean isActive) {
		this.isActive = isActive;
	}

	
	
	
	
}
