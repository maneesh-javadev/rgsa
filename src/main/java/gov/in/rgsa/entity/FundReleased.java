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
import javax.persistence.NamedQuery;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Transient;

import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;

/**
 * @author Aashish Barua
 *
 */
@Entity
@Table(name="fund_released",schema="rgsa")
@NamedQuery(name="FETCH_FUND_RELEASE_DATA",query="from FundReleased where planCode=:planCode")
public class FundReleased {
	
	@Id
	@Column(name="fund_released_id" , updatable = false , nullable = false)
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private Integer fundReleasedId;
	
	@Column(name="plan_code")
	private Integer planCode;
	
	@Column(name="created_by")
	private Integer createdBy;
	
	@CreationTimestamp
	@Column(name="created_on" , updatable = false)
	private Timestamp createdOn;

	@Column(name="last_updated_by")
	private Integer lastUpdatedBy;
	
	@UpdateTimestamp
	@Column(name="last_updated_on")
	private Timestamp lastUpdatedOn;
	
	@OneToMany(cascade = CascadeType.ALL , mappedBy = "fundReleased" , fetch = FetchType.EAGER)
	private List<FundReleasedDetails> fundReleasedDetails;
	
	@Transient
	private Integer finYearId;
	
	@Transient
	private Integer stateCode;
	
	@Transient
	private String msg;

	public Integer getFundReleasedId() {
		return fundReleasedId;
	}

	public void setFundReleasedId(Integer fundReleasedId) {
		this.fundReleasedId = fundReleasedId;
	}

	public Integer getPlanCode() {
		return planCode;
	}

	public void setPlanCode(Integer planCode) {
		this.planCode = planCode;
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

	public List<FundReleasedDetails> getFundReleasedDetails() {
		return fundReleasedDetails;
	}

	public void setFundReleasedDetails(List<FundReleasedDetails> fundReleasedDetails) {
		this.fundReleasedDetails = fundReleasedDetails;
	}

	public Integer getFinYearId() {
		return finYearId;
	}

	public void setFinYearId(Integer finYearId) {
		this.finYearId = finYearId;
	}

	public Integer getStateCode() {
		return stateCode;
	}

	public void setStateCode(Integer stateCode) {
		this.stateCode = stateCode;
	}

	public String getMsg() {
		return msg;
	}

	public void setMsg(String msg) {
		this.msg = msg;
	}
}
