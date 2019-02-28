package gov.in.rgsa.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToOne;
import javax.persistence.Table;

import com.fasterxml.jackson.annotation.JsonBackReference;

/**
 * 
 * @author sourabh
 *
 */

@Entity
@Table(name="cb_activity_details", schema = "rgsa")
public class CapacityBuildingActivityDetails {
	
	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	@Column(name="cb_activity_detail_id",updatable=false,nullable=false)
	private Integer capacityBuildingActivityDetailsId;
	
	@JsonBackReference
	@ManyToOne(fetch=FetchType.LAZY)
	@JoinColumn(name="cb_activity_id")
	private CapacityBuildingActivity capacityBuildingActivity;
	
	@Column(name="cb_master_id")
	private Integer cbMaster;
	
	@Column(name="no_of_units")
	private Integer noOfUnits;
	
	@Column(name="unit_cost")
	private Integer unitCost;
	
	@Column(name="no_of_days")
	private Integer noOfDays;
	
	@Column(name="funds")
	private Integer funds;
	
	@Column(name="collab_institute")
	private String collabInstitute;
	
	@Column(name="is_approved")
	private Boolean isApproved;
	
	@Column(name="remarks")
	private String remarks;

	public Integer getCapacityBuildingActivityDetailsId() {
		return capacityBuildingActivityDetailsId;
	}

	public void setCapacityBuildingActivityDetailsId(Integer capacityBuildingActivityDetailsId) {
		this.capacityBuildingActivityDetailsId = capacityBuildingActivityDetailsId;
	}

	public CapacityBuildingActivity getCapacityBuildingActivity() {
		return capacityBuildingActivity;
	}

	public void setCapacityBuildingActivity(CapacityBuildingActivity capacityBuildingActivity) {
		this.capacityBuildingActivity = capacityBuildingActivity;
	}

	public Integer getNoOfUnits() {
		return noOfUnits;
	}

	public Integer getCbMaster() {
		return cbMaster;
	}

	public void setCbMaster(Integer cbMaster) {
		this.cbMaster = cbMaster;
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

	public Integer getNoOfDays() {
		return noOfDays;
	}

	public void setNoOfDays(Integer noOfDays) {
		this.noOfDays = noOfDays;
	}

	public Integer getFunds() {
		return funds;
	}

	public void setFunds(Integer funds) {
		this.funds = funds;
	}

	public String getCollabInstitute() {
		return collabInstitute;
	}

	public void setCollabInstitute(String collabInstitute) {
		this.collabInstitute = collabInstitute;
	}

	public String getRemarks() {
		return remarks;
	}

	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}

	public Boolean getIsApproved() {
		return isApproved;
	}

	public void setIsApproved(Boolean isApproved) {
		this.isApproved = isApproved;
	}

	
}