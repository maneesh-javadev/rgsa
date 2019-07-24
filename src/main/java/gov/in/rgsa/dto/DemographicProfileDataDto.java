package gov.in.rgsa.dto;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;

import org.hibernate.annotations.NamedNativeQuery;

@Entity
@NamedNativeQuery(name="FETCH_DEMOGRAPHIC_DATA",query="select * from rgsa.view_report_of_basic_info_mopr(:stateCode, :yearId)",resultClass = DemographicProfileDataDto.class)
public class DemographicProfileDataDto {

	@Id
	@Column(name="id")
	private Integer id;
	
	@Column(name="particulars")
	private String particular;
	
	@Column(name="details")
	private String details;
	
	@Column(name="sub_id")
	private Integer subId;
	
	@Column(name="no_of_fields")
	private Integer noOfFields;
	
	@Column(name="dp_data")
	private String dpData;
	
	@Column(name="bp_data")
	private String bpData;
	
	@Column(name="gp_data")
	private String gpData;

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getParticular() {
		return particular;
	}

	public void setParticular(String particular) {
		this.particular = particular;
	}

	public String getDetails() {
		return details;
	}

	public void setDetails(String details) {
		this.details = details;
	}

	public Integer getSubId() {
		return subId;
	}

	public void setSubId(Integer subId) {
		this.subId = subId;
	}

	public Integer getNoOfFields() {
		return noOfFields;
	}

	public void setNoOfFields(Integer noOfFields) {
		this.noOfFields = noOfFields;
	}

	public String getDpData() {
		return dpData;
	}

	public void setDpData(String dpData) {
		this.dpData = dpData;
	}

	public String getBpData() {
		return bpData;
	}

	public void setBpData(String bpData) {
		this.bpData = bpData;
	}

	public String getGpData() {
		return gpData;
	}

	public void setGpData(String gpData) {
		this.gpData = gpData;
	}
}
