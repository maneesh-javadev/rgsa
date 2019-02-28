package gov.in.rgsa.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;

@Entity
@NamedQueries({
	@NamedQuery(name="FIND_STALE_ALLOCATION",query="from StateAllocation where planCode=:planCode and installmentNo=:installmentNo"),
})
@Table(name="state_allocation",schema="rgsa")
public class StateAllocation {

@Id
@GeneratedValue(strategy=GenerationType.IDENTITY)
@Column(name="sr_no")
private Integer srNo;


@Column(name="installment_no")
private Integer installmentNo;

@Column(name="plan_code")
private Integer planCode;

@Column(name = "component_id")
private Integer componentId;

@Column(name = "subcomponent_id")
private Integer subcomponentId;


@Column(name="funds_allocated")
private Double fundsAllocated;

@Column(name="status")
private String status;

public Integer getSrNo() {
	return srNo;
}

public void setSrNo(Integer srNo) {
	this.srNo = srNo;
}

public Integer getInstallmentNo() {
	return installmentNo;
}

public void setInstallmentNo(Integer installmentNo) {
	this.installmentNo = installmentNo;
}

public Integer getPlanCode() {
	return planCode;
}

public void setPlanCode(Integer planCode) {
	this.planCode = planCode;
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

public Double getFundsAllocated() {
	return fundsAllocated;
}

public void setFundsAllocated(Double fundsAllocated) {
	this.fundsAllocated = fundsAllocated;
}

public String getStatus() {
	return status;
}

public void setStatus(String status) {
	this.status = status;
}


}