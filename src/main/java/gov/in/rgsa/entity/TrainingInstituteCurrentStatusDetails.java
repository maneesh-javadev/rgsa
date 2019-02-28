package gov.in.rgsa.entity;

import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Transient;

import com.fasterxml.jackson.annotation.JsonBackReference;

/**
 * 
 * @author sourabh
 *
 */

/**
 * @author nic1
 *
 */
@Entity
@NamedQueries({
	@NamedQuery(name="FETCH_TRAINING_DETAILS_BASED_ON_LOCATION", query="from TrainingInstituteCurrentStatusDetails where tiLocation=:location and trainingInstitueType.instituteLevel.trainingInstituteLevelId=:level"),
	@NamedQuery(name="DELETE_DETAILS_BY_ID",query="delete from TrainingInstituteCurrentStatusDetails where trainingInstituteCsDetailsId=:detailId"),
	@NamedQuery(name="FETCH_TRAINING_DETAILS_OF_DPRC",query="from TrainingInstituteCurrentStatusDetails where trainingInstitueType.trainingInstitueTypeId=:trainingInstitueTypeId")
})
@Table(name="training_institute_cs_details", schema = "rgsa")
public class TrainingInstituteCurrentStatusDetails {
	
	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	@Column(name="training_institute_cs_details_id")
	private Integer trainingInstituteCsDetailsId;
	
	@JsonBackReference
	@ManyToOne
	@JoinColumn(name="ti_cs_id")
	private TrainingInstituteCurrentStatus trainingInstituteCurrentStatus;
	
	@ManyToOne
	@JoinColumn(name="training_institue_type_id")
	private TrainingInstitueType trainingInstitueType;

	@Column(name="is_ti_functional")
	private Boolean isTiFunctional = Boolean.FALSE;
	
	@Column(name="no_of_trainings_conducted_lastyear")
	private Integer noOfTrainingsConductedLastyear;

	@Column(name="ti_functional_from_year")
	private String tiFunctionalFromYear;

	@Column(name="no_of_training_halls")
	private Integer noOfTrainingHalls;
	
	@Column(name="capacity_training_hall")
	private Integer capacityTrainingHall;

	@Column(name="conference_hall_available")
	private Boolean conferenceHallAvailable = Boolean.FALSE;

	@Column(name="comp_projector_internet_available")
	private Boolean compProjectorInternetAvailable = Boolean.FALSE;

	@Column(name="library_available")
	private Boolean libraryAvailable = Boolean.FALSE;

	@Column(name="dining_hall_available")
	private Boolean diningHallAvailable = Boolean.FALSE;

	@Column(name="sepertate_toilet_for_women_n_disabled")
	private Boolean sepertateToiletForWomenAndDisabled = Boolean.FALSE;
	
	@Column(name="no_of_administrative_staff")
	private Integer noOfAdministrativeStaff;
	
	@Column(name="no_of_thematic_experts_regular")
	private Integer noOfThematicExpertsRegular;
	
	@Column(name="no_of_thematic_experts_contractual")
	private Integer noOfThematicExpertsContractual;
	
	@Column(name="no_of_thematic_experts_resourceperson")
	private Integer noOfThematicExpertsResourceperson;
	
	@Column(name="ti_location")
	private Integer tiLocation;

	@OneToMany(mappedBy="trainingInstituteCurrentStatusDetails",cascade=CascadeType.ALL)
	private List<TrainingInstituteCurrentStatusFundSource> trainingInstituteFundSource;
	
	@Transient
	private String locationName;
	
	@Transient
	private String[] scheme;

	public Integer getTrainingInstituteCsDetailsId() {
		return trainingInstituteCsDetailsId;
	}

	public void setTrainingInstituteCsDetailsId(Integer trainingInstituteCsDetailsId) {
		this.trainingInstituteCsDetailsId = trainingInstituteCsDetailsId;
	}

	public TrainingInstituteCurrentStatus getTrainingInstituteCurrentStatus() {
		return trainingInstituteCurrentStatus;
	}

	public void setTrainingInstituteCurrentStatus(TrainingInstituteCurrentStatus trainingInstituteCurrentStatus) {
		this.trainingInstituteCurrentStatus = trainingInstituteCurrentStatus;
	}
	
	public Boolean getIsTiFunctional() {
		return isTiFunctional;
	}

	public void setIsTiFunctional(Boolean isTiFunctional) {
		this.isTiFunctional = isTiFunctional;
	}

	public Integer getNoOfTrainingsConductedLastyear() {
		return noOfTrainingsConductedLastyear;
	}

