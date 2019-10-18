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
 * @author Mohammad Ayaz 31/12/2018
 *
 */
@Entity
@Table(name="qpr_cb_activity" , schema="rgsa")
@NamedQueries({
@NamedQuery(name="FETCH_QPR_TRAINING_ACT_BY_QTR_ID_AND_ACT_ID",query="from QprCbActivity where capacityBuildingActivity.cbActivityId=:cbActivityId and quarterDuration.qtrId!=:quarterId"),	
@NamedQuery(name="UPDATE_QPRCBACtivity_FRZUNFREEZ_STATUS", query="UPDATE QprCbActivity SET  isFreeze=:isFreeze where qpCbActivityId=:qpCbActivityId"),
@NamedQuery(name="QPR_CAPACITY_BUILDING_REPORT_BASED_ON_QUARTER", query="Select QCA from QprCbActivity QCA where  QCA.capacityBuildingActivity.stateCode=:stateCode AND  QCA.capacityBuildingActivity.yearId=:yearId AND QCA.quarterDuration.qtrId=:quarterId AND capacityBuildingActivity.cbActivityId=:cbActivityId")
})
public class QprCbActivity  implements IFreezable{

	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	@Column(name="qpr_cb_activity_id",nullable=false,updatable=false)
	private Integer qpCbActivityId;
	
	@ManyToOne
	@JoinColumn(name="cb_activity_id")
	private CapacityBuildingActivity capacityBuildingActivity;
	
	@OneToMany(mappedBy="qprCbActivity",cascade=CascadeType.ALL)
	@LazyCollection(LazyCollectionOption.FALSE)
	private List<QprCbActivityDetails> qprCbActivityDetails;
	
	@ManyToOne
	@JoinColumn(name="qtr_id")
	private QuarterDuration quarterDuration;
	
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
	private Integer showQqrtrId=0;
	
	@Transient
	private String origin;

	public Integer getShowQqrtrId() {
		return showQqrtrId;
	}

	public Integer getQpCbActivityId() {
		return qpCbActivityId;
	}

	public void setQpCbActivityId(Integer qpCbActivityId) {
		this.qpCbActivityId = qpCbActivityId;
	}

	public CapacityBuildingActivity getCapacityBuildingActivity() {
		return capacityBuildingActivity;
	}

	public void setCapacityBuildingActivity(CapacityBuildingActivity capacityBuildingActivity) {
		this.capacityBuildingActivity = capacityBuildingActivity;
	}

	public List<QprCbActivityDetails> getQprCbActivityDetails() {
		return qprCbActivityDetails;
	}

	public void setQprCbActivityDetails(List<QprCbActivityDetails> qprCbActivityDetails) {
		this.qprCbActivityDetails = qprCbActivityDetails;
	}

	public QuarterDuration getQuarterDuration() {
		return quarterDuration;
	}

	public void setQuarterDuration(QuarterDuration quarterDuration) {
		this.quarterDuration = quarterDuration;
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

	public void setShowQqrtrId(Integer showQqrtrId) {
		this.showQqrtrId = showQqrtrId;
	}

	public String getOrigin() {
		return origin;
	}

	public void setOrigin(String origin) {
		this.origin = origin;
	}
	
	

}
