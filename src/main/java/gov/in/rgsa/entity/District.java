package gov.in.rgsa.entity;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.NamedNativeQueries;
import javax.persistence.NamedNativeQuery;
import javax.persistence.Table;

@Entity
@Table(schema = "lgd")
@NamedNativeQueries({@NamedNativeQuery(query="select state_code,state_version,district_code,district_version,district_name_english,district_name_local from lgd.get_district_list_fn(:id)",name="DISTRICT_LIST_BY_STATE_CODE",resultClass=District.class),
	@NamedNativeQuery(query="select state_code,state_version,district_code,district_version,district_name_english,district_name_local from lgd.get_district_list_fn(:id) where district_code=:districtCode",name="DISTRICT_DETAIL_BY_STATECODE_DISTRICTCODE",resultClass=District.class),
@NamedNativeQuery(query="select state_code,state_version,district_code,district_version,district_name_english,district_name_local from lgd.get_district_list_fn(:id);",name="districtByCode",resultClass=District.class),
@NamedNativeQuery(query="select state_code,state_version,district_code,district_version,district_name_english,district_name_local from lgd.get_district_list_fn(:id) order by district_code;",name="districtByorder",resultClass=District.class),
@NamedNativeQuery(name="DISTRICT_NAME_LIST",query="select training_institute_cs_details_id ,training_institue_type_name || ',' ||district_name_english As district_Name_Add_Faclty_And_Main from rgsa.training_institute_cs_details ticsd, rgsa.training_institue_type tit, lgd.district d where d.dlc=ticsd.ti_location and ticsd.training_institue_type_id=tit.training_institue_type_id"),
@NamedNativeQuery(query="select district_code,district_name_english from lgd.get_district_list_fn(:id)" , name="DISTRICT_PMU_LIST"),
@NamedNativeQuery(query="select slc as state_code, district_version as state_version,district_code,district_version,district_name_english,district_name_local from lgd.district where district_code=:dlc and isactive" , name="DISTRICT_BY_ID",resultClass=District.class)
})


public class District implements Serializable {

	private static final long serialVersionUID = 1L;
	
	@Column(name = "state_code")
	int stateCode;
	
	@Column(name = "state_version")
	int stateVersion;
	
	@Column(name = "district_code")
	@Id
	int districtCode; 
	
	@Column(name = "district_version")
	int districtVersion;
	
	@Column(name = "district_name_english")
	String districtNameEnglish;
	
	@Column(name = "district_name_local")
	String districtNamelocal ;
	
	public int getStateCode() {
		return stateCode;
	}
	public void setStateCode(int stateCode) {
		this.stateCode = stateCode;
	}
	public int getStateVersion() {
		return stateVersion;
	}
	public void setStateVersion(int stateVersion) {
		this.stateVersion = stateVersion;
	}
	public int getDistrictCode() {
		return districtCode;
	}
	public void setDistrictCode(int districtCode) {
		this.districtCode = districtCode;
	}
	public int getDistrictVersion() {
		return districtVersion;
	}
	public void setDistrictVersion(int districtVersion) {
		this.districtVersion = districtVersion;
	}
	public String getDistrictNameEnglish() {
		return districtNameEnglish;
	}
	public void setDistrictNameEnglish(String districtNameEnglish) {
		this.districtNameEnglish = districtNameEnglish;
	}
	public String getDistrictNamelocal() {
		return districtNamelocal;
	}
	public void setDistrictNamelocal(String districtNamelocal) {
		this.districtNamelocal = districtNamelocal;
	}

}

