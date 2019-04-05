package gov.in.rgsa.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.NamedNativeQuery;

@Entity
@NamedNativeQuery(name="FETCH_PLAN_STAUS_COUNT",query="select cast(ROW_NUMBER () OVER () as integer) row_number,cast(count(1) as integer) plan_sumit_count,(select cast(count(1)as integer) plan_approved_count from rgsa.plan pa where pa.plan_status_id=5 and  pa.year_id=ps.year_id ),0 cec_metting_count  from rgsa.plan ps left join rgsa.fin_year fy on ps.year_id=fy.year_id where ps.plan_status_id in(2,4,5) and fy.finyear = :fin_year group by ps.year_id",resultClass=FetchPlanStatusCount.class)
public class FetchPlanStatusCount {
	
	@Id
	@Column(name="row_number")
	private Integer rowId;
	
	
	@Column(name="plan_sumit_count")
	private Integer planSumitCount;
	
	
	@Column(name="plan_approved_count")
	private Integer planApprovedCount;
	
	@Column(name="cec_metting_count")
	private Integer cecMettingCount;

	public Integer getRowId() {
		return rowId;
	}

	public void setRowId(Integer rowId) {
		this.rowId = rowId;
	}

	public Integer getPlanSumitCount() {
		return planSumitCount;
	}

	public void setPlanSumitCount(Integer planSumitCount) {
		this.planSumitCount = planSumitCount;
	}

	public Integer getPlanApprovedCount() {
		return planApprovedCount;
	}

	public void setPlanApprovedCount(Integer planApprovedCount) {
		this.planApprovedCount = planApprovedCount;
	}

	public Integer getCecMettingCount() {
		return cecMettingCount;
	}

	public void setCecMettingCount(Integer cecMettingCount) {
		this.cecMettingCount = cecMettingCount;
	}
	
	

}
