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
import javax.persistence.Transient;

import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;


/**
 * @author Mohammad Ayaz 18/09/2018
 *
 */
@Entity
@Table(name="income_enhancement_activity",schema="rgsa")
@NamedQueries({@NamedQuery(name="FETCH_ALL_INCOME_ENHNCMNT_ACTIVITY",
						query="from IncomeEnhancementActivity where stateCode=:stateCode and yearId=:yearId and userType=:userType"),
				@NamedQuery(name="UPDATE_FRZUNFREEZ_STATUS",
					query="UPDATE IncomeEnhancementActivity SET  isFreeze=:isFreeze where incomeEnhancementId=:incomeEnhancementId"),
				@NamedQuery(name="DELETE_INCM_ENHNCMNT_ACTIVITY",
					query="delete from IncomeEnhancementActivity where incomeEnhancementId=:incomeEnhancementId")
})
public class IncomeEnhancementActivity {

	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	@Column(name="income_enhancement_id",nullable=false,updatable=false)
	private Integer incomeEnhancementId;
	
	@OneToMany(mappedBy="incomeEnhancementActivity",cascade=CascadeType.ALL,fetch=FetchType.LAZY)
	private List<IncomeEnhancementDetails> incomeEnhancementDetails;
	
	@Column(name="state_code")
	private Integer stateCode;
	
	@Column(name="year_id")
	private Integer yearId;
	
	@Column(name="version_no")
	private Integer versionNo;
	
	@Column(name="user_type")
	private Character userType;
	
	@Column(name="additional_requirement")
	private Integer additionalRequirement;
	
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
	private Integer setBlockId;
	
	@Transient
	private String path;
	
	@Transient
	private String dbFileName;
	
	@Transient
	private Integer idToDelete;

	public Integer getIncomeEnhancementId() {
		return incomeEnhancementId;
	}

	public void setIncomeEnhancementId(Integer incomeEnhancementId) {
		this.incomeEnhancementId = incomeEnhancementId;
	}

	public List<IncomeEnhancementDetails> getIncomeEnhancementDetails() {
		return incomeEnhancementDetails;
	}

	public void setIncomeEnhancementDetails(List<IncomeEnhancementDetails> incomeEnhancementDetails) {
		this.incomeEnhancementDetails = incomeEnhancementDetails;
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

	public Character getUserType() {
		return userType;
	}

	public void setUserType(Character userType) {
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

	public Integer getSetBlockId() {
		return setBlockId;
	}

	public void setSetBlockId(Integer setBlockId) {
		this.setBlockId = setBlockId;
	}

	public String getPath() {
		return path;
	}

	public void setPath(String path) {
		this.path = path;
	}

	public String getDbFileName() {
		return dbFileName;
	}

	public void setDbFileName(String dbFileName) {
		this.dbFileName = dbFileName;
	}

	public Integer getIdToDelete() {
		return idToDelete;
	}

	public void setIdToDelete(Integer idToDelete) {
		this.idToDelete = idToDelete;
	}
	
	
}

