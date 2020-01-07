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

import com.fasterxml.jackson.annotation.JsonBackReference;




@Entity
@NamedQueries({
	@NamedQuery(name="FIND_PANCHYAT_BHWAN_GP",query="from PanchayatBhawanProposedInfo where activityDetails.id=:activityDetailsId and isactive=true"),
	@NamedQuery(name="RESET_PANCHYAT_BHWAN_GP",query="from PanchayatBhawanProposedInfo where activityDetails.id in(:activityDetailIdList)"),

	
})

@Table(name="panhcayat_bhawan_activity_gps",schema="rgsa")
public class PanchayatBhawanProposedInfo implements Serializable{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 8783730459257223567L;


	@Id
	@Column(name="panhcayat_bhawan_activity_gps_id")
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private Integer proposedInfoId;
	
	
	@JsonBackReference
	@ManyToOne
	@JoinColumn(name="panhcayat_bhawan_activity_details_id",referencedColumnName="id")
	private PanchatayBhawanActivityDetails activityDetails;
	
	@Column(name="local_body_code")
	private Integer localBodyCode;
	
	@Column(name="land_identified")
	private Boolean landIdentified;
	
	@Column(name="layout_approved" )
	private Boolean approvedMap;
	
	@Column(name="separate_toilet_for_women")
	private Boolean separateToilet;
	
	@Column(name="provision_for_barrier_free_access")
	private Boolean barrierFreeAccess;
	
	@Column(name="provision_for_water_facility")
	private Boolean waterFacility;
	
	@Column(name="provision_for_internet_facility")
	private Boolean internetFacility;
	
	@Column(name="provision_for_electricity")
	private Boolean electricity;
	
	@Column(name="remarks")
	private String remarks;
	
	@Column(name="isactive")
	private boolean isactive;
	
	@Column(name="district_code")
	private Integer districtCode;

	public Integer getProposedInfoId() {
		return proposedInfoId;
	}

	public void setProposedInfoId(Integer proposedInfoId) {
		this.proposedInfoId = proposedInfoId;
	}

	

	public PanchatayBhawanActivityDetails getActivityDetails() {
		return activityDetails;
	}

	public void setActivityDetails(PanchatayBhawanActivityDetails activityDetails) {
		this.activityDetails = activityDetails;
	}

	public Integer getLocalBodyCode() {
		return localBodyCode;
	}

	public void setLocalBodyCode(Integer localBodyCode) {
		this.localBodyCode = localBodyCode;
	}

	public Boolean getLandIdentified() {
		return landIdentified;
	}

	public void setLandIdentified(Boolean landIdentified) {
		this.landIdentified = landIdentified;
	}

	public Boolean getApprovedMap() {
		return approvedMap;
	}

	public void setApprovedMap(Boolean approvedMap) {
		this.approvedMap = approvedMap;
	}

	public Boolean getSeparateToilet() {
		return separateToilet;
	}

	public void setSeparateToilet(Boolean separateToilet) {
		this.separateToilet = separateToilet;
	}

	public Boolean getBarrierFreeAccess() {
		return barrierFreeAccess;
	}

	public void setBarrierFreeAccess(Boolean barrierFreeAccess) {
		this.barrierFreeAccess = barrierFreeAccess;
	}

	public Boolean getWaterFacility() {
		return waterFacility;
	}

	public void setWaterFacility(Boolean waterFacility) {
		this.waterFacility = waterFacility;
	}

	public Boolean getInternetFacility() {
		return internetFacility;
	}

	public void setInternetFacility(Boolean internetFacility) {
		this.internetFacility = internetFacility;
	}

	public Boolean getElectricity() {
		return electricity;
	}

	public void setElectricity(Boolean electricity) {
		this.electricity = electricity;
	}

	public String getRemarks() {
		return remarks;
	}

	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}

	public boolean isIsactive() {
		return isactive;
	}

	public void setIsactive(boolean isactive) {
		this.isactive = isactive;
	}

	public Integer getDistrictCode() {
		return districtCode;
	}

	public void setDistrictCode(Integer districtCode) {
		this.districtCode = districtCode;
	}
	
	

}
