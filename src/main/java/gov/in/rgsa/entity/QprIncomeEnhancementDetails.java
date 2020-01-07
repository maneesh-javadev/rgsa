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
import javax.persistence.Table;

/**
 * @author Mohammad Ayaz 28/12/2018
 *
 */
@Entity
@Table(name="qpr_income_enhancement_details" , schema="rgsa")
public class QprIncomeEnhancementDetails implements Serializable {
	
	/**
	 * 
	 */
	private static final long serialVersionUID = -1050501112221065665L;

	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	@Column(name="qpr_income_enhancement_details_id",nullable=false,updatable=false)
	private Integer qprIncomeEnhancementDetailsId;
	
	@ManyToOne
	@JoinColumn(name="qpr_income_enhancement_id")
	private QprIncomeEnhancement qprIncomeEnhancement;
	
	@ManyToOne
	@JoinColumn(name="income_enhancement_details_id")
	private IncomeEnhancementDetails incomeEnhancementDetails;
	
	@Column(name="expenditure_incurred")
	private Integer expenditureIncurred;

	public Integer getQprIncomeEnhancementDetailsId() {
		return qprIncomeEnhancementDetailsId;
	}

	public void setQprIncomeEnhancementDetailsId(Integer qprIncomeEnhancementDetailsId) {
		this.qprIncomeEnhancementDetailsId = qprIncomeEnhancementDetailsId;
	}

	public QprIncomeEnhancement getQprIncomeEnhancement() {
		return qprIncomeEnhancement;
	}

	public void setQprIncomeEnhancement(QprIncomeEnhancement qprIncomeEnhancement) {
		this.qprIncomeEnhancement = qprIncomeEnhancement;
	}

	public IncomeEnhancementDetails getIncomeEnhancementDetails() {
		return incomeEnhancementDetails;
	}

	public void setIncomeEnhancementDetails(IncomeEnhancementDetails incomeEnhancementDetails) {
		this.incomeEnhancementDetails = incomeEnhancementDetails;
	}

	public Integer getExpenditureIncurred() {
		return expenditureIncurred;
	}

	public void setExpenditureIncurred(Integer expenditureIncurred) {
		this.expenditureIncurred = expenditureIncurred;
	}

	
}
