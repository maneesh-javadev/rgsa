package gov.in.rgsa.dto;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;

import org.hibernate.annotations.NamedNativeQueries;
import org.hibernate.annotations.NamedNativeQuery;

@Entity
@NamedNativeQueries({
	@NamedNativeQuery(name="FETCH_ALL_STATE_DATA",query="SELECT\r\n" + 
			"ROW_NUMBER () OVER () as s_no, \r\n" + 
			"null as field_type ,\r\n" + 
			"null as state_name_english ,\r\n" + 
			"(select (COALESCE(subtable.total_female_sar_sc,0) + COALESCE(subtable.total_male_sar_sc,0) + COALESCE(subtable.total_female_sar_st,0) + \r\n" + 
			"COALESCE(subtable.total_male_sar_st,0) + COALESCE(subtable.total_female_sar_oth,0) + COALESCE(subtable.total_male_sar_oth ,0) +\r\n" + 
			"COALESCE(subtable.total_male_oth_sc ,0) + COALESCE(subtable.total_female_oth_sc ,0) + COALESCE(subtable.total_female_oth_st ,0) + \r\n" + 
			"COALESCE(subtable.total_male_oth_st  ,0) + COALESCE(subtable.total_male_oth_ot ,0) + COALESCE(subtable.total_female_oth_ot ,0) ) as total_er_rep\r\n" + 
			"from (select sum(er_sar_f_sc) as total_female_sar_sc,sum(er_sar_m_sc) as total_male_sar_sc , sum(er_sar_f_st) as total_female_sar_st ,\r\n" + 
			"sum(er_sar_m_st) as total_male_sar_st ,sum(er_sar_f_ot) as total_female_sar_oth , sum(er_sar_m_ot) as total_male_sar_oth ,\r\n" + 
			"sum(er_oth_m_sc) as total_male_oth_sc ,sum(er_oth_f_sc) as total_female_oth_sc , sum(er_oth_m_st) as total_male_oth_st ,\r\n" + 
			"sum(er_oth_f_st) as total_female_oth_st ,sum(er_oth_m_ot) as total_male_oth_ot , sum(er_oth_f_ot) as total_female_oth_ot\r\n" + 
			"from rgsa.trg_of_hundred_days_program_ch2) subtable),\r\n" + 
			"\r\n" + 
			"(select (COALESCE(subtable.total_female_sar_sc,0) + COALESCE(subtable.total_female_sar_st,0) + COALESCE(subtable.total_female_sar_oth,0) \r\n" + 
			"+ COALESCE(subtable.total_female_oth_sc ,0) + COALESCE(subtable.total_female_oth_st ,0) \r\n" + 
			"+ COALESCE(subtable.total_female_oth_ot ,0) ) as total_women_er_rep\r\n" + 
			"from (select sum(er_sar_f_sc) as total_female_sar_sc, sum(er_sar_f_st) as total_female_sar_st ,\r\n" + 
			"sum(er_sar_f_ot) as total_female_sar_oth ,\r\n" + 
			"sum(er_oth_f_sc) as total_female_oth_sc , \r\n" + 
			"sum(er_oth_f_st) as total_female_oth_st ,sum(er_oth_f_ot) as total_female_oth_ot\r\n" + 
			"from rgsa.trg_of_hundred_days_program_ch2) subtable) ,\r\n" + 
			"\r\n" + 
			"(select (COALESCE(subtable.total_female_sar_sc,0) + COALESCE(subtable.total_male_sar_sc,0) +\r\n" + 
			"COALESCE(subtable.total_male_oth_sc ,0) + COALESCE(subtable.total_female_oth_sc ,0)) as total_sc_er_rep\r\n" + 
			"from (select sum(er_sar_f_sc) as total_female_sar_sc,sum(er_sar_m_sc) as total_male_sar_sc,\r\n" + 
			"sum(er_oth_m_sc) as total_male_oth_sc ,sum(er_oth_f_sc) as total_female_oth_sc\r\n" + 
			"  from rgsa.trg_of_hundred_days_program_ch2) subtable) ,\r\n" + 
			"\r\n" + 
			"(select (COALESCE(subtable.total_female_sar_st,0) + COALESCE(subtable.total_male_sar_st,0) +\r\n" + 
			"COALESCE(subtable.total_male_oth_st ,0) + COALESCE(subtable.total_female_oth_st ,0)) as total_st_er_rep\r\n" + 
			"from (select sum(er_sar_f_st) as total_female_sar_st,sum(er_sar_m_st) as total_male_sar_st,\r\n" + 
			"sum(er_oth_m_st) as total_male_oth_st ,sum(er_oth_f_st) as total_female_oth_st\r\n" + 
			"from rgsa.trg_of_hundred_days_program_ch2) subtable) ,\r\n" + 
			"  \r\n" + 
			"(select sum(er_in_aspirational_district)  from rgsa.trg_of_hundred_days_program_ch2) as total_er_in_aspirational_district,\r\n" + 
			"\r\n" + 
			"(select sum(fun_in_aspirational_district)  from rgsa.trg_of_hundred_days_program_ch2) as total_fun_in_aspirational_district,\r\n" + 
			"\r\n" + 
			"(select sum(no_of_training_conducted)  from rgsa.trg_of_hundred_days_program_ch2) as total_no_of_training_conducted,\r\n" + 
			"\r\n" + 
			"(select sum(trg_conducted_in_asp_district)  from rgsa.trg_of_hundred_days_program_ch2) as total_trg_conducted_in_asp_district\r\n" + 
			"\r\n" + 
			"FROM rgsa.trg_of_hundred_days_program_ch2 LIMIT 1",resultClass = HundredDaysWebServiceDTO.class),
	@NamedNativeQuery(name="STATEWISE_DATA_FOR_ALL_FIELDS",query="select ROW_NUMBER () OVER () as s_no,null as field_type,s.state_name_english,COALESCE(sum(ch.er_sar_f_sc),0) + COALESCE(sum(ch.er_sar_m_sc),0) + COALESCE(sum(ch.er_sar_f_st),0) + COALESCE(sum(ch.er_sar_m_st),0) + COALESCE(sum(ch.er_sar_f_ot),0) + COALESCE( sum(ch.er_sar_m_ot),0) + COALESCE(sum(ch.er_oth_m_sc),0) + COALESCE(sum(ch.er_oth_f_sc),0) + COALESCE( sum(ch.er_oth_m_st),0) + COALESCE( sum(ch.er_oth_f_st),0) + COALESCE(sum(ch.er_oth_m_ot),0) + COALESCE( sum(ch.er_oth_f_ot),0) as total_er_rep,COALESCE(sum(ch.er_sar_f_sc),0) + COALESCE(sum(ch.er_sar_f_st),0) + COALESCE(sum(ch.er_sar_f_ot),0)  + COALESCE(sum(ch.er_oth_f_sc),0) + COALESCE( sum(ch.er_oth_f_st),0) + COALESCE( sum(ch.er_oth_f_ot),0) as total_women_er_rep ,COALESCE(sum(ch.er_sar_f_sc),0) + COALESCE(sum(ch.er_sar_m_sc),0) + COALESCE(sum(ch.er_oth_m_sc),0) + COALESCE(sum(ch.er_oth_f_sc),0) as total_sc_er_rep,COALESCE(sum(ch.er_sar_f_st),0) + COALESCE(sum(ch.er_sar_m_st),0) + COALESCE( sum(ch.er_oth_m_st),0) + COALESCE( sum(ch.er_oth_f_st),0) as total_st_er_rep,COALESCE(sum(er_in_aspirational_district),0) as total_er_in_aspirational_district,COALESCE(sum(fun_in_aspirational_district),0) as total_fun_in_aspirational_district,COALESCE(sum(no_of_training_conducted),0) as total_no_of_training_conducted,\r\n" + 
			"COALESCE(sum(trg_conducted_in_asp_district),0) as total_trg_conducted_in_asp_district\r\n" + 
			"from rgsa.trg_of_hundred_days_program_ch2 ch right join lgd.state s on ch.state_code=s.state_code group by s.state_name_english order by s.state_name_english",resultClass = HundredDaysWebServiceDTO.class)
})
public class HundredDaysWebServiceDTO {

