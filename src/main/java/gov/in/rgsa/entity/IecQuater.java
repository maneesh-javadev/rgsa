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
import org.hibernate.annotations.UpdateTimestamp;

@Entity
@Table(name= "qpr_iec" , schema="rgsa")
@NamedQueries ({@NamedQuery(name="FETCH_IEC_REPORT_DETAILS", query="Select IQ from IecQuater IQ RIGHT OUTER JOIN FETCH IQ.iecQuaterDetails IQD where IQ.iecActivity.id=:id AND IQ.quarterDuration.qtrId=:qtrId  order by IQD.qprIecDetailsId asc"),
@NamedQuery(name="FETCH_IEC__REPORT_BASED_ID", query="Select IQ from IecQuater IQ where IQ.iecActivity.id=:id")
})
public class IecQuater {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name="qpr_iec_id")
	private Integer qprIecId;
			
	@ManyToOne(fetch=FetchType.LAZY)
	@JoinColumn(name="id")
	private IecActivity iecActivity;

	
	@ManyToOne(fetch=FetchType.LAZY)
	@JoinColumn(name="qtr_id")
	private QuarterDuration quarterDuration;
	
	@OneToMany(cascade=CascadeType.ALL,mappedBy="iecQuater",fetch=FetchType.EAGER)
	private List<IecQuaterDetails> iecQuaterDetails;

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
	
	@Transient
	private Integer qtrId;
	
	
	@Column(name="is_freeze")
	private Boolean isFreeze;


	public Integer getQprIecId() {
		return qprIecId;
	}


	public void setQprIecId(Integer qprIecId) {
		this.qprIecId = qprIecId;
	}


	public Integer getQtrId() {
		return qtrId;
	}


	public void setQtrId(Integer qtrId) {
		this.qtrId = qtrId;
	}


	public IecActivity getIecActivity() {
		return iecActivity;
	}


	public void setIecActivity(IecActivity iecActivity) {
		this.iecActivity = iecActivity;
	}


	public QuarterDuration getQuarterDuration() {
		return quarterDuration;
	}


	public void setQuarterDuration(QuarterDuration quarterDuration) {
		this.quarterDuration = quarterDuration;
	}


	public List<IecQuaterDetails> getIecQuaterDetails() {
		return iecQuaterDetails;
	}


	public void setIecQuaterDetails(List<IecQuaterDetails> iecQuaterDetails) {
		this.iecQuaterDetails = iecQuaterDetails;
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


	public Boolean getIsFreeze() {
		return isFreeze;
	}


	public void setIsFreeze(Boolean isFreeze) {
		this.isFreeze = isFreeze;
	}

	
}
