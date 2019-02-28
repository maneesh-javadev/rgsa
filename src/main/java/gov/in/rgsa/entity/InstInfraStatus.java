package gov.in.rgsa.entity;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;

@Entity
@Table(name="inst_infra_status" , schema="rgsa")
@NamedQuery(name="GET_INST_INFRA_STATUS",query="SELECT I FROM InstInfraStatus I WHERE trainingInstitueType.trainingInstitueTypeId=:trainingInstituteTypeId")
public class InstInfraStatus implements Serializable  {
	
	public static long getSerialversionuid() {
		return serialVersionUID;
	}


	private static final long serialVersionUID = 1L;
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "inst_infra_status_id" ,updatable = false, nullable = false)
	private  Integer instInfraStatusId;

	
	@ManyToOne
	@JoinColumn(name="training_institue_type_id")
	private TrainingInstitueType trainingInstitueType;

	@Column(name = "inst_infra_status_name")
	private String instInfraStatusName;


	public Integer getInstInfraStatusId() {
		return instInfraStatusId;
	}


	public void setInstInfraStatusId(Integer instInfraStatusId) {
		this.instInfraStatusId = instInfraStatusId;
	}


	public TrainingInstitueType getTrainingInstitueType() {
		return trainingInstitueType;
	}


	public void setTrainingInstitueType(TrainingInstitueType trainingInstitueType) {
		this.trainingInstitueType = trainingInstitueType;
	}


	public String getInstInfraStatusName() {
		return instInfraStatusName;
	}


	public void setInstInfraStatusName(String instInfraStatusName) {
		this.instInfraStatusName = instInfraStatusName;
	}
	
	
	
}
