package gov.in.rgsa.entity;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;

@Entity
@Table(name="quarter_wise_funds",schema="rgsa")
@NamedQueries({
	@NamedQuery(name="FETCH_QUATOR_WISE_FUND",query="from QuaterWiseFund where state_code=:stateCode and quarter_id=:quarterId and componentId=:componentId"),
	@NamedQuery(name="FETCH_ALL_QUATOR_WISE_FUND",query="from QuaterWiseFund where state_code=:stateCode and componentId=:componentId"),
	
})

public class QuaterWiseFund implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = -2454430945691202202L;

	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	@Column(name="serial_id")
	private Integer srNo;

	@Column(name="state_code")
	private Integer state_code;

	@Column(name="year_id")
	private Integer year_id;
	
	@Column(name="quarter_id")
	private Integer quarter_id;

	@Column(name = "component_id")
	private Integer componentId;

	@Column(name = "subcomponent_id")
	private Integer subcomponentId;

	@Column(name="funds")
	private Double funds;

	public Integer getSrNo() {
		return srNo;
	}

	public void setSrNo(Integer srNo) {
		this.srNo = srNo;
	}

	public Integer getState_code() {
		return state_code;
	}

	public void setState_code(Integer state_code) {
		this.state_code = state_code;
	}

	public Integer getYear_id() {
		return year_id;
	}

	public void setYear_id(Integer year_id) {
		this.year_id = year_id;
	}

	public Integer getQuarter_id() {
		return quarter_id;
	}

	public void setQuarter_id(Integer quarter_id) {
		this.quarter_id = quarter_id;
	}

	public Integer getComponentId() {
		return componentId;
	}

	public void setComponentId(Integer componentId) {
		this.componentId = componentId;
	}

	public Integer getSubcomponentId() {
		return subcomponentId;
	}

	public void setSubcomponentId(Integer subcomponentId) {
		this.subcomponentId = subcomponentId;
	}

	public Double getFunds() {
		return funds;
	}

	public void setFunds(Double funds) {
		this.funds = funds;
	}
	
}
