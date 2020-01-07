package gov.in.rgsa.entity;

import java.io.Serializable;
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
import javax.persistence.NamedQuery;
import javax.persistence.OneToMany;
import javax.persistence.Table;


@Entity
@Table(name="domains",schema="rgsa")
@NamedQuery(name="FIND_TRAINING_INSTITUTION_TYPE",query ="SELECT D FROM Domains D ORDER BY D.domainId")
public class Domains implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = -580717128470912493L;

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name="domain_id")
	private Integer domainId;
	
	@Column(name="domain_name")
	private String domainName;

	@ManyToOne
	@JoinColumn(name="training_institue_type_id", referencedColumnName="training_institue_type_id")
	private TrainingInstitueType trainingInstitueType;
	
	public Integer getDomainId() {
		return domainId;
	}

	public void setDomainId(Integer domainId) {
		this.domainId = domainId;
	}

	public String getDomainName() {
		return domainName;
	}

	public void setDomainName(String domainName) {
		this.domainName = domainName;
	}

	public TrainingInstitueType getTrainingInstitueType() {
		return trainingInstitueType;
	}

	public void setTrainingInstitueType(TrainingInstitueType trainingInstitueType) {
		this.trainingInstitueType = trainingInstitueType;
	}

}