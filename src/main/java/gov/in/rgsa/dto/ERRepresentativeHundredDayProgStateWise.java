package gov.in.rgsa.dto;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.NamedNativeQueries;
import javax.persistence.NamedNativeQuery;

@Entity

@NamedNativeQueries({
@NamedNativeQuery(name="ER_Representative_Hundred_Day_Prog_State_Wise",
query=//" select cast(row_number() over() as integer) id,"+ 
	"	  select trim(s.state_name_english)state_name_english,cast(coalesce(sum(sc),0)+coalesce(sum(st),0)+coalesce(sum(woman),0)+coalesce(sum(others),0) as integer) total_ER_trained ," + 
	"	 cast(coalesce(sum(woman),0)as integer)woman_ER_trained, cast(coalesce(sum(sc),0)as integer)sc_ER_trained, cast(coalesce(sum(st),0)as integer)st_ER_trained, " + 
	"	 cast(coalesce(sum(sc_aspirational),0)+coalesce(sum(st_aspirational),0)+coalesce(sum(woman_aspirational),0)+coalesce(sum(others_aspirational),0)as integer)   total_aspirational_trained " + 
	"  			from lgd.state s left join rgsa.trg_of_hundred_days_program_ch1 td on td.state_code=s.state_code and trg_st_date>=:stDate and trg_end_date<=:endDate "+ 
	"  			where   s.isactive=true group by   s.state_name_english order by s.state_name_english "
,resultClass=ERRepresentativeHundredDayProgStateWise.class)

})
public class ERRepresentativeHundredDayProgStateWise {
	
	@Id
	@Column(name="state_name_english")
	private String stateNameEnglish;
	
	
	@Column(name="total_ER_Trained")
	private Integer totalERTrained;
	
	@Column(name="woman_ER_trained")
	private Integer womanERTrained;
	
	@Column(name="sc_ER_trained")
	private Integer scERTrained;
	
	
	@Column(name="st_ER_trained")
	private Integer stERTrained;
	
	@Column(name="total_aspirational_trained")
	private Integer totalADTrained;

	/*
	 * public Integer getId() { return id; }
	 * 
	 * public void setId(Integer id) { this.id = id; }
	 */

	public Integer getTotalERTrained() {
		return totalERTrained;
	}

	public void setTotalERTrained(Integer totalERTrained) {
		this.totalERTrained = totalERTrained;
	}

	public Integer getWomanERTrained() {
		return womanERTrained;
	}

	public void setWomanERTrained(Integer womanERTrained) {
		this.womanERTrained = womanERTrained;
	}

	public Integer getScERTrained() {
		return scERTrained;
	}

	public void setScERTrained(Integer scERTrained) {
		this.scERTrained = scERTrained;
	}

	public Integer getStERTrained() {
		return stERTrained;
	}

	public void setStERTrained(Integer stERTrained) {
		this.stERTrained = stERTrained;
	}

	public Integer getTotalADTrained() {
		return totalADTrained;
	}

	public void setTotalADTrained(Integer totalADTrained) {
		this.totalADTrained = totalADTrained;
	}

	public String getStateNameEnglish() {
		return stateNameEnglish;
	}

	public void setStateNameEnglish(String stateNameEnglish) {
		this.stateNameEnglish = stateNameEnglish;
	}
	
	
	

}
