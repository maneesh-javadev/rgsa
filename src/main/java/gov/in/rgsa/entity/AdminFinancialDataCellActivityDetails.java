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
import javax.persistence.Transient;


@Entity
@Table(name="admin_financial_data_cell_activity_details",schema="rgsa")
@NamedQueries({
	@NamedQuery(name="FETCH_ALL_ADMIN_ACTIVITY_DETAILS_EXCEPT_CURRENT_VERSION",query="from AdminFinancialDataCellActivityDetails where adminAndFinancialDataActivity.stateCode=:stateCode and adminAndFinancialDataActivity.versionNo !=:versionNo  and adminAndFinancialDataActivity.yearId =:yearId and  adminAndFinancialDataActivity.userType in('S','M') order by adminFinancialDataActivityDetailId"),
	@NamedQuery(name="FETCH_ADMIN_FIN_DATA_DETAILS",query="select AD from AdminFinancialDataCellActivityDetails AD where adminAndFinancialDataActivity.adminFinancialDataActivityId=:adminFinancialDataActivityId order by adminFinancialDataActivityDetailId")
})

public class AdminFinancialDataCellActivityDetails implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 9466993912377233L;

	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	@Column(name="admin_financial_data_cell_activity_detail_id")
	private Integer adminFinancialDataActivityDetailId;
	
	@ManyToOne
	@JoinColumn(name="admin_financial_data_cell_activity_id")
	private AdminAndFinancialDataActivity adminAndFinancialDataActivity;
	
	/*@Column(name="pmu_activity_type_id")
	private Integer pmuActivityTypeId;
	*/
	@ManyToOne
	@JoinColumn(name="pmu_activity_type_id")
	private PmuActivityType pmuActivityType;
	
	
	@Column(name="no_of_staffs_proposed")
	private Integer noOfStaffProposed; 
	
	@Column(name="unit_cost")
	private Integer unitCost;
	
	@Column(name="no_of_months")
	private Integer noOfMonths;
	
	@Column(name="funds")
	private Integer funds;
	
	/*@Column(name="other_expenses")
	private Integer otherExpenses;*/
	
	@Column(name="remarks")
	private String remarks;
	
	@Transient
	private Integer subTotal;
	
	@Column(name="is_approved")
	private Boolean isApproved;
	
	public Integer getAdminFinancialDataActivityDetailId() {
		return adminFinancialDataActivityDetailId;
	}

	public void setAdminFinancialDataActivityDetailId(Integer adminFinancialDataActivityDetailId) {
		this.adminFinancialDataActivityDetailId = adminFinancialDataActivityDetailId;
	}

	/*public Integer getPmuActivityTypeId() {
		return pmuActivityTypeId;
	}

	public void setPmuActivityTypeId(Integer pmuActivityTypeId) {
		this.pmuActivityTypeId = pmuActivityTypeId;
	}*/

	public Integer getNoOfStaffProposed() {
		return noOfStaffProposed;
	}

	public PmuActivityType getPmuActivityType() {
		return pmuActivityType;
	}

	public void setPmuActivityType(PmuActivityType pmuActivityType) {
		this.pmuActivityType = pmuActivityType;
	}

	public void setNoOfStaffProposed(Integer noOfStaffProposed) {
		this.noOfStaffProposed = noOfStaffProposed;
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

	public Integer getFunds() {
		return funds;
	}

	public void setFunds(Integer funds) {
		this.funds = funds;
	}

	/*public Integer getOtherExpenses() {
		return otherExpenses;
	}

	public void setOtherExpenses(Integer otherExpenses) {
		this.otherExpenses = otherExpenses;
	}
*/
	public String getRemarks() {
		return remarks;
	}

	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}

	public AdminAndFinancialDataActivity getAdminAndFinancialDataActivity() {
		return adminAndFinancialDataActivity;
	}

	public void setAdminAndFinancialDataActivity(AdminAndFinancialDataActivity adminAndFinancialDataActivity) {
		this.adminAndFinancialDataActivity = adminAndFinancialDataActivity;
	}

	public Integer getSubTotal() {
		return subTotal;
	}

	public void setSubTotal(Integer subTotal) {
		this.subTotal = subTotal;
	}

	public Boolean getIsApproved() {
		return isApproved;
	}

	public void setIsApproved(Boolean isApproved) {
		this.isApproved = isApproved;
	}
	
}
