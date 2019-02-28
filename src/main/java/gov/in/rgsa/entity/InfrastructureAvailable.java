package gov.in.rgsa.entity;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

@Entity
@Table(name="infrastructure_available",schema="rgsa")
public class InfrastructureAvailable implements Serializable {
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "infrastructure_available_id",updatable = false, nullable = false)
	private Integer infrastructureAvailableId;
	
	@ManyToOne
	@JoinColumn(name="training_institue_id",referencedColumnName="training_institue_id")
	private TrainingInstitueMaster  institueMaster;
	
	@Column(name="year_id")
	private Integer yearId;
	
	@Column(name="state_code")
	private Integer stateCode;
	
	
	@Column(name="entity_code")
	private Integer entityCode;
	
	@Column(name="is_institute_functional")
	private Boolean isInstituteFunctional;
	
	@Column(name="from_year")
	private String fromYear;
	
	@Column(name="training_conducted_last_year")
	private String trainingConductedLastYear;
	
	@Column(name="available_halls")
	private Integer availableHalls;
	
	@Column(name="conference_halls_availble")
	private Integer conferenceHallsAvailble;
	
	@Column(name="is_system_resource")
	private Boolean isSystemResource;
	
	@Column(name="is_separate_toilet")
	private Boolean isSeparateToilet;
	
	@Column(name="is_library")
	private Boolean isLibrary;
	
	@Column(name="is_dining_hall")
	private Boolean isDiningHall;
	
	@Column(name="is_hostel_facility")
	private Boolean isHostelFacility;
	
	@Column(name="status")
	private String status;
	
	@Column(name="version_no")
	private Integer versionNo;
	
	@Column(name="created_by")
	private Integer createdBy;
	
	@Column(name="created_on")
	private Date createdOn;
	
	@Column(name="last_updated_by")
	private Integer lastUpdatedBy;
	
	
	@Column(name="last_updated_on")
	private Date lastUpdatedOn;


	public Integer getInfrastructureAvailableId() {
		return infrastructureAvailableId;
	}


	public void setInfrastructureAvailableId(Integer infrastructureAvailableId) {
		this.infrastructureAvailableId = infrastructureAvailableId;
	}


	public TrainingInstitueMaster getInstitueMaster() {
		return institueMaster;
	}


	public void setInstitueMaster(TrainingInstitueMaster institueMaster) {
		this.institueMaster = institueMaster;
	}


	public Integer getYearId() {
		return yearId;
	}


	public void setYearId(Integer yearId) {
		this.yearId = yearId;
	}


	public Integer getStateCode() {
		return stateCode;
	}


	public void setStateCode(Integer stateCode) {
		this.stateCode = stateCode;
	}


	public Integer getEntityCode() {
		return entityCode;
	}


	public void setEntityCode(Integer entityCode) {
		this.entityCode = entityCode;
	}


	public Boolean getIsInstituteFunctional() {
		return isInstituteFunctional;
	}


	public void setIsInstituteFunctional(Boolean isInstituteFunctional) {
		this.isInstituteFunctional = isInstituteFunctional;
	}


	public String getFromYear() {
		return fromYear;
	}


	public void setFromYear(String fromYear) {
		this.fromYear = fromYear;
	}


	public String getTrainingConductedLastYear() {
		return trainingConductedLastYear;
	}


	public void setTrainingConductedLastYear(String trainingConductedLastYear) {
		this.trainingConductedLastYear = trainingConductedLastYear;
	}


	public Integer getAvailableHalls() {
		return availableHalls;
	}


	public void setAvailableHalls(Integer availableHalls) {
		this.availableHalls = availableHalls;
	}


	public Integer getConferenceHallsAvailble() {
		return conferenceHallsAvailble;
	}


	public void setConferenceHallsAvailble(Integer conferenceHallsAvailble) {
		this.conferenceHallsAvailble = conferenceHallsAvailble;
	}


	public Boolean getIsSystemResource() {
		return isSystemResource;
	}


	public void setIsSystemResource(Boolean isSystemResource) {
		this.isSystemResource = isSystemResource;
	}


	public Boolean getIsSeparateToilet() {
		return isSeparateToilet;
	}


	public void setIsSeparateToilet(Boolean isSeparateToilet) {
		this.isSeparateToilet = isSeparateToilet;
	}


	public Boolean getIsLibrary() {
		return isLibrary;
	}


	public void setIsLibrary(Boolean isLibrary) {
		this.isLibrary = isLibrary;
	}


	public Boolean getIsDiningHall() {
		return isDiningHall;
	}


	public void setIsDiningHall(Boolean isDiningHall) {
		this.isDiningHall = isDiningHall;
	}


	public Boolean getIsHostelFacility() {
		return isHostelFacility;
	}


	public void setIsHostelFacility(Boolean isHostelFacility) {
		this.isHostelFacility = isHostelFacility;
	}


	public String getStatus() {
		return status;
	}


	public void setStatus(String status) {
		this.status = status;
	}


	public Integer getVersionNo() {
		return versionNo;
	}


	public void setVersionNo(Integer versionNo) {
		this.versionNo = versionNo;
	}


	public Integer getCreatedBy() {
		return createdBy;
	}


	public void setCreatedBy(Integer createdBy) {
		this.createdBy = createdBy;
	}


	public Date getCreatedOn() {
		return createdOn;
	}


	public void setCreatedOn(Date createdOn) {
		this.createdOn = createdOn;
	}


	public Integer getLastUpdatedBy() {
		return lastUpdatedBy;
	}


	public void setLastUpdatedBy(Integer lastUpdatedBy) {
		this.lastUpdatedBy = lastUpdatedBy;
	}


	public Date getLastUpdatedOn() {
		return lastUpdatedOn;
	}


	public void setLastUpdatedOn(Date lastUpdatedOn) {
		this.lastUpdatedOn = lastUpdatedOn;
	}
	
	
	
	
	

}
