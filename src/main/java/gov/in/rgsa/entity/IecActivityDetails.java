package gov.in.rgsa.entity;

import javax.persistence.*;

import java.io.Serializable;
import java.util.List;


@Entity
@Table(name = "iec_activity_details", schema = "rgsa")
@NamedQueries({
        @NamedQuery(name = "FIND_IEC_ID", query = "SELECT C FROM IecActivityDropdown C  "),
        @NamedQuery(name = "FETCH_Iec_Activity_BY_ID", query = "Delete FROM IecActivityDetails where idMain=:idMain"),
        @NamedQuery(name="FETCH_ALL_IEC_DETAILS_EXCEPT_CURRENT_VERSION",query="From IecActivityDetails where iecActivity.stateCode =:stateCode and iecActivity.versionNo !=:versionNo and  iecActivity.yearId =:yearId and iecActivity.userType in('S','M')order by idMain")
        /*@NamedQuery(name="FETCH_Iec_DETAILS",query="SELECT IAD FROM IecActivityDetails IAD where idMain=:idMain")*/
})

public class IecActivityDetails implements Serializable{

    /**
	 * 
	 */
	private static final long serialVersionUID = 6242426608895931360L;

	@Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "iec_activity_details_id", nullable = false)
    private Integer idMain;

    @JoinColumn(name = "iec_activity_id", referencedColumnName = "id")
    @OneToOne
    private IecActivity iecActivity;

    @Column(name = "Total_Amount_Proposed")
    private Integer TotalAmountProposed;

    @Column(name = "remarks")
    private String remarks;
    
    @Column(name = "is_approved")
    private Boolean isApproved;

    @Column(name = "is_active")
    private Boolean isActive;

    @OneToMany(fetch = FetchType.LAZY, mappedBy = "iecActivityDetails")
    private List<IecDetailsDropdown> iecDetailsDropdownSet;

    public Integer getIdMain() {
        return idMain;
    }

    public void setIdMain(Integer idMain) {
        this.idMain = idMain;
    }

    public Integer getTotalAmountProposed() {
        return TotalAmountProposed;
    }

    public void setTotalAmountProposed(Integer totalAmountProposed) {
        TotalAmountProposed = totalAmountProposed;
    }

    public IecActivity getIecActivity() {
        return iecActivity;
    }

    public void setIecActivity(IecActivity iecActivity) {
        this.iecActivity = iecActivity;
    }

    public String getRemarks() {
        return remarks;
    }

    public void setRemarks(String remarks) {
        this.remarks = remarks;
    }

    public Boolean getIsApproved() {
        return isApproved;
    }

    public void setIsApproved(Boolean isApproved) {
        this.isApproved = isApproved;
    }

    public Boolean getIsActive() {
        return isActive;
    }

    public void setIsActive(Boolean isActive) {
        this.isActive = isActive;
    }


    public List<IecDetailsDropdown> getIecDetailsDropdownSet() {
        return iecDetailsDropdownSet;
    }

    public void setIecDetailsDropdownSet(List<IecDetailsDropdown> iecDetailsDropdownSet) {
        this.iecDetailsDropdownSet = iecDetailsDropdownSet;
    }

}

	

