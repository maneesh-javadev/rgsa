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
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.OneToMany;
import javax.persistence.Table;

import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;

@Entity
@Table(name="admin_financial_data_cell_activity",schema="rgsa")
@NamedQueries({
	@NamedQuery(name="FETCH_APPROVED_ACTIVITY",query="from AdminAndFinancialDataActivity where userType=:userType and stateCode=:stateCode and yearId=:yearId and versionNo=:versionNo and isActive=true"),
	@NamedQuery(name="FETCH_ADMIN_FIN_DATA_ACTIVITY",query="select A from AdminAndFinancialDataActivity A where stateCode=:stateCode and yearId=:yearId and userType=:userType and versionNo=:versionNo and isActive=true"),
})

public class AdminAndFinancialDataActivity implements IFreezable{

	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	@Column(name="admin_financial_data_cell_activity_id")
	private Integer adminFinancialDataActivityId;
	
	@Column(name="state_code")
	private Integer stateCode;
	
	@Column(name="year_id")
	private Integer yearId;
	
	@Column(name="user_type")
	private String userType;
	
	@Column(name="additional_requirement")
	private Integer additionalRequirement;
	
	@Column(name="created_by")
	private Integer createdBy;
	
	@Column(name="last_updated_by")
	private Integer lastUpdatedBy;
	
	@Column(name="is_freeze")
	private Boolean isFreeze;
	
	@Column(name="menu_id")
	private Integer menuId;
	
	@CreationTimestamp
	@Column(name="created_on",updatable=false)
	private Timestamp createdOn;
	
	@UpdateTimestamp
	@Column(name="last_updated_on")
	private Timestamp lastUpdatedOn;
	
	@Column(name="version_no")
	private Integer versionNo;
	
	@Column(name="is_active")
	private Boolean isActive;
	
	@OneToMany(cascade=CascadeType.ALL,mappedBy="adminAndFinancialDataActivity",fetch=FetchType.EAGER)
	private List<AdminFinancialDataCellActivityDetails> adminFinancialDataCellActivityDetails;
	
	public Integer getAdminFinancialDataActivityId() {
		return adminFinancialDataActivityId;
	}

	public void setAdminFinancialDataActivityId(Integer adminFinancialDataActivityId) {
		this.adminFinancialDataActivityId = adminFinancialDataActivityId;
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

	public Integer getLastUpdatedBy() {
		return lastUpdatedBy;
	}

	public void setLastUpdatedBy(Integer lastUpdatedBy) {
		this.lastUpdatedBy = lastUpdatedBy;
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

	public Timestamp getCreatedOn() {
		return createdOn;
	}

	public void setCreatedOn(Timestamp createdOn) {
		this.createdOn = createdOn;
	}

	public Timestamp getLastUpdatedOn() {
		return lastUpdatedOn;
	}

	public void setLastUpdatedOn(Timestamp lastUpdatedOn) {
		this.lastUpdatedOn = lastUpdatedOn;
	}

	public Integer getVersionNo() {
		return versionNo;
	}

	public void setVersionNo(Integer versionNo) {
		this.versionNo = versionNo;
	}

	public List<AdminFinancialDataCellActivityDetails> getAdminFinancialDataCellActivityDetails() {
		return adminFinancialDataCellActivityDetails;
	}

	public void setAdminFinancialDataCellActivityDetails(
			List<AdminFinancialDataCellActivityDetails> adminFinancialDataCellActivityDetails) {
		this.adminFinancialDataCellActivityDetails = adminFinancialDataCellActivityDetails;
	}

	public Boolean getIsActive() {
		return isActive;
	}

	public void setIsActive(Boolean isActive) {
		this.isActive = isActive;
	}
	
	
}
