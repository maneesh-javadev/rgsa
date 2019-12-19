package gov.in.rgsa.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;

@Entity
@Table(name="qpr_e_enablement_details" , schema="rgsa")
@NamedQueries({
	@NamedQuery(name="FETCH_EENABLEMENT_REPORT_DETAILS_BY_LB", query="from QprEnablementDetails where localBodyCode=:localbodyCode AND qprEnablement.qprEEnablementId=:qprEEnablementId"),
	@NamedQuery(name="FETCH_EENABLEMENT_QPR_DETAILS",query="from QprEnablementDetails where qprEnablement.qprEEnablementId=:qprEEnablementId and districtCode=:dlc order by qprEEenablementDetailsId")
})

public class QprEnablementDetails {
	
	@Id
	@Column(name="qpr_e_enablement_details_id")
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Integer qprEEenablementDetailsId;
	
	
	@ManyToOne
	@JoinColumn(name="qpr_e_enablement_id")
	private QprEnablement qprEnablement;
	
	@Column(name="district_code")
	private Integer districtCode; 
	
	
	@Column(name="local_body_code")
	private Integer localBodyCode; 
	
	@Column(name="expenditure_incurred")
	private Integer expenditureIncurred;
	
	@Column(name="qpr_status")
	private Integer enablementStatus;


	public Integer getQprEEenablementDetailsId() {
		return qprEEenablementDetailsId;
	}


	public void setQprEEenablementDetailsId(Integer qprEEenablementDetailsId) {
		this.qprEEenablementDetailsId = qprEEenablementDetailsId;
	}


	public QprEnablement getQprEnablement() {
		return qprEnablement;
	}


	public void setQprEnablement(QprEnablement qprEnablement) {
		this.qprEnablement = qprEnablement;
	}


	


	public Integer getExpenditureIncurred() {
		return expenditureIncurred;
	}


	public void setExpenditureIncurred(Integer expenditureIncurred) {
		this.expenditureIncurred = expenditureIncurred;
	}


	public Integer getLocalBodyCode() {
		return localBodyCode;
	}


	public void setLocalBodyCode(Integer localBodyCode) {
		this.localBodyCode = localBodyCode;
	}


	public Integer getDistrictCode() {
		return districtCode;
	}


	public void setDistrictCode(Integer districtCode) {
		this.districtCode = districtCode;
	}


	public Integer getEnablementStatus() {
		return enablementStatus;
	}


	public void setEnablementStatus(Integer enablementStatus) {
		this.enablementStatus = enablementStatus;
	}


	




}
