package gov.in.rgsa.dto;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.NamedNativeQuery;

@Entity
@NamedNativeQuery(name="NO_OF_PARTICIPANTS_STATE_WISE",
  query=" select trim(s.state_name_english)state_name_english,(coalesce((no_of_participants_sc),0)+coalesce((no_of_participants_st),0)" + 
  		"+coalesce((no_of_participants_woman),0)+coalesce((no_of_participants_others),0))no_of_participants " + 
  		"	from lgd.state s left join rgsa.trg_details_of_hundred_days_program td on td.state_code=s.state_code and td.isactive" + 
  		"	left join rgsa.fin_year  fy  on td.year_id =fy.year_id and fy.finyear = :fin_year" + 
  		"	where   s.isactive=true  order by s.state_name_english"
 ,resultClass=StatewiseNoOfParticipants.class)
 
public class StatewiseNoOfParticipants {
	
	
	
	@Id
	@Column(name="state_name_english")
	private String stateNameEnglish;
	
	@Column(name="no_of_participants")
	private Integer noOfParticipants;

	

	public String getStateNameEnglish() {
		return stateNameEnglish;
	}

	public void setStateNameEnglish(String stateNameEnglish) {
		this.stateNameEnglish = stateNameEnglish;
	}

	public Integer getNoOfParticipants() {
		return noOfParticipants;
	}

	public void setNoOfParticipants(Integer noOfParticipants) {
		this.noOfParticipants = noOfParticipants;
	}
	
	
	

}
