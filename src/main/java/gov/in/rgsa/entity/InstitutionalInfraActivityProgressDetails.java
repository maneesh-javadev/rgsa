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
@Table(name="qpr_inst_infra_details", schema="rgsa")
public class InstitutionalInfraActivityProgressDetails implements Serializable {
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1978364757844986763L;

	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	@Column(name="qpr_inst_infra_details_id",updatable=false,nullable=false)
	private Integer qprInstInfradetailsId;
	
	@ManyToOne
	@JoinColumn(name="qpr_inst_infra_id",referencedColumnName="qpr_inst_infra_id")
	private InstitutionalInfraActivityPlanProgress institutionalInfraActivityPlanProgress;
	
	@ManyToOne
	@JoinColumn(name="inst_infra_status_id")
	private InstInfraStatus instInfraStatus;
	
	
	@ManyToOne
	@JoinColumn(name="institutional_infra_activity_details_id")
	private InstitutionalInfraActivityPlanDetails institutionalInfraActivityPlanDetails;
	
	@Column(name="expenditure_incurred")
	private Integer expenditureIncurred;
	
	@Column(name="file_path")
	private String filePath;

	public Integer getQprInstInfradetailsId() {
		return qprInstInfradetailsId;
	}

	public void setQprInstInfradetailsId(Integer qprInstInfradetailsId) {
		this.qprInstInfradetailsId = qprInstInfradetailsId;
	}

	public InstitutionalInfraActivityPlanProgress getInstitutionalInfraActivityPlanProgress() {
		return institutionalInfraActivityPlanProgress;
	}

	public void setInstitutionalInfraActivityPlanProgress(
			InstitutionalInfraActivityPlanProgress institutionalInfraActivityPlanProgress) {
		this.institutionalInfraActivityPlanProgress = institutionalInfraActivityPlanProgress;
	}

	public InstitutionalInfraActivityPlanDetails getInstitutionalInfraActivityPlanDetails() {
		return institutionalInfraActivityPlanDetails;
	}

	public void setInstitutionalInfraActivityPlanDetails(
			InstitutionalInfraActivityPlanDetails institutionalInfraActivityPlanDetails) {
		this.institutionalInfraActivityPlanDetails = institutionalInfraActivityPlanDetails;
	}

	public Integer getExpenditureIncurred() {
		return expenditureIncurred;
	}

	public void setExpenditureIncurred(Integer expenditureIncurred) {
		this.expenditureIncurred = expenditureIncurred;
	}

	public String getFilePath() {
		return filePath;
	}

	public void setFilePath(String filePath) {
		this.filePath = filePath;
	}

	public InstInfraStatus getInstInfraStatus() {
		return instInfraStatus;
	}

	public void setInstInfraStatus(InstInfraStatus instInfraStatus) {
		this.instInfraStatus = instInfraStatus;
	}
	
	
	
}
