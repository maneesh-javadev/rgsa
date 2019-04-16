package gov.in.rgsa.entity;

import javax.persistence.*;

@Entity
@Table(name = "iec_details_dropdown", schema = "rgsa")
public class IecDetailsDropdown {

    @Id
    @GeneratedValue(strategy= GenerationType.IDENTITY)
    @Column(name="iec_details_dropdown_id",nullable=false)
    private Integer iecDetailsDropdownId;

    @ManyToOne
    @JoinColumn(name="iec_activity_details_id",referencedColumnName="iec_activity_details_id")
    private IecActivityDetails iecActivityDetails;

    @ManyToOne
    @JoinColumn(name="iec_activity_dropdown_id",referencedColumnName="iec_id")
    private IecActivityDropdown iecActivityDropdown;

    public Integer getIecDetailsDropdownId() {
        return iecDetailsDropdownId;
    }

    public void setIecDetailsDropdownId(Integer iecDetailsDropdownId) {
        this.iecDetailsDropdownId = iecDetailsDropdownId;
    }

    public IecActivityDetails getIecActivityDetails() {
        return iecActivityDetails;
    }

    public void setIecActivityDetails(IecActivityDetails iecActivityDetails) {
        this.iecActivityDetails = iecActivityDetails;
    }

    public IecActivityDropdown getIecActivityDropdown() {
        return iecActivityDropdown;
    }

    public void setIecActivityDropdown(IecActivityDropdown iecActivityDropdown) {
        this.iecActivityDropdown = iecActivityDropdown;
    }
}
