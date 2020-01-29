package gov.in.rgsa.entity;

import java.io.Serializable;
import java.sql.Timestamp;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.NamedQuery;
import javax.persistence.OneToMany;
import javax.persistence.Table;

import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;

import com.fasterxml.jackson.annotation.JsonManagedReference;

@Entity
@Table(name="panhcayat_bhawan_activity" , schema="rgsa")
@NamedQuery(name="FETCH_PANCHAYAT_DETAILS",query="select pb from PanchatayBhawanActivity pb left outer join fetch pb.panchatayBhawanActivityDetails pbd where pb.stateCode=:stateCode and pb.yearId=:yearId and pb.userType=:userType and pb.versionNo=:versionNo and pb.isActive=true order by pbd.activity.activityId asc")
public class PanchatayBhawanActivity implements Serializable {
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name="panhcayat_bhawan_activity_id")
	private Integer panhcayatBhawanActivityId;
	
	@Column(name = "state_code")
	private Integer stateCode;
	
	@Column(name = "year_id")
	private Integer yearId;
	
	@Column(name = "version_no")
	private Integer versionNo;
	
	@Column(name="user_type")
	private String userType;
	
	@Column(name="additional_requirement")
	private Integer additionalRequirement;
	
	@Column(name="created_by")
	private Integer createdBy;
	
	
	@Column(name="created_on",updatable=false)
	@CreationTimestamp
	private Timestamp createdOn;
	
	@Column(name="last_updated_by")
	private Integer lastUpdatedBy;
	
	
	@Column(name="last_updated_on")
	@UpdateTimestamp
	private Timestamp lastUpdatedOn;
	
	@Column(name="status")
	private String status;
	
	@Column(name="is_active")
	private Boolean isActive;
	
//	@JsonManagedReference
	@OneToMany(mappedBy="panchatayBhawanActivity",cascade=CascadeType.ALL)
	private List<PanchatayBhawanActivityDetails> panchatayBhawanActivityDetails;
	
	
	
	public Integer getPanhcayatBhawanActivityId() {
		return panhcayatBhawanActivityId;
	}

	public void setPanhcayatBhawanActivityId(Integer panhcayatBhawanActivityId) {
		this.panhcayatBhawanActivityId = panhcayatBhawanActivityId;
	}

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

	public Integer getVersionNo() {
		return versionNo;
	}

	public void setVersionNo(Integer versionNo) {
		this.versionNo = versionNo;
	}

	public String getUserType() {
		return userType;
	}

	public void setUserType(String userType) {
		this.userType = userType;
	}

	public Integer getAdditionalRequirement() {
		return additionalRequirement;
	}

	public void setAdditionalRequirement(Integer additionalRequirement) {
		this.additionalRequirement = additionalRequirement;
	}

	public Integer getCreatedBy() {
		return createdBy;
	}

	public void setCreatedBy(Integer createdBy) {
		this.createdBy = createdBy;
	}

	public Timestamp getCreatedOn() {
		return createdOn;
	}

	public void setCreatedOn(Timestamp createdOn) {
		this.createdOn = createdOn;
	}

	public Integer getLastUpdatedBy() {
		return lastUpdatedBy;
	}

	public void setLastUpdatedBy(Integer lastUpdatedBy) {
		this.lastUpdatedBy = lastUpdatedBy;
	}

	public Timestamp getLastUpdatedOn() {
		return lastUpdatedOn;
	}

	public void setLastUpdatedOn(Timestamp lastUpdatedOn) {
		this.lastUpdatedOn = lastUpdatedOn;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public List<PanchatayBhawanActivityDetails> getPanchatayBhawanActivityDetails() {
		return panchatayBhawanActivityDetails;
	}

	public void setPanchatayBhawanActivityDetails(List<PanchatayBhawanActivityDetails> panchatayBhawanActivityDetails) {
		this.panchatayBhawanActivityDetails = panchatayBhawanActivityDetails;
	}

	public Boolean getIsActive() {
		return isActive;
	}

	public void setIsActive(Boolean isActive) {
		this.isActive = isActive;
	}
	
	

}
