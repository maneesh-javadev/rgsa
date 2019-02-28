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
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Transient;

import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;





@Entity
@Table(name = "iec_activity", schema = "rgsa")
@NamedQueries({@NamedQuery(name="FETCH_Iec_Activity",query=" FROM IecActivity IA left outer join fetch  IA.iecActivityDetails IAD where IA.stateCode=:stateCode and IA.yearId=:yearId and IA.userType=:userType"),
@NamedQuery(name="REMOVE_Iec_Activity",
query="Delete FROM IecActivity where id=:id"),})
@NamedQuery(name="FETCH_IEC_APPROVED_ACTIVITY" ,query="SELECT IA from IecActivity IA RIGHT OUTER JOIN FETCH IA.iecActivityDetails IAD where IA.yearId=:yearId and IAD.isActive='TRUE' and IA.userType=:userType and IA.stateCode=:stateCode and IAD.isApproved='TRUE' ")

public class IecActivity implements Serializable {

	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "id")
	private Integer id;

	@Transient
	private Integer idToDelete;
	
	@OneToMany(mappedBy="iecActivity",cascade=CascadeType.ALL,fetch=FetchType.EAGER)
	private List<IecActivityDetails> iecActivityDetails;

	@Column(name = "state_code")
	private int stateCode;

	@Column(name = "year_id")
	private int yearId;

	@Column(name = "version_no")
	private int versionNo;

	@Column(name="created_on",updatable=false)
	@CreationTimestamp
	private Timestamp createdOn;

	@Transient
	private String dbFileName;
	
	@Column(name="is_freez")
	private Boolean isFreez;
	
	@Column(name = "created_by")
	private int createdBy;

	@Column(name = "user_type")
	private String userType;


	
	@Column(name = "last_updated_by")
	private int lastUpdatedBy;
	
	@Column(name="last_updated_on")
	@UpdateTimestamp
	private Timestamp lastUpdatedOn;

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public int getStateCode() {
		return stateCode;
	}

	public void setStateCode(int stateCode) {
		this.stateCode = stateCode;
	}

	public int getYearId() {
		return yearId;
	}

	public void setYearId(int yearId) {
		this.yearId = yearId;
	}

	public int getVersionNo() {
		return versionNo;
	}

	public void setVersionNo(int versionNo) {
		this.versionNo = versionNo;
	}

	public int getCreatedBy() {
		return createdBy;
	}

	public void setCreatedBy(int createdBy) {
		this.createdBy = createdBy;
	}

	public String getUserType() {
		return userType;
	}

	public void setUserType(String userType) {
		this.userType = userType;
	}

	public int getLastUpdatedBy() {
		return lastUpdatedBy;
	}


	public void setLastUpdatedBy(int lastUpdatedBy) {
		this.lastUpdatedBy = lastUpdatedBy;
	}


	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	public Integer getIdToDelete() {
		return idToDelete;
	}

	public void setIdToDelete(Integer idToDelete) {
		this.idToDelete = idToDelete;
	}

	public List<IecActivityDetails> getIecActivityDetails() {
		return iecActivityDetails;
	}

	public void setIecActivityDetails(List<IecActivityDetails> iecActivityDetails) {
		this.iecActivityDetails = iecActivityDetails;
	}

	public Timestamp getCreatedOn() {
		return createdOn;
	}

	public void setCreatedOn(Timestamp createdOn) {
		this.createdOn = createdOn;
	}

	public String getDbFileName() {
		return dbFileName;
	}

	public void setDbFileName(String dbFileName) {
		this.dbFileName = dbFileName;
	}

	public Boolean getIsFreez() {
		return isFreez;
	}

	public void setIsFreez(Boolean isFreez) {
		this.isFreez = isFreez;
	}

	public Timestamp getLastUpdatedOn() {
		return lastUpdatedOn;
	}

	public void setLastUpdatedOn(Timestamp lastUpdatedOn) {
		this.lastUpdatedOn = lastUpdatedOn;
	}


}