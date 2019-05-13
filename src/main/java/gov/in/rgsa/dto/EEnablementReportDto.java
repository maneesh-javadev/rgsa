package gov.in.rgsa.dto;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.NamedNativeQuery;

@Entity
@NamedNativeQuery(name="FETCH_EEnablement_REPORT_DETAILS",query="SELECT  lb.local_body_code,lb.local_body_name_english,t.e_enablement_id,t.e_enablement_details_id,t.unit_cost,t.funds,t.no_of_units,t.district_code\r\n" + 
		" from lgd.view_all_lb_details lb inner join\r\n" + 
		"(SELECT  ed.e_enablement_id,ed.e_enablement_details_id,ed.unit_cost,ed.no_of_units,ed.funds,egp.district_code,egp.local_body_code from rgsa.e_enablement_gps egp inner join rgsa.e_enablement_details ed on\r\n" + 
		" (egp.e_enablement_details_id = ed.e_enablement_details_id) where egp.district_code=:districtCode) t on (t.local_body_code=lb.local_body_code)\r\n" + 
		"",resultClass=EEnablementReportDto.class)

public class EEnablementReportDto {

	@Column(name="e_enablement_id")
	private Integer eEnablementId;
	
	@Column(name="e_enablement_details_id")
	private Integer eEnablementDetailId;
	
	@Column(name="district_code")
	private Integer districtCode;
	
	@Column(name="no_of_units")
	private Integer noOfUnit;
	
	@Column(name="unit_cost")
	private Integer unitCost;
	
	@Column(name="funds")
	private Integer fund;
	
	@Id
	@Column(name="local_body_code")
	private Integer localBodyCode;
	
	@Column(name="local_body_name_english")
	private String localBodyNameEnglish;

	public Integer geteEnablementId() {
		return eEnablementId;
	}

	public void seteEnablementId(Integer eEnablementId) {
		this.eEnablementId = eEnablementId;
	}

	public Integer geteEnablementDetailId() {
		return eEnablementDetailId;
	}

	public void seteEnablementDetailId(Integer eEnablementDetailId) {
		this.eEnablementDetailId = eEnablementDetailId;
	}

	public Integer getDistrictCode() {
		return districtCode;
	}

	public void setDistrictCode(Integer districtCode) {
		this.districtCode = districtCode;
	}

	
	public Integer getLocalBodyCode() {
		return localBodyCode;
	}

	public void setLocalBodyCode(Integer localBodyCode) {
		this.localBodyCode = localBodyCode;
	}

	public String getLocalBodyNameEnglish() {
		return localBodyNameEnglish;
	}

	public void setLocalBodyNameEnglish(String localBodyNameEnglish) {
		this.localBodyNameEnglish = localBodyNameEnglish;
	}

	public Integer getNoOfUnit() {
		return noOfUnit;
	}

	public void setNoOfUnit(Integer noOfUnit) {
		this.noOfUnit = noOfUnit;
	}

	public Integer getUnitCost() {
		return unitCost;
	}

	public void setUnitCost(Integer unitCost) {
		this.unitCost = unitCost;
	}

	public Integer getFund() {
		return fund;
	}

	public void setFund(Integer fund) {
		this.fund = fund;
	}

}
