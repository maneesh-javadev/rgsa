package gov.in.rgsa.dto;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.NamedNativeQuery;

@Entity
@NamedNativeQuery(name="CHECK_ALL_COMPONENT_FOR_FORWARD_PLAN",query="select * from rgsa.check_all_component_for_forward_plan(:stateCode,:yearId,:userType)"
,resultClass=CheckAllComponentforForwardPlan.class)
	
public class CheckAllComponentforForwardPlan {
	
	@Id
	@Column(name = "component_id")
	private Integer componentId;

	@Column(name = "component_name")
	private String componentName;
	
	@Column(name = "link")
	private String link;
	
	@Column(name = "is_freeze")
	private boolean checkFreeze;
	
	@Column(name = "is_filled")
	private boolean checkFilled;

	@Column(name = "master_table_id")
	private Integer masterTableId;

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

	public String getLink() {
		return link;
	}

	public void setLink(String link) {
		this.link = link;
	}

	public boolean isCheckFreeze() {
		return checkFreeze;
	}

	public void setCheckFreeze(boolean checkFreeze) {
		this.checkFreeze = checkFreeze;
	}

	public boolean isCheckFilled() {
		return checkFilled;
	}

	public void setCheckFilled(boolean checkFilled) {
		this.checkFilled = checkFilled;
	}

	public Integer getMasterTableId() {
		return masterTableId;
	}

	public void setMasterTableId(Integer masterTableId) {
		this.masterTableId = masterTableId;
	}

	
}
