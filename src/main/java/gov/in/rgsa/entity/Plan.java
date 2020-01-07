package gov.in.rgsa.entity;

import java.sql.Timestamp;

import javax.persistence.AttributeOverride;
import javax.persistence.AttributeOverrides;
import javax.persistence.Column;
import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.NamedNativeQueries;
import javax.persistence.NamedNativeQuery;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;
import javax.persistence.Transient;

import org.hibernate.annotations.CreationTimestamp;

@Entity
@NamedQueries({
	@NamedQuery(name="CURRENT_PLAN_STATUS",query="from Plan where planCode=:planCode and planStatusId=:planStatusId and yearId=:yearId and isactive=true"),
	@NamedQuery(name="PLAN_STATUS",query="from Plan where stateCode=:stateCode and planStatusId=:planStatusId and yearId=:yearId and planVersion=:planVersion"),
	@NamedQuery(name="PLAN_STATUS_LIST",query="from Plan where yearId=:yearId and planStatusId=:planStatusId and isactive=:isactive"),
	@NamedQuery(name="SHOW_HIDE_BUTTON_PLAN_STATUS",query="from Plan where stateCode=:stateCode  and yearId=:yearId and isactive=true"),


})

@NamedNativeQueries({
	@NamedNativeQuery(name="PLAN_COUNT",query="select count(*) from rgsa.plan where plan_status_id=:plan_status_id and isactive=:isactive"),
	@NamedNativeQuery(name="GET_PLAN_CURRENT",query="select * from rgsa.plan where state_code=:stateCode and year_id=:yearId order by plan_status_id desc limit 1",resultClass = Plan.class),
	@NamedNativeQuery(name="PLAN_FORWARDED_OR_NOT",query="select count(*) from rgsa.plan where plan_status_id=:plan_status_id and isactive and state_code=:stateCode and year_id=:yearId")
	// @NamedNativeQuery(name="FETCH_PLAN_STAUS_COUNT",query="select cast(count(1)  ||','|| (select count(1)  from rgsa.plan pa where pa.plan_status_id=5 and  pa.year_id=ps.year_id )||','|| 0 as character varying)as meeting_by_cec_current_year from rgsa.plan ps left join rgsa.fin_year fy on ps.year_id=fy.year_id where ps.plan_status_id in(2,4,5) and fy.finyear ilike :fin_year group by ps.year_id")
})
@Table(name="plan",schema="rgsa")
public class Plan {

	
	
	@EmbeddedId
	@AttributeOverrides({
		@AttributeOverride(name = "planCode", column = @Column(name = "plan_code", nullable = false)),
		@AttributeOverride(name = "planVersion", column = @Column(name = "plan_version", nullable = false)),
		@AttributeOverride(name = "planStatusId", column = @Column(name = "plan_status_id", nullable = false))
	})
	private PlanPK planPK;
	
	@Column(name="plan_code",insertable=false,updatable=false)
	private Integer planCode;
	
	@Column(name="plan_version",insertable=false,updatable=false)
	private Integer planVersion;
	
	@Column(name="state_code")
	private Integer stateCode;
	
	@Column(name="plan_status_id",insertable=false,updatable=false)
	private Integer planStatusId; 
	
	@Column(name="status_date")
	@CreationTimestamp
	private Timestamp statusDate;
	
	@Column(name="created_by")
	private Integer createdBy;
	
	@Column(name="year_id")
	private Integer yearId;
	
	@Column(name="created_on")
	@CreationTimestamp
	private Timestamp createdOn;
	
	@Column(name="isactive")
	private Boolean isactive;
	
	@Column(name="central_share")
	private Double centralShare;
	
	@Column(name="state_share")
	private Double stateShare;
	
	@Transient
	private String stateName;

	public PlanPK getPlanPK() {
		return planPK;
	}

	public void setPlanPK(PlanPK planPK) {
		this.planPK = planPK;
	}

	public Integer getPlanCode() {
		return planCode;
	}

	public void setPlanCode(Integer planCode) {
		this.planCode = planCode;
	}

	public Integer getPlanVersion() {
		return planVersion;
	}

	public void setPlanVersion(Integer planVersion) {
		this.planVersion = planVersion;
	}

	public Integer getStateCode() {
		return stateCode;
	}

	public void setStateCode(Integer stateCode) {
		this.stateCode = stateCode;
	}

	public Integer getPlanStatusId() {
		return planStatusId;
	}

	public void setPlanStatusId(Integer planStatusId) {
		this.planStatusId = planStatusId;
	}

	public Timestamp getStatusDate() {
		return statusDate;
	}

	public void setStatusDate(Timestamp statusDate) {
		this.statusDate = statusDate;
	}

	public Integer getCreatedBy() {
		return createdBy;
	}

	public void setCreatedBy(Integer createdBy) {
		this.createdBy = createdBy;
	}

	public Integer getYearId() {
		return yearId;
	}

	public void setYearId(Integer yearId) {
		this.yearId = yearId;
	}

	public Timestamp getCreatedOn() {
		return createdOn;
	}

	public void setCreatedOn(Timestamp createdOn) {
		this.createdOn = createdOn;
	}

	public Boolean getIsactive() {
		return isactive;
	}

	public void setIsactive(Boolean isactive) {
		this.isactive = isactive;
	}

	public Double getCentralShare() {
		return centralShare;
	}

	public void setCentralShare(Double centralShare) {
		this.centralShare = centralShare;
	}

	public Double getStateShare() {
		return stateShare;
	}

	public void setStateShare(Double stateShare) {
		this.stateShare = stateShare;
	}

	public String getStateName() {
		return stateName;
	}

	public void setStateName(String stateName) {
		this.stateName = stateName;
	}

	
}
