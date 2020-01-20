package gov.in.rgsa.dto;

import gov.in.rgsa.entity.CapacityBuildingErForOoms;
import java.util.List;
import com.fasterxml.jackson.annotation.JsonPropertyOrder;

@JsonPropertyOrder({ "status", "statuscode", "value" })
public class OomsWebService
{
    private Boolean status;
    private Integer statuscode;
    private List<CapacityBuildingErForOoms> value;
    
    public Boolean getStatus() {
        return this.status;
    }
    
    public void setStatus(final Boolean status) {
        this.status = status;
    }
    
    public Integer getStatuscode() {
        return this.statuscode;
    }
    
    public void setStatuscode(final Integer statuscode) {
        this.statuscode = statuscode;
    }
    
    public List<CapacityBuildingErForOoms> getValue() {
        return this.value;
    }
    
    public void setValue(final List<CapacityBuildingErForOoms> value) {
        this.value = value;
    }
}