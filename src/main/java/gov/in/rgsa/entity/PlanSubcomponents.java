package gov.in.rgsa.entity;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQuery;
import javax.persistence.Table;
import javax.persistence.Transient;

@Entity
@Table(name="plan_subcomponents",schema="rgsa")
@NamedQuery(name="PLAN_SUB_COMPONENTS_LIST",query="from PlanSubcomponents order by sortOrder")
public class PlanSubcomponents implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 2966575518486771545L;

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "subcomponent_id")
	private Integer subcomponentId;
	
	@Column(name="subcomponent_name")
	private String subcomponentName;
	
	@Column(name="sort_order")
	private Integer sortOrder;
	
	@ManyToOne(fetch=FetchType.LAZY)
	@JoinColumn(name="component_id")
	private PlanComponents planComponents;
	
	
	@Transient
	private Integer stateFunds;
	
	@Transient
	private Integer stateUnitCost;

	public Integer getSubcomponentId() {
		return subcomponentId;
	}

	public void setSubcomponentId(Integer subcomponentId) {
		this.subcomponentId = subcomponentId;
	}

	public String getSubcomponentName() {
		return subcomponentName;
	}

	public void setSubcomponentName(String subcomponentName) {
		this.subcomponentName = subcomponentName;
	}

	public Integer getSortOrder() {
		return sortOrder;
	}

	public void setSortOrder(Integer sortOrder) {
		this.sortOrder = sortOrder;
	}

	public PlanComponents getPlanComponents() {
		return planComponents;
	}

	public void setPlanComponents(PlanComponents planComponents) {
		this.planComponents = planComponents;
	}

	public Integer getStateFunds() {
		return stateFunds;
	}

	public void setStateFunds(Integer stateFunds) {
		this.stateFunds = stateFunds;
	}

	public Integer getStateUnitCost() {
		return stateUnitCost;
	}

	public void setStateUnitCost(Integer stateUnitCost) {
		this.stateUnitCost = stateUnitCost;
	}
	
	
}
