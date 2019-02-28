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
@Table(name="qpr_inst_infra_hr", schema="rgsa")
@NamedQueries ({@NamedQuery(name="FETCH_Additional_Faculty_progress_report_DETAILS", query="Select AFP from AdditionalFacultyProgress AFP RIGHT OUTER JOIN FETCH AFP.additionalFacultyProgressDetail AFPD where AFP.institueInfraHrActivity.instituteInfraHrActivityId=:instituteInfraHrActivityId AND AFP.quarterDuration.qtrId=:qtrId order by AFPD.qprInstInfraHrDetailsId asc"),
@NamedQuery(name="FETCH_Additional_Facult_progress_report_BASED_ID", query="Select AFP from AdditionalFacultyProgress AFP  where AFP.institueInfraHrActivity.instituteInfraHrActivityId=:instituteInfraHrActivityId")
})
public class AdditionalFacultyProgress {

	

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name="qpr_inst_infra_hr_id")
	private Integer qprInstInfraHrId;
			
	@ManyToOne(fetch=FetchType.LAZY)
	@JoinColumn(name="institue_infra_hr_activity_id")
	private InstitueInfraHrActivity institueInfraHrActivity;

	
	@ManyToOne(fetch=FetchType.LAZY)
	@JoinColumn(name="qtr_id")
	private QuarterDuration quarterDuration;
	
	@OneToMany(cascade=CascadeType.ALL,mappedBy="additionalFacultyProgress",fetch=FetchType.EAGER)
	private List<AdditionalFacultyProgressDetail> additionalFacultyProgressDetail;

	
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
	
	@Column(name="is_freez")
	private Boolean isFreeze;


	@Transient
	private Integer qtrIdJsp3;

	public Integer getQprInstInfraHrId() {
		return qprInstInfraHrId;
	}

	public void setQprInstInfraHrId(Integer qprInstInfraHrId) {
		this.qprInstInfraHrId = qprInstInfraHrId;
	}

	
	public InstitueInfraHrActivity getInstitueInfraHrActivity() {
		return institueInfraHrActivity;
	}

	public void setInstitueInfraHrActivity(InstitueInfraHrActivity institueInfraHrActivity) {
		this.institueInfraHrActivity = institueInfraHrActivity;
	}

	public QuarterDuration getQuarterDuration() {
		return quarterDuration;
	}

	public void setQuarterDuration(QuarterDuration quarterDuration) {
		this.quarterDuration = quarterDuration;
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

	public Integer getQtrIdJsp3() {
		return qtrIdJsp3;
	}

	public void setQtrIdJsp3(Integer qtrIdJsp3) {
		this.qtrIdJsp3 = qtrIdJsp3;
	}

	public List<AdditionalFacultyProgressDetail> getAdditionalFacultyProgressDetail() {
		return additionalFacultyProgressDetail;
	}

	public void setAdditionalFacultyProgressDetail(List<AdditionalFacultyProgressDetail> additionalFacultyProgressDetail) {
		this.additionalFacultyProgressDetail = additionalFacultyProgressDetail;
	}
	
	
}