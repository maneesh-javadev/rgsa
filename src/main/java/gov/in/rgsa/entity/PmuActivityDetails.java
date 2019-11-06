package gov.in.rgsa.entity;

import javax.persistence.CascadeType;
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
/**
 * @author MOhammad Ayaz 04/10/2018
 *
 */
@Entity
@Table(name="pmu_activity_details",schema="rgsa")
@NamedQuery(name="FETCH_ALL_PMU_DETAILS_EXCEPT_CURRENT_VERSION" , query="from PmuActivityDetails where pmuActivity.stateCode=:stateCode and pmuActivity.versionNo !=:versionNo and pmuActivity.userType in('S','M') order by pmuDetailsId")
public class PmuActivityDetails {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name="pmu_activity_details_id")
	private Integer pmuDetailsId;
	
	@ManyToOne(cascade=CascadeType.ALL , fetch=FetchType.EAGER)
	@JoinColumn(name="pmu_activity_id")
	private PmuActivity pmuActivity;
	
	@ManyToOne
	@JoinColumn(name="pmu_activity_type_id")
	private PmuActivityType pmuActivityType;
	
	
	@Column(name="no_of_units")
	private Integer noOfUnits;
	
	@Column(name="unit_cost")
	private Integer unitCost;
	
	@Column(name="no_of_months")
	private Integer noOfMonths;
	
	@Column(name="other_expenses")
	private Integer otherExpenses;
	
	@Column(name="funds")
	private Integer fund;

	@Column(name="remarks")
	private String remarks;
	
	@Column(name="is_approved")
	private Boolean isApproved;

	@Column(name="is_active")
	private Boolean isActive;

	
	public Boolean getIsActive() {
		return isActive;
	}

	public void setIsActive(Boolean isActive) {
		this.isActive = isActive;
	}

	public Integer getPmuDetailsId() {
		return pmuDetailsId;
	}

	public void setPmuDetailsId(Integer pmuDetailsId) {
		this.pmuDetailsId = pmuDetailsId;
	}

	public PmuActivity getPmuActivity() {
		return pmuActivity;
	}

	public void setPmuActivity(PmuActivity pmuActivity) {
		this.pmuActivity = pmuActivity;
	}

	public Integer getNoOfUnits() {
		return noOfUnits;
	}

	public void setNoOfUnits(Integer noOfUnits) {
		this.noOfUnits = noOfUnits;
	}

	public Integer getUnitCost() {
		return unitCost;
	}

	public void setUnitCost(Integer unitCost) {
		this.unitCost = unitCost;
	}

	public Integer getNoOfMonths() {
		return noOfMonths;
	}

	public void setNoOfMonths(Integer noOfMonths) {
		this.noOfMonths = noOfMonths;
	}

	public Integer getOtherExpenses() {
		return otherExpenses;
	}

	public void setOtherExpenses(Integer otherExpenses) {
		this.otherExpenses = otherExpenses;
	}

	public Integer getFund() {
		return fund;
	}

	public void setFund(Integer fund) {
		this.fund = fund;
	}

	public String getRemarks() {
		return remarks;
	}

	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}

	public Boolean getIsApproved() {
		return isApproved;
	}

	public void setIsApproved(Boolean isApproved) {
		this.isApproved = isApproved;
	}

	public PmuActivityType getPmuActivityType() {
		return pmuActivityType;
	}

	public void setPmuActivityType(PmuActivityType pmuActivityType) {
		this.pmuActivityType = pmuActivityType;
	}
	
	
}
