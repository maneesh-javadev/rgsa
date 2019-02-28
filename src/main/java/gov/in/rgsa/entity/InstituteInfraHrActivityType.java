package gov.in.rgsa.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQuery;
import javax.persistence.OneToOne;
import javax.persistence.Table;

@Entity
@NamedQuery(name="FETCH_ALL_ACTIVITY_HR_TYPE",query="from InstituteInfraHrActivityType order by instituteInfraHrActivityTypeId")
@Table(name="institue_infra_hr_activity_type",schema="rgsa")
public class InstituteInfraHrActivityType {
	
	@Id
	@Column(name="institue_infra_hr_activity_type_id")
	private Integer instituteInfraHrActivityTypeId;
	
	@Column(name="institue_infra_hr_activity_type_name")
	private String instituteInfraHrActivityName;
	
	@Column(name="ceiling_value")
	private Integer ceilingValue;

	
	@ManyToOne
	@JoinColumn(name="training_institue_type_id")
	private TrainingInstitueType trainingInstitueType;
	

	public Integer getInstituteInfraHrActivityTypeId() {
		return instituteInfraHrActivityTypeId;
	}

	public void setInstituteInfraHrActivityTypeId(Integer instituteInfraHrActivityTypeId) {
		this.instituteInfraHrActivityTypeId = instituteInfraHrActivityTypeId;
	}

	public String getInstituteInfraHrActivityName() {
		return instituteInfraHrActivityName;
	}

	public void setInstituteInfraHrActivityName(String instituteInfraHrActivityName) {
		this.instituteInfraHrActivityName = instituteInfraHrActivityName;
	}

	public Integer getCeilingValue() {
		return ceilingValue;
	}

	public TrainingInstitueType getTrainingInstitueType() {
		return trainingInstitueType;
	}

	public void setTrainingInstitueType(TrainingInstitueType trainingInstitueType) {
		this.trainingInstitueType = trainingInstitueType;
	}

	public void setCeilingValue(Integer ceilingValue) {
		this.ceilingValue = ceilingValue;
	}

	
}
