package gov.in.rgsa.entity;

import java.util.Date;
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
@Table(name="qpr_inst_infra",schema="rgsa")


@NamedQueries({
@NamedQuery(name="FETCH_QPR_INST_ACTIVITY_DEPEND_ON_QUATOR",query ="SELECT Q FROM QprInstitutionalInfrastructure Q WHERE Q.qtrId=:quatorId and Q.institutionalInfraActivivtyId=:activityId"),
@NamedQuery(name="UPDATE_QPR_INST_ACTIVITY_DEPEND_ON_QUATOR",query="UPDATE QprInstitutionalInfrastructure SET additionalRequirement=:additionalRequirement,additionalRequirementDPRC=:additionalRequirementDPRC  where qprInstInfraId=:qprInstInfraId"),
})
public class QprInstitutionalInfrastructure {

	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	@Column(name="qpr_inst_infra_id")
	private Integer qprInstInfraId;
	
	@Column(name="institutional_infra_activity_id")
	private Integer institutionalInfraActivivtyId;
	
	@Column(name="qtr_id")
	private Integer qtrId;
	
	@Column(name="additional_requirement")
	private Integer additionalRequirement;
	
	@Column(name="additional_requirement_dprc")
	private Integer additionalRequirementDPRC;
	
	@Column(name="created_by")
	private Integer createdBy;
	
	@CreationTimestamp
	@Column(name="created_on",updatable=false)
	private Date createdOn;
	
	@Column(name="last_updated_by")
	private Integer lastUpdatedBy;
	
	@UpdateTimestamp
	@Column(name="last_updated_on")
	private Date lastUpdateOn;
	
	@Column(name="is_freez")
	private Boolean isFreeze;
	
	@Column(name="menu_id")
	private Integer menuId;
	
	
	@OneToMany(fetch=FetchType.EAGER,cascade=CascadeType.ALL,mappedBy="qprInstitutionalInfrastructure")
	private List<QprInstitutionalInfraDetails> qprInstitutionalInfraDetails;


	public Integer getQprInstInfraId() {
		return qprInstInfraId;
	}


	public void setQprInstInfraId(Integer qprInstInfraId) {
		this.qprInstInfraId = qprInstInfraId;
	}


	public Integer getInstitutionalInfraActivivtyId() {
		return institutionalInfraActivivtyId;
	}


	public void setInstitutionalInfraActivivtyId(Integer institutionalInfraActivivtyId) {
		this.institutionalInfraActivivtyId = institutionalInfraActivivtyId;
	}


	public Integer getQtrId() {
		return qtrId;
	}


	public void setQtrId(Integer qtrId) {
		this.qtrId = qtrId;
	}


	public Integer getAdditionalRequirement() {
		return additionalRequirement;
	}


	public void setAdditionalRequirement(Integer additionalRequirement) {
		this.additionalRequirement = additionalRequirement;
	}


	public Integer getAdditionalRequirementDPRC() {
		return additionalRequirementDPRC;
	}


	public void setAdditionalRequirementDPRC(Integer additionalRequirementDPRC) {
		this.additionalRequirementDPRC = additionalRequirementDPRC;
	}


	public Integer getCreatedBy() {
		return createdBy;
	}


	public void setCreatedBy(Integer createdBy) {
		this.createdBy = createdBy;
	}


	public Date getCreatedOn() {
		return createdOn;
	}


	public void setCreatedOn(Date createdOn) {
		this.createdOn = createdOn;
	}


	public Integer getLastUpdatedBy() {
		return lastUpdatedBy;
	}


	public void setLastUpdatedBy(Integer lastUpdatedBy) {
		this.lastUpdatedBy = lastUpdatedBy;
	}


	public Date getLastUpdateOn() {
		return lastUpdateOn;
	}


	public void setLastUpdateOn(Date lastUpdateOn) {
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


	public List<QprInstitutionalInfraDetails> getQprInstitutionalInfraDetails() {
		return qprInstitutionalInfraDetails;
	}


	public void setQprInstitutionalInfraDetails(List<QprInstitutionalInfraDetails> qprInstitutionalInfraDetails) {
		this.qprInstitutionalInfraDetails = qprInstitutionalInfraDetails;
	}



}
