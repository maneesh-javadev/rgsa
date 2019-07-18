package gov.in.rgsa.entity;

import java.sql.Timestamp;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;
import javax.persistence.Transient;

import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;

@Entity
@Table(name="trg_of_hundred_days_program_ch1",schema="rgsa")
@NamedQueries({
	@NamedQuery(name="FETCH_TRG_OF_100_CH_DAYS_BY_DATE_RANGE",query="from TrgOfHundredDaysProgramCh1 where stateCode=:stateCode  and yearId=:yearId and trgStartDate=:startDate"),
	@NamedQuery(name="FETCH_TRG_OF_100_CH_DAYS" , query = "from TrgOfHundredDaysProgramCh1 where stateCode=:stateCode  and yearId=:yearId"),
})

public class TrgOfHundredDaysProgramCh1 {
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name="trg_of_hundred_days_program_ch_id")
	private Long trgOfHundredDaysProgramChId;
	
	@Column(name="state_code")
	private Integer stateCode;
	
	@Column(name="year_id")
	private Integer yearId;
	
	@Column(name="no_of_training_conducted")
	private Integer noOfTrainingConducted;
	
	@Column(name="trg_st_date")
	private java.util.Date trgStartDate;
	
	@Column(name="trg_end_date")
	private java.util.Date trgEndDate;
	
	@Column(name="sc")
	private Integer scParticipants; 
	
	@Column(name="st")
	private Integer stParticipants;
	
	@Column(name="woman")
	private Integer womenParticipants;
	
	@Column(name="others")
	private Integer othersParticipants;
	
	@Column(name="sc_aspirational")
	private Integer scAspirationalParticipants;
	
	@Column(name="st_aspirational")
	private Integer stAspirationalParticipants;

	@Column(name="woman_aspirational")
	private Integer womenAspirationalParticipants;
	
	@Column(name="others_aspirational")
	private Integer othersAspirationalParticipants;
	
	@Column(name="user_type")
	private String userType;
	
	@CreationTimestamp
	@Column(name="created_on",updatable=false)
	private Timestamp createdOn;
	
	@UpdateTimestamp
	@Column(name="last_updated_on")
	private Timestamp lastUpdatedOn;
	
	@Column(name="created_by")
	private Integer createdBy;
	
	@Column(name="last_updated_by")
	private Integer lastUpdatedBy;
	
	@Column(name="is_freeze")
	private Boolean isFreeze;
	
	@Transient
	private String msg;
	
	@Transient
	private String demoStartDate;
	
	@Transient
	private String demoEndDate;

	public Long getTrgOfHundredDaysProgramChId() {
		return trgOfHundredDaysProgramChId;
	}

	public void setTrgOfHundredDaysProgramChId(Long trgOfHundredDaysProgramChId) {
		this.trgOfHundredDaysProgramChId = trgOfHundredDaysProgramChId;
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

	public Integer getNoOfTrainingConducted() {
		return noOfTrainingConducted;
	}

	public void setNoOfTrainingConducted(Integer noOfTrainingConducted) {
		this.noOfTrainingConducted = noOfTrainingConducted;
	}

	public java.util.Date getTrgStartDate() {
		return trgStartDate;
	}

	public void setTrgStartDate(java.util.Date trgStartDate) {
		this.trgStartDate = trgStartDate;
	}

	public java.util.Date getTrgEndDate() {
		return trgEndDate;
	}

	public void setTrgEndDate(java.util.Date trgEndDate) {
		this.trgEndDate = trgEndDate;
	}

	public Integer getScParticipants() {
		return scParticipants;
	}

	public void setScParticipants(Integer scParticipants) {
		this.scParticipants = scParticipants;
	}

	public Integer getStParticipants() {
		return stParticipants;
	}

	public void setStParticipants(Integer stParticipants) {
		this.stParticipants = stParticipants;
	}

	public Integer getWomenParticipants() {
		return womenParticipants;
	}

	public void setWomenParticipants(Integer womenParticipants) {
		this.womenParticipants = womenParticipants;
	}

	public Integer getOthersParticipants() {
		return othersParticipants;
	}

	public void setOthersParticipants(Integer othersParticipants) {
		this.othersParticipants = othersParticipants;
	}

	public Integer getScAspirationalParticipants() {
		return scAspirationalParticipants;
	}

	public void setScAspirationalParticipants(Integer scAspirationalParticipants) {
		this.scAspirationalParticipants = scAspirationalParticipants;
	}

	public Integer getStAspirationalParticipants() {
		return stAspirationalParticipants;
	}

	public void setStAspirationalParticipants(Integer stAspirationalParticipants) {
		this.stAspirationalParticipants = stAspirationalParticipants;
	}

	public Integer getOthersAspirationalParticipants() {
		return othersAspirationalParticipants;
	}

	public void setOthersAspirationalParticipants(Integer othersAspirationalParticipants) {
		this.othersAspirationalParticipants = othersAspirationalParticipants;
	}

	public String getUserType() {
		return userType;
	}

	public void setUserType(String userType) {
		this.userType = userType;
	}

	public Timestamp getCreatedOn() {
		return createdOn;
	}

	public void setCreatedOn(Timestamp createdOn) {
		this.createdOn = createdOn;
	}

	public Timestamp getLastUpdatedOn() {
		return lastUpdatedOn;
	}

	public void setLastUpdatedOn(Timestamp lastUpdatedOn) {
		this.lastUpdatedOn = lastUpdatedOn;
	}

	public Integer getCreatedBy() {
		return createdBy;
	}

	public void setCreatedBy(Integer createdBy) {
		this.createdBy = createdBy;
	}

	public Integer getLastUpdatedBy() {
		return lastUpdatedBy;
	}

	public void setLastUpdatedBy(Integer lastUpdatedBy) {
		this.lastUpdatedBy = lastUpdatedBy;
	}

	public Boolean getIsFreeze() {
		return isFreeze;
	}

	public void setIsFreeze(Boolean isFreeze) {
		this.isFreeze = isFreeze;
	}

	public String getMsg() {
		return msg;
	}

	public void setMsg(String msg) {
		this.msg = msg;
	}

	public String getDemoStartDate() {
		return demoStartDate;
	}

	public void setDemoStartDate(String demoStartDate) {
		this.demoStartDate = demoStartDate;
	}

	public String getDemoEndDate() {
		return demoEndDate;
	}

	public void setDemoEndDate(String demoEndDate) {
		this.demoEndDate = demoEndDate;
	}

	public Integer getWomenAspirationalParticipants() {
		return womenAspirationalParticipants;
	}

	public void setWomenAspirationalParticipants(Integer womenAspirationalParticipants) {
		this.womenAspirationalParticipants = womenAspirationalParticipants;
	}
}
