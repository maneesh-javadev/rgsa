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
@Table(name="qpr_pmu_details", schema="rgsa")

public class PmuProgressDetails {

	
	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	@Column(name="qpr_pmu_details_id")
	private Integer qprPmuDetailsId;
	
	@ManyToOne
	@JoinColumn(name="pmu_activity_type_id")
	private PmuActivityType pmuActivityType;
	
	@ManyToOne
	@JoinColumn(name="qpr_pmu_id")
	private PmuProgress pmuProgress;
	
	@Column(name="no_of_units_filled")
	private Integer noOfUnitsFilled;
	
	@Column(name="expenditure_incurred")
	private Integer expenditureIncurred;

	public Integer getQprPmuDetailsId() {
		return qprPmuDetailsId;
	}

	public void setQprPmuDetailsId(Integer qprPmuDetailsId) {
		this.qprPmuDetailsId = qprPmuDetailsId;
	}

	public PmuActivityType getPmuActivityType() {
		return pmuActivityType;
	}

	public void setPmuActivityType(PmuActivityType pmuActivityType) {
		this.pmuActivityType = pmuActivityType;
	}

	public PmuProgress getPmuProgress() {
		return pmuProgress;
	}

	public void setPmuProgress(PmuProgress pmuProgress) {
		this.pmuProgress = pmuProgress;
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





	