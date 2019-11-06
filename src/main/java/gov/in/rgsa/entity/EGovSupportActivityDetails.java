package gov.in.rgsa.entity;

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
@Table(name="egov_support_activity_details",schema="rgsa")
@NamedQueries({
	@NamedQuery(name="FETCH_ALL_EGOV_DETAILS_EXCEPT_CURRENT_VERSION",query="from EGovSupportActivityDetails where eGovSupportActivity.stateCode=:stateCode and eGovSupportActivity.versionNo !=:versionNo and eGovSupportActivity.userType in('S','M') order by eGovDetailsId"),
	@NamedQuery(name="FIND_ACTIVITY_DETAILS",query="FROM EGovSupportActivityDetails where eGovSupportActivity.eGovSupportActivityId=:eGovSupportActivityId order by eGovPostId asc")
})
 
public class EGovSupportActivityDetails {
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name="egov_support_activity_details_id")
	private Integer eGovDetailsId;
	
	@Column(name="egov_post_id")
	private  Integer eGovPostId;
	
	@Column(name="no_of_units")
	private Integer noOfPosts;
	
	@Column(name="unit_cost")
	private Integer unitCost;
	
	@Column(name="no_of_months")
	private Integer months;
	
	@Column(name="funds")
	private Integer funds;
	
	@Column(name="remarks")
	private String remarks;
	
	@Column(name="is_approved")
	private Boolean isApproved;
	
	@ManyToOne
	@JoinColumn(name="egov_support_activity_id")
	private EGovSupportActivity eGovSupportActivity;
	
	public Integer geteGovDetailsId() {
		return eGovDetailsId;
	}

	public void seteGovDetailsId(Integer eGovDetailsId) {
		this.eGovDetailsId = eGovDetailsId;
	}

	public Integer geteGovPostId() {
		return eGovPostId;
	}

	public void seteGovPostId(Integer eGovPostId) {
		this.eGovPostId = eGovPostId;
	}

	public Integer getNoOfPosts() {
		return noOfPosts;
	}

	public void setNoOfPosts(Integer noOfPosts) {
		this.noOfPosts = noOfPosts;
	}

	public Integer getUnitCost() {
		return unitCost;
	}

	public void setUnitCost(Integer unitCost) {
		this.unitCost = unitCost;
	}

	public Integer getMonths() {
		return months;
	}

	public void setMonths(Integer months) {
		this.months = months;
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

	public Boolean getIsApproved() {
		return isApproved;
	}

	public void setIsApproved(Boolean isApproved) {
		this.isApproved = isApproved;
	}

	public EGovSupportActivity geteGovSupportActivity() {
		return eGovSupportActivity;
	}

	public void seteGovSupportActivity(EGovSupportActivity eGovSupportActivity) {
		this.eGovSupportActivity = eGovSupportActivity;
	}

	
	

}
