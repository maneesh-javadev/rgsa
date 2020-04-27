package gov.in.rgsa.dto;

import java.math.BigInteger;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.NamedNativeQuery;


@Entity
@NamedNativeQuery(name="FETCH_Subcomponent_wise_Quater_Balance",resultClass=SubcomponentwiseQuaterBalance.class,
query="select * from rgsa.get_balance_amount_to_quater(:stateCode,:yearId,:componentId,:quaterId)")	

@NamedNativeQuery(name="FETCH_Component_wise_Additional_Requirment_Quater_Balance",query="select * from  "
		+ "rgsa.get_balance_additional_requirement_to_quater(:stateCode, :yearId, :componentId, :quaterId)")

public class SubcomponentwiseQuaterBalance {
	
	@Id
	@Column(name="subcomponent_id")
	private Integer subcomponentId;
	
	
	@Column(name="balance_amount")
	private BigInteger balanceAmount;


	public Integer getSubcomponentId() {
		return subcomponentId;
	}


	public void setSubcomponentId(Integer subcomponentId) {
		this.subcomponentId = subcomponentId;
	}


	public BigInteger getBalanceAmount()
	{
		return balanceAmount;
	}


	public void setBalanceAmount(BigInteger balanceAmount)
	{
		this.balanceAmount = balanceAmount;
	}


	
	
	

}
