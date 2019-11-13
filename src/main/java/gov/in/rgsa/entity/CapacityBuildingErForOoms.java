package gov.in.rgsa.entity;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.NamedNativeQueries;
import javax.persistence.NamedNativeQuery;
import javax.persistence.Transient;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonInclude.Include;

@Entity
@NamedNativeQueries({
@NamedNativeQuery(name="FETCH_CAPACITY_BUILDING_ER_OOMS", query="select * from rgsa.get_capacity_building_er_for_ooms(:finYear)" ,resultClass=CapacityBuildingErForOoms.class),
@NamedNativeQuery(name="FETCH_NO_OF_TRAINING_OOMS", query="select * from rgsa.get_no_of_training_for_ooms(:finYear)" ,resultClass=CapacityBuildingErForOoms.class),
@NamedNativeQuery(name="NO_OF_EXPOSURE_VIEW_OOMS", query="select * from rgsa.get_no_of_exposure_visit_for_ooms(:finYear)" ,resultClass=CapacityBuildingErForOoms.class),
@NamedNativeQuery(name="NO_OF_GP_BUILDING_SUPPORT_OOMS", query="select * from rgsa.get_no_of_gp_building_support_for_ooms(:finYear)" ,resultClass=CapacityBuildingErForOoms.class),
@NamedNativeQuery(name="NO_OF_SPRC_DPRC_SUPPORT_OOMS", query="select * from rgsa.no_of_sprc_dprc_support_ooms(:finYear)" ,resultClass=CapacityBuildingErForOoms.class)

})
public class CapacityBuildingErForOoms {
	
	
	/**
	 * 
	 */
	


	@JsonInclude(Include.NON_NULL)
	@Transient
	private String frequencyCode;
	
	
	@JsonInclude(Include.NON_NULL)
	@Transient
	private String year;
	
	
	@JsonInclude(Include.NON_NULL)
	@Transient
	private String measurementAreaCode;
	
	@JsonInclude(Include.NON_NULL)
	@Transient
	private String indicatorCode;
	
	@JsonInclude(Include.NON_NULL)
	@Transient
	private String value;
	
	@Id
	@Column(name="state_code")
	private String stateCode;
	
	
	
	@JsonInclude(Include.NON_NULL)
	@Transient
	private String districtCode;
	
	
	@JsonInclude(Include.NON_NULL)
	@Transient
	private String measurementFreqCode;
	
	
	@JsonInclude(Include.NON_NULL)
	@Transient
	private String schemeCode;
	
	
	
	@JsonInclude(Include.NON_NULL)
	@Column(name="entity_sum")
	private String fieldGenricName;
	
	
	@JsonInclude(Include.NON_NULL)
	@Transient
	private String noOfTraining;
	
	@JsonInclude(Include.NON_NULL)
	@Transient
	private String noOfExposureView;

	public String getFrequencyCode() {
		return frequencyCode;
	}

	public void setFrequencyCode(String frequencyCode) {
		this.frequencyCode = frequencyCode;
	}

	public String getYear() {
		return year;
	}

	public void setYear(String year) {
		this.year = year;
	}

	public String getMeasurementAreaCode() {
		return measurementAreaCode;
	}

	public void setMeasurementAreaCode(String measurementAreaCode) {
		this.measurementAreaCode = measurementAreaCode;
	}

	public String getIndicatorCode() {
		return indicatorCode;
	}

	public void setIndicatorCode(String indicatorCode) {
		this.indicatorCode = indicatorCode;
	}

	public String getValue() {
		return value;
	}

	public void setValue(String value) {
		this.value = value;
	}

	public String getStateCode() {
		return stateCode;
	}

	public void setStateCode(String stateCode) {
		this.stateCode = stateCode;
	}


	public String getDistrictCode() {
		return districtCode;
	}

	public void setDistrictCode(String districtCode) {
		this.districtCode = districtCode;
	}

	public String getMeasurementFreqCode() {
		return measurementFreqCode;
	}

	public void setMeasurementFreqCode(String measurementFreqCode) {
		this.measurementFreqCode = measurementFreqCode;
	}

	public String getSchemeCode() {
		return schemeCode;
	}

	public void setSchemeCode(String schemeCode) {
		this.schemeCode = schemeCode;
	}

	public String getFieldGenricName() {
		return fieldGenricName;
	}

	public void setFieldGenricName(String fieldGenricName) {
		this.fieldGenricName = fieldGenricName;
	}

	public String getNoOfTraining() {
		return noOfTraining;
	}

	public void setNoOfTraining(String noOfTraining) {
		this.noOfTraining = noOfTraining;
	}

	public String getNoOfExposureView() {
		return noOfExposureView;
	}

	public void setNoOfExposureView(String noOfExposureView) {
		this.noOfExposureView = noOfExposureView;
	}

}
