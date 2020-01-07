package gov.in.rgsa.model;

import java.util.Date;
import java.util.List;

import javax.persistence.Transient;

import gov.in.rgsa.entity.ReleaseIntallment;
import gov.in.rgsa.entity.SanctionOrder;
import gov.in.rgsa.entity.SanctionOrderCompomentAmount;

public class SnactionOrderModel {
	
	
	private Integer stateCode;
	
	private Integer yearId;
	
	private String sactionDate;

	private Integer installmentNo;
	
	private List<SanctionOrderCompomentAmount> sanctionOrderCompomentAmountList;
	
	private List<SanctionOrder> sanctionOrderList;
	
	private ReleaseIntallment releaseIntallment;
	
	private Integer releaseIntallmentSno;
	
	private Integer planCode;
	private Boolean status;
	
	@Transient
	private String origin;

	private String dbFileName;
	
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

	

	public String getSactionDate() {
		return sactionDate;
	}

	public void setSactionDate(String sactionDate) {
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

	public Integer getPlanCode() {
		return planCode;
	}

	public void setPlanCode(Integer planCode) {
		this.planCode = planCode;
	}

	public String getOrigin() {
		return origin;
	}

	public void setOrigin(String origin) {
		this.origin = origin;
	}

	public String getDbFileName() {
		return dbFileName;
	}

	public void setDbFileName(String dbFileName) {
		this.dbFileName = dbFileName;
	}
	
	
	

}
