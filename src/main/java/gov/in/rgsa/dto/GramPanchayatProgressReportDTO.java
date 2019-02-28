package gov.in.rgsa.dto;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.NamedNativeQuery;

@Entity
@NamedNativeQuery(name="FETCH_GRAM_PANCHAYAT_REPORT_DETAILS",query="SELECT t.panhcayat_bhawan_activity_id, t.id as panhcayat_bhawan_activity_details_id, t.district_code,t.local_body_code,"
		+ "l.local_body_name_english from (select d.id,d.panhcayat_bhawan_activity_id,dg.district_code ,dg.local_body_code FROM rgsa.panhcayat_bhawan_activity_details d "
		+ "LEFT OUTER JOIN rgsa.panhcayat_bhawan_activity_gps dg ON (d.id  = dg.panhcayat_bhawan_activity_details_id) WHERE d.activity_id=:activityId and "
		+ "dg.district_code=:districtCode) t left outer join lgd.view_all_lb_details l on (t.local_body_code = l.local_body_code)",resultClass=GramPanchayatProgressReportDTO.class)
public class GramPanchayatProgressReportDTO {

	
	@Column(name="panhcayat_bhawan_activity_id")
	private Integer panchayatBhawanActivityId;
	
	@Column(name="panhcayat_bhawan_activity_details_id")
	private Integer panchayatBhawanActivityDetailId;
	
	@Column(name="district_code")
	private Integer districtCode;
	
	@Id
	@Column(name="local_body_code")
	private Integer localBodyCode;
	
	@Column(name="local_body_name_english")
	private String localBodyNameEnglish;

	public Integer getPanchayatBhawanActivityId() {
		return panchayatBhawanActivityId;
	}

	public void setPanchayatBhawanActivityId(Integer panchayatBhawanActivityId) {
		this.panchayatBhawanActivityId = panchayatBhawanActivityId;
	}

	public Integer getPanchayatBhawanActivityDetailId() {
		return panchayatBhawanActivityDetailId;
	}

	public void setPanchayatBhawanActivityDetailId(Integer panchayatBhawanActivityDetailId) {
		this.panchayatBhawanActivityDetailId = panchayatBhawanActivityDetailId;
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
}
