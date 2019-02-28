package gov.in.rgsa.model;

import java.util.Date;
import java.util.List;

import gov.in.rgsa.entity.ReleaseIntallment;
import gov.in.rgsa.entity.SanctionOrder;
import gov.in.rgsa.entity.SanctionOrderCompomentAmount;

public class SnactionOrderModel {
	
	
	private Integer stateCode;
	
	private Integer yearId;
	
	private Date sactionDate;

	private Integer installmentNo;
	
	private List<SanctionOrderCompomentAmount> sanctionOrderCompomentAmountList;
	
	private List<SanctionOrder> sanctionOrderList;
	
	private ReleaseIntallment releaseIntallment;
	
	private Integer releaseIntallmentSno;
	
	
	private Boolean status;

	public Integer getStateCode() {
		return stateCode;
	}

	public void setStateCode(Integer stateCode) {
		this.stateCode = stateCode;
	}

	public Integer getYearId() {
		return yearId;
	}

	public void setYearId(Integer yearId) {
		this.yearId = yearId;
	}

	public Date getSactionDate() {
		return sactionDate;
	}

	public void setSactionDate(Date sactionDate) {
		this.sactionDate = sactionDate;
	}

	public Integer getInstallmentNo() {
		return installmentNo;
	}

	public void setInstallmentNo(Integer installmentNo) {
		this.installmentNo = installmentNo;
	}

	public List<SanctionOrderCompomentAmount> getSanctionOrderCompomentAmountList() {
		return sanctionOrderCompomentAmountList;
	}

	public void setSanctionOrderCompomentAmountList(List<SanctionOrderCompomentAmount> sanctionOrderCompomentAmountList) {
		this.sanctionOrderCompomentAmountList = sanctionOrderCompomentAmountList;
	}

	public List<SanctionOrder> getSanctionOrderList() {
		return sanctionOrderList;
	}

	public void setSanctionOrderList(List<SanctionOrder> sanctionOrderList) {
		this.sanctionOrderList = sanctionOrderList;
	}

	public ReleaseIntallment getReleaseIntallment() {
		return releaseIntallment;
	}

	public void setReleaseIntallment(ReleaseIntallment releaseIntallment) {
		this.releaseIntallment = releaseIntallment;
	}

	public Integer getReleaseIntallmentSno() {
		return releaseIntallmentSno;
	}

	public void setReleaseIntallmentSno(Integer releaseIntallmentSno) {
		this.releaseIntallmentSno = releaseIntallmentSno;
	}

	public Boolean getStatus() {
		return status;
	}

	public void setStatus(Boolean status) {
		this.status = status;
	}
	
	
	

}
