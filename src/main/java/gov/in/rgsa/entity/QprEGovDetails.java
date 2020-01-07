package gov.in.rgsa.entity;

import java.io.Serializable;

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
@NamedQuery(name="DETAILS_BY_QPR_EGOV_ACTIVITY_ID",query="from QprEGovDetails where qprEgov.qprEgovId=:qprEgovId")
@Table(name="qpr_egov_details", schema="rgsa")
public class QprEGovDetails implements Serializable
{
	/**
	 * 
	 */
	private static final long serialVersionUID = 3288755517397824413L;

	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	@Column(name="qpr_egov_details_id")
	private Integer qprEGovDetailsId;

	@ManyToOne(fetch=FetchType.LAZY)
	@JoinColumn(name="qpr_egov_id", nullable=false)
	private QprEGov qprEgov;

	@ManyToOne(fetch=FetchType.LAZY)
	@JoinColumn(name="egov_support_activity_details_id", nullable=false)
	private EGovSupportActivityDetails eGovSupportActivityDetails;

	@ManyToOne(fetch=FetchType.LAZY)
	@JoinColumn(name="egov_post_id", nullable=false)
	private EGovPost eGovPost;

	@Column(name="no_of_units_filled")
	private Integer noOfUnitsFilled;

	@Column(name="expenditure_incurred")
	private Double expenditureIncurred;

	public Integer getQprEGovDetailsId() {
		return qprEGovDetailsId;
	}

	public void setQprEGovDetailsId(Integer qprEGovDetailsId) {
		this.qprEGovDetailsId = qprEGovDetailsId;
	}

	public QprEGov getQprEgov() {
		return qprEgov;
	}

	public void setQprEgov(QprEGov qprEgov) {
		this.qprEgov = qprEgov;
	}

	public EGovPost geteGovPost() {
		return eGovPost;
	}

	public void seteGovPost(EGovPost eGovPost) {
		this.eGovPost = eGovPost;
	}

	public Integer getNoOfUnitsFilled() {
		return noOfUnitsFilled;
	}

	public void setNoOfUnitsFilled(Integer noOfUnitsFilled) {
		this.noOfUnitsFilled = noOfUnitsFilled;
	}

	public Double getExpenditureIncurred() {
		return expenditureIncurred;
	}

	public void setExpenditureIncurred(Double expenditureIncurred) {
		this.expenditureIncurred = expenditureIncurred;
	}

	public EGovSupportActivityDetails geteGovSupportActivityDetails() {
		return eGovSupportActivityDetails;
	}

	public void seteGovSupportActivityDetails(EGovSupportActivityDetails eGovSupportActivityDetails) {
		this.eGovSupportActivityDetails = eGovSupportActivityDetails;
	}
}