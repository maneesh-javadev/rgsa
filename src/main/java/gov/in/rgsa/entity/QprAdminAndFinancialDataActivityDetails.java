package gov.in.rgsa.entity;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

@Entity
@Table(name="qpr_afp_details" , schema="rgsa")
public class QprAdminAndFinancialDataActivityDetails implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = -3808288507661430958L;

	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	@Column(name="qpr_afp_details_id",nullable=false,updatable=false)
	private Integer qprAfpDetailsId;
	
	@ManyToOne
	@JoinColumn(name="qpr_afp_id")
	private QprAdminAndFinancialDataActivity qprAdminAndFinancialDataActivity;
	
	@ManyToOne
	@JoinColumn(name="pmu_activity_type_id")
	private PmuActivityType pmuActivityType;
	
	
	@Column(name="no_of_units_filled")
	private Integer noOfUnitsFilled;

	@Column(name="expenditure_incurred")
	private Integer expenditureIncurred;

	public Integer getQprAfpDetailsId() {
		return qprAfpDetailsId;
	}

	public void setQprAfpDetailsId(Integer qprAfpDetailsId) {
		this.qprAfpDetailsId = qprAfpDetailsId;
	}

	public QprAdminAndFinancialDataActivity getQprAdminAndFinancialDataActivity() {
		return qprAdminAndFinancialDataActivity;
	}

	public void setQprAdminAndFinancialDataActivity(QprAdminAndFinancialDataActivity qprAdminAndFinancialDataActivity) {
		this.qprAdminAndFinancialDataActivity = qprAdminAndFinancialDataActivity;
	}

	public PmuActivityType getPmuActivityType() {
		return pmuActivityType;
	}

	public void setPmuActivityType(PmuActivityType pmuActivityType) {
		this.pmuActivityType = pmuActivityType;
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