	@Id
	@Column(name="s_no")
	private Integer sNo;
	
	@Column(name="field_type")
	private String fieldType;
	
	@Column(name="state_name_english")
	private String stateName;
	
	@Column(name="total_er_rep")
	private Integer totalErTrained;
	
	@Column(name="total_women_er_rep")
	private Integer womenErTrained;
	
	@Column(name="total_sc_er_rep")
	private Integer scErTrained;
	
	@Column(name="total_st_er_rep")
	private Integer stErTrained;
	
	@Column(name="total_er_in_aspirational_district")
	private Integer erTrainedAspDistrict;
	
	@Column(name="total_fun_in_aspirational_district")
	private Integer funAndStakeHolderTrainedAspDistrict;
	
	@Column(name="total_no_of_training_conducted")
	private Integer noOfTrainingConducted;
	
	@Column(name="total_trg_conducted_in_asp_district")
	private Integer noOfTrainingConductedAspDistrict;

	public Integer getsNo() {
		return sNo;
	}

	public void setsNo(Integer sNo) {
		this.sNo = sNo;
	}

	public String getStateName() {
		return stateName;
	}

	public void setStateName(String stateName) {
		this.stateName = stateName;
	}

	public Integer getTotalErTrained() {
		return totalErTrained;
	}

	public void setTotalErTrained(Integer totalErTrained) {
		this.totalErTrained = totalErTrained;
	}

	public Integer getWomenErTrained() {
		return womenErTrained;
	}

	public void setWomenErTrained(Integer womenErTrained) {
		this.womenErTrained = womenErTrained;
	}

	public Integer getScErTrained() {
		return scErTrained;
	}

	public void setScErTrained(Integer scErTrained) {
		this.scErTrained = scErTrained;
	}

	public Integer getStErTrained() {
		return stErTrained;
	}

	public void setStErTrained(Integer stErTrained) {
		this.stErTrained = stErTrained;
	}

	public Integer getErTrainedAspDistrict() {
		return erTrainedAspDistrict;
	}

	public void setErTrainedAspDistrict(Integer erTrainedAspDistrict) {
		this.erTrainedAspDistrict = erTrainedAspDistrict;
	}

	public Integer getFunAndStakeHolderTrainedAspDistrict() {
		return funAndStakeHolderTrainedAspDistrict;
	}

	public void setFunAndStakeHolderTrainedAspDistrict(Integer funAndStakeHolderTrainedAspDistrict) {
		this.funAndStakeHolderTrainedAspDistrict = funAndStakeHolderTrainedAspDistrict;
	}

	public Integer getNoOfTrainingConducted() {
		return noOfTrainingConducted;
	}

	public void setNoOfTrainingConducted(Integer noOfTrainingConducted) {
		this.noOfTrainingConducted = noOfTrainingConducted;
	}

	public Integer getNoOfTrainingConductedAspDistrict() {
		return noOfTrainingConductedAspDistrict;
	}

	public void setNoOfTrainingConductedAspDistrict(Integer noOfTrainingConductedAspDistrict) {
		this.noOfTrainingConductedAspDistrict = noOfTrainingConductedAspDistrict;
	}

	public String getFieldType() {
		return fieldType;
	}

	public void setFieldType(String fieldType) {
		this.fieldType = fieldType;
	}
	
	
	
}
