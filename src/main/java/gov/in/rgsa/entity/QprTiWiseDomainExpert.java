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
@Table(name="qpr_ti_wise_proposed_domain_experts",schema="rgsa")
public class QprTiWiseDomainExpert implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 5779336180621981774L;

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name="qpr_ti_wise_proposed_domain_experts_id")	
	private Integer qprTiWiseProposedDomainExpertsId;
	
	@ManyToOne
	@JoinColumn(name="qpr_inst_infra_hr_id")
	private AdditionalFacultyProgress additionalFacultyProgress;
	
	@Column(name="district_code")
	private Integer districtCode;
	
	@Column(name="domain_id")
	private Integer domainId;
	
	@Column(name="no_of_experts")
	private Integer noOfExperts;

	public Integer getQprTiWiseProposedDomainExpertsId() {
		return qprTiWiseProposedDomainExpertsId;
	}

	public void setQprTiWiseProposedDomainExpertsId(Integer qprTiWiseProposedDomainExpertsId) {
		this.qprTiWiseProposedDomainExpertsId = qprTiWiseProposedDomainExpertsId;
	}

	public Integer getDistrictCode() {
		return districtCode;
	}

	public void setDistrictCode(Integer districtCode) {
		this.districtCode = districtCode;
	}

	public Integer getDomainId() {
		return domainId;
	}

	public void setDomainId(Integer domainId) {
		this.domainId = domainId;
	}

	public Integer getNoOfExperts() {
		return noOfExperts;
	}

	public void setNoOfExperts(Integer noOfExperts) {
		this.noOfExperts = noOfExperts;
	}

	public AdditionalFacultyProgress getAdditionalFacultyProgress() {
		return additionalFacultyProgress;
	}

	public void setAdditionalFacultyProgress(AdditionalFacultyProgress additionalFacultyProgress) {
		this.additionalFacultyProgress = additionalFacultyProgress;
	}
}
