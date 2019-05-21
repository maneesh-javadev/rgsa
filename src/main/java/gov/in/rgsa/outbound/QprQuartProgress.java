package gov.in.rgsa.outbound;

import javax.persistence.Entity;
import javax.persistence.Id;

@Entity
public class QprQuartProgress {
	@Id
	public Integer pesaPlanDetailsId ;
	public Integer pesaPlanId ;
	public Integer designationId ;
	public String pesaPostName ;
	public Integer ceilingValue ;
	public Integer noOfUnits ;
	public Integer unitCostPerMonth ;
	public Integer qprPesaId ;
	public Integer qprPesaDetailsId ;
	public Integer noOfUnitsFilled ;
	public Double expenditureIncurred ;
	public Integer additionalRequirement ;
	public Integer additionalRequirementState ;
	public Boolean isFreeze;
	private Double funds;
	private Double spent;
	private Integer addreqused;
	
	public Integer getPesaPlanDetailsId() {
		return pesaPlanDetailsId;
	}
	public void setPesaPlanDetailsId(Integer pesaPlanDetailsId) {
		this.pesaPlanDetailsId = pesaPlanDetailsId;
	}
	public Integer getPesaPlanId() {
		return pesaPlanId;
	}
	public void setPesaPlanId(Integer pesaPlanId) {
		this.pesaPlanId = pesaPlanId;
	}
	public Integer getDesignationId() {
		return designationId;
	}
	public void setDesignationId(Integer designationId) {
		this.designationId = designationId;
	}
	public String getPesaPostName() {
		return pesaPostName;
	}
	public void setPesaPostName(String pesaPostName) {
		this.pesaPostName = pesaPostName;
	}
	public Integer getCeilingValue() {
		return ceilingValue;
	}
	public void setCeilingValue(Integer ceilingValue) {
		this.ceilingValue = ceilingValue;
	}
	public Integer getNoOfUnits() {
		return noOfUnits;
	}
	public void setNoOfUnits(Integer noOfUnits) {
		this.noOfUnits = noOfUnits;
	}
	public Integer getUnitCostPerMonth() {
		return unitCostPerMonth;
	}
	public void setUnitCostPerMonth(Integer unitCostPerMonth) {
		this.unitCostPerMonth = unitCostPerMonth;
	}
	public Integer getQprPesaId() {
		return qprPesaId;
	}
	public void setQprPesaId(Integer qprPesaId) {
		this.qprPesaId = qprPesaId;
	}
	public Integer getNoOfUnitsFilled() {
		return noOfUnitsFilled;
	}
	public void setNoOfUnitsFilled(Integer noOfUnitsFilled) {
		this.noOfUnitsFilled = noOfUnitsFilled;
	}
	public Double getExpenditureIncurred() {
		return expenditureIncurred;
	}
	public void setExpenditureIncurred(Double expenditureIncurred) {
		this.expenditureIncurred = expenditureIncurred;
	}
	public Integer getAdditionalRequirement() {
		return additionalRequirement;
	}
	public void setAdditionalRequirement(Integer additionalRequirement) {
		this.additionalRequirement = additionalRequirement;
	}
	public Boolean getIsFreeze() {
		return isFreeze;
	}
	public void setIsFreeze(Boolean isFreeze) {
		this.isFreeze = isFreeze;
	}
	public Integer getQprPesaDetailsId() {
		return qprPesaDetailsId;
	}
	public void setQprPesaDetailsId(Integer qprPesaDetailsId) {
		this.qprPesaDetailsId = qprPesaDetailsId;
	}

	public Double getSpent() {
		return spent;
	}

	public void setSpent(Double spent) {
		this.spent = spent;
	}

	/*
	 * public Integer getAddReqUsed() { return addReqUsed; }
	 * 
	 * public void setAddReqUsed(Integer addReqUsed) { this.addReqUsed = addReqUsed;
	 * }
	 */

	public Double getFunds() {
		return funds;
	}

	public void setFunds(Double funds) {
		this.funds = funds;
	}
	public Integer getAddreqused() {
		return addreqused;
	}
	public void setAddreqused(Integer addreqused) {
		this.addreqused = addreqused;
	}
	public Integer getAdditionalRequirementState() {
		return additionalRequirementState;
	}
	public void setAdditionalRequirementState(Integer additionalRequirementState) {
		this.additionalRequirementState = additionalRequirementState;
	}
}
