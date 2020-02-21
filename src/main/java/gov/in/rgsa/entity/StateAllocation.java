package gov.in.rgsa.entity;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.NamedNativeQueries;
import javax.persistence.NamedNativeQuery;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;

@Entity
@NamedQueries({
	@NamedQuery(name="FIND_STALE_ALLOCATION",query="from StateAllocation where planCode=:planCode and installmentNo=:installmentNo order by srNo"),
	@NamedQuery(query="UPDATE StateAllocation set fundsAllocated=:fundsAllocated,status=:status where srNo=:srNo",name="UPDATE_STATUS_STATE_ALLOCATION"),
	@NamedQuery(name="FETCH_STATE_ALLOCATION_BY_COMP_ID_AND_SUBCOMPID_AND_INSTALL_NO",query="from StateAllocation where componentId=:componentId and installmentNo=:installmentNo and subcomponentId=:subComponentId and fundsAllocated is not null and fundsAllocated != 0 and planCode=:planCode"),
	//@NamedQuery(name="FETCH_STATE_ALLOCATION_BY_COMP_ID_AND_INSTALL_NO",query="from StateAllocation where componentId=:componentId and installmentNo in (1,2) and fundsAllocated is not null and fundsAllocated != 0 and planCode=:planCode")
    @NamedQuery(name="FETCH_STATE_ALLOCATION_BY_COMP_ID_AND_INSTALL_NO",query="from StateAllocation where componentId=:componentId and installmentNo=:installmentNo and fundsAllocated is not null and fundsAllocated != 0 and planCode=:planCode")

})

@NamedNativeQueries({
	@NamedNativeQuery(name="FETCH_MAX_INSTALLMENT_NO_AND_PLAN_CODE",query="select * from rgsa.fetch_plancode_and_installment_no(:stateCode,:yearId)"),
})


@Table(name="state_allocation",schema="rgsa")
public class StateAllocation implements Serializable{

/**
	 * 
	 */
	private static final long serialVersionUID = 1L;


@Id
@GeneratedValue(strategy=GenerationType.IDENTITY)
@Column(name="sr_no",nullable = false,updatable = false)
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
