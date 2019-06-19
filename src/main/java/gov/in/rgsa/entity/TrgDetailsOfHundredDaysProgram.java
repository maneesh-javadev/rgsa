package gov.in.rgsa.entity;

import java.sql.Timestamp;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.NamedQuery;
import javax.persistence.Table;
import javax.persistence.Transient;

import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;

@Entity
@Table(name = "trg_details_of_hundred_days_program",schema = "rgsa")
@NamedQuery(name="FETCH_DETAILS",query="from TrgDetailsOfHundredDaysProgram where stateCode=:stateCode and yearId=:yearId")
public class TrgDetailsOfHundredDaysProgram {

	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	@Column(name="id")
	private Long id;
	
	@Column(name="state_code")
	private Integer stateCode;
	
	@Column(name="year_id")
	private Integer yearId;
	
	@Column(name = "no_of_participants_sc")
	private Integer noOfParticipantsSC;
	
	@Column(name = "no_of_participants_st")
	private Integer noOfParticipantsST;
	
	@Column(name = "no_of_participants_woman")
	private Integer noOfParticipantsWomen;
	
	@Column(name = "no_of_participants_others")
	private Integer noOfParticipantsOthers;
	
	@Column(name = "no_of_training_conducted")
	private Integer noOfTrainingsConducted;
	
	@Column(name="user_type")
	private String userType;
	
	@Column(name="created_by")
	private Integer createdBy;
	
	@CreationTimestamp
	@Column(name="created_on",updatable=false)
	private Timestamp createdOn;
	
	@Column(name="last_updated_by")
	private Integer lastUpdatedBy;
	
	@UpdateTimestamp
	@Column(name="last_updated_on")
	private Timestamp lastUpdatedOn;
	
	@Column(name="is_freeze")
	private Boolean isFreeze;
	
	@Transient
	private String msg;

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
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

	public Integer getNoOfParticipantsSC() {
		return noOfParticipantsSC;
	}

	public void setNoOfParticipantsSC(Integer noOfParticipantsSC) {
		this.noOfParticipantsSC = noOfParticipantsSC;
	}

	public Integer getNoOfParticipantsST() {
		return noOfParticipantsST;
	}

	public void setNoOfParticipantsST(Integer noOfParticipantsST) {
		this.noOfParticipantsST = noOfParticipantsST;
	}

	public Integer getNoOfParticipantsWomen() {
		return noOfParticipantsWomen;
	}

	public void setNoOfParticipantsWomen(Integer noOfParticipantsWomen) {
		this.noOfParticipantsWomen = noOfParticipantsWomen;
	}

	public Integer getNoOfParticipantsOthers() {
		return noOfParticipantsOthers;
	}

	public void setNoOfParticipantsOthers(Integer noOfParticipantsOthers) {
		this.noOfParticipantsOthers = noOfParticipantsOthers;
	}

	public String getUserType() {
		return userType;
	}

	public void setUserType(String userType) {
		this.userType = userType;
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

	public Integer getNoOfTrainingsConducted() {
		return noOfTrainingsConducted;
	}

	public void setNoOfTrainingsConducted(Integer noOfTrainingsConducted) {
		this.noOfTrainingsConducted = noOfTrainingsConducted;
	}

	public String getMsg() {
		return msg;
	}

	public void setMsg(String msg) {
		this.msg = msg;
	}
	
	
	
	
}
