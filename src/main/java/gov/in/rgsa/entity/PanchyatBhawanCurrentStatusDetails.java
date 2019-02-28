package gov.in.rgsa.entity;

import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Transient;

import com.fasterxml.jackson.annotation.JsonBackReference;

/**
 * 
 * @author sourabh
 *
 */

@Entity
@Table(name="panchayat_bhawan_cs_details", schema = "rgsa")
public class PanchyatBhawanCurrentStatusDetails {
	
	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	@Column(name="panchayat_bhawan_cs_details_id")
	private Integer panchyatBhawanCurrentStatusDetailsId;
	
	@JsonBackReference
	@ManyToOne(fetch=FetchType.LAZY)
	@JoinColumn(name="panchayat_bhawan_cs_id")
	private PanchyatBhawanCurrentStatus panchyatBhawanCurrentStatus;
	
	@Column(name="local_body_code")
	private Integer localBodyCode;
	
	@Column(name="gram_panchyat_functional")
	private Boolean isGramPanchyatFunctional=Boolean.FALSE;
	
	@Column(name="panchyat_bhawan_functional_from_where")
	private String panchyatBhawanFunctionalFromWhere;
	
	@Column(name="no_of_staff_regular_admin")
	private Integer noOfStaffRegularAdmin;
	
	@Column(name="no_of_staff_regular_tech")
	private Integer noOfStaffRegularTech;
	
	@Column(name="no_of_staff_contract_admin")
	private Integer noOfStaffContractAdmin;

	@Column(name="no_of_staff_contract_tech")
	private Integer noOfStaffContractTech;

	@Column(name="computer_available")
	private Boolean computerAvailable=Boolean.FALSE;
	
	@Column(name="internet_available")
	private Boolean internetAvailable=Boolean.FALSE;

	@Column(name="electricity_available")
	private Boolean electricityAvailable=Boolean.FALSE;

	@Column(name="no_of_gs_held_during_last_year")
	private Integer noOfGsHeldDuringLastYear;

	@Column(name="gram_panchayat_prepared_annual_plan")
	private Boolean gramPanchayatPreparedAnnualPlan=Boolean.FALSE;

	@Column(name="standing_committee_functional")
	private Boolean standingCommitteeFunctional=Boolean.FALSE;


	@Column(name="no_of_standing_committee_meeting_held")
	private Integer noOfStandingCommitteeMeetingHeld;
	
	@OneToMany(mappedBy="panchyatBhawanCurrentStatusDetails",cascade=CascadeType.ALL)
	private List<PanchyatWiseServicesProvided> panchyatWiseServicesProvideds;
	
	@Transient
	private String[] services;
	
	public Integer getPanchyatBhawanCurrentStatusDetailsId() {
		return panchyatBhawanCurrentStatusDetailsId;
	}

	public void setPanchyatBhawanCurrentStatusDetailsId(Integer panchyatBhawanCurrentStatusDetailsId) {
		this.panchyatBhawanCurrentStatusDetailsId = panchyatBhawanCurrentStatusDetailsId;
	}

	public PanchyatBhawanCurrentStatus getPanchyatBhawanCurrentStatus() {
		return panchyatBhawanCurrentStatus;
	}

	public void setPanchyatBhawanCurrentStatus(PanchyatBhawanCurrentStatus panchyatBhawanCurrentStatus) {
		this.panchyatBhawanCurrentStatus = panchyatBhawanCurrentStatus;
	}

	public Integer getLocalBodyCode() {
		return localBodyCode;
	}

	public void setLocalBodyCode(Integer localBodyCode) {
		this.localBodyCode = localBodyCode;
	}

	public Boolean getIsGramPanchyatFunctional() {
		return isGramPanchyatFunctional;
	}

	public void setIsGramPanchyatFunctional(Boolean isGramPanchyatFunctional) {
		this.isGramPanchyatFunctional = isGramPanchyatFunctional;
	}

