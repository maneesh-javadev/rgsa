	package gov.in.rgsa.entity;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.NamedQuery;
import javax.persistence.Table;

/**
 * 
 * @author sourabh
 *
 */

@Entity
@Table(name="pesa_plan_details", schema = "rgsa")
@NamedQuery(name="FETCH_PESA_DETAILS",query="SELECT PPD FROM PesaPlanDetails PPD where pesaPlanId=:pesaPlanId")
public class PesaPlanDetails implements Serializable{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = -7437062767890987918L;

	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	@Column(name="id")
	private Integer pesaPlanDetailsId;
	
	@Column(name="pesa_plan_id")
	private Integer pesaPlanId;
	
//	@ManyToOne(fetch=FetchType.LAZY)
//	@JoinColumn(name="pesa_plan_id", nullable=false)
//	private PesaPlan pesaPlan;
	
	@Column(name="designation_id")
	private Integer pesaPostId;
	
//	@ManyToOne(fetch=FetchType.LAZY)
//	@JoinColumn(name="designation_id", nullable=false)
//	private PesaPost pesaPost;
	
	@Column(name="no_of_units")
	private Integer noOfUnits;
	
	@Column(name="unit_cost_per_month")
	private Integer unitCostPerMonth;
	
	@Column(name="no_of_months")
	private Integer noOfMonths;
	
	@Column(name="funds")
	private Integer funds;
	
	@Column(name="is_approved")
	private Boolean isApproved;
	
	@Column(name="remarks")
	private String remarks;

	public Integer getPesaPlanDetailsId() {
		return pesaPlanDetailsId;
	}

	public void setPesaPlanDetailsId(Integer pesaPlanDetailsId) {
		this.pesaPlanDetailsId = pesaPlanDetailsId;
	}

	public Integer getNoOfUnits() {
		return noOfUnits;
	}

	public void setNoOfUnits(Integer noOfUnits) {
		this.noOfUnits = noOfUnits;
	}

	public Integer getUnitCostPerMonth() {
		return unitCostPerMonth;
	}

	public void setUnitCostPerMonth(Integer unitCostPerMonth) {
		this.unitCostPerMonth = unitCostPerMonth;
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

	public String getRemarks() {
		return remarks;
	}

	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}

	public Integer getPesaPostId() {
		return pesaPostId;
	}

	public void setPesaPostId(Integer pesaPostId) {
		this.pesaPostId = pesaPostId;
	}

	public Integer getPesaPlanId() {
		return pesaPlanId;
	}

	public void setPesaPlanId(Integer pesaPlanId) {
		this.pesaPlanId = pesaPlanId;
	}

	public Boolean getIsApproved() {
		return isApproved;
	}

	public void setIsApproved(Boolean isApproved) {
		this.isApproved = isApproved;
	}
}