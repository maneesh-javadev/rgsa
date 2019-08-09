package gov.in.rgsa.dto;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;

import org.hibernate.annotations.NamedNativeQuery;

@Entity
@NamedNativeQuery(name = "FETCH_FORMS_FREEZE_STATUS",query = "select * from rgsa.get_is_freeze_status_at_all_level(:stateCode,:yearId)",resultClass = IsFreezeStatusDto.class)
public class IsFreezeStatusDto {

	@Id
	@Column(name="component_id")
	private Integer componentId;
	
	@Column(name="component_name")
	private String componentName;
	
	@Column(name="state_is_freeze")
	private Boolean stateIsFreeze;
	
	@Column(name="ministry_is_freeze")
	private Boolean ministryIsFreeze;
	
	@Column(name="cec_is_freeze")
	private Boolean cecIsFreeze;
	
	@Column(name="state_link")
	private String stateLink;
	
	@Column(name="ministry_link")
	private String ministryLink;
	
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

	public Boolean getStateIsFreeze() {
		return stateIsFreeze;
	}

	public void setStateIsFreeze(Boolean stateIsFreeze) {
		this.stateIsFreeze = stateIsFreeze;
	}

	public Boolean getMinistryIsFreeze() {
		return ministryIsFreeze;
	}

	public void setMinistryIsFreeze(Boolean ministryIsFreeze) {
		this.ministryIsFreeze = ministryIsFreeze;
	}

	public Boolean getCecIsFreeze() {
		return cecIsFreeze;
	}

	public void setCecIsFreeze(Boolean cecIsFreeze) {
		this.cecIsFreeze = cecIsFreeze;
	}

	public String getStateLink() {
		return stateLink;
	}

	public void setStateLink(String stateLink) {
		this.stateLink = stateLink;
	}

	public String getMinistryLink() {
		return ministryLink;
	}

	public void setMinistryLink(String ministryLink) {
		this.ministryLink = ministryLink;
	}

	public String getCecLink() {
		return cecLink;
	}

	public void setCecLink(String cecLink) {
		this.cecLink = cecLink;
	}
	
}