	public String getPanchyatBhawanFunctionalFromWhere() {
		return panchyatBhawanFunctionalFromWhere;
	}

	public void setPanchyatBhawanFunctionalFromWhere(String panchyatBhawanFunctionalFromWhere) {
		this.panchyatBhawanFunctionalFromWhere = panchyatBhawanFunctionalFromWhere;
	}

	public Integer getNoOfStaffRegularAdmin() {
		return noOfStaffRegularAdmin;
	}

	public void setNoOfStaffRegularAdmin(Integer noOfStaffRegularAdmin) {
		this.noOfStaffRegularAdmin = noOfStaffRegularAdmin;
	}

	public Integer getNoOfStaffRegularTech() {
		return noOfStaffRegularTech;
	}

	public void setNoOfStaffRegularTech(Integer noOfStaffRegularTech) {
		this.noOfStaffRegularTech = noOfStaffRegularTech;
	}

	public Integer getNoOfStaffContractAdmin() {
		return noOfStaffContractAdmin;
	}

	public void setNoOfStaffContractAdmin(Integer noOfStaffContractAdmin) {
		this.noOfStaffContractAdmin = noOfStaffContractAdmin;
	}

	public Integer getNoOfStaffContractTech() {
		return noOfStaffContractTech;
	}

	public void setNoOfStaffContractTech(Integer noOfStaffContractTech) {
		this.noOfStaffContractTech = noOfStaffContractTech;
	}

	public Boolean getComputerAvailable() {
		return computerAvailable;
	}

	public void setComputerAvailable(Boolean computerAvailable) {
		this.computerAvailable = computerAvailable;
	}

	public Boolean getInternetAvailable() {
		return internetAvailable;
	}

	public void setInternetAvailable(Boolean internetAvailable) {
		this.internetAvailable = internetAvailable;
	}

	public Boolean getElectricityAvailable() {
		return electricityAvailable;
	}

	public void setElectricityAvailable(Boolean electricityAvailable) {
		this.electricityAvailable = electricityAvailable;
	}

	public Boolean getGramPanchayatPreparedAnnualPlan() {
		return gramPanchayatPreparedAnnualPlan;
	}

	public void setGramPanchayatPreparedAnnualPlan(Boolean gramPanchayatPreparedAnnualPlan) {
		this.gramPanchayatPreparedAnnualPlan = gramPanchayatPreparedAnnualPlan;
	}

	public Boolean getStandingCommitteeFunctional() {
		return standingCommitteeFunctional;
	}

	public void setStandingCommitteeFunctional(Boolean standingCommitteeFunctional) {
		this.standingCommitteeFunctional = standingCommitteeFunctional;
	}

	public Integer getNoOfGsHeldDuringLastYear() {
		return noOfGsHeldDuringLastYear;
	}

	public void setNoOfGsHeldDuringLastYear(Integer noOfGsHeldDuringLastYear) {
		this.noOfGsHeldDuringLastYear = noOfGsHeldDuringLastYear;
	}

	public Integer getNoOfStandingCommitteeMeetingHeld() {
		return noOfStandingCommitteeMeetingHeld;
	}

	public void setNoOfStandingCommitteeMeetingHeld(Integer noOfStandingCommitteeMeetingHeld) {
		this.noOfStandingCommitteeMeetingHeld = noOfStandingCommitteeMeetingHeld;
	}

	public List<PanchyatWiseServicesProvided> getPanchyatWiseServicesProvideds() {
		return panchyatWiseServicesProvideds;
	}

	public void setPanchyatWiseServicesProvideds(List<PanchyatWiseServicesProvided> panchyatWiseServicesProvideds) {
		this.panchyatWiseServicesProvideds = panchyatWiseServicesProvideds;
	}

	public String[] getServices() {
		return services;
	}

	public void setServices(String[] services) {
		this.services = services;
	}
}