package gov.in.rgsa.dto;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.NamedNativeQueries;
import javax.persistence.NamedNativeQuery;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

@Entity

@NamedNativeQueries({
@NamedNativeQuery(name="ER_Representative_Hundred_Day_Prog_LAST_WEEK_WISE",
query="select * from rgsa.Week_wise_Elective_Representative_Trained()"
,resultClass=ERRepresentativeHundredDayProgLastWeekWise.class),



})


public class ERRepresentativeHundredDayProgLastWeekWise {
	
	/*
	 * @Id
	 * 
	 * @Column(name="id") private Integer id;
	 */
	@Id
	@Temporal(TemporalType.DATE)
	@Column(name="trg_date")
	private Date  trgDate;
	
	
	@Column(name="total_ER_Trained")
	private Integer totalERTrained;


	public Date getTrgDate() {
		return trgDate;
	}


	public void setTrgDate(Date trgDate) {
		this.trgDate = trgDate;
	}


	public Integer getTotalERTrained() {
		return totalERTrained;
	}


	public void setTotalERTrained(Integer totalERTrained) {
		this.totalERTrained = totalERTrained;
	}
	
	
	

}
