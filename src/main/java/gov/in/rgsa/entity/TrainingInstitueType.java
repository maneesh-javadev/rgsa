package gov.in.rgsa.entity;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;

@Entity
@Table(name="training_institue_type",schema="rgsa")
@NamedQueries({
	@NamedQuery(name="FETCH_TRAINING_INSTITUTION_TYPE",query="from TrainingInstitueType order by trainingInstitueTypeId"),
	@NamedQuery(name="FETCH_TRAINING_INSTITUTION_TYPE_BASED_ON_LEVEL",query="from TrainingInstitueType where instituteLevel.trainingInstituteLevelId=:level order by trainingInstitueTypeName"),
	@NamedQuery(name="FETCH_TRAINING_INSTITUTION_TYPE_BASED_ON_TYPE_ID",query="from TrainingInstitueType where trainingInstitueTypeId=:typeId order by trainingInstitueTypeName"),
	@NamedQuery(name="FETCH_TRAINING_INSTITUTION_TYPE_BASED_ON_TYPE_ID_2_4",query="from TrainingInstitueType where trainingInstitueTypeId in (2,4)  order by trainingInstitueTypeName")

})
public class TrainingInstitueType implements Serializable {
	
	/**
	 * 
	 */
	private static final long serialVersionUID = -2423039562173050845L;

	@Id
	@Column(name="training_institue_type_id")
	private Integer trainingInstitueTypeId;
	
	@Column(name="training_institue_type_name")
	private String trainingInstitueTypeName;
	
	@ManyToOne
	@JoinColumn(name="training_institute_level_id")
	private TrainingInstituteLevel instituteLevel;

	/*@ManyToOne
	@JoinColumn(name="inst_infra_status_id")
	private InstInfraStatus instInfraStatus;
*/
	
	public Integer getTrainingInstitueTypeId() {
		return trainingInstitueTypeId;
	}

	public void setTrainingInstitueTypeId(Integer trainingInstitueTypeId) {
		this.trainingInstitueTypeId = trainingInstitueTypeId;
	}

	public String getTrainingInstitueTypeName() {
		return trainingInstitueTypeName;
	}

	public void setTrainingInstitueTypeName(String trainingInstitueTypeName) {
		this.trainingInstitueTypeName = trainingInstitueTypeName;
	}

	public TrainingInstituteLevel getInstituteLevel() {
		return instituteLevel;
	}

	public void setInstituteLevel(TrainingInstituteLevel instituteLevel) {
		this.instituteLevel = instituteLevel;
	}

	/*public InstInfraStatus getInstInfraStatus() {
		return instInfraStatus;
	}

	public void setInstInfraStatus(InstInfraStatus instInfraStatus) {
		this.instInfraStatus = instInfraStatus;
	}*/
	
	

}
