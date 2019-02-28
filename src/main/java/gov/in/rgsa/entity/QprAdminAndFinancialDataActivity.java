package gov.in.rgsa.entity;

import java.sql.Timestamp;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQuery;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Transient;

import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.LazyCollection;
import org.hibernate.annotations.LazyCollectionOption;
import org.hibernate.annotations.UpdateTimestamp;

@Entity
@Table(name="qpr_afp" , schema= "rgsa")
@NamedQuery(name="QPR_ADMIN_FINANCIALDATA_ACTIVITY_REPORT_BASED_ON_QUARTER", query="Select QAF from QprAdminAndFinancialDataActivity QAF where  QAF.adminAndFinancialDataActivity.stateCode=:stateCode AND  QAF.adminAndFinancialDataActivity.yearId=:yearId AND  QAF.adminAndFinancialDataActivity.userType=:userType AND QAF.quarterDuration.qtrId=:quarterId")
public class QprAdminAndFinancialDataActivity {

	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	@Column(name="qpr_afp_id",nullable=false,updatable=false)
	private Integer qprAfpId;
	
	@ManyToOne
	@JoinColumn(name="admin_financial_data_cell_activity_id")
	private AdminAndFinancialDataActivity adminAndFinancialDataActivity;
	
	@OneToMany(mappedBy="qprAdminAndFinancialDataActivity",cascade=CascadeType.ALL)
	@LazyCollection(LazyCollectionOption.FALSE)
	private List<QprAdminAndFinancialDataActivityDetails> qprAdminAndFinancialDataActivityDetails;
	

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

	public Integer getQprAfpId() {
		return qprAfpId;
	}

	public void setQprAfpId(Integer qprAfpId) {
		this.qprAfpId = qprAfpId;
	}

	public AdminAndFinancialDataActivity getAdminAndFinancialDataActivity() {
		return adminAndFinancialDataActivity;
	}

	public void setAdminAndFinancialDataActivity(AdminAndFinancialDataActivity adminAndFinancialDataActivity) {
		this.adminAndFinancialDataActivity = adminAndFinancialDataActivity;
	}

	public List<QprAdminAndFinancialDataActivityDetails> getQprAdminAndFinancialDataActivityDetails() {
		return qprAdminAndFinancialDataActivityDetails;
	}

	public void setQprAdminAndFinancialDataActivityDetails(
			List<QprAdminAndFinancialDataActivityDetails> qprAdminAndFinancialDataActivityDetails) {
		this.qprAdminAndFinancialDataActivityDetails = qprAdminAndFinancialDataActivityDetails;
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

	public Integer getShowQqrtrId() {
		return showQqrtrId;
	}

	public void setShowQqrtrId(Integer showQqrtrId) {
		this.showQqrtrId = showQqrtrId;
	}

	
}
