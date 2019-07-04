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
@Table(name="trg_of_hundred_days_program_ch2",schema="rgsa")
@NamedQueries({
	@NamedQuery(name="FETCH_TRG_OF_100_LATEST",query="from TrgOfHundredDaysProgramCh2 where stateCode=:stateCode and yearId=:yearId order by trgDate desc"),
	@NamedQuery(name="FETCH_TRG_100_DAYS_CH2",query="from TrgOfHundredDaysProgramCh2 where stateCode=:stateCode and yearId=:yearId and trgDate=:trgDate")
})

public class TrgOfHundredDaysProgramCh2 {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name="trg_of_hundred_days_program_ch2_id")
	private Long trgOfHundredDaysProgramCh2Id;
	
	@Column(name="state_code")
	private Integer stateCode;
	
	@Column(name="year_id")
	private Integer yearId;
	
	@Column(name="no_of_training_conducted")
	private Integer noOfTrainingConducted;
	
	@Column(name="trg_date")
	private java.util.Date trgDate;
	
	@Column(name="er_sar_m_sc")
	private Integer erSarMaleSc;
	
	@Column(name="er_sar_m_st")
	private Integer erSarMaleSt;
	
	@Column(name="er_sar_m_ot")
	private Integer erSarMaleOthers;
	
	@Column(name="er_sar_f_sc")
	private Integer erSarFemaleSc;
	
	@Column(name="er_sar_f_st")
	private Integer erSarFemaleSt;
	
	@Column(name="er_sar_f_ot")
	private Integer erSarFemaleOthers;
	
	@Column(name="er_oth_m_sc")
	private Integer erOtherMaleSc;
	
	@Column(name="er_oth_m_st")
	private Integer erOtherMaleSt;
	
	@Column(name="er_oth_m_ot")
	private Integer erOtherMaleOthers;
	
	@Column(name="er_oth_f_sc")
	private Integer erOtherFemaleSc;
	
	@Column(name="er_oth_f_st")
	private Integer erOtherFemaleSt;
	
	@Column(name="er_oth_f_ot")
	private Integer erOtherFemaleOthers;
	
	@Column(name="fun_m_sc")
	private Integer funMaleSc;
	
	@Column(name="fun_m_st")
	private Integer funMaleSt;
	
	@Column(name="fun_m_ot")
	private Integer funMaleOthers;
	
	@Column(name="fun_f_sc")
	private Integer funFemaleSc;
	
	@Column(name="fun_f_st")
	private Integer funFemaleSt;
	
	@Column(name="fun_f_ot")
	private Integer funFemaleOthers;
	
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
	private String demoDate;
	
	@Column(name="trg_conducted_in_asp_district")
	private Integer noOfTrainingConductedAspDistrict;
	
	@Column(name="er_in_aspirational_district")
	private Integer electativeRepresentativeInAspDistrict;
	
	@Column(name="fun_in_aspirational_district")
	private Integer funcAndStakeHolderInAspDistrict;
	
	public Long getTrgOfHundredDaysProgramCh2Id() {
		return trgOfHundredDaysProgramCh2Id;
	}

	public void setTrgOfHundredDaysProgramCh2Id(Long trgOfHundredDaysProgramCh2Id) {
		this.trgOfHundredDaysProgramCh2Id = trgOfHundredDaysProgramCh2Id;
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

	public java.util.Date getTrgDate() {
		return trgDate;
	}

	public void setTrgDate(java.util.Date trgDate) {
		this.trgDate = trgDate;
	}

	public Integer getErSarMaleSc() {
		return erSarMaleSc;
	}

	public void setErSarMaleSc(Integer erSarMaleSc) {
		this.erSarMaleSc = erSarMaleSc;
	}

	public Integer getErSarMaleSt() {
		return erSarMaleSt;
	}

	public void setErSarMaleSt(Integer erSarMaleSt) {
		this.erSarMaleSt = erSarMaleSt;
	}

	public Integer getErSarMaleOthers() {
		return erSarMaleOthers;
	}

	public void setErSarMaleOthers(Integer erSarMaleOthers) {
		this.erSarMaleOthers = erSarMaleOthers;
	}

	public Integer getErSarFemaleSc() {
		return erSarFemaleSc;
	}

	public void setErSarFemaleSc(Integer erSarFemaleSc) {
		this.erSarFemaleSc = erSarFemaleSc;
	}

	public Integer getErSarFemaleSt() {
		return erSarFemaleSt;
	}

	public void setErSarFemaleSt(Integer erSarFemaleSt) {
		this.erSarFemaleSt = erSarFemaleSt;
	}

	public Integer getErSarFemaleOthers() {
		return erSarFemaleOthers;
	}

	public void setErSarFemaleOthers(Integer erSarFemaleOthers) {
		this.erSarFemaleOthers = erSarFemaleOthers;
	}

	public Integer getErOtherMaleSc() {
		return erOtherMaleSc;
	}

	public void setErOtherMaleSc(Integer erOtherMaleSc) {
		this.erOtherMaleSc = erOtherMaleSc;
	}

	public Integer getErOtherMaleSt() {
		return erOtherMaleSt;
	}

	public void setErOtherMaleSt(Integer erOtherMaleSt) {
		this.erOtherMaleSt = erOtherMaleSt;
	}

	public Integer getErOtherMaleOthers() {
		return erOtherMaleOthers;
	}

	public void setErOtherMaleOthers(Integer erOtherMaleOthers) {
		this.erOtherMaleOthers = erOtherMaleOthers;
	}

	public Integer getErOtherFemaleSc() {
		return erOtherFemaleSc;
	}

	public void setErOtherFemaleSc(Integer erOtherFemaleSc) {
		this.erOtherFemaleSc = erOtherFemaleSc;
	}

	public Integer getErOtherFemaleSt() {
		return erOtherFemaleSt;
	}

	public void setErOtherFemaleSt(Integer erOtherFemaleSt) {
		this.erOtherFemaleSt = erOtherFemaleSt;
	}

	public Integer getErOtherFemaleOthers() {
		return erOtherFemaleOthers;
	}

	public void setErOtherFemaleOthers(Integer erOtherFemaleOthers) {
		this.erOtherFemaleOthers = erOtherFemaleOthers;
	}

	public Integer getFunMaleSc() {
		return funMaleSc;
	}

	public void setFunMaleSc(Integer funMaleSc) {
		this.funMaleSc = funMaleSc;
	}

	public Integer getFunMaleSt() {
		return funMaleSt;
	}

	public void setFunMaleSt(Integer funMaleSt) {
		this.funMaleSt = funMaleSt;
	}

	public Integer getFunMaleOthers() {
		return funMaleOthers;
	}

	public void setFunMaleOthers(Integer funMaleOthers) {
		this.funMaleOthers = funMaleOthers;
	}

	public Integer getFunFemaleSc() {
		return funFemaleSc;
	}

	public void setFunFemaleSc(Integer funFemaleSc) {
		this.funFemaleSc = funFemaleSc;
	}

	public Integer getFunFemaleSt() {
		return funFemaleSt;
	}

	public void setFunFemaleSt(Integer funFemaleSt) {
		this.funFemaleSt = funFemaleSt;
	}

	public Integer getFunFemaleOthers() {
		return funFemaleOthers;
	}

	public void setFunFemaleOthers(Integer funFemaleOthers) {
		this.funFemaleOthers = funFemaleOthers;
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

	public String getDemoDate() {
		return demoDate;
	}

	public void setDemoDate(String demoDate) {
		this.demoDate = demoDate;
	}

	public Integer getNoOfTrainingConductedAspDistrict() {
		return noOfTrainingConductedAspDistrict;
	}

	public void setNoOfTrainingConductedAspDistrict(Integer noOfTrainingConductedAspDistrict) {
		this.noOfTrainingConductedAspDistrict = noOfTrainingConductedAspDistrict;
	}

	public Integer getElectativeRepresentativeInAspDistrict() {
		return electativeRepresentativeInAspDistrict;
	}

	public void setElectativeRepresentativeInAspDistrict(Integer electativeRepresentativeInAspDistrict) {
		this.electativeRepresentativeInAspDistrict = electativeRepresentativeInAspDistrict;
	}

	public Integer getFuncAndStakeHolderInAspDistrict() {
		return funcAndStakeHolderInAspDistrict;
	}

	public void setFuncAndStakeHolderInAspDistrict(Integer funcAndStakeHolderInAspDistrict) {
		this.funcAndStakeHolderInAspDistrict = funcAndStakeHolderInAspDistrict;
	}
	
}
