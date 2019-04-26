package gov.in.rgsa.dto;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.NamedNativeQuery;

@Entity
@NamedNativeQuery(name="GET_INITIAL_DATA_FOR_INST_INFRA",query="select d.district_code,d.district_name_english,iad.institutional_infra_activity_id,iad.institutional_infra_activity_details_id," + 
		" case when iad.work_type='N' then  iad.fund_proposed else iad.fund_required end fund_proposed,iad.work_type,iad.institutional_activity_type_id "+ 
		" from  rgsa.institutional_infra_activity ia left join  rgsa.institutional_infra_activity_details iad on "+ 
		" ia.institutional_infra_activity_id=iad.institutional_infra_activity_id inner join lgd.get_district_list_fn(ia.state_code) d" + 
		" on iad.institutional_infra_location=d.district_code" + 
		" where ia.state_code=:stateCode and ia.year_id=:yearId and user_type=:userType "
		,resultClass=InstitutionalInfraProgressReportDTO.class)

public class InstitutionalInfraProgressReportDTO {
	
	@Id
	@Column(name="district_code")
	private Integer districtCode;

	@Column(name="district_name_english")
	private String districtName;
	
	@Column(name="institutional_infra_activity_id")
	private Integer institutionalInfraActivityId;
	
	@Column(name="institutional_infra_activity_details_id")
	private Integer institutionalInfraActivityDetailId;
	
	@Column(name="fund_proposed")
	private Integer totalFundApproved;
	
	
	@Column(name="work_type")
	private String workType;
	
	@Column(name="institutional_activity_type_id")
	private Integer institutionalActivityTypeId;
	
	public Integer getDistrictCode() {
		return districtCode;
	}

	public void setDistrictCode(Integer districtCode) {
		this.districtCode = districtCode;
	}

	public String getDistrictName() {
		return districtName;
	}

	public void setDistrictName(String districtName) {
		this.districtName = districtName;
	}

	

	public Integer getInstitutionalInfraActivityId() {
		return institutionalInfraActivityId;
	}

	public void setInstitutionalInfraActivityId(Integer institutionalInfraActivityId) {
		this.institutionalInfraActivityId = institutionalInfraActivityId;
	}

	public Integer getInstitutionalInfraActivityDetailId() {
		return institutionalInfraActivityDetailId;
	}

	public void setInstitutionalInfraActivityDetailId(Integer institutionalInfraActivityDetailId) {
		this.institutionalInfraActivityDetailId = institutionalInfraActivityDetailId;
	}

	public Integer getTotalFundApproved() {
		return totalFundApproved;
	}

	public void setTotalFundApproved(Integer totalFundApproved) {
		this.totalFundApproved = totalFundApproved;
	}

	public String getWorkType() {
		return workType;
	}

	public void setWorkType(String workType) {
		this.workType = workType;
	}

	public Integer getInstitutionalActivityTypeId() {
		return institutionalActivityTypeId;
	}

	public void setInstitutionalActivityTypeId(Integer institutionalActivityTypeId) {
		this.institutionalActivityTypeId = institutionalActivityTypeId;
	}

	
	
	
	
}
