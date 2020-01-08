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
@Table(name="qpr_ats" , schema="rgsa")
@NamedQueries ({@NamedQuery(name="FETCH_Admin_Tech_Progress_progress_report", query="Select ATP from AdministrativeTechnicalProgress ATP RIGHT OUTER JOIN FETCH ATP.administrativeTechnicalDetailProgress ATDP where ATP.administrativeTechnicalSupport.administrativeTechnicalSupportId=:administrativeTechnicalSupportId AND ATP.quarterDuration.qtrId=:qtrId order by ATDP.atsDetailsProgressId asc"),
@NamedQuery(name="FETCH_Admin_Tech_Progress_progress_report_BASED_ID", query="Select ATP from AdministrativeTechnicalProgress ATP  where ATP.administrativeTechnicalSupport.administrativeTechnicalSupportId=:administrativeTechnicalSupportId"),
@NamedQuery(name="FETCH_ADMIN_TECH_ACT_QTR_ID_AND_ACT_ID",query="from AdministrativeTechnicalProgress where administrativeTechnicalSupport.administrativeTechnicalSupportId=:administrativeTechnicalSupportId and quarterDuration.qtrId !=:quarterId")
})
public class AdministrativeTechnicalProgress  implements IFreezable, Serializable{
	
	
	/**
	 * 
	 */
	private static final long serialVersionUID = -98068391707234698L;

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "qpr_ats_id")
	private Integer atsId;
	
	@ManyToOne(fetch=FetchType.LAZY)
	@JoinColumn(name="administrative_technical_support_id")
	private AdministrativeTechnicalSupport administrativeTechnicalSupport;
	
	@ManyToOne(fetch=FetchType.LAZY)
	@JoinColumn(name="qtr_id")
	private QuarterDuration quarterDuration;
	
	
	@Column(name = "created_by")
	private Integer createdBy;
	
	@Column(name="created_on",updatable=false)
	@CreationTimestamp
	private Timestamp createdOn;
	
	@Column(name="additional_requirement")
	private Integer additionalRequirement;
	

	@Column(name="last_updated_by")
	private Integer lastUpdatedBy;
	
	
	@Column(name="last_updated_on")
	@UpdateTimestamp
	private Timestamp lastUpdatedOn;
	
	@Column(name = "is_freeze")
	private Boolean isFreeze;
	
	@Column(name = "menu_id")
	private Integer menuId;
	
	@OneToMany(cascade=CascadeType.ALL,mappedBy="administrativeTechnicalSupportProgress",fetch=FetchType.EAGER)
	private List<AdministrativeTechnicalDetailProgress> administrativeTechnicalDetailProgress;

	@Transient
	private Integer qtrIdJsp2;
	
	@Transient
	private String origin;

	public Integer getAtsId() {
		return atsId;
	}

	public void setAtsId(Integer atsId) {
		this.atsId = atsId;
	}

	public AdministrativeTechnicalSupport getAdministrativeTechnicalSupport() {
		return administrativeTechnicalSupport;
	}

	public void setAdministrativeTechnicalSupport(AdministrativeTechnicalSupport administrativeTechnicalSupport) {
		this.administrativeTechnicalSupport = administrativeTechnicalSupport;
	}

	
	public QuarterDuration getQuarterDuration() {
		return quarterDuration;
	}

	public void setQuarterDuration(QuarterDuration quarterDuration) {
		this.quarterDuration = quarterDuration;
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

	public Integer getAdditionalRequirement() {
		return additionalRequirement;
	}

	public void setAdditionalRequirement(Integer additionalRequirement) {
		this.additionalRequirement = additionalRequirement;
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

	public List<AdministrativeTechnicalDetailProgress> getAdministrativeTechnicalDetailProgress() {
		return administrativeTechnicalDetailProgress;
	}

	public Integer getQtrIdJsp2() {
		return qtrIdJsp2;
	}

	public void setQtrIdJsp2(Integer qtrIdJsp2) {
		this.qtrIdJsp2 = qtrIdJsp2;
	}

	public void setAdministrativeTechnicalDetailProgress(
			List<AdministrativeTechnicalDetailProgress> administrativeTechnicalDetailProgress) {
		this.administrativeTechnicalDetailProgress = administrativeTechnicalDetailProgress;
	}

	public String getOrigin() {
		return origin;
	}

	public void setOrigin(String origin) {
		this.origin = origin;
	}

	
}
