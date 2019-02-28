package gov.in.rgsa.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.NamedNativeQueries;
import javax.persistence.NamedNativeQuery;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;
import javax.persistence.Transient;

@Entity
@NamedQueries({@NamedQuery(name="FETCH_INSTITUTE_HR_ACTIVITY_DETAILS",query="FROM InstitueInfraHrActivityDetails where instituteInfraHrActivityId=:instituteInfraHrActivityId order by instituteInfrsaHrActivityDetailsId asc")
,@NamedQuery(name="FETCH_INSTITUTE_HR_APPROVED_ACTIVITY_DETAILS" ,query="FROM InstitueInfraHrActivityDetails where instituteInfraHrActivityId=:instituteInfraHrActivityId AND isApproved='TRUE' AND isActive='TRUE'")})

@Table(name="institue_infra_hr_activity_details",schema="rgsa")
public class InstitueInfraHrActivityDetails {
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name="institue_infra_hr_activity_details_id")
	private Integer instituteInfrsaHrActivityDetailsId;
	
	@Column(name="institue_infra_hr_activity_id")
	private Integer instituteInfraHrActivityId;
	
	@Column(name="no_of_units")
	private Integer noOfUnits;
	
	@Column(name="unit_cost") 
	private Integer unitCost;
	
	@Column(name="no_of_months")
	private Integer noOfMonths;
	
	@Column(name="other_expenses")
	private Integer otherExpenses;
	
	
	@ManyToOne
	@JoinColumn(name="institue_infra_hr_activity_type_id")
	private InstituteInfraHrActivityType instituteInfraHrActivityType;
	
	@Column(name="funds")
	private Integer fund;

	@Column(name="remarks")
	private String remarks;
	
	@Column(name="is_approved")
	private Boolean isApproved;
	
	@Column(name="is_active")
	private Boolean isActive;
	
	@Transient
	private Integer totalFund;

	public Integer getInstituteInfrsaHrActivityDetailsId() {
		return instituteInfrsaHrActivityDetailsId;
	}

	public void setInstituteInfrsaHrActivityDetailsId(Integer instituteInfrsaHrActivityDetailsId) {
		this.instituteInfrsaHrActivityDetailsId = instituteInfrsaHrActivityDetailsId;
	}

	public Integer getInstituteInfraHrActivityId() {
		return instituteInfraHrActivityId;
	}

	public void setInstituteInfraHrActivityId(Integer instituteInfraHrActivityId) {
		this.instituteInfraHrActivityId = instituteInfraHrActivityId;
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

	public Integer getTotalFund() {
		return totalFund;
	}

	public void setTotalFund(Integer totalFund) {
		this.totalFund = totalFund;
	}

	

	public InstituteInfraHrActivityType getInstituteInfraHrActivityType() {
		return instituteInfraHrActivityType;
	}

	public void setInstituteInfraHrActivityType(InstituteInfraHrActivityType instituteInfraHrActivityType) {
		this.instituteInfraHrActivityType = instituteInfraHrActivityType;
	}

	public Boolean getIsApproved() {
		return isApproved;
	}

	public void setIsApproved(Boolean isApproved) {
		this.isApproved = isApproved;
	}

	public Boolean getIsActive() {
		return isActive;
	}

	public void setIsActive(Boolean isActive) {
		this.isActive = isActive;
	}
	
	
	
}
