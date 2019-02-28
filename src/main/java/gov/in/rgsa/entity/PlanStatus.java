package gov.in.rgsa.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.NamedNativeQuery;
import javax.persistence.NamedQuery;
import javax.persistence.Table;

@Entity
@Table(name="plan_status",schema="rgsa")
@NamedNativeQuery(name="PLAN_NAME",query="select plan_status_name from rgsa.plan_status  where plan_status_id = (select max(plan_status_id)  from rgsa.plan   where  state_code=:stateCode and year_id=:yearId)")
public class PlanStatus {
	/**
	 * Sourabh Rai
	 */
	
	@Id
	@Column(name="plan_status_id")
	private Integer planStatusId;
	
	@Column(name="plan_status_name")
	private String planStatusName;

	public Integer getPlanStatusId() {
		return planStatusId;
	}

	public void setPlanStatusId(Integer planStatusId) {
		this.planStatusId = planStatusId;
	}

	public String getPlanStatusName() {
		return planStatusName;
	}

	public void setPlanStatusName(String planStatusName) {
		this.planStatusName = planStatusName;
	}

	
	
}
