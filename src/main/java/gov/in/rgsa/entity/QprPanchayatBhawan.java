package gov.in.rgsa.entity;

import java.util.Date;
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

@Entity
@Table(name="qpr_panhcayat_bhawan",schema="rgsa")
@NamedQuery(name="FETCH_ACTIVITY_DEPEND_ON_QUATOR",query="SELECT Q FROM QprPanchayatBhawan Q WHERE qtrId=:quatorId AND panchayatBhawanActivityId=:panchayatBhawanActivityId AND activityId=:activityId ")
public class QprPanchayatBhawan  implements IFreezable{

	
	@Id
	@Column(name="qpr_panhcayat_bhawan_id")
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private Integer qprPanchayatBhawanId;
	
	@Column(name="panhcayat_bhawan_activity_id")
	private Integer panchayatBhawanActivityId;
	
	@Column(name="qtr_id")
	private Integer qtrId;
	
	@Column(name="additional_requirement")
	private Integer additionalRequirement;
	
	@Column(name="created_by")
	private Integer createdBy;
	
	@Column(name="created_on",updatable=false)
	private Date createdOn;
	
	@Column(name="last_updated_by")
	private Integer lastUpdatedBy;
	
	@Column(name="last_updated_on")
	private Date lastUpdatedOn;
	
	@Column(name="is_freeze")
	private Boolean isFreeze;
	
	@Column(name="menu_id")
	private Integer menuId;
	
	@Column(name="activity_id")
	private Integer activityId;
	
	@OneToMany(cascade=CascadeType.ALL,fetch=FetchType.EAGER,mappedBy="qprPanchayatBhawan")
	private List<QprPanhcayatBhawanDetails> qprPanhcayatBhawanDetails;
	
	@Transient
	private Integer selectDistrictId;
	

	public Integer getQprPanchayatBhawanId() {
		return qprPanchayatBhawanId;
	}

	public void setQprPanchayatBhawanId(Integer qprPanchayatBhawanId) {
		this.qprPanchayatBhawanId = qprPanchayatBhawanId;
	}

	public Integer getPanchayatBhawanActivityId() {
		return panchayatBhawanActivityId;
	}

	public void setPanchayatBhawanActivityId(Integer panchayatBhawanActivityId) {
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

	public Date getCreatedOn() {
		return createdOn;
	}

	public void setCreatedOn(Date createdOn) {
		this.createdOn = createdOn;
	}

	public Integer getLastUpdatedBy() {
		return lastUpdatedBy;
	}

	public void setLastUpdatedBy(Integer lastUpdatedBy) {
		this.lastUpdatedBy = lastUpdatedBy;
	}

	public Date getLastUpdatedOn() {
		return lastUpdatedOn;
	}

	public void setLastUpdatedOn(Date lastUpdatedOn) {
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

	public Integer getActivityId() {
		return activityId;
	}

	public void setActivityId(Integer activityId) {
		this.activityId = activityId;
	}

	public List<QprPanhcayatBhawanDetails> getQprPanhcayatBhawanDetails() {
		return qprPanhcayatBhawanDetails;
	}

	public void setQprPanhcayatBhawanDetails(List<QprPanhcayatBhawanDetails> qprPanhcayatBhawanDetails) {
		this.qprPanhcayatBhawanDetails = qprPanhcayatBhawanDetails;
	}

	public Integer getSelectDistrictId() {
		return selectDistrictId;
	}

	public void setSelectDistrictId(Integer selectDistrictId) {
		this.selectDistrictId = selectDistrictId;
	}

	
	
	
}
