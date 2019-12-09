package gov.in.rgsa.dto;

import com.fasterxml.jackson.annotation.JsonProperty;

public class WebServiceOoms {
	
	@JsonProperty("Year") String year;
	
	private String frequencyCode;
	
	
	private String measurementAreaCode;
	
	private String indicatorCode;
	
	private String schemeCode;

	public String getFrequencyCode() {
		return frequencyCode;
	}

	public void setFrequencyCode(String frequencyCode) {
		this.frequencyCode = frequencyCode;
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

	public String getSchemeCode() {
		return schemeCode;
	}

	public void setSchemeCode(String schemeCode) {
		this.schemeCode = schemeCode;
	}

	public String getYear() {
		return year;
	}

	public void setYear(String year) {
		this.year = year;
	}

	
	
	
	
	
	
	
	
	
}
