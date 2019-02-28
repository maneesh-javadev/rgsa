package gov.in.rgsa.dto;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.NamedNativeQuery;

@Entity
@NamedNativeQuery(name="GET_INITIAL_DATA_FOR_INST_INFRA",query="select district_code,district_name_english,t.institutional_infra_activity_id,t.institutional_infra_activity_details_id, "
		+ "t.fund_proposed from lgd.get_district_list_fn(:stateCode) d "
		+ "inner join (SELECT ia.institutional_infra_activity_id,iad.institutional_infra_activity_details_id, "
		+ "iad.fund_proposed,iad.institutional_infra_location"
		+ " from rgsa.institutional_infra_activity ia inner join rgsa.institutional_infra_activity_details  iad "
		+ "on (ia.institutional_infra_activity_id=iad.institutional_infra_activity_id and institutional_activity_type_id=:trainingInstituteTypeId)) "
		+ "t on (d.district_code = t.institutional_infra_location)",resultClass=InstitutionalInfraProgressReportDTO.class)
public class InstitutionalInfraProgressReportDTO {
	
	@Id
	@Column(name="district_code")
	private Integer districtCode;

	@Column(name="district_name_english")
	private String districtName;
	
	@Column(name="institutional_infra_activity_id")
	private Long institutionalInfraActivityId;
	
	@Column(name="institutional_infra_activity_details_id")
	private Long institutionalInfraActivityDetailId;
	
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

	public Long getInstitutionalInfraActivityId() {
		return institutionalInfraActivityId;
	}

	public void setInstitutionalInfraActivityId(Long institutionalInfraActivityId) {
		this.institutionalInfraActivityId = institutionalInfraActivityId;
	}

	public Long getInstitutionalInfraActivityDetailId() {
		return institutionalInfraActivityDetailId;
	}

	public void setInstitutionalInfraActivityDetailId(Long institutionalInfraActivityDetailId) {
		this.institutionalInfraActivityDetailId = institutionalInfraActivityDetailId;
	}

	public Integer getTotalFundApproved() {
		return totalFundApproved;
	}

	public void setTotalFundApproved(Integer totalFundApproved) {
		this.totalFundApproved = totalFundApproved;
	}
}
