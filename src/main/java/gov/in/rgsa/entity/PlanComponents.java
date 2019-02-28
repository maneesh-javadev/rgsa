package gov.in.rgsa.entity;

import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.NamedNativeQueries;
import javax.persistence.NamedNativeQuery;
import javax.persistence.NamedQuery;
import javax.persistence.OneToMany;
import javax.persistence.Table;

import gov.in.rgsa.model.StatewisePlanStatus;

@Entity
@Table(name="plan_components",schema="rgsa")
@NamedQuery(name="PLAN_COMPONENTS_LIST",query="from PlanComponents order by sortOrder")

public class PlanComponents {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "component_id")
	private Integer componentId;
	
	@Column(name="component_name")
	private String componentName;
	
	@Column(name="sort_order")
	private Integer sortOrder;
	
	@OneToMany(fetch = FetchType.EAGER,mappedBy="planComponents",cascade=CascadeType.ALL)
	private List<PlanSubcomponents> subcomponents;
	
	@Column(name="mopr_link")
	private String componentLink;

	@Column(name="cec_link")
	private String cecLink;
	
	public Integer getComponentId() {
		return componentId;
	}

	public void setComponentId(Integer componentId) {
		this.componentId = componentId;
	}

	public String getComponentName() {
		return componentName;
	}

	public void setComponentName(String componentName) {
		this.componentName = componentName;
	}

	public Integer getSortOrder() {
		return sortOrder;
	}

	public void setSortOrder(Integer sortOrder) {
		this.sortOrder = sortOrder;
	}

	public List<PlanSubcomponents> getSubcomponents() {
		return subcomponents;
	}

	public void setSubcomponents(List<PlanSubcomponents> subcomponents) {
		this.subcomponents = subcomponents;
	}

	public String getComponentLink() {
		return componentLink;
	}

	public void setComponentLink(String componentLink) {
		this.componentLink = componentLink;
	}

	public String getCecLink() {
		return cecLink;
	}

	public void setCecLink(String cecLink) {
		this.cecLink = cecLink;
	}
	
	
	
}
