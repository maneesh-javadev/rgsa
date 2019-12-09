package gov.in.rgsa.entity;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;


@Entity
@Table(name="qpr_inst_infra_hr_details", schema="rgsa")
public class AdditionalFacultyProgressDetail implements Serializable{
 
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	@Column(name="qpr_inst_infra_hr_details_id",nullable = false,updatable = false)
	private Integer qprInstInfraHrDetailsId;
	
	@ManyToOne
	@JoinColumn(name="institue_infra_hr_activity_type_id")
	private InstituteInfraHrActivityType instituteInfraHrActivityType;
	
	
	
	@ManyToOne
	@JoinColumn(name="qpr_inst_infra_hr_id")
	private AdditionalFacultyProgress additionalFacultyProgress;
	
	@Column(name="no_of_units_filled")
	private Integer noOfUnitsFilled;
	
	@Column(name="expenditure_incurred")
	private Integer expenditureIncurred;

	public Integer getQprInstInfraHrDetailsId() {
		return qprInstInfraHrDetailsId;
	}

	public void setQprInstInfraHrDetailsId(Integer qprInstInfraHrDetailsId) {
		this.qprInstInfraHrDetailsId = qprInstInfraHrDetailsId;
	}

	public InstituteInfraHrActivityType getInstituteInfraHrActivityType() {
		return instituteInfraHrActivityType;
	}

	public void setInstituteInfraHrActivityType(InstituteInfraHrActivityType instituteInfraHrActivityType) {
		this.instituteInfraHrActivityType = instituteInfraHrActivityType;
	}

	public AdditionalFacultyProgress getAdditionalFacultyProgress() {
		return additionalFacultyProgress;
	}

	public void setAdditionalFacultyProgress(AdditionalFacultyProgress additionalFacultyProgress) {
		this.additionalFacultyProgress = additionalFacultyProgress;
	}

	public Integer getNoOfUnitsFilled() {
		return noOfUnitsFilled;
	}

	public void setNoOfUnitsFilled(Integer noOfUnitsFilled) {
		this.noOfUnitsFilled = noOfUnitsFilled;
	}

	public Integer getExpenditureIncurred() {
		return expenditureIncurred;
	}

	public void setExpenditureIncurred(Integer expenditureIncurred) {
		this.expenditureIncurred = expenditureIncurred;
	}
	
	
}
