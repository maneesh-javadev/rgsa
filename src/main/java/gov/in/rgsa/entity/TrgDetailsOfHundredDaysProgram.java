package gov.in.rgsa.entity;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQuery;
import javax.persistence.Table;

@Entity
@Table(name = "trg_details_of_hundred_days_program",schema = "rgsa")
@NamedQuery(name="FETCH_TRG_DETAILS_OF_100_DAYS",query="from TrgDetailsOfHundredDaysProgram where trgOfHundredDaysProgram.trgOfHundredDaysProgramId=:trgOfHundredDaysProgramId ORDER BY trgDetailsOfHundredDaysProgramId")
public class TrgDetailsOfHundredDaysProgram implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = -2491174948601397513L;

	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	@Column(name="trg_details_of_hundred_days_program_id")
	private Long trgDetailsOfHundredDaysProgramId;
	
	@ManyToOne
	@JoinColumn(name="trg_of_hundred_days_program_id")
	private TrgOfHundredDaysProgram trgOfHundredDaysProgram;
	
	@Column(name="target_group_master_id")
	private Integer targetGroupMasterId;
	
	@Column(name = "male_sc")
	private Integer maleSC;
	
	@Column(name = "male_st")
	private Integer maleST;
	
	@Column(name = "male_others")
	private Integer maleOthers;
	
	@Column(name = "female_sc")
	private Integer femaleSC;
	
	@Column(name = "female_st")
	private Integer femaleST;
	
	@Column(name="female_others")
	private Integer femaleOthers;

	public Long getTrgDetailsOfHundredDaysProgramId() {
		return trgDetailsOfHundredDaysProgramId;
	}

	public void setTrgDetailsOfHundredDaysProgramId(Long trgDetailsOfHundredDaysProgramId) {
		this.trgDetailsOfHundredDaysProgramId = trgDetailsOfHundredDaysProgramId;
	}

	public Integer getTargetGroupMasterId() {
		return targetGroupMasterId;
	}

	public void setTargetGroupMasterId(Integer targetGroupMasterId) {
		this.targetGroupMasterId = targetGroupMasterId;
	}

	public Integer getMaleSC() {
		return maleSC;
	}

	public void setMaleSC(Integer maleSC) {
		this.maleSC = maleSC;
	}

	public Integer getMaleST() {
		return maleST;
	}

	public void setMaleST(Integer maleST) {
		this.maleST = maleST;
	}

	public Integer getMaleOthers() {
		return maleOthers;
	}

	public void setMaleOthers(Integer maleOthers) {
		this.maleOthers = maleOthers;
	}

	public Integer getFemaleSC() {
		return femaleSC;
	}

	public void setFemaleSC(Integer femaleSC) {
		this.femaleSC = femaleSC;
	}

	public Integer getFemaleST() {
		return femaleST;
	}

	public void setFemaleST(Integer femaleST) {
		this.femaleST = femaleST;
	}

	public Integer getFemaleOthers() {
		return femaleOthers;
	}

	public void setFemaleOthers(Integer femaleOthers) {
		this.femaleOthers = femaleOthers;
	}

	public TrgOfHundredDaysProgram getTrgOfHundredDaysProgram() {
		return trgOfHundredDaysProgram;
	}

	public void setTrgOfHundredDaysProgram(TrgOfHundredDaysProgram trgOfHundredDaysProgram) {
		this.trgOfHundredDaysProgram = trgOfHundredDaysProgram;
	}
	
}