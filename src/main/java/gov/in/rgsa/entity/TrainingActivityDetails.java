package gov.in.rgsa.entity;

import java.io.Serializable;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Transient;

import org.hibernate.annotations.DynamicUpdate;
import org.hibernate.annotations.LazyCollection;
import org.hibernate.annotations.LazyCollectionOption;

/**
 * @author Mohammad Ayaz 06/09/2018
 *
 */

@Entity
@Table(name="training_activity_details" , schema="rgsa")
@NamedQueries({
@NamedQuery(name="UPDATE_DELETE_STATUS",query="UPDATE TrainingActivityDetails SET isActive = 'FALSE' where trainingActivityDetailsId=:trainingActivityDetailsId"),
@NamedQuery(name="FIND_TrainingActivityDetails_BY_ID",query="FROM TrainingActivityDetails  where trainingActivityDetailsId=:trainingActivityDetailsId and isActive=true"),
@NamedQuery(name="UPDATE_DELETE_STATUS_BY_MULTIPLE_ID",query="UPDATE TrainingActivityDetails SET isActive = 'FALSE' where trainingActivityDetailsId in(:trainingActivityDetailsId)"),

})
@DynamicUpdate
public class TrainingActivityDetails implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 8616868302617161438L;

	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	@Column(name="training_id",nullable=false)
	private Integer trainingActivityDetailsId;
	
	@ManyToOne
	@JoinColumn(name="training_activity_id" ,referencedColumnName="training_activity_id")
	private TrainingActivity trainingActivity;
	
	@OneToMany(cascade=CascadeType.ALL,mappedBy="subjectsTrainingActivityDetails")
	@LazyCollection(LazyCollectionOption.FALSE)
	private List<TrainingSubjects> trainingSubjectsList;
	
	@OneToMany(cascade=CascadeType.ALL,mappedBy="targetTrainingActivityDetails")
	@LazyCollection(LazyCollectionOption.FALSE)
	private List<TrainingTargetGroups> trainingTargetGroupsList;
	
	@OneToMany(cascade=CascadeType.ALL,mappedBy="targetTrainingActivityDetails")
	@LazyCollection(LazyCollectionOption.FALSE)
	private List<TrainingWiseCategory> trainingWiseCategoryList;
	
	@ManyToOne
	@JoinColumn(name="training_venue_level_id" ,referencedColumnName="training_venue_level_id")
	private TrainingVenueLevel trainingVenueLevelId;
	
	/*@ManyToOne
	@JoinColumn(name="training_category_id" , referencedColumnName="training_category_id")
	private TrainingCategories trainingCategoryId;*/
	
	@ManyToOne
	@JoinColumn(name="training_mode_id")
	private TrainingMode trainingMode;
	
	@Column(name="no_of_participants")
	private Integer noOfParticipants;
	
	@Column(name="unit_cost")
	private Integer unitCost;
	
	@Column(name="no_of_days")
	private Integer noOfDays;
	
	@Column(name="funds")
	private Integer funds;
	
	@Column(name="is_approved")
	private Boolean isApproved;
	
	@Column(name="remarks")
	private String remarks; 
	
	@Column(name="is_active")
	private Boolean isActive;
	
	@Transient
	private String[] trainingTargetGroupsArray;
	
	@Transient
	private String[] trainingSubjectsArray;
	
	
	public Integer getTrainingActivityDetailsId() {
		return trainingActivityDetailsId;
	}

	public void setTrainingActivityDetailsId(Integer trainingActivityDetailsId) {
		this.trainingActivityDetailsId = trainingActivityDetailsId;
	}

	public TrainingVenueLevel getTrainingVenueLevelId() {
		return trainingVenueLevelId;
	}

	public void setTrainingVenueLevelId(TrainingVenueLevel trainingVenueLevelId) {
		this.trainingVenueLevelId = trainingVenueLevelId;
	}

	public Integer getNoOfParticipants() {
		return noOfParticipants;
	}

	public void setNoOfParticipants(Integer noOfParticipants) {
		this.noOfParticipants = noOfParticipants;
	}

	public Integer getUnitCost() {
		return unitCost;
	}

	public void setUnitCost(Integer unitCost) {
		this.unitCost = unitCost;
	}

	public Integer getNoOfDays() {
		return noOfDays;
	}

	public void setNoOfDays(Integer noOfDays) {
		this.noOfDays = noOfDays;
	}

	public Integer getFunds() {
		return funds;
	}

	public void setFunds(Integer funds) {
		this.funds = funds;
	}

	public String getRemarks() {
		return remarks;
	}

	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}

	public TrainingActivity getTrainingActivity() {
		return trainingActivity;
	}

	public void setTrainingActivity(TrainingActivity trainingActivity) {
		this.trainingActivity = trainingActivity;
	}

	public List<TrainingSubjects> getTrainingSubjectsList() {
		return trainingSubjectsList;
	}

	public void setTrainingSubjectsList(List<TrainingSubjects> trainingSubjectsList) {
		this.trainingSubjectsList = trainingSubjectsList;
	}

	public List<TrainingTargetGroups> getTrainingTargetGroupsList() {
		return trainingTargetGroupsList;
	}

	public void setTrainingTargetGroupsList(List<TrainingTargetGroups> trainingTargetGroupsList) {
		this.trainingTargetGroupsList = trainingTargetGroupsList;
	}

	public String[] getTrainingTargetGroupsArray() {
		return trainingTargetGroupsArray;
	}

	public void setTrainingTargetGroupsArray(String[] trainingTargetGroupsArray) {
		this.trainingTargetGroupsArray = trainingTargetGroupsArray;
	}

	public String[] getTrainingSubjectsArray() {
		return trainingSubjectsArray;
	}

	public void setTrainingSubjectsArray(String[] trainingSubjectsArray) {
		this.trainingSubjectsArray = trainingSubjectsArray;
	}

	/*public TrainingCategories getTrainingCategoryId() {
		return trainingCategoryId;
	}

	public void setTrainingCategoryId(TrainingCategories trainingCategoryId) {
		this.trainingCategoryId = trainingCategoryId;
	}*/

	public Boolean getIsActive() {
		return isActive;
	}

	public void setIsActive(Boolean isActive) {
		this.isActive = isActive;
	}

	public Boolean getIsApproved() {
		return isApproved;
	}

	public void setIsApproved(Boolean isApproved) {
		this.isApproved = isApproved;
	}

	public TrainingMode getTrainingMode() {
		return trainingMode;
	}

	public void setTrainingMode(TrainingMode trainingMode) {
		this.trainingMode = trainingMode;
	}

	public List<TrainingWiseCategory> getTrainingWiseCategoryList() {
		return trainingWiseCategoryList;
	}

	public void setTrainingWiseCategoryList(List<TrainingWiseCategory> trainingWiseCategoryList) {
		this.trainingWiseCategoryList = trainingWiseCategoryList;
	}
	
	
	
}
