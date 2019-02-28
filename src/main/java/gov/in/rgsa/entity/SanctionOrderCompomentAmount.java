package gov.in.rgsa.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.NamedNativeQueries;
import javax.persistence.NamedNativeQuery;
import javax.persistence.Transient;

@Entity
@NamedNativeQueries({
@NamedNativeQuery(name="soComponentAmount",query="select * from rgsa.get_sanction_order_compoment_amount_new(:planCode)",resultClass=SanctionOrderCompomentAmount.class) 
})
public class SanctionOrderCompomentAmount {
	
	
	
	@Id
	@Column(name="component_id")
	private Integer componentId;
	
	@Column(name="component_name")
	private String componentName;
	
	@Column(name="component_amount")
	private Double componentAmount;
	
	@Transient
	private String filePath;
	
	@Transient
	private Integer sanctionOrderSno;

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

	public Double getComponentAmount() {
		return componentAmount;
	}

	public void setComponentAmount(Double componentAmount) {
		this.componentAmount = componentAmount;
	}

	public String getFilePath() {
		return filePath;
	}

	public void setFilePath(String filePath) {
		this.filePath = filePath;
	}

	public Integer getSanctionOrderSno() {
		return sanctionOrderSno;
	}

	public void setSanctionOrderSno(Integer sanctionOrderSno) {
		this.sanctionOrderSno = sanctionOrderSno;
	}

	

	

	
	

}
