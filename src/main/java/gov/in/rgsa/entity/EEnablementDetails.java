package gov.in.rgsa.entity;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;

@Entity	
@Table(name="e_enablement_details" , schema="rgsa")
@NamedQueries({
	@NamedQuery(name="FETCH_ALL_EENABLEMENT_DETAILS_EXCEPT_CURRENT_VERSION",query = "from EEnablementDetails where eEnablement.stateCode=:stateCode and eEnablement.versionNo !=:versionNo and eEnablement.yearId=:yearId and  eEnablement.userType in('S','M') order by eEnablementDetailId"),
	@NamedQuery(name="FETCH_ENABLEMENT_DETAILS",query="select EE FROM EEnablementDetails EE where eEnablement.eEnablementId=:eEnablementId")
})

public class EEnablementDetails implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name="e_enablement_details_id")
	private Integer eEnablementDetailId;
	
	/*@Column(name="e_enablement_id")
	private Integer eEnablementId;*/
	
	@ManyToOne
	@JoinColumn(name="e_enablement_id")
	private EEnablement eEnablement;
	
	@Column(name="ee_master_id")
	private Integer eeMasterId;
	
	@Column(name="no_of_units")
	private Integer noOfUnit;
	
	@Column(name="unit_cost")
	private Integer unitCost;
	
	@Column(name="funds")
	private Integer fund;
	
	@Column(name="remarks")
	private String remarks;
	
	@Column(name="aspirational_gps")
	private Integer aspirationalGps;

	@Column(name="is_approved")
	private Boolean isApproved;
	
	@Column(name="is_active")
	private Boolean isActive;
	
	
	public Integer geteEnablementDetailId() {
		return eEnablementDetailId;
	}

	public void seteEnablementDetailId(Integer eEnablementDetailId) {
		this.eEnablementDetailId = eEnablementDetailId;
	}

	public Integer getEeMasterId() {
		return eeMasterId;
	}

	public void setEeMasterId(Integer eeMasterId) {
		this.eeMasterId = eeMasterId;
	}

	public Integer getNoOfUnit() {
		return noOfUnit;
	}

	public void setNoOfUnit(Integer noOfUnit) {
		this.noOfUnit = noOfUnit;
	}

	public Integer getUnitCost() {
		return unitCost;
	}

	public void setUnitCost(Integer unitCost) {
		this.unitCost = unitCost;
	}

	public Integer getFund() {
		return fund;
	}

	public void setFund(Integer fund) {
		this.fund = fund;
	}

	public String getRemarks() {
		return remarks;
	}

	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}

	public Integer getAspirationalGps() {
		return aspirationalGps;
	}

	public void setAspirationalGps(Integer aspirationalGps) {
		this.aspirationalGps = aspirationalGps;
	}

	public EEnablement geteEnablement() {
		return eEnablement;
	}

	public void seteEnablement(EEnablement eEnablement) {
		this.eEnablement = eEnablement;
	}

	public Boolean getIsApproved() {
		return isApproved;
	}

	public void setIsApproved(Boolean isApproved) {
		this.isApproved = isApproved;
	}

	public Boolean getIsActive() {
		return isActive;
	}

	public void setIsActive(Boolean isActive) {
		this.isActive = isActive;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	
	
	
}
