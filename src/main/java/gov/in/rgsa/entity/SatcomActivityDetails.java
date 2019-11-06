package gov.in.rgsa.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQuery;
import javax.persistence.Table;

import com.fasterxml.jackson.annotation.JsonBackReference;

@Entity
@Table(name="satcom_activity_details", schema="rgsa")
@NamedQuery(name="FETCH_ALL_SATCOM_DETAILS_EXCEPT_CURRENT_VERSION",query="from SatcomActivityDetails where satcomActivity.stateCode=:stateCode and satcomActivity.versionNo !=:versionNo and  satcomActivity.userType in('S','M') order by satcomActivityDetailsId")
public class SatcomActivityDetails {

	@Id
	@Column(name="satcom_activity_details_id")
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Integer satcomActivityDetailsId;
	
	@JsonBackReference
	@ManyToOne(fetch=FetchType.LAZY)
	@JoinColumn(name="satcom_activity_id")
	private SatcomActivity satcomActivity;
	
	@ManyToOne
	@JoinColumn(name="satcom_master_id")
	private SatcomMaster satcomMaster;
	
	@ManyToOne
	@JoinColumn(name="satcom_level_id")
	private SatcomLevel level;
	
	@Column(name="no_of_units")
	private Integer noOfUnits; 
	
	
	@Column(name="unit_cost")
	private Integer unitCost; 
	
	
	@Column(name="funds")
	private Integer funds; 
	
	@Column(name="is_approved")
	private Boolean isApproved;
	
	
	public Boolean getIsActive() {
		return isActive;
	}

	public void setIsActive(Boolean isActive) {
		this.isActive = isActive;
	}

	@Column(name="is_active")
	private Boolean isActive;
	
	
	public Boolean getIsApproved() {
		return isApproved;
	}

	public void setIsApproved(Boolean isApproved) {
		this.isApproved = isApproved;
	}

	@Column(name="remarks")
	private String remarks;

	public Integer getSatcomActivityDetailsId() {
		return satcomActivityDetailsId;
	}

	public void setSatcomActivityDetailsId(Integer satcomActivityDetailsId) {
		this.satcomActivityDetailsId = satcomActivityDetailsId;
	}

	public SatcomActivity getSatcomActivity() {
		return satcomActivity;
	}

	public void setSatcomActivity(SatcomActivity satcomActivity) {
		this.satcomActivity = satcomActivity;
	}

	public SatcomMaster getSatcomMaster() {
		return satcomMaster;
	}

	public void setSatcomMaster(SatcomMaster satcomMaster) {
		this.satcomMaster = satcomMaster;
	}

	public Integer getNoOfUnits() {
		return noOfUnits;
	}

	public void setNoOfUnits(Integer noOfUnits) {
		this.noOfUnits = noOfUnits;
	}

	public Integer getUnitCost() {
		return unitCost;
	}

	public void setUnitCost(Integer unitCost) {
		this.unitCost = unitCost;
	}

	public Integer getFunds() {
		return funds;
	}

	public void setFunds(Integer funds) {
		this.funds = funds;
	}

	public String getRemarks() {
		return remarks;
	}

	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}

	public SatcomLevel getLevel() {
		return level;
	}

	public void setLevel(SatcomLevel level) {
		this.level = level;
	} 
	
	
	
}
