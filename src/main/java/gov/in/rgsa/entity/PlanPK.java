package gov.in.rgsa.entity;

import javax.persistence.Column;
import javax.persistence.Embeddable;

@Embeddable
public class PlanPK implements java.io.Serializable {
	
	
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	
	@Column(name="plan_code",nullable=false)
	private Integer planCode;
	
	@Column(name="plan_version",nullable=false)
	private Integer planVersion;
	
	@Column(name="plan_status_id",nullable=false)
	private Integer planStatusId;

	public Integer getPlanCode() {
		return planCode;
	}

	public void setPlanCode(Integer planCode) {
		this.planCode = planCode;
	}

	public Integer getPlanVersion() {
		return planVersion;
	}

	public void setPlanVersion(Integer planVersion) {
		this.planVersion = planVersion;
	}

	public Integer getPlanStatusId() {
		return planStatusId;
	}

	public void setPlanStatusId(Integer planStatusId) {
		this.planStatusId = planStatusId;
	} 
	
	public PlanPK() {
	}

	public PlanPK( Integer planCode,Integer planVersion,Integer planStatusId) {
		this.planCode = planCode;
		this.planVersion = planVersion;
		this.planStatusId=planStatusId;
	}

	
	

}
