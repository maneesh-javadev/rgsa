package gov.in.rgsa.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.NamedNativeQueries;
import javax.persistence.NamedNativeQuery;

@Entity

@NamedNativeQueries({ 
	@NamedNativeQuery(query = "SELECT row_number() over() as count, * from rgsa.get_statewise_plan_details(:stateCode,:yearId)",
	name = "STATEWISEPLANDETAILS", resultClass = StatewisePlanDetails.class)
	
})




public class StatewisePlanDetails {
	
	@Id
	@Column(name = "count", nullable = false)
	private Integer count;
	
	@Column(name = "training_category_name")
	private String trainingCategoryName;
	
	@Column(name = "subject_name")
	private String subjectName;
	
	@Column(name = "target_group_master_name")
	private String targetGroupMasterName;
	
	@Column(name = "training_venue_level_name")
	private String trainingVenueLevelName;
	
	@Column(name = "no_of_participants", nullable = false)
	private Integer noOfParticipants;
	
	@Column(name = "funds", nullable = false)
	private Integer funds;

	public Integer getCount() {
		return count;
	}

	public void setCount(Integer count) {
		this.count = count;
	}

	public String getTrainingCategoryName() {
		return trainingCategoryName;
	}

	public void setTrainingCategoryName(String trainingCategoryName) {
		this.trainingCategoryName = trainingCategoryName;
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

	public String getTrainingVenueLevelName() {
		return trainingVenueLevelName;
	}

	public void setTrainingVenueLevelName(String trainingVenueLevelName) {
		this.trainingVenueLevelName = trainingVenueLevelName;
	}

	public Integer getNoOfParticipants() {
		return noOfParticipants;
	}

	public void setNoOfParticipants(Integer noOfParticipants) {
		this.noOfParticipants = noOfParticipants;
	}

	public Integer getFunds() {
		return funds;
	}

	public void setFunds(Integer funds) {
		this.funds = funds;
	}
	
	

}
