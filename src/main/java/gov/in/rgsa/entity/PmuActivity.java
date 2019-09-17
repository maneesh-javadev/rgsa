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
import org.hibernate.annotations.LazyCollection;
import org.hibernate.annotations.LazyCollectionOption;
import org.hibernate.annotations.UpdateTimestamp;
/**
 * @author MOhammad Ayaz 04/10/2018
 *
 */
@Entity
@NamedQueries({@NamedQuery(name="FETCH_PMU_ACTIVITY",
							query="SELECT pa FROM PmuActivity pa Left OUTER JOIN FETCH pa.pmuActivityDetails pad  where pa.stateCode =:stateCode and pa.yearId =:yearId and pa.userType =:userType and pa.versionNo=:versionNo order by pad.pmuDetailsId"),
				@NamedQuery(name="PMU_FREEZ_UNFREEZE",
							query="UPDATE PmuActivity SET  isFreeze=:isFreeze where pmuActivityId=:pmuActivityId"),
				 @NamedQuery(name="FETCH_PMU_APPROVED_ACTIVITY" ,query="SELECT PP from PmuActivity PP RIGHT OUTER JOIN FETCH PP.pmuActivityDetails PAD where PP.yearId=:yearId and PP.userType=:userType and PP.stateCode=:stateCode ")
				
})
@Table(name="pmu_activity",schema="rgsa")
public class PmuActivity {
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name="pmu_activity_id")
	private Integer pmuActivityId;
	
	@OneToMany(mappedBy="pmuActivity",cascade=CascadeType.ALL,fetch=FetchType.EAGER)
	private List<PmuActivityDetails> pmuActivityDetails;
	
	
	@OneToMany(mappedBy="pmuActivityDomain",cascade=CascadeType.ALL)
	@LazyCollection(LazyCollectionOption.FALSE)
	private List<PmuWiseProposedDomainExperts> pmuWiseProposedDomainExperts;
	
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
	
	@Column(name="created_by")
	private Integer createdBy;
	
	@CreationTimestamp
	@Column(name="created_on",updatable=false)
	private Timestamp createdOn;
	
	@Column(name="last_updated_by")
	private Integer lastUpdateBy;
	
	@UpdateTimestamp
	@Column(name="last_updated_on ")
	private Timestamp lastUpdateOn;

	@Column(name="is_freeze")
	private Boolean isFreeze;

	@Column(name="menu_id")
	private Integer menuId;
	
	@Column(name="is_active")
	private Boolean isActive;
	
	@Transient
	private Integer setDistrictIdPmuWise;
	
	public Integer getPmuActivityId() {
		return pmuActivityId;
	}

	public void setPmuActivityId(Integer pmuActivityId) {
		this.pmuActivityId = pmuActivityId;
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

	public Integer getLastUpdateBy() {
		return lastUpdateBy;
	}

	public void setLastUpdateBy(Integer lastUpdateBy) {
		this.lastUpdateBy = lastUpdateBy;
	}

	public Timestamp getLastUpdateOn() {
		return lastUpdateOn;
	}

	public void setLastUpdateOn(Timestamp lastUpdateOn) {
		this.lastUpdateOn = lastUpdateOn;
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

	public List<PmuActivityDetails> getPmuActivityDetails() {
		return pmuActivityDetails;
	}

	public void setPmuActivityDetails(List<PmuActivityDetails> pmuActivityDetails) {
		this.pmuActivityDetails = pmuActivityDetails;
	}

	
	public List<PmuWiseProposedDomainExperts> getPmuWiseProposedDomainExperts() {
		return pmuWiseProposedDomainExperts;
	}

	public void setPmuWiseProposedDomainExperts(List<PmuWiseProposedDomainExperts> pmuWiseProposedDomainExperts) {
		this.pmuWiseProposedDomainExperts = pmuWiseProposedDomainExperts;
	}

	public Integer getSetDistrictIdPmuWise() {
		return setDistrictIdPmuWise;
	}

	public void setSetDistrictIdPmuWise(Integer setDistrictIdPmuWise) {
		this.setDistrictIdPmuWise = setDistrictIdPmuWise;
	}

	public Boolean getIsActive() {
		return isActive;
	}

	public void setIsActive(Boolean isActive) {
		this.isActive = isActive;
	}
	
}
