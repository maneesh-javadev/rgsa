package gov.in.rgsa.entity;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name="status_of_e_governance",schema="rgsa")
public class StatusOfEGovernance implements Serializable{
	
	/**
	 * @Monty Garg
	 */
	private static final long serialVersionUID = 1L;
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "status_of_e_governance_id",updatable = false, nullable = false)
	private Integer statusOfEGovernanceId;
	
	
	@Column(name="level")
	private String level;
	
	@Column(name="year_id")
	private int yearId;
	
	@Column(name="state_code")
	private int stateCode;
	
	@Column(name="entity_code")
	private int entityCode;
	
	@Column(name="version_no")
	private int versionNo;
	
	@Column(name="status")
	private String status;
	
	@Column(name="created_by")
	private int createdBy;
	
	@Column(name="created_on")
	private Date createdOn; 
	
	
	@Column(name="last_updated_by")
	private int lastUpdatedBy;
	
	@Column(name="last_updated_on")
	private Date lastUpdatedOn; 
	
	

	public Integer getStatusOfEGovernanceId() {
		return statusOfEGovernanceId;
	}

	public void setStatusOfEGovernanceId(Integer statusOfEGovernanceId) {
		this.statusOfEGovernanceId = statusOfEGovernanceId;
	}

	public String getLevel() {
		return level;
	}

	public void setLevel(String level) {
		this.level = level;
	}

	public int getYearId() {
		return yearId;
	}

	public void setYearId(int yearId) {
		this.yearId = yearId;
	}

	public int getStateCode() {
		return stateCode;
	}

	public void setStateCode(int stateCode) {
		this.stateCode = stateCode;
	}

	public int getEntityCode() {
		return entityCode;
	}

	public void setEntityCode(int entityCode) {
		this.entityCode = entityCode;
	}

	public int getVersionNo() {
		return versionNo;
	}

	public void setVersionNo(int versionNo) {
		this.versionNo = versionNo;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public int getCreatedBy() {
		return createdBy;
	}

	public void setCreatedBy(int createdBy) {
		this.createdBy = createdBy;
	}

	public Date getCreatedOn() {
		return createdOn;
	}

	public void setCreatedOn(Date createdOn) {
		this.createdOn = createdOn;
	}

	public int getLastUpdatedBy() {
		return lastUpdatedBy;
	}

	public void setLastUpdatedBy(int lastUpdatedBy) {
		this.lastUpdatedBy = lastUpdatedBy;
	}

	public Date getLastUpdatedOn() {
		return lastUpdatedOn;
	}

	public void setLastUpdatedOn(Date lastUpdatedOn) {
		this.lastUpdatedOn = lastUpdatedOn;
	}
	
	

}
