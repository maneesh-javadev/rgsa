package gov.in.rgsa.entity;

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

@Entity
@Table(name="qpr_inst_infra" ,schema="rgsa")

@NamedQueries ({@NamedQuery(name="FETCH_INSTITUTIONAL_INFRA_PROGRESS_REPORT_DETAILS", query="Select IIPP from InstitutionalInfraActivityPlanProgress IIPP RIGHT OUTER JOIN FETCH IIPP.institutionalInfraActivityProgressDetails IIPD where (IIPD.institutionalInfraActivityPlanDetails.institutionalInfraActivityDetailsId IN (:infraActivityDetailId)) AND IIPP.institutionalInfraActivityPlan.institutionalInfraActivityId=:institutionalInfraActivityId AND IIPP.quarterDuration.qtrId=:quarterId"),
@NamedQuery(name="FETCH_INSTITUTIONAL_INFRAACTIVITY_PROGRESS_REPORT_BASED_ID", query="Select IIPP from InstitutionalInfraActivityPlanProgress IIPP  where IIPP.institutionalInfraActivityPlan.institutionalInfraActivityId=:institutionalInfraActivityId")
})

public class InstitutionalInfraActivityPlanProgress {


	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	@Column(name="qpr_inst_infra_id",updatable=false,nullable=false)
	private Integer qprInstInfraId;
	
	@ManyToOne(fetch=FetchType.LAZY)
	@JoinColumn(name="institutional_infra_activity_id")
	private InstitutionalInfraActivityPlan institutionalInfraActivityPlan;

	@OneToMany(cascade=CascadeType.ALL,mappedBy="institutionalInfraActivityPlanProgress",fetch=FetchType.EAGER)
	private List<InstitutionalInfraActivityProgressDetails> institutionalInfraActivityProgressDetails;

	
	@Column(name="created_by")
	private Integer createdBy;
	
	@Column(name="created_on")
	private Integer createdOn;
	
	@Column(name="last_updated_by")
	private int lastUpdatedBy;
	
	@Column(name="additional_requirement")
	private Integer additionalRequirement;
	
	@Column(name="is_freez")
	private int isFreez;
			
	@Column(name="menu_id")
	private int menuId;
	
	@ManyToOne(fetch=FetchType.LAZY)
	@JoinColumn(name="qtr_id")
	private QuarterDuration quarterDuration;
	
	
	@Transient
	private Integer qtrIdJsp5;


	public Integer getQprInstInfraId() {
		return qprInstInfraId;
	}


	public void setQprInstInfraId(Integer qprInstInfraId) {
		this.qprInstInfraId = qprInstInfraId;
	}


	public InstitutionalInfraActivityPlan getInstitutionalInfraActivityPlan() {
		return institutionalInfraActivityPlan;
	}


	public void setInstitutionalInfraActivityPlan(InstitutionalInfraActivityPlan institutionalInfraActivityPlan) {
		this.institutionalInfraActivityPlan = institutionalInfraActivityPlan;
	}


	public Integer getCreatedBy() {
		return createdBy;
	}


	public void setCreatedBy(Integer createdBy) {
		this.createdBy = createdBy;
	}


	public Integer getCreatedOn() {
		return createdOn;
	}


	public void setCreatedOn(Integer createdOn) {
		this.createdOn = createdOn;
	}


	public int getLastUpdatedBy() {
		return lastUpdatedBy;
	}


	public void setLastUpdatedBy(int lastUpdatedBy) {
		this.lastUpdatedBy = lastUpdatedBy;
	}


	public Integer getAdditionalRequirement() {
		return additionalRequirement;
	}


	public void setAdditionalRequirement(Integer additionalRequirement) {
		this.additionalRequirement = additionalRequirement;
	}


	public int getIsFreez() {
		return isFreez;
	}


	public void setIsFreez(int isFreez) {
		this.isFreez = isFreez;
	}


	public int getMenuId() {
		return menuId;
	}


	public void setMenuId(int menuId) {
		this.menuId = menuId;
	}


	public QuarterDuration getQuarterDuration() {
		return quarterDuration;
	}


	public void setQuarterDuration(QuarterDuration quarterDuration) {
		this.quarterDuration = quarterDuration;
	}


	public Integer getQtrIdJsp5() {
		return qtrIdJsp5;
	}


	public void setQtrIdJsp5(Integer qtrIdJsp5) {
		this.qtrIdJsp5 = qtrIdJsp5;
	}
	
	

}
