package gov.in.rgsa.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

@Entity
@Table(name = "qpr_pesa_details", schema = "rgsa")
public class QprPesaDetails {
	
	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)	
	@Column(name="qpr_pesa_details_id", updatable=false, nullable=false)
	private Integer qprPesaDetailsId;	

	@ManyToOne(fetch=FetchType.LAZY)
	@JoinColumn(name="qpr_pesa_id", nullable=false)
	private QprPesa qprPesa;
	
	@ManyToOne(fetch=FetchType.LAZY)
	@JoinColumn(name="designation_id", nullable=false)
	private PesaPost pesaPost;

	@ManyToOne(fetch=FetchType.LAZY)
	@JoinColumn(name="pesa_plan_details_id", nullable=false)
	private PesaPlanDetails pesaPlanDetails;
	
	@Column(name="no_of_units_filled")
	private Integer noOfUnitsFilled;
	
	@Column(name="expenditure_incurred")
	private Double expenditureIncurred;

	public Integer getQprPesaDetailsId() {
		return qprPesaDetailsId;
	}

	public void setQprPesaDetailsId(Integer qprPesaDetailsId) {
		this.qprPesaDetailsId = qprPesaDetailsId;
	}

	public QprPesa getQprPesa() {
		return qprPesa;
	}

	public void setQprPesa(QprPesa qprPesa) {
		this.qprPesa = qprPesa;
	}

	public PesaPost getPesaPost() {
		return pesaPost;
	}

	public void setPesaPost(PesaPost pesaPost) {
		this.pesaPost = pesaPost;
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

	public PesaPlanDetails getPesaPlanDetails() {
		return pesaPlanDetails;
	}

	public void setPesaPlanDetails(PesaPlanDetails pesaPlanDetails) {
		this.pesaPlanDetails = pesaPlanDetails;
	}
}
