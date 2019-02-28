package gov.in.rgsa.entity;

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
import javax.persistence.Transient;

import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;

@Entity
@Table(name="qpr_panhcayat_bhawan",schema="rgsa")
@NamedQuery(name="FETCH_ACTIVITY_DEPEND_ON_QUATOR",query="SELECT Q FROM QprPanchayatBhawan Q WHERE qtrId=:quatorId AND activityId=:activityId AND districtCode=:districtCode")
public class QprPanchayatBhawan {

	@Id
	@Column(name="qpr_panhcayat_bhawan_id")
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private Long qprPanchayatBhawanId;
	
	@Column(name="panhcayat_bhawan_activity_id")
	private Long panchayatBhawanActivityId;
	
	@Column(name="qtr_id")
	private Integer qtrId;
	
	@Column(name="additional_requirement")
	private Integer additionalRequirement;
	
	@Column(name="created_by")
	private Integer createdBy;
	
	@CreationTimestamp
	@Column(name="created_on",updatable=false)
	private Timestamp createdOn;
	
	@Column(name="last_updated_by")
	private Integer lastUpdatedBy;
	
	@UpdateTimestamp
	@Column(name="last_updated_on")
	private Timestamp lastUpdatedOn;
	
	@Column(name="is_freeze")
	private Boolean isFreeze;
	
	@Column(name="menu_id")
	private Integer menuId;
	
	@Column(name="activity_id")
	private Integer activityId;
	
	@Column(name="district_code")
	private Integer districtCode;
	
	@Transient
	private Integer selectDistrictId;
	
	@Transient
	private Integer quaterId;
	
	@Transient
	private Integer activityId1;
	
	@Transient
	private String path;
	
	@Transient
	private String dbFileName;
	
	
	
	public String getDbFileName() {
		return dbFileName;
	}

	public void setDbFileName(String dbFileName) {
		this.dbFileName = dbFileName;
	}

	@OneToMany(cascade=CascadeType.ALL,fetch=FetchType.EAGER,mappedBy="qprPanchayatBhawan")
	private List<QprPanhcayatBhawanDetails> qprPanhcayatBhawanDetails;

	@Transient
	private Integer previousActivityId;
	
	@Transient
	private Integer previousDistrictCode;
	
	
	
	public String getPath() {
		return path;
	}

	public void setPath(String path) {
		this.path = path;
	}

	public Integer getSelectDistrictId() {
		return selectDistrictId;
	}

	public void setSelectDistrictId(Integer selectDistrictId) {
		this.selectDistrictId = selectDistrictId;
	}

	public Integer getQuaterId() {
		return quaterId;
	}

	public void setQuaterId(Integer quaterId) {
		this.quaterId = quaterId;
	}

	public Integer getActivityId1() {
		return activityId1;
	}

	public void setActivityId1(Integer activityId1) {
		this.activityId1 = activityId1;
	}

	public Long getQprPanchayatBhawanId() {
		return qprPanchayatBhawanId;
	}

	public void setQprPanchayatBhawanId(Long qprPanchayatBhawanId) {
		this.qprPanchayatBhawanId = qprPanchayatBhawanId;
	}

	public Long getPanchayatBhawanActivityId() {
		return panchayatBhawanActivityId;
	}

	public void setPanchayatBhawanActivityId(Long panchayatBhawanActivityId) {
		this.panchayatBhawanActivityId = panchayatBhawanActivityId;
	}

	public Integer getQtrId() {
		return qtrId;
	}

	public void setQtrId(Integer qtrId) {
		this.qtrId = qtrId;
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

	public Boolean getIsFreeze() {
		return isFreeze;
	}

	public void setIsFreeze(Boolean isFreeze) {
		this.isFreeze = isFreeze;
	}

	public Integer getMenuId() {
		return menuId;
	}

	public void setMenuId(Integer menuId) {
		this.menuId = menuId;
	}

	public List<QprPanhcayatBhawanDetails> getQprPanhcayatBhawanDetails() {
		return qprPanhcayatBhawanDetails;
	}

	public void setQprPanhcayatBhawanDetails(List<QprPanhcayatBhawanDetails> qprPanhcayatBhawanDetails) {
		this.qprPanhcayatBhawanDetails = qprPanhcayatBhawanDetails;
	}

	public Integer getActivityId() {
		return activityId;
	}

	public void setActivityId(Integer activityId) {
		this.activityId = activityId;
	}

	public Integer getDistrictCode() {
		return districtCode;
	}

	public void setDistrictCode(Integer districtCode) {
		this.districtCode = districtCode;
	}

	public Integer getPreviousActivityId() {
		return previousActivityId;
	}

	public void setPreviousActivityId(Integer previousActivityId) {
		this.previousActivityId = previousActivityId;
	}

	public Integer getPreviousDistrictCode() {
		return previousDistrictCode;
	}

	public void setPreviousDistrictCode(Integer previousDistrictCode) {
		this.previousDistrictCode = previousDistrictCode;
	}
}
