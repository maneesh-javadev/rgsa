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
import org.hibernate.annotations.LazyCollection;
import org.hibernate.annotations.LazyCollectionOption;
import org.hibernate.annotations.UpdateTimestamp;

@Entity
@Table(name="qpr_inst_infra_hr", schema="rgsa")
@NamedQueries ({@NamedQuery(name="FETCH_Additional_Faculty_progress_report_DETAILS", query="Select AFP from AdditionalFacultyProgress AFP RIGHT OUTER JOIN FETCH AFP.additionalFacultyProgressDetail AFPD where AFP.institueInfraHrActivity.instituteInfraHrActivityId=:instituteInfraHrActivityId AND AFP.quarterDuration.qtrId=:qtrId order by AFPD.qprInstInfraHrDetailsId asc"),
@NamedQuery(name="FETCH_Additional_Facult_progress_report_BASED_ID", query="Select AFP from AdditionalFacultyProgress AFP  where AFP.institueInfraHrActivity.instituteInfraHrActivityId=:instituteInfraHrActivityId"),
@NamedQuery(name="FETCH_HR_SUPPORT_ACT_QTR_ID_AND_ACT_ID",query="from AdditionalFacultyProgress where institueInfraHrActivity.instituteInfraHrActivityId=:instituteInfraHrActivityId and quarterDuration.qtrId !=:quarterId")
})
public class AdditionalFacultyProgress  implements IFreezable{

	

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name="qpr_inst_infra_hr_id")
	private Integer qprInstInfraHrId;
			
	@ManyToOne(fetch=FetchType.LAZY)
	@JoinColumn(name="institue_infra_hr_activity_id")
	private InstitueInfraHrActivity institueInfraHrActivity;
	
	@ManyToOne(fetch=FetchType.LAZY)
	@JoinColumn(name="qtr_id")
	private QuarterDuration quarterDuration;
	
	@OneToMany(cascade=CascadeType.ALL,mappedBy="additionalFacultyProgress",fetch=FetchType.EAGER)
	private List<AdditionalFacultyProgressDetail> additionalFacultyProgressDetail;
	
	@OneToMany(cascade = CascadeType.ALL,mappedBy = "additionalFacultyProgress")
	@LazyCollection(LazyCollectionOption.FALSE)
	private List<QprTiWiseDomainExpert> qprTiWiseDomainExpert; 

	@Column(name="additional_req_sprc")
	private Integer additionalReqSprc;
	
	@Column(name="additional_req_dprc")
	private Integer additionalReqDprc;
	
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
	
	@Column(name="is_freez")
	private Boolean isFreeze;

	@Transient
	private Integer qtrIdJsp3;
	
	@Transient
	private String origin;

	public Integer getQprInstInfraHrId() {
		return qprInstInfraHrId;
	}

	public void setQprInstInfraHrId(Integer qprInstInfraHrId) {
		this.qprInstInfraHrId = qprInstInfraHrId;
	}

	
	public InstitueInfraHrActivity getInstitueInfraHrActivity() {
		return institueInfraHrActivity;
	}

	public void setInstitueInfraHrActivity(InstitueInfraHrActivity institueInfraHrActivity) {
		this.institueInfraHrActivity = institueInfraHrActivity;
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

	public Integer getQtrIdJsp3() {
		return qtrIdJsp3;
	}

	public void setQtrIdJsp3(Integer qtrIdJsp3) {
		this.qtrIdJsp3 = qtrIdJsp3;
	}

	public List<AdditionalFacultyProgressDetail> getAdditionalFacultyProgressDetail() {
		return additionalFacultyProgressDetail;
	}

	public void setAdditionalFacultyProgressDetail(List<AdditionalFacultyProgressDetail> additionalFacultyProgressDetail) {
		this.additionalFacultyProgressDetail = additionalFacultyProgressDetail;
	}

	public String getOrigin() {
		return origin;
	}

	public void setOrigin(String origin) {
		this.origin = origin;
	}

	public Integer getAdditionalReqSprc() {
		return additionalReqSprc;
	}

	public void setAdditionalReqSprc(Integer additionalReqSprc) {
		this.additionalReqSprc = additionalReqSprc;
	}

	public Integer getAdditionalReqDprc() {
		return additionalReqDprc;
	}

	public void setAdditionalReqDprc(Integer additionalReqDprc) {
		this.additionalReqDprc = additionalReqDprc;
	}

	public List<QprTiWiseDomainExpert> getQprTiWiseDomainExpert() {
		return qprTiWiseDomainExpert;
	}

	public void setQprTiWiseDomainExpert(List<QprTiWiseDomainExpert> qprTiWiseDomainExpert) {
		this.qprTiWiseDomainExpert = qprTiWiseDomainExpert;
	}
	
	
}
