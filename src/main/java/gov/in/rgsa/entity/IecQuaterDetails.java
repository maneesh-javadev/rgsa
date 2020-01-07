package gov.in.rgsa.entity;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;

@Entity
@Table(name="qpr_iec_details", schema="rgsa")
public class IecQuaterDetails implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = -4047615418405619593L;

	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	@Column(name="qpr_iec_details_id")
	private Integer qprIecDetailsId;
	
	@ManyToOne
	@JoinColumn(name="qpr_iec_id")
	private IecQuater iecQuater;
	
	@Column(name="no_of_units_filled")
	private Integer noOfUnitsFilled;
	
	@Column(name="expenditure_incurred")
	private Integer expenditureIncurred;

	public Integer getQprIecDetailsId() {
		return qprIecDetailsId;
	}

	public void setQprIecDetailsId(Integer qprIecDetailsId) {
		this.qprIecDetailsId = qprIecDetailsId;
	}

	public IecQuater getIecQuater() {
		return iecQuater;
	}

	public void setIecQuater(IecQuater iecQuater) {
		this.iecQuater = iecQuater;
	}

	public Integer getNoOfUnitsFilled() {
		return noOfUnitsFilled;
	}

	public void setNoOfUnitsFilled(Integer noOfUnitsFilled) {
		this.noOfUnitsFilled = noOfUnitsFilled;
	}

	public Integer getExpenditureIncurred() {
		return expenditureIncurred;
	}

	public void setExpenditureIncurred(Integer expenditureIncurred) {
		this.expenditureIncurred = expenditureIncurred;
	}

	
}
