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
import javax.persistence.NamedNativeQuery;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Transient;

import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;

@Entity
@Table(name="qpr_e_enablement" ,schema="rgsa")
@NamedQueries ({@NamedQuery(name="FETCH_QPR_ENABLEMENT_REPORT_DETAILS", query="Select QE from QprEnablement QE RIGHT OUTER JOIN FETCH QE.qprEnablementDetails QED where QE.eEnablement.eEnablementId=:eEnablementId AND QE.quarterDuration.qtrId=:qtrId AND QED.districtCode =:districtCode"),
@NamedQuery(name="FETCH_QPR_ENABLEMENT_REPORT_BASED_ID", query="Select  QE from QprEnablement QE  where QE.eEnablement.eEnablementId=:eEnablementId"),
@NamedQuery(name="FETCH_ENABLEMENT_QPR_ACT_BY_QTR_ID_AND_ACT_ID",query="from QprEnablement where eEnablement.eEnablementId=:eEnablementId and quarterDuration.qtrId!=:quarterId"),
@NamedQuery(name="FETCH_QPR_ENABLEMENT_REPORT_DETAILS_ID", query="Select QE from QprEnablement QE RIGHT OUTER JOIN FETCH QE.qprEnablementDetails QED where QE.eEnablement.eEnablementId=:eEnablementId AND QE.quarterDuration.qtrId=:qtrId")

})
public class QprEnablement  implements IFreezable{
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name="qpr_e_enablement_id")
	private Integer qprEEnablementId;
	
	
	@Column(name="additional_requirement")
	private Integer additionalRequirement;
	
	@ManyToOne(fetch=FetchType.LAZY)
	@JoinColumn(name="e_enablement_id")
	private EEnablement eEnablement;


	@ManyToOne(fetch=FetchType.LAZY)
	@JoinColumn(name="qtr_id")
	private QuarterDuration quarterDuration;
	
	
	@OneToMany(cascade=CascadeType.ALL,mappedBy="qprEnablement",fetch=FetchType.EAGER)
	private List<QprEnablementDetails> qprEnablementDetails;


	@Column(name="created_by")
	private Integer createdBy;
	
	@Column(name="created_on",updatable=false)
	@CreationTimestamp
	private Timestamp createdOn;
	
	@Column(name="last_updated_by")
	private Integer lastUpdatedBy;
	
	@Column(name="last_updated_on")
	@UpdateTimestamp
	private Timestamp lastUpdatedOn;
	
	
	@Column(name="menu_id")
	private Integer menuId;
	
	@Column(name="is_freez")
	private Boolean isFreeze;
	
	@Transient
	private Integer districtId;
	
	@Transient
	private Integer qrtId;
	
	@Transient
	private String origin;
	
	
	public Integer getQprEEnablementId() {
		return qprEEnablementId;
	}

	public void setQprEEnablementId(Integer qprEEnablementId) {
		this.qprEEnablementId = qprEEnablementId;
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

	public Integer getMenuId() {
		return menuId;
	}

	public void setMenuId(Integer menuId) {
		this.menuId = menuId;
	}

	public Integer getDistrictId() {
		return districtId;
	}

	public void setDistrictId(Integer districtId) {
		this.districtId = districtId;
	}

	public EEnablement geteEnablement() {
		return eEnablement;
	}

	public void seteEnablement(EEnablement eEnablement) {
		this.eEnablement = eEnablement;
	}

	public List<QprEnablementDetails> getQprEnablementDetails() {
		return qprEnablementDetails;
	}

	public void setQprEnablementDetails(List<QprEnablementDetails> qprEnablementDetails) {
		this.qprEnablementDetails = qprEnablementDetails;
	}

	public Integer getQrtId() {
		return qrtId;
	}

	public void setQrtId(Integer qrtId) {
		this.qrtId = qrtId;
	}

	public QuarterDuration getQuarterDuration() {
		return quarterDuration;
	}

	public void setQuarterDuration(QuarterDuration quarterDuration) {
		this.quarterDuration = quarterDuration;
	}

	public String getOrigin() {
		return origin;
	}

	public void setOrigin(String origin) {
		this.origin = origin;
	}

	public Boolean getIsFreeze() {
		return isFreeze;
	}

	public void setIsFreeze(Boolean isFreeze) {
		this.isFreeze = isFreeze;
	}

	


}
