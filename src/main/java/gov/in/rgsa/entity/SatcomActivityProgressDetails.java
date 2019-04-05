
package gov.in.rgsa.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQuery;
import javax.persistence.Table;

@Entity
@Table(name="satcom_details_progress_report", schema="rgsa")
@NamedQuery(name="FETCH_DETAILS_BY_QTR_ID_AND_ACT_ID",query="from SatcomActivityProgressDetails where satcomActivityProgress.satcomActivityProgressId=:satcomActivityProgressId and quarterDuration.qtrId !=:quarterId")
public class SatcomActivityProgressDetails{

	@Id
	@Column(name="satcom_details_progress_report_id")
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Integer satcomDetailsProgressId;
	
	
	@ManyToOne
	@JoinColumn(name="satcom_activity_progress_report_id")
	private SatcomActivityProgress satcomActivityProgress;
	
	
	@ManyToOne(fetch=FetchType.LAZY)
	@JoinColumn(name="quarter_id")
	private QuarterDuration quarterDuration;
	
		
	@Column(name="no_of_units_completed")
	private Integer noOfUnitCompleted; 
	
	
	@Column(name="expenditure_incurred")
	private Integer expenditureIncurred;


	public Integer getSatcomDetailsProgressId() {
		return satcomDetailsProgressId;
	}


	public void setSatcomDetailsProgressId(Integer satcomDetailsProgressId) {
		this.satcomDetailsProgressId = satcomDetailsProgressId;
	}


	public SatcomActivityProgress getSatcomActivityProgress() {
		return satcomActivityProgress;
	}


	public void setSatcomActivityProgress(SatcomActivityProgress satcomActivityProgress) {
		this.satcomActivityProgress = satcomActivityProgress;
	}
	
	public Integer getNoOfUnitCompleted() {
		return noOfUnitCompleted;
	}


	public void setNoOfUnitCompleted(Integer noOfUnitCompleted) {
		this.noOfUnitCompleted = noOfUnitCompleted;
	}


	public Integer getExpenditureIncurred() {
		return expenditureIncurred;
	}


	public void setExpenditureIncurred(Integer expenditureIncurred) {
		this.expenditureIncurred = expenditureIncurred;
	} 
	
	public QuarterDuration getQuarterDuration() {
		return quarterDuration;
	}


	public void setQuarterDuration(QuarterDuration quarterDuration) {
		this.quarterDuration = quarterDuration;
	}

	
}