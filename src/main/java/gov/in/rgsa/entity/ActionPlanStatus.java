package gov.in.rgsa.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.NamedNativeQuery;
import javax.persistence.NamedQuery;
import javax.persistence.Table;

@Entity
@Table(schema="rgsa")
@NamedNativeQuery(name="PLAN_ACTIVITY_STATUS",query=" select * from (select is_freez from rgsa.pesa_plan where year_id=:yearId and state_code=:stateCode"
		+ " union all"
		+ " select case when status = 'F' then true else false end from rgsa.satcom_activity where year_id=:yearId and state_code=:stateCode"
		+ " union all"
		+ " select is_freeze from rgsa.innovative_activity where year_id=:yearId and state_code=:stateCode"
		+ " union all"
		+ " select case when status = 'F' then true else false end from rgsa.panhcayat_bhawan_activity where year_id=:yearId and state_code=:stateCode"
		+ " union all"
		+ " select case when status = 'F' then true else false end from rgsa.administrative_technical_support where year_id=:yearId and state_code=:stateCode"
		+ " union all"
		+ " select is_freeze from rgsa.egov_support_activity where year_id=:yearId and state_code=:stateCode"
		+ " union all"
		+ " select case when status = 'F' then true else false end from rgsa.e_enablement where year_id=:yearId and state_code=:stateCode"
		+ " union all"
		+ " select if_freeze from rgsa.cb_activity where year_id=:yearId and state_code=:stateCode"
		+ " union all"
		+ " select is_freeze from rgsa.training_activity where year_id=:yearId and state_code=:stateCode"
		+ " union all"
	    + " select is_freez from rgsa.iec_activity where year_id=:yearId and state_code=:stateCode"
		+ " union all"
		+ " select is_freeze from rgsa.pmu_activity where year_id=:yearId and state_code=:stateCode"
		+ " union all"
		+ " select is_freeze from rgsa.income_enhancement_activity where year_id=:yearId and state_code=:stateCode"
		+ " union all"
		+ " select is_freeze from rgsa.admin_financial_data_cell_activity where year_id=:yearId and state_code=:stateCode"
		+ " union all"
		+ " select is_freeze from rgsa.institutional_infra_activity where year_id=:yearId and state_code=:stateCode"
		
		+ " union all"
		+ " select is_freeze from rgsa.institue_infra_hr_activity where year_id=:yearId and state_code=:stateCode) a ",resultClass=ActionPlanStatus.class)
public class ActionPlanStatus {

	
	@Id
	@Column(name="is_freez")
	private Boolean isFreezed;

	public Boolean getIsFreezed() {
		return isFreezed;
	}

	public void setIsFreezed(Boolean isFreezed) {
		this.isFreezed = isFreezed;
	}

	
	
	
}
