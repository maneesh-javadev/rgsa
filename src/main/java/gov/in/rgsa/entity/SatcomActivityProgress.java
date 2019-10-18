
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
import javax.persistence.OneToOne;
import javax.persistence.Table;
import javax.persistence.Transient;

import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;

@Entity
@Table(name="satcom_activity_progress_report",schema="rgsa")
//@NamedQuery(name="FETCH_SATCOM_progress_report_DETAILS", query="Select sap from SatcomActivityProgress sap join sap.satcomActivityProgressDetails where sap.satcomActivityProgressDetails.quarterDuration.qtrId=:qtrId")
//@NamedQuery(name="FETCH_SATCOM_progress_report_DETAILS",query="select sap from SatcomActivityProgress sap where sap.satcomActivityProgressDetails.quarterDuration.qtrId=:qtrId")
@NamedQueries ({@NamedQuery(name="FETCH_SATCOM_progress_report_DETAILS", query="Select SAP from SatcomActivityProgress SAP RIGHT OUTER JOIN FETCH SAP.satcomActivityProgressDetails SAPD where SAP.satcomActivity.satcomActivityId=:satcomActivityId AND SAPD.quarterDuration.qtrId=:qtrId"),
@NamedQuery(name="FETCH_SATCOM_progress_report_BASED_ID", query="Select SAP from SatcomActivityProgress SAP  where SAP.satcomActivity.satcomActivityId=:satcomActivityId")
})

public class SatcomActivityProgress implements Serializable , IFreezable{
	
	/**
	 * Rajeev
	 */
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name="satcom_activity_progress_report_id")
	private Integer satcomActivityProgressId;
			
	@ManyToOne(fetch=FetchType.LAZY)
	@JoinColumn(name="satcom_activity_id")
	private SatcomActivity satcomActivity;

	
	@Column(name="created_by")
	private Integer createdBy;
		
	@Column(name="menu_id")
	private Integer menuId;
		
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
	
	@Column(name="additional_requirement")
	private Integer additionalRequirement;
	
	@Transient
	private Integer qtrIdJsp1;
	
	@Transient
	private String origin;

	
	@OneToMany(cascade=CascadeType.ALL,mappedBy="satcomActivityProgress",fetch=FetchType.EAGER)
	private List<SatcomActivityProgressDetails> satcomActivityProgressDetails;

	public Integer getSatcomActivityProgressId() {
		return satcomActivityProgressId;
	}

	public void setSatcomActivityProgressId(Integer satcomActivityProgressId) {
		this.satcomActivityProgressId = satcomActivityProgressId;
	}
	
	public SatcomActivity getSatcomActivity() {
		return satcomActivity;
	}

	public void setSatcomActivity(SatcomActivity satcomActivity) {
		this.satcomActivity = satcomActivity;
	}

	public Integer getCreatedBy() {
		return createdBy;
	}

	public void setCreatedBy(Integer createdBy) {
		this.createdBy = createdBy;
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
	

	public List<SatcomActivityProgressDetails> getSatcomActivityProgressDetails() {
		return satcomActivityProgressDetails;
	}

	public void setSatcomActivityProgressDetails(List<SatcomActivityProgressDetails> satcomActivityProgressDetails) {
		this.satcomActivityProgressDetails = satcomActivityProgressDetails;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	public Integer getQtrIdJsp1() {
		return qtrIdJsp1;
	}

	public void setQtrIdJsp1(Integer qtrIdJsp1) {
		this.qtrIdJsp1 = qtrIdJsp1;
	}

	public String getOrigin() {
		return origin;
	}

	public void setOrigin(String origin) {
		this.origin = origin;
	}

	public Integer getAdditionalRequirement() {
		return additionalRequirement;
	}

	public void setAdditionalRequirement(Integer additionalRequirement) {
		this.additionalRequirement = additionalRequirement;
	}

	public Boolean getIsFreeze() {
		return isFreeze;
	}

	public void setIsFreeze(Boolean isFreeze) {
		this.isFreeze = isFreeze;
	}
	
}
