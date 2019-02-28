package gov.in.rgsa.entity;


import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.NamedQuery;
import javax.persistence.Table;
import javax.persistence.Transient;

@Entity
@Table(name="trg_extend_coverage",schema="rgsa")
@NamedQuery(name="FETCH_Extent_Of_Coverage", query="SELECT E FROM ExtentOfCoverage E where stateCode =:stateCode and yearId =:yearId and userType =:userType")
public class ExtentOfCoverage {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name="trg_extend_coverage_id")
	public Integer coverageId;
	
	@Column(name="state_code")
	public Integer stateCode;
	
	@Column(name="year_id")
	public Integer yearId;
	
	@Column(name="version_no")
	public Integer versionNo;
	
	
	@Column(name="user_type")
	public String userType;
	
	

	@Column(name="created_by")
	public Integer createdBy;
	
	@Column(name="created_on")
	public Date createdOn;
	
	@Column(name="last_updated_by")
	public Integer lastUpdatedBy;
	
	@Column(name="last_updated_on")
	public Date lastUpdatedOn;
	
	

	@Column(name="is_freeze")
	public Boolean isfreez;

	@Transient
	private String dbFileName;

	public Integer getCoverageId() {
		return coverageId;
	}

	public void setCoverageId(Integer coverageId) {
		this.coverageId = coverageId;
	}

	public Integer getStateCode() {
		return stateCode;
	}

	public void setStateCode(Integer stateCode) {
		this.stateCode = stateCode;
	}

	public Integer getyearId() {
		return yearId;
	}

	public void setyearId(Integer yearId) {
		this.yearId = yearId;
	}

	public Integer getVersionNo() {
		return versionNo;
	}

	public void setVersionNo(Integer versionNo) {
		this.versionNo = versionNo;
	}

	public String getUserType() {
		return userType;
	}

	public void setUserType(String userType) {
		this.userType = userType;
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

	public Date getLastUpdatedOn() {
		return lastUpdatedOn;
	}

	public void setLastUpdatedOn(Date lastUpdatedOn) {
		this.lastUpdatedOn = lastUpdatedOn;
	}

	public Integer getYearId() {
		return yearId;
	}

	public void setYearId(Integer yearId) {
		this.yearId = yearId;
	}

	public Boolean getIsfreez() {
		return isfreez;
	}

	public void setIsfreez(Boolean isfreez) {
		this.isfreez = isfreez;
	}



	public String getDbFileName() {
		return dbFileName;
	}

	public void setDbFileName(String dbFileName) {
		this.dbFileName = dbFileName;
	}

}
