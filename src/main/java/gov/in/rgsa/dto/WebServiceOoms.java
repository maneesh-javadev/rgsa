package gov.in.rgsa.dto;

import com.fasterxml.jackson.annotation.JsonProperty;

public class WebServiceOoms
{
    @JsonProperty("Year")
    String year;
    private String frequencyCode;
    private String measurementAreaCode;
    private String indicatorCode;
    private String schemeCode;
    
    public String getFrequencyCode() {
        return this.frequencyCode;
    }
    
    public void setFrequencyCode(final String frequencyCode) {
        this.frequencyCode = frequencyCode;
    }
    
    public String getMeasurementAreaCode() {
        return this.measurementAreaCode;
    }
    
    public void setMeasurementAreaCode(final String measurementAreaCode) {
        this.measurementAreaCode = measurementAreaCode;
    }
    
    public String getIndicatorCode() {
        return this.indicatorCode;
    }
    
    public void setIndicatorCode(final String indicatorCode) {
        this.indicatorCode = indicatorCode;
    }
    
    public String getSchemeCode() {
        return this.schemeCode;
    }
    
    public void setSchemeCode(final String schemeCode) {
        this.schemeCode = schemeCode;
    }
    
    public String getYear() {
        return this.year;
    }
    
    public void setYear(final String year) {
        this.year = year;
    }
}