package gov.in.rgsa.entity;

import java.io.Serializable;
import java.util.Date;
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

@Entity
@Table(name = "basic_info", schema = "rgsa")
@NamedQueries({
@NamedQuery(name = "FIND_BASIC_INFO_DETAILS_BY_STATE", 
query = "SELECT B FROM BasicInfo B LEFT OUTER JOIN FETCH B.basicInfoDetails LEFT OUTER JOIN FETCH B.basicInfoDefination BID LEFT OUTER JOIN FETCH B.finYear F WHERE B.finYear.yearId=:yearId and B.stateCode=:stateCode and BID.basicInfoDefinationId=:basicInfoDefinationId"),
@NamedQuery(name = "FIND_BASIC_INFO_BY_STATE", 
query = "SELECT B FROM BasicInfo B WHERE B.finYear.yearId=:yearId and B.stateCode=:stateCode"),
@NamedQuery(name="FIND_BASIC_INFO_DETAILS",query="FROM BasicInfoDetails B where B.basicInfo.basicInfoId=:basicInfoId and definationKey='27_bp' and B.basicInfo.basicInfoDefination.basicInfoDefinationId=1"),
@NamedQuery(name = "FIND_BASIC_INFO_BY_ID", 
query = "SELECT B FROM BasicInfo B WHERE B.basicInfoId=:basicInfoId"),
})


public class BasicInfo implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "basic_info_id",updatable = false, nullable = false)
	private Integer basicInfoId;
	
	@ManyToOne(fetch=FetchType.LAZY)
	@JoinColumn(name = "basic_info_defination_id",referencedColumnName="basic_info_defination_id")
	private BasicInfoDefination basicInfoDefination;
	
	
	@OneToMany(mappedBy = "basicInfo",cascade=CascadeType.ALL)
	private List<BasicInfoDetails> basicInfoDetails;
	
	@Column(name="state_code")
	private int stateCode;
	
	@Column(name="status")
	private String status;
	
	@ManyToOne(fetch=FetchType.LAZY)
	@JoinColumn(name = "year_id")
	private FinYear finYear;
	
	@Column(name="created_by")
	private int createdBy;
	
	@Column(name="created_on")
	private Date createdOn;
	
	@Column(name="last_updated_by")
	private int lastUpdatedBy;
	
	@Column(name="last_updated_on")
	private Date lastUpdatedOn;

	public Integer getBasicInfoId() {
		return basicInfoId;
	}

	public void setBasicInfoId(Integer basicInfoId) {
		this.basicInfoId = basicInfoId;
	}

	

	
	public int getStateCode() {
		return stateCode;
	}

	public void setStateCode(int stateCode) {
		this.stateCode = stateCode;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public FinYear getFinYear() {
		return finYear;
	}

	public void setFinYear(FinYear finYear) {
		this.finYear = finYear;
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

	public BasicInfoDefination getBasicInfoDefination() {
		return basicInfoDefination;
	}

	public void setBasicInfoDefination(BasicInfoDefination basicInfoDefination) {
		this.basicInfoDefination = basicInfoDefination;
	}

	public List<BasicInfoDetails> getBasicInfoDetails() {
		return basicInfoDetails;
	}

	public void setBasicInfoDetails(List<BasicInfoDetails> basicInfoDetails) {
		this.basicInfoDetails = basicInfoDetails;
	}
	
	
	
	
	
}