	public void setNoOfTrainingsConductedLastyear(Integer noOfTrainingsConductedLastyear) {
		this.noOfTrainingsConductedLastyear = noOfTrainingsConductedLastyear;
	}

	public String getTiFunctionalFromYear() {
		return tiFunctionalFromYear;
	}

	public void setTiFunctionalFromYear(String tiFunctionalFromYear) {
		this.tiFunctionalFromYear = tiFunctionalFromYear;
	}

	public Integer getNoOfTrainingHalls() {
		return noOfTrainingHalls;
	}

	public void setNoOfTrainingHalls(Integer noOfTrainingHalls) {
		this.noOfTrainingHalls = noOfTrainingHalls;
	}

	public Integer getCapacityTrainingHall() {
		return capacityTrainingHall;
	}

	public void setCapacityTrainingHall(Integer capacityTrainingHall) {
		this.capacityTrainingHall = capacityTrainingHall;
	}

	public Boolean getConferenceHallAvailable() {
		return conferenceHallAvailable;
	}

	public void setConferenceHallAvailable(Boolean conferenceHallAvailable) {
		this.conferenceHallAvailable = conferenceHallAvailable;
	}

	public Boolean getCompProjectorInternetAvailable() {
		return compProjectorInternetAvailable;
	}

	public void setCompProjectorInternetAvailable(Boolean compProjectorInternetAvailable) {
		this.compProjectorInternetAvailable = compProjectorInternetAvailable;
	}

	public Boolean getLibraryAvailable() {
		return libraryAvailable;
	}

	public void setLibraryAvailable(Boolean libraryAvailable) {
		this.libraryAvailable = libraryAvailable;
	}

	public Boolean getDiningHallAvailable() {
		return diningHallAvailable;
	}

	public void setDiningHallAvailable(Boolean diningHallAvailable) {
		this.diningHallAvailable = diningHallAvailable;
	}

	public Boolean getSepertateToiletForWomenAndDisabled() {
		return sepertateToiletForWomenAndDisabled;
	}

	public void setSepertateToiletForWomenAndDisabled(Boolean sepertateToiletForWomenAndDisabled) {
		this.sepertateToiletForWomenAndDisabled = sepertateToiletForWomenAndDisabled;
	}

	public Integer getNoOfAdministrativeStaff() {
		return noOfAdministrativeStaff;
	}

	public void setNoOfAdministrativeStaff(Integer noOfAdministrativeStaff) {
		this.noOfAdministrativeStaff = noOfAdministrativeStaff;
	}

	public Integer getNoOfThematicExpertsRegular() {
		return noOfThematicExpertsRegular;
	}

	public void setNoOfThematicExpertsRegular(Integer noOfThematicExpertsRegular) {
		this.noOfThematicExpertsRegular = noOfThematicExpertsRegular;
	}

	public Integer getNoOfThematicExpertsContractual() {
		return noOfThematicExpertsContractual;
	}

	public void setNoOfThematicExpertsContractual(Integer noOfThematicExpertsContractual) {
		this.noOfThematicExpertsContractual = noOfThematicExpertsContractual;
	}

	public Integer getNoOfThematicExpertsResourceperson() {
		return noOfThematicExpertsResourceperson;
	}

	public void setNoOfThematicExpertsResourceperson(Integer noOfThematicExpertsResourceperson) {
		this.noOfThematicExpertsResourceperson = noOfThematicExpertsResourceperson;
	}

	public Integer getTiLocation() {
		return tiLocation;
	}

	public void setTiLocation(Integer tiLocation) {
		this.tiLocation = tiLocation;
	}

	public List<TrainingInstituteCurrentStatusFundSource> getTrainingInstituteFundSource() {
		return trainingInstituteFundSource;
	}

	public void setTrainingInstituteFundSource(List<TrainingInstituteCurrentStatusFundSource> trainingInstituteFundSource) {
		this.trainingInstituteFundSource = trainingInstituteFundSource;
	}

	public String[] getScheme() {
		return scheme;
	}

	public void setScheme(String[] scheme) {
		this.scheme = scheme;
	}

	public TrainingInstitueType getTrainingInstitueType() {
		return trainingInstitueType;
	}

	public void setTrainingInstitueType(TrainingInstitueType trainingInstitueType) {
		this.trainingInstitueType = trainingInstitueType;
	}

	public String getLocationName() {
		return locationName;
	}

	public void setLocationName(String locationName) {
		this.locationName = locationName;
	}
	
}