package gov.in.rgsa.dto;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.NamedNativeQuery;

@Entity
@NamedNativeQuery(name="GET_INITIAL_DATA_FOR_INST_INFRA",query=" select d.district_code,d.district_name_english,iad.institutional_infra_activity_id,iad.institutional_infra_activity_details_id,"
		+ " iad.fund_proposed from  rgsa.institutional_infra_activity ia left join  rgsa.institutional_infra_activity_details iad"
		+ " on ia.institutional_infra_activity_id=iad.institutional_infra_activity_id inner join lgd.get_district_list_fn(ia.state_code) d"
		+ " on iad.institutional_infra_location=d.district_code"
		+ " where ia.state_code=:stateCode and ia.year_id=:yearId and user_type=:userType and institutional_activity_type_id=:trainingInstituteTypeId",resultClass=InstitutionalInfraProgressReportDTO.class)

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
}
