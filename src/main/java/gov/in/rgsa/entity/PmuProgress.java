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
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Transient;

import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;





@Entity
@Table(name="qpr_pmu", schema="rgsa")
@NamedQueries ({@NamedQuery(name="FETCH_PMU_PROGRESS_PROGRESS_REPORT_DETAILS", query="Select PP from PmuProgress PP RIGHT OUTER JOIN FETCH PP.pmuProgressDetails PPD where PP.pmuActivity.pmuActivityId=:pmuActivityId AND PP.quarterDuration.qtrId=:qtrId order by PPD.qprPmuDetailsId asc "),
@NamedQuery(name="FETCH_Pmu_Progress_progress_report_BASED_ID", query="Select PP from PmuProgress PP  where PP.pmuActivity.pmuActivityId=:pmuActivityId"),
@NamedQuery(name="FETCH_PMU_ACT_QTR_ID_AND_ACT_ID",query="from PmuProgress where pmuActivity.pmuActivityId=:pmuActivityId and quarterDuration.qtrId !=:quarterId")
})
public class PmuProgress {

	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name="qpr_pmu_id")
	private Integer qprPmuId;
			
	@ManyToOne(fetch=FetchType.LAZY)
	@JoinColumn(name="pmu_activity_id")
	private PmuActivity pmuActivity;

	
	@ManyToOne(fetch=FetchType.LAZY)
	@JoinColumn(name="qtr_id")
	private QuarterDuration quarterDuration;
	
	@OneToMany(cascade=CascadeType.ALL,mappedBy="pmuProgress",fetch=FetchType.EAGER)
	private List<PmuProgressDetails> pmuProgressDetails;

	
	@Column(name="additional_requirement")
	private Integer additionalRequirement;
	
	@Column(name="created_by")
	private Integer createdBy;
		
	@Column(name="menu_id")
	private Integer menuId;
		
	
	@Column(name="created_on",updatable=false)
	@CreationTimestamp
	private Timestamp createdOn;
	
	@Column(name="last_updated_by")
	private Integer lastUpdatedBy;
		
	@Column(name="last_updated_on")
	@UpdateTimestamp
	private Timestamp lastUpdatedOn;
	
	
	@Column(name="is_freeze")
	private Boolean isFreeze;

	@Transient
	private Integer qtrIdJsp6;
	
	@Transient
	private String origin;

	public Integer getQprPmuId() {
		return qprPmuId;
	}

	public void setQprPmuId(Integer qprPmuId) {
		this.qprPmuId = qprPmuId;
	}

	public PmuActivity getPmuActivity() {
		return pmuActivity;
	}

	public void setPmuActivity(PmuActivity pmuActivity) {
		this.pmuActivity = pmuActivity;
	}

	public QuarterDuration getQuarterDuration() {
		return quarterDuration;
	}

	public void setQuarterDuration(QuarterDuration quarterDuration) {
		this.quarterDuration = quarterDuration;
	}

	public List<PmuProgressDetails> getPmuProgressDetails() {
		return pmuProgressDetails;
	}

	public void setPmuProgressDetails(List<PmuProgressDetails> pmuProgressDetails) {
		this.pmuProgressDetails = pmuProgressDetails;
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

	public Integer getMenuId() {
		return menuId;
	}

	public void setMenuId(Integer menuId) {
		this.menuId = menuId;
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

	public Integer getQtrIdJsp6() {
		return qtrIdJsp6;
	}

	public void setQtrIdJsp6(Integer qtrIdJsp6) {
		this.qtrIdJsp6 = qtrIdJsp6;
	}

	public String getOrigin() {
		return origin;
	}

	public void setOrigin(String origin) {
		this.origin = origin;
	}
	
}



	

