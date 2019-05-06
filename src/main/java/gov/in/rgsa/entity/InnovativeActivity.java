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
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Transient;

import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;

/**
 * @author Mohammad Ayaz 20/08/2018
 *
 */

@Entity
@Table(name="innovative_activity", schema="rgsa")
@NamedQueries({@NamedQuery(name="FETCH_INNOVATIVE_ACTIVITY",
query="SELECT INNO FROM InnovativeActivity INNO where stateCode=:stateCode and yearId=:yearId and userType=:userType"),
@NamedQuery(name="DELETE_INNOVATIVE_ACTIVITY",
query="Delete FROM InnovativeActivity where innovativeActivityId=:innovativeActivityId"),
@NamedQuery(name="FETCH_INNOVATIVE_ACTIVITY_APPROVED_ACTIVITY" ,query="SELECT IA from InnovativeActivity IA RIGHT OUTER JOIN FETCH IA.innovativeActivityDetails IAD where IA.yearId=:yearId and IA.userType=:userType and IA.stateCode=:stateCode ")


})
public class InnovativeActivity {
	
	@Id
	@Column(name="innovative_activity_id" ,nullable=false , updatable =false)
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private Integer innovativeActivityId;
	
	@OneToMany(cascade=CascadeType.ALL,mappedBy="innovativeActivity",fetch=FetchType.EAGER)
	private List<InnovativeActivityDetails> innovativeActivityDetails;
	
	@Column(name="additional_requirement")
	private Integer additioinalRequirements;
	
	@Column(name="state_code")
	private Integer stateCode;
	
	@Column(name="year_id")
	private Integer yearId;
	
	@Column(name="user_type")
	private Character userType;
	
	@Column(name="version_no")
	private Integer versionId;
	
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
	
	@Transient
	private String path;
	
	@Transient
	private String dbFileName;
	
	@Transient
	private Integer idToDelete;
	
	public String getPath() {
		return path;
	}

	public void setPath(String path) {
		this.path = path;
	}

	public Integer getInnovativeActivityId() {
		return innovativeActivityId;
	}

	public void setInnovativeActivityId(Integer innovativeActivityId) {
		this.innovativeActivityId = innovativeActivityId;
	}

	public Integer getAdditioinalRequirements() {
		return additioinalRequirements;
	}

	public void setAdditioinalRequirements(Integer additioinalRequirements) {
		this.additioinalRequirements = additioinalRequirements;
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

	public Integer getVersionId() {
		return versionId;
	}

	public void setVersionId(Integer versionId) {
		this.versionId = versionId;
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

	public List<InnovativeActivityDetails> getInnovativeActivityDetails() {
		return innovativeActivityDetails;
	}

	public void setInnovativeActivityDetails(List<InnovativeActivityDetails> innovativeActivityDetails) {
		this.innovativeActivityDetails = innovativeActivityDetails;
	}

	public String getDbFileName() {
		return dbFileName;
	}

	public void setDbFileName(String dbFileName) {
		this.dbFileName = dbFileName;
	}

	public Integer getIdToDelete() {
		return idToDelete;
	}

	public void setIdToDelete(Integer idToDelete) {
		this.idToDelete = idToDelete;
	}

	public Boolean getIsFreeze() {
		return isFreeze;
	}

	public void setIsFreeze(Boolean isFreeze) {
		this.isFreeze = isFreeze;
	}

	public Character getUserType() {
		return userType;
	}

	public void setUserType(Character userType) {
		this.userType = userType;
	}
	
}
