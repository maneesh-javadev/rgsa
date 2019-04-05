package gov.in.rgsa.model;

import java.util.List;

import gov.in.rgsa.entity.StateAllocation;

public class StateAllocationModal {
	
	private Integer planCode;

	private Integer installmentNo;
   
	private boolean sanctionOrderExist;
	
	private Double totalAmount;
	
	private String status;
	
	private boolean isPlanAllocationNotExist;
	
	private List<StateAllocation> stateAllocationList;

	public Integer getPlanCode() {
		return planCode;
	}

	public void setPlanCode(Integer planCode) {
		this.planCode = planCode;
	}

	public Integer getInstallmentNo() {
		return installmentNo;
	}

	public void setInstallmentNo(Integer installmentNo) {
		this.installmentNo = installmentNo;
	}

	public boolean isSanctionOrderExist() {
		return sanctionOrderExist;
	}

	public void setSanctionOrderExist(boolean sanctionOrderExist) {
		this.sanctionOrderExist = sanctionOrderExist;
	}

	public Double getTotalAmount() {
		return totalAmount;
	}

	public void setTotalAmount(Double totalAmount) {
		this.totalAmount = totalAmount;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public List<StateAllocation> getStateAllocationList() {
		return stateAllocationList;
	}

	public void setStateAllocationList(List<StateAllocation> stateAllocationList) {
		this.stateAllocationList = stateAllocationList;
	}

	public boolean isPlanAllocationNotExist() {
		return isPlanAllocationNotExist;
	}

	public void setPlanAllocationNotExist(boolean isPlanAllocationNotExist) {
		this.isPlanAllocationNotExist = isPlanAllocationNotExist;
	}


	

}
