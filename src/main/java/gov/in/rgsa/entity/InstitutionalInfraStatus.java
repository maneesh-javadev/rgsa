package gov.in.rgsa.entity;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name="inst_infra_status",schema="rgsa")
public class InstitutionalInfraStatus implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = -7906628100693776421L;

	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	@Column(name="inst_infra_status_id")
	private Long instInfraStatusId;
	
	@Column(name="training_institue_type_id")
	private Long trainingInstituteTypeId;
	
	@Column(name="inst_infra_status_name")
	private String instInfraStatusName;

	public Long getInstInfraStatusId() {
		return instInfraStatusId;
	}

	public void setInstInfraStatusId(Long instInfraStatusId) {
		this.instInfraStatusId = instInfraStatusId;
	}

	public long getTrainingInstituteTypeId() {
		return trainingInstituteTypeId;
	}

	public void setTrainingInstituteTypeId(long trainingInstituteTypeId) {
		this.trainingInstituteTypeId = trainingInstituteTypeId;
	}

	public String getInstInfraStatusName() {
		return instInfraStatusName;
	}

	public void setInstInfraStatusName(String instInfraStatusName) {
		this.instInfraStatusName = instInfraStatusName;
	}
	
}
