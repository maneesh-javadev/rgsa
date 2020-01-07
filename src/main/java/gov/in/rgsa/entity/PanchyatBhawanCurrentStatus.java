package gov.in.rgsa.entity;

import java.io.Serializable;
import java.sql.Timestamp;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.OneToMany;
import javax.persistence.Table;

import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;

/**
 * 
 * @author sourabh
 *
 */

@Entity
@Table(name="panchayat_bhawan_currentstatus", schema = "rgsa")

@NamedQueries({
	@NamedQuery(name="FETCH_PANCHAYAT_BHAWAN_CURRENTSTATUS",query="SELECT scs FROM PanchyatBhawanCurrentStatus scs where stateCode=:stateCode and yearId=:yearId and userType=:userType")
,
@NamedQuery(name="FETCH_PANCHAYAT_BHAWAN_CURRENTSTATUS_DETAILS",query="FROM PanchyatBhawanCurrentStatus PBCS left outer join fetch PBCS.panchayatBhawanCurrentStatusDetails pbcsd where pbcsd.localBodyCode in (:localBodyCodeList)")
})

public class PanchyatBhawanCurrentStatus implements Serializable{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 2661325247120724427L;

	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	@Column(name="panchayat_bhawan_cs_id",updatable=false,nullable=false)
	private Integer panchayat_bhawan_currentstatus_id;
	
	@Column(name="state_code")
	private Integer stateCode;
	
	@Column(name="year_id")
	private Integer yearId;
	
	@Column(name="user_type")
	private Character userType;
	
	@Column(name="created_by")
	private Integer createdBy;
	
	@CreationTimestamp
	@Column(name="created_on",updatable=false)
	private Timestamp createdOn;
	
	@Column(name="last_updated_by")
	private Integer lastUpdatedBy;
	
	@UpdateTimestamp
	@Column(name="last_updated_on")
	private Timestamp lastUpdatedOn;
	
	@Column(name="is_freeze")
	private Boolean isFreeze;
	
	@OneToMany(mappedBy="panchyatBhawanCurrentStatus",cascade=CascadeType.ALL)
	private List<PanchyatBhawanCurrentStatusDetails> panchayatBhawanCurrentStatusDetails;

	public Integer getPanchayat_bhawan_currentstatus_id() {
		return panchayat_bhawan_currentstatus_id;
	}

	public void setPanchayat_bhawan_currentstatus_id(Integer panchayat_bhawan_currentstatus_id) {
		this.panchayat_bhawan_currentstatus_id = panchayat_bhawan_currentstatus_id;
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

	public Character getUserType() {
		return userType;
	}

	public void setUserType(Character userType) {
		this.userType = userType;
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

	public List<PanchyatBhawanCurrentStatusDetails> getPanchayatBhawanCurrentStatusDetails() {
		return panchayatBhawanCurrentStatusDetails;
	}

	public void setPanchayatBhawanCurrentStatusDetails(
			List<PanchyatBhawanCurrentStatusDetails> panchayatBhawanCurrentStatusDetails) {
		this.panchayatBhawanCurrentStatusDetails = panchayatBhawanCurrentStatusDetails;
	}

}