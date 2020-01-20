package gov.in.rgsa.entity;

import javax.persistence.Column;
import javax.persistence.Id;
import javax.persistence.Transient;
import com.fasterxml.jackson.annotation.JsonInclude;
import javax.persistence.NamedNativeQuery;
import javax.persistence.NamedNativeQueries;
import javax.persistence.Entity;

@Entity
@NamedNativeQueries({ @NamedNativeQuery(name = "FETCH_CAPACITY_BUILDING_ER_OOMS", query = "select * from rgsa.get_capacity_building_er_for_ooms(:finYear)", resultClass = CapacityBuildingErForOoms.class), @NamedNativeQuery(name = "FETCH_NO_OF_TRAINING_OOMS", query = "select * from rgsa.get_no_of_training_for_ooms(:finYear)", resultClass = CapacityBuildingErForOoms.class), @NamedNativeQuery(name = "NO_OF_EXPOSURE_VIEW_OOMS", query = "select * from rgsa.get_no_of_exposure_visit_for_ooms(:finYear)", resultClass = CapacityBuildingErForOoms.class), @NamedNativeQuery(name = "NO_OF_GP_BUILDING_SUPPORT_OOMS", query = "select * from rgsa.get_no_of_gp_building_support_for_ooms(:finYear)", resultClass = CapacityBuildingErForOoms.class), @NamedNativeQuery(name = "NO_OF_SPRC_DPRC_SUPPORT_OOMS", query = "select * from rgsa.no_of_sprc_dprc_support_ooms(:finYear)", resultClass = CapacityBuildingErForOoms.class) })
public class CapacityBuildingErForOoms
{
    @JsonInclude(JsonInclude.Include.NON_NULL)
    @Transient
    private String frequencyCode;
    @JsonInclude(JsonInclude.Include.NON_NULL)
    @Transient
    private String year;
    @JsonInclude(JsonInclude.Include.NON_NULL)
    @Transient
    private String measurementAreaCode;
    @JsonInclude(JsonInclude.Include.NON_NULL)
    @Transient
    private String indicatorCode;
    @JsonInclude(JsonInclude.Include.NON_NULL)
    @Transient
    private String value;
    @Id
    @Column(name = "state_code")
    private Integer stateCode;
    @JsonInclude(JsonInclude.Include.NON_NULL)
    @Transient
    private String districtCode;
    @JsonInclude(JsonInclude.Include.NON_NULL)
    @Transient
    private String measurementFreqCode;
    @JsonInclude(JsonInclude.Include.NON_NULL)
    @Transient
    private String schemeCode;
    @JsonInclude(JsonInclude.Include.NON_NULL)
    @Column(name = "entity_sum")
    private String fieldGenricName;
    @JsonInclude(JsonInclude.Include.NON_NULL)
    @Transient
    private String noOfTraining;
    @JsonInclude(JsonInclude.Include.NON_NULL)
    @Transient
    private String noOfExposureView;
    
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
    
    public String getValue() {
        return this.value;
    }
    
    public void setValue(final String value) {
        this.value = value;
    }
    
    public String getDistrictCode() {
        return this.districtCode;
    }
    
    public void setDistrictCode(final String districtCode) {
        this.districtCode = districtCode;
    }
    
    public String getMeasurementFreqCode() {
        return this.measurementFreqCode;
    }
    
    public void setMeasurementFreqCode(final String measurementFreqCode) {
        this.measurementFreqCode = measurementFreqCode;
    }
    
    public String getSchemeCode() {
        return this.schemeCode;
    }
    
    public void setSchemeCode(final String schemeCode) {
        this.schemeCode = schemeCode;
    }
    
    public String getFieldGenricName() {
        return this.fieldGenricName;
    }
    
    public void setFieldGenricName(final String fieldGenricName) {
        this.fieldGenricName = fieldGenricName;
    }
    
    public String getNoOfTraining() {
        return this.noOfTraining;
    }
    
    public void setNoOfTraining(final String noOfTraining) {
        this.noOfTraining = noOfTraining;
    }
    
    public String getNoOfExposureView() {
        return this.noOfExposureView;
    }
    
    public void setNoOfExposureView(final String noOfExposureView) {
        this.noOfExposureView = noOfExposureView;
    }
    
    public String getYear() {
        return this.year;
    }
    
    public void setYear(final String year) {
        this.year = year;
    }
    
    public Integer getStateCode() {
        return this.stateCode;
    }
    
    public void setStateCode(final Integer stateCode) {
        this.stateCode = stateCode;
    }
}