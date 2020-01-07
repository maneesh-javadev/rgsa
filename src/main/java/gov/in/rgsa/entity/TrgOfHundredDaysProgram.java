package gov.in.rgsa.entity;

import java.io.Serializable;
import java.sql.Timestamp;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.NamedQuery;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Transient;

import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;

@Entity
@Table(name="trg_of_hundred_days_program",schema="rgsa")
@NamedQuery(name="FETCH_TRG_OF_100_DAYS",query="from TrgOfHundredDaysProgram where stateCode=:stateCode and yearId=:yearId")
public class TrgOfHundredDaysProgram implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 8140346896772930577L;

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name="trg_of_hundred_days_program_id")
	private Long trgOfHundredDaysProgramId;
	
	@Column(name="state_code")
	private Integer stateCode;
	
	@Column(name="year_id")
	private Integer yearId;
	
	@Column(name="no_of_training_conducted")
	private Integer noOfTrainingConducted;
	
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
	
	@OneToMany(cascade = CascadeType.ALL,mappedBy = "trgOfHundredDaysProgram",fetch = FetchType.EAGER)
	private List<TrgDetailsOfHundredDaysProgram> trgDetailsOfHundredDaysProgram; 

	public Long getTrgOfHundredDaysProgramId() {
		return trgOfHundredDaysProgramId;
	}

	public void setTrgOfHundredDaysProgramId(Long trgOfHundredDaysProgramId) {
		this.trgOfHundredDaysProgramId = trgOfHundredDaysProgramId;
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

	public List<TrgDetailsOfHundredDaysProgram> getTrgDetailsOfHundredDaysProgram() {
		return trgDetailsOfHundredDaysProgram;
	}

	public void setTrgDetailsOfHundredDaysProgram(List<TrgDetailsOfHundredDaysProgram> trgDetailsOfHundredDaysProgram) {
		this.trgDetailsOfHundredDaysProgram = trgDetailsOfHundredDaysProgram;
	}

	public String getMsg() {
		return msg;
	}

	public void setMsg(String msg) {
		this.msg = msg;
	}
	
}
