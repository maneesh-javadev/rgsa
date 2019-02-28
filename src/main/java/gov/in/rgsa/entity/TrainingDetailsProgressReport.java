package gov.in.rgsa.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

/**
 * @author Mohammad Ayaz 06/12/2018
 *
 */
@Entity
@Table(name="training_details_progress_report",schema="rgsa")
public class TrainingDetailsProgressReport {

	
	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	@Column(name="training_details_report_id",nullable=false,updatable=false)
	private Integer trainingDetailsReportId;
	
	@ManyToOne
	@JoinColumn(name="training_report_id",referencedColumnName="training_report_id")
	private TrainingProgressReport trainingProgressReport;
	
	@ManyToOne
	@JoinColumn(name="training_details_id")
	private TrainingActivityDetails trainingActivityDetails;
	
	@ManyToOne
	@JoinColumn(name="quarter_id")
	private QuarterDuration quarterDuration;
	
	/*@OneToMany(mappedBy="trainingDetailsProgressReport",cascade=CascadeType.ALL,fetch=FetchType.EAGER)
	private List<CategoriesOfParticipant> categoriesOfParticipantList;*/
	
	
	@Column(name="training_institute_id")
	private Integer trainingInstituteId;

	@Column(name="training_institute_name")
	private String trainingInstituteName;
	
	@Column(name="no_of_participants")
	private Integer noOfParticipants;
	
	@Column(name="no_of_days")
	private Integer noOfDays;
	
	@Column(name="funds_incurred")
	private Integer fundsIncurred;

	public Integer getTrainingDetailsReportId() {
		return trainingDetailsReportId;
	}

	public void setTrainingDetailsReportId(Integer trainingDetailsReportId) {
		this.trainingDetailsReportId = trainingDetailsReportId;
	}

	public TrainingProgressReport getTrainingProgressReport() {
		return trainingProgressReport;
	}

	public void setTrainingProgressReport(TrainingProgressReport trainingProgressReport) {
		this.trainingProgressReport = trainingProgressReport;
	}

	/*public List<CategoriesOfParticipant> getCategoriesOfParticipantList() {
		return categoriesOfParticipantList;
	}

	public void setCategoriesOfParticipantList(List<CategoriesOfParticipant> categoriesOfParticipantList) {
		this.categoriesOfParticipantList = categoriesOfParticipantList;
	}*/

	public TrainingActivityDetails getTrainingActivityDetails() {
		return trainingActivityDetails;
	}

	public void setTrainingActivityDetails(TrainingActivityDetails trainingActivityDetails) {
		this.trainingActivityDetails = trainingActivityDetails;
	}

	public QuarterDuration getQuarterDuration() {
		return quarterDuration;
	}

	public void setQuarterDuration(QuarterDuration quarterDuration) {
		this.quarterDuration = quarterDuration;
	}

	public Integer getTrainingInstituteId() {
		return trainingInstituteId;
	}

	public void setTrainingInstituteId(Integer trainingInstituteId) {
		this.trainingInstituteId = trainingInstituteId;
	}

	public String getTrainingInstituteName() {
		return trainingInstituteName;
	}

	public void setTrainingInstituteName(String trainingInstituteName) {
		this.trainingInstituteName = trainingInstituteName;
	}

	public Integer getNoOfParticipants() {
		return noOfParticipants;
	}

	public void setNoOfParticipants(Integer noOfParticipants) {
		this.noOfParticipants = noOfParticipants;
	}

	public Integer getNoOfDays() {
		return noOfDays;
	}

	public void setNoOfDays(Integer noOfDays) {
		this.noOfDays = noOfDays;
	}

	public Integer getFundsIncurred() {
		return fundsIncurred;
	}

	public void setFundsIncurred(Integer fundsIncurred) {
		this.fundsIncurred = fundsIncurred;
	}
	
	
}
