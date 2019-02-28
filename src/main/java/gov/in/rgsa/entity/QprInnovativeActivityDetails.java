package gov.in.rgsa.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

@Entity
@Table(name="qpr_ia_details", schema="rgsa")

public class QprInnovativeActivityDetails {

	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	@Column(name="qpr_ia_details_id")
	private Integer qprIaDetailsId;
	
	@ManyToOne
	@JoinColumn(name="qpr_ia_id")
	private QprInnovativeActivity qprInnovativeActivity;
	
	
	@Column(name="expenditure_incurred")
	private Integer expenditureIncurred;


	public Integer getQprIaDetailsId() {
		return qprIaDetailsId;
	}


	public void setQprIaDetailsId(Integer qprIaDetailsId) {
		this.qprIaDetailsId = qprIaDetailsId;
	}


	public QprInnovativeActivity getQprInnovativeActivity() {
		return qprInnovativeActivity;
	}


	public void setQprInnovativeActivity(QprInnovativeActivity qprInnovativeActivity) {
		this.qprInnovativeActivity = qprInnovativeActivity;
	}


	public Integer getExpenditureIncurred() {
		return expenditureIncurred;
	}


	public void setExpenditureIncurred(Integer expenditureIncurred) {
		this.expenditureIncurred = expenditureIncurred;
	}

	
	
}
