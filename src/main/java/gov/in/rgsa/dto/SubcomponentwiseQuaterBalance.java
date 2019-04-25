package gov.in.rgsa.dto;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.NamedNativeQuery;


@Entity
@NamedNativeQuery(name="FETCH_Subcomponent_wise_Quater_Balance",resultClass=SubcomponentwiseQuaterBalance.class,
query="select * from rgsa.get_balance_amount_to_quater(:stateCode,:yearId,:componentId,:quaterId)")	

public class SubcomponentwiseQuaterBalance {
	
	@Id
	@Column(name="subcomponent_id")
	private Integer subcomponentId;
	
	
	@Column(name="balance_amount")
	private Double balanceAmount;


	public Integer getSubcomponentId() {
		return subcomponentId;
	}


	public void setSubcomponentId(Integer subcomponentId) {
		this.subcomponentId = subcomponentId;
	}


	public Double getBalanceAmount() {
		return balanceAmount;
	}


	public void setBalanceAmount(Double balanceAmount) {
		this.balanceAmount = balanceAmount;
	}
	
	

}