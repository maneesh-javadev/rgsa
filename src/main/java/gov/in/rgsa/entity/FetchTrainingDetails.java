package gov.in.rgsa.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.NamedNativeQuery;
import javax.persistence.Transient;


@Entity
@NamedNativeQuery(name="Fetch_Training_Details",
query=	"	select tad.training_id,tad.training_activity_id,tad.training_venue_level_id ,tad.no_of_participants ,tad.unit_cost ,tad.no_of_days ,tad.funds ,"
	+ 	"	tad.remarks ,tad.training_category_id ,tad.is_active ,tad.is_approved ,tad.training_mode_id,tvl.training_venue_level_name,tm.training_mode_name,  " 
	+ 	"  (select cast(array_to_string(array(select subject_name from rgsa.training_subjects ts inner join rgsa.subjects s on ts.subject_id=s.subject_id "
	+ 	"	where ts.training_id =tad.training_id),',') as char varying))subject_name,(select cast(array_to_string(array(select tc.training_category_name from "
	+ 	"	rgsa.training_wise_category twc inner join rgsa.training_categories tc on twc.training_category_id=tc.training_category_id where twc.training_id =tad.training_id),"
	+ 	"   ',') as char varying))training_category_name, (select cast(array_to_string(array(select target_group_master_name from rgsa.training_target_groups ttg inner "
	+ 	"	join rgsa.target_group_master tgm on ttg.target_group_master_id= tgm.target_group_master_id where ttg.training_id =tad.training_id),',') as char varying) "
	+ 	"	target_group_master_name ) from rgsa.training_activity_details tad inner join rgsa.training_venue_level tvl on tad.training_venue_level_id="
	+ 	"	tvl.training_venue_level_id inner join rgsa.training_mode tm on tad.training_mode_id=tm.training_mode_id where tad.training_activity_id=:trainingActivityId "
	+ 	"	and tad.is_active=:isactive"
,resultClass=FetchTrainingDetails.class)
public class FetchTrainingDetails {
	
	@Id
	@Column(name="training_id")
	private Integer trainingId;
	
	@Column(name="training_activity_id")
	private Integer trainingActivityId;
	
	@Column(name="training_venue_level_id")
	private Integer trainingVenueLevelId;
	
	@Column(name="no_of_participants")
	private Integer noOfParticipants;
	
	@Column(name="unit_cost")
	private Integer unitCost;
	
	@Column(name="no_of_days")
	private Integer noOfDays;
	
	@Column(name="funds")
	private Integer funds;
	
	
	@Column(name="remarks")
	private String remarks; 
	
	@Column(name="training_category_id" )
	private Integer trainingCategoryId;
	
	@Column(name="is_active")
	private Boolean isActive;

	@Column(name="is_approved")
	private Boolean isApproved;

	@Column(name="training_mode_id")
	private Integer trainingMode;
		
	@Column(name="training_category_name")
	private String trainingCategoryName;
	
	@Column(name="training_venue_level_name")
	private String trainingVenueLevelName;
	
	@Column(name="training_mode_name")
	private String trainingModeName;
	
	@Column(name="subject_name")
	private String subjectName;
	
	@Column(name="target_group_master_name")
	private String targetGroupMasterName;
	
	@Transient
	private String targetGrptArr;
	
	
	@Transient
	private String trainingSubjectArr;
	
	@Transient
	private String trgCategoryArr;
	
	@Transient
	private String delIds;
	
	@Transient
	private Integer preLevelTrainActivityId;

	public Integer getTrainingId() {
		return trainingId;
	}


	public void setTrainingId(Integer trainingId) {
		this.trainingId = trainingId;
	}


	public Integer getTrainingActivityId() {
		return trainingActivityId;
	}


	public void setTrainingActivityId(Integer trainingActivityId) {
		this.trainingActivityId = trainingActivityId;
	}


	public Integer getTrainingVenueLevelId() {
		return trainingVenueLevelId;
	}


	public void setTrainingVenueLevelId(Integer trainingVenueLevelId) {
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


	public Integer getTrainingCategoryId() {
		return trainingCategoryId;
	}


	public void setTrainingCategoryId(Integer trainingCategoryId) {
		this.trainingCategoryId = trainingCategoryId;
	}


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


	public Integer getTrainingMode() {
		return trainingMode;
	}


	public void setTrainingMode(Integer trainingMode) {
		this.trainingMode = trainingMode;
	}


	public String getTrainingCategoryName() {
		return trainingCategoryName;
	}


	public void setTrainingCategoryName(String trainingCategoryName) {
		this.trainingCategoryName = trainingCategoryName;
	}


	public String getTrainingVenueLevelName() {
		return trainingVenueLevelName;
	}


	public void setTrainingVenueLevelName(String trainingVenueLevelName) {
		this.trainingVenueLevelName = trainingVenueLevelName;
	}


	public String getTrainingModeName() {
		return trainingModeName;
	}


	public void setTrainingModeName(String trainingModeName) {
		this.trainingModeName = trainingModeName;
	}


	public String getSubjectName() {
		return subjectName;
	}


	public void setSubjectName(String subjectName) {
		this.subjectName = subjectName;
	}


	public String getTargetGroupMasterName() {
		return targetGroupMasterName;
	}


	public void setTargetGroupMasterName(String targetGroupMasterName) {
		this.targetGroupMasterName = targetGroupMasterName;
	}


	public String getTargetGrptArr() {
		return targetGrptArr;
	}


	public void setTargetGrptArr(String targetGrptArr) {
		this.targetGrptArr = targetGrptArr;
	}


	public String getTrainingSubjectArr() {
		return trainingSubjectArr;
	}


	public void setTrainingSubjectArr(String trainingSubjectArr) {
		this.trainingSubjectArr = trainingSubjectArr;
	}


	public String getDelIds() {
		return delIds;
	}


	public void setDelIds(String delIds) {
		this.delIds = delIds;
	}


	public Integer getPreLevelTrainActivityId() {
		return preLevelTrainActivityId;
	}


	public void setPreLevelTrainActivityId(Integer preLevelTrainActivityId) {
		this.preLevelTrainActivityId = preLevelTrainActivityId;
	}


	public String getTrgCategoryArr() {
		return trgCategoryArr;
	}


	public void setTrgCategoryArr(String trgCategoryArr) {
		this.trgCategoryArr = trgCategoryArr;
	}
	
	

	
	
	
	
}
