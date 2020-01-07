package gov.in.rgsa.entity;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.NamedQuery;
import javax.persistence.Table;

@Entity
@NamedQuery(name="FIND_ALL_ACTIVITY_DETAILS",query="FROM TrainingInstituteActivityDetails where trainingInstituteActivityId=:trainingInstituteActivityId order by tiActivityDetailId asc")
@Table(name="training_institute_activity_details",schema="rgsa")
public class TrainingInstituteActivityDetails implements Serializable {
	
	/**
	 * 
	 */
	private static final long serialVersionUID = -7181554389484915091L;

	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	@Column(name="ti_activity_details_id")
	private Integer tiActivityDetailId;
	
	@Column(name="training_institute_activity_id")
	private Integer trainingInstituteActivityId;
	
	@Column(name="training_institue_activity_type_id")
	private Integer trainingInstitueActivityTypeId;
	
	@Column(name="unit_cost")
	private Integer unitCost;
	
	@Column(name="no_of_units")
	private Integer noOfUnits;
	
	@Column(name="funds")
	private Integer fund;
	
	@Column(name="remarks")
	private String remarks;

	public Integer getTiActivityDetailId() {
		return tiActivityDetailId;
	}

	public void setTiActivityDetailId(Integer tiActivityDetailId) {
		this.tiActivityDetailId = tiActivityDetailId;
	}

	public Integer getTrainingInstituteActivityId() {
		return trainingInstituteActivityId;
	}

	public void setTrainingInstituteActivityId(Integer trainingInstituteActivityId) {
		this.trainingInstituteActivityId = trainingInstituteActivityId;
	}

	public Integer getTrainingInstitueActivityTypeId() {
		return trainingInstitueActivityTypeId;
	}

	public void setTrainingInstitueActivityTypeId(Integer trainingInstitueActivityTypeId) {
		this.trainingInstitueActivityTypeId = trainingInstitueActivityTypeId;
	}

	public Integer getUnitCost() {
		return unitCost;
	}

	public void setUnitCost(Integer unitCost) {
		this.unitCost = unitCost;
	}

	public Integer getNoOfUnits() {
		return noOfUnits;
	}

	public void setNoOfUnits(Integer noOfUnits) {
		this.noOfUnits = noOfUnits;
	}

	public Integer getFund() {
		return fund;
	}

	public void setFund(Integer fund) {
		this.fund = fund;
	}

	public String getRemarks() {
		return remarks;
	}

	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}
	
	

}
