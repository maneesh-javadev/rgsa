package gov.in.rgsa.entity;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.NamedNativeQuery;

@Entity
@NamedNativeQuery(name="STATE_PLAN_FUNDS",query="select  ROW_NUMBER () OVER (),*  from rgsa.get_state_fund_details(:stateCode,:yearId,:userType)",resultClass=StatePlanComponentsFunds.class)
public class StatePlanComponentsFunds implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 3003340792367641414L;

	@Id
	@Column(name="row_number")
	private Integer rowId;
	
	@Column(name="e_name")
	private String eName;
	
	@Column(name="e_type")
	private String eType;
	
	@Column(name="subcomponent_id")
	private Integer subcomponentsId;
	
	@Column(name="component_id")
	private Integer componentsId;
	
	@Column(name="no_of_units")
	private Integer noOfUnits;
	
	@Column(name="amount_Proposed")
	private Double amountProposed;
	
	@Column(name="no_of_units_mopr")
	private Integer noOfUnitsMOPR;
	
	@Column(name="amount_proposed_mopr")
	private Double amountProposedMOPR;
	
	@Column(name="no_of_units_cec")
	private Integer noOfUnitsCEC;
	
	@Column(name="amount_proposed_cec")
	private Double amountProposedCEC;
	
	@Column(name="status")
	private String status;
	
	@Column(name="sort_order")
	private Integer sortOrder;
	
	@Column(name="link")
	private String link;
	
	@Column(name="addtional_requirement")
	private Double addtionalRequirement;
	
	@Column(name="additional_requirement_mopr")
	private Double addtionalRequirementMOPR;
	
	@Column(name="additional_requirement_cec")
	private Double addtionalRequirementCEC;
	
	public Integer getRowId() {
		return rowId;
	}

	public void setRowId(Integer rowId) {
		this.rowId = rowId;
	}

	public String geteName() {
		return eName;
	}

	public void seteName(String eName) {
		this.eName = eName;
	}

	public String geteType() {
		return eType;
	}

	public void seteType(String eType) {
		this.eType = eType;
	}

	public Integer getSubcomponentsId() {
		return subcomponentsId;
	}

	public void setSubcomponentsId(Integer subcomponentsId) {
		this.subcomponentsId = subcomponentsId;
	}

	public Integer getComponentsId() {
		return componentsId;
	}

	public void setComponentsId(Integer componentsId) {
		this.componentsId = componentsId;
	}

	public Integer getNoOfUnits() {
		return noOfUnits;
	}

	public void setNoOfUnits(Integer noOfUnits) {
		this.noOfUnits = noOfUnits;
	}

	public Double getAmountProposed() {
		return amountProposed;
	}

	public void setAmountProposed(Double amountProposed) {
		this.amountProposed = amountProposed;
	}

	public Integer getNoOfUnitsMOPR() {
		return noOfUnitsMOPR;
	}

	public void setNoOfUnitsMOPR(Integer noOfUnitsMOPR) {
		this.noOfUnitsMOPR = noOfUnitsMOPR;
	}

	public Double getAmountProposedMOPR() {
		return amountProposedMOPR;
	}

	public void setAmountProposedMOPR(Double amountProposedMOPR) {
		this.amountProposedMOPR = amountProposedMOPR;
	}

	public Integer getNoOfUnitsCEC() {
		return noOfUnitsCEC;
	}

	public void setNoOfUnitsCEC(Integer noOfUnitsCEC) {
		this.noOfUnitsCEC = noOfUnitsCEC;
	}

	public Double getAmountProposedCEC() {
		return amountProposedCEC;
	}

	public void setAmountProposedCEC(Double amountProposedCEC) {
		this.amountProposedCEC = amountProposedCEC;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public Integer getSortOrder() {
		return sortOrder;
	}

	public void setSortOrder(Integer sortOrder) {
		this.sortOrder = sortOrder;
	}

	public String getLink() {
		return link;
	}

	public void setLink(String link) {
		this.link = link;
	}

	public Double getAddtionalRequirement() {
		return addtionalRequirement;
	}

	public void setAddtionalRequirement(Double addtionalRequirement) {
		this.addtionalRequirement = addtionalRequirement;
	}

	public Double getAddtionalRequirementMOPR() {
		return addtionalRequirementMOPR;
	}

	public void setAddtionalRequirementMOPR(Double addtionalRequirementMOPR) {
		this.addtionalRequirementMOPR = addtionalRequirementMOPR;
	}

	public Double getAddtionalRequirementCEC() {
		return addtionalRequirementCEC;
	}

	public void setAddtionalRequirementCEC(Double addtionalRequirementCEC) {
		this.addtionalRequirementCEC = addtionalRequirementCEC;
	}
	
	

}
