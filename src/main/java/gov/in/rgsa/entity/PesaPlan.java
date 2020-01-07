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
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Transient;

import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;

/**
 * 
 * @author sourabh
 *
 */

@Entity
@Table(name="pesa_plan", schema = "rgsa")

@NamedQuery(name="FETCH_PESA_PLAN",query="SELECT PP FROM PesaPlan PP where stateCode=:stateCode and yearId=:yearId and userType=:userType and versionNo=:versionNo and isActive=true")
public class PesaPlan implements Serializable{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 8749463751405252655L;

	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	@Column(name="pesa_plan_id",updatable=false,nullable=false)
	private Integer pesaPlanId;
	
	@Column(name="state_code")
	private Integer stateCode;
	
	@Column(name="year_id")
	private Integer yearId;
	
	@Column(name="version_no")
	private Integer versionNo;
	
	@Column(name="user_type")
	private Character userType;
	
	@Column(name="additional_requirement")
	private Double additionalRequirement;
	
	@Column(name="is_freez")
	private Boolean isFreez;
	
	@Column(name="is_active")
	private Boolean isActive;
	
	@Transient
	private List<PesaPlanDetails> pesaPlanDetails;
//	@OneToMany(mappedBy = "pesaPlan", cascade = CascadeType.ALL, orphanRemoval = true, fetch=FetchType.LAZY)
//	private List<PesaPlanDetails> pesaPlanDetails;
//	
//	@OneToMany(mappedBy = "pesaPlan", cascade = CascadeType.ALL, orphanRemoval = true, fetch=FetchType.LAZY)
//	private List<QprPesa> qprPesas;
	
	@Column(name="created_by")
	private Integer createdBy;
	
	@CreationTimestamp
	@Column(name="created_on",updatable=false)
	private Timestamp createdOn;
	
	@Column(name="last_updated_by")
	private Integer lastUpdatedBy;
	
	@UpdateTimestamp
	@Column(name="last_updated_on")
	private Timestamp lastUpdatedOn;
	
	
	@Column(name="menu_id")
	private Integer menuId;

	public Integer getPesaPlanId() {
		return pesaPlanId;
	}

	public void setPesaPlanId(Integer pesaPlanId) {
		this.pesaPlanId = pesaPlanId;
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

	public List<PesaPlanDetails> getPesaPlanDetails() {
		return pesaPlanDetails;
	}

	public void setPesaPlanDetails(List<PesaPlanDetails> pesaPlanDetails) {
		this.pesaPlanDetails = pesaPlanDetails;
	}

	public Boolean getIsFreez() {
		return isFreez;
	}

	public void setIsFreez(Boolean isFreez) {
		this.isFreez = isFreez;
	}

	public Double getAdditionalRequirement() {
		return additionalRequirement;
	}

	public void setAdditionalRequirement(Double additionalRequirement) {
		this.additionalRequirement = additionalRequirement;
	}

	public Integer getMenuId() {
		return menuId;
	}

	public void setMenuId(Integer menuId) {
		this.menuId = menuId;
	}

	public Boolean getIsActive() {
		return isActive;
	}

	public void setIsActive(Boolean isActive) {
		this.isActive = isActive;
	}
	
	

}