package gov.in.rgsa.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQueries;
import javax.persistence.Table;
import javax.persistence.Transient;

import org.hibernate.annotations.NamedQuery;

import com.fasterxml.jackson.annotation.JsonBackReference;

/**
 * 
 * @author Ashish
 *
 */
@Entity
@Table(name="institutional_infra_activity_details", schema = "rgsa")
@NamedQueries({
	@javax.persistence.NamedQuery(name="FETCH_ALL_INSTITUTIONAL_ACTIVITY_DETAILS",query="FROM InstitutionalInfraActivityPlanDetails where institutionalInfraActivityPlan.institutionalInfraActivityId=:institutionalInfraActivityId and trainingInstitueType.trainingInstitueTypeId=:instituteType order by institutionalInfraActivityDetailsId asc"),
	@javax.persistence.NamedQuery(name="FETCH_ALL_DETAILS",query="FROM InstitutionalInfraActivityPlanDetails where institutionalInfraActivityPlan.institutionalInfraActivityId=:institutionalInfraActivityId order by institutionalInfraActivityDetailsId asc")
})

public class InstitutionalInfraActivityPlanDetails {
	
	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	@Column(name="institutional_infra_activity_details_id")
	private Integer institutionalInfraActivityDetailsId;
	
	@JsonBackReference
	@ManyToOne
	@JoinColumn(name="institutional_infra_activity_id")
	private InstitutionalInfraActivityPlan institutionalInfraActivityPlan;
	
	@ManyToOne
	@JoinColumn(name="institutional_activity_type_id")
	private TrainingInstitueType trainingInstitueType;

	@Column(name="fund_proposed")
	private int fundProposed;
	
	@Column(name="total_fund")
	private int totalFund;
	
	@Column(name="land_indentified")
	private Boolean landIndentified = Boolean.FALSE;
	
	@Column(name="source_of_funding")
	private Boolean anyOtherSourceOfFunding = Boolean.FALSE;
	
	@Column(name="design_and_layout_of_building")
	private Boolean designAndLayoutOfBuilding = Boolean.FALSE;
		
	@Column(name="remarks")
	private String remarks;
	
	@Column(name="institutional_infra_location")
	private int institutionalInfraLocation;
	
	@Transient
	private String[] locationName;
	
	@Column(name="is_approved")
	private Boolean isApproved;
	
	@Transient
	private String districtName;
	
	@Column(name="work_type")
	private Character workType;

	public Integer getInstitutionalInfraActivityDetailsId() {
		return institutionalInfraActivityDetailsId;
	}

	public void setInstitutionalInfraActivityDetailsId(Integer institutionalInfraActivityDetailsId) {
		this.institutionalInfraActivityDetailsId = institutionalInfraActivityDetailsId;
	}

	public InstitutionalInfraActivityPlan getInstitutionalInfraActivityPlan() {
		return institutionalInfraActivityPlan;
	}

	public void setInstitutionalInfraActivityPlan(InstitutionalInfraActivityPlan institutionalInfraActivityPlan) {
		this.institutionalInfraActivityPlan = institutionalInfraActivityPlan;
	}

	public TrainingInstitueType getTrainingInstitueType() {
		return trainingInstitueType;
	}

	public void setTrainingInstitueType(TrainingInstitueType trainingInstitueType) {
		this.trainingInstitueType = trainingInstitueType;
	}

	public Boolean getLandIndentified() {
		return landIndentified;
	}

	public void setLandIndentified(Boolean landIndentified) {
		this.landIndentified = landIndentified;
	}

	public Boolean getAnyOtherSourceOfFunding() {
		return anyOtherSourceOfFunding;
	}

	public void setAnyOtherSourceOfFunding(Boolean anyOtherSourceOfFunding) {
		this.anyOtherSourceOfFunding = anyOtherSourceOfFunding;
	}

	public Boolean getDesignAndLayoutOfBuilding() {
		return designAndLayoutOfBuilding;
	}

	public void setDesignAndLayoutOfBuilding(Boolean designAndLayoutOfBuilding) {
		this.designAndLayoutOfBuilding = designAndLayoutOfBuilding;
	}

	public int getFundProposed() {
		return fundProposed;
	}

	public void setFundProposed(int fundProposed) {
		this.fundProposed = fundProposed;
	}

	public int getTotalFund() {
		return totalFund;
	}

	public void setTotalFund(int totalFund) {
		this.totalFund = totalFund;
	}

	public String getRemarks() {
		return remarks;
	}

	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}

	public int getInstitutionalInfraLocation() {
		return institutionalInfraLocation;
	}

	public void setInstitutionalInfraLocation(int institutionalInfraLocation) {
		this.institutionalInfraLocation = institutionalInfraLocation;
	}

	public String[] getLocationName() {
		return locationName;
	}

	public void setLocationName(String[] locationName) {
		this.locationName = locationName;
	}

	public Boolean getIsApproved() {
		return isApproved;
	}

	public void setIsApproved(Boolean isApproved) {
		this.isApproved = isApproved;
	}

	public String getDistrictName() {
		return districtName;
	}

	public void setDistrictName(String districtName) {
		this.districtName = districtName;
	}

	public Character getWorkType() {
		return workType;
	}

	public void setWorkType(Character workType) {
		this.workType = workType;
	}
	
}