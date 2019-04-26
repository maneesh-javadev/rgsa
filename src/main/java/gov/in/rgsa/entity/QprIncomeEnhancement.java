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
import org.hibernate.annotations.LazyCollection;
import org.hibernate.annotations.LazyCollectionOption;
import org.hibernate.annotations.UpdateTimestamp;

/**
 * @author Mohammad Ayaz 28/12/2018
 *
 */
@Entity
@Table(name="qpr_income_enhancement" , schema="rgsa")
@NamedQueries({
@NamedQuery(name="UPDATE_QPR_FRZUNFREEZ_STATUS", query="UPDATE QprIncomeEnhancement SET  isFreeze=:isFreeze where qprIncomeEnhancementId=:qprIncomeEnhancementId"),
@NamedQuery(name="QPR_INCM_ENHNCMNT_REPORT_BASED_ON_QUARTER", query="Select QIE from QprIncomeEnhancement QIE where QIE.quarterDuration.qtrId=:quarterId and QIE.incomeEnhancementActivity.incomeEnhancementId=:incomeEnhancementId")
})
public class QprIncomeEnhancement {
	
	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	@Column(name="qpr_income_enhancement_id",nullable=false,updatable=false)
	private Integer qprIncomeEnhancementId;
	
	@ManyToOne
	@JoinColumn(name="income_enhancement_id")
	private IncomeEnhancementActivity incomeEnhancementActivity;
	
	@OneToMany(mappedBy="qprIncomeEnhancement",cascade=CascadeType.ALL)
	@LazyCollection(LazyCollectionOption.FALSE)
	private List<QprIncomeEnhancementDetails> qprIncomeEnhancementDetails;
	

	@ManyToOne
	@JoinColumn(name="qtr_id")
	private QuarterDuration quarterDuration;
	
	@Column(name="created_by",updatable=false)
	private Integer createdBy;
	
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
	
	@Column(name="menu_id")
	private Integer menuId;
	
	@Transient
	private Integer showQqrtrId;

	public Integer getShowQqrtrId() {
		return showQqrtrId;
	}

	public void setShowQqrtrId(Integer showQqrtrId) {
		this.showQqrtrId = showQqrtrId;
	}

	public List<QprIncomeEnhancementDetails> getQprIncomeEnhancementDetails() {
		return qprIncomeEnhancementDetails;
	}
	
	public void setQprIncomeEnhancementDetails(List<QprIncomeEnhancementDetails> qprIncomeEnhancementDetails) {
		this.qprIncomeEnhancementDetails = qprIncomeEnhancementDetails;
	}
	
	public Integer getQprIncomeEnhancementId() {
		return qprIncomeEnhancementId;
	}

	public void setQprIncomeEnhancementId(Integer qprIncomeEnhancementId) {
		this.qprIncomeEnhancementId = qprIncomeEnhancementId;
	}

	public IncomeEnhancementActivity getIncomeEnhancementActivity() {
		return incomeEnhancementActivity;
	}

	public void setIncomeEnhancementActivity(IncomeEnhancementActivity incomeEnhancementActivity) {
		this.incomeEnhancementActivity = incomeEnhancementActivity;
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
	
}
