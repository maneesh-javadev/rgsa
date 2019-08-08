package gov.in.rgsa.entity;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

@Entity
@Table(name="qpr_pmu_wise_proposed_domain_experts",schema="rgsa")
public class QprPmuWiseProposedDomainExperts {
	
	@Id
	@Column(name="qpr_pmu_wise_proposed_domain_experts_id")
	@GeneratedValue(strategy =GenerationType.IDENTITY)
	private Integer qprPmuWiseProposedDomainExpertsId;
	
	@ManyToOne(fetch=FetchType.LAZY)
	@JoinColumn(name="qpr_pmu_id")
	private PmuProgress pmuProgress;
	
	@Column(name="district_id")
	private Integer districtId;
	
	@Column(name="domain_id")
	private Integer domainId;
	
	@Column(name="no_of_experts")
	private Integer noOfExperts;

	public Integer getQprPmuWiseProposedDomainExpertsId() {
		return qprPmuWiseProposedDomainExpertsId;
	}

	public void setQprPmuWiseProposedDomainExpertsId(Integer qprPmuWiseProposedDomainExpertsId) {
		this.qprPmuWiseProposedDomainExpertsId = qprPmuWiseProposedDomainExpertsId;
	}

	public Integer getDistrictId() {
		return districtId;
	}

	public void setDistrictId(Integer districtId) {
		this.districtId = districtId;
	}

	public Integer getDomainId() {
		return domainId;
	}

	public void setDomainId(Integer domainId) {
		this.domainId = domainId;
	}

	public PmuProgress getPmuProgress() {
		return pmuProgress;
	}

	public void setPmuProgress(PmuProgress pmuProgress) {
		this.pmuProgress = pmuProgress;
	}

	public Integer getNoOfExperts() {
		return noOfExperts;
	}

	public void setNoOfExperts(Integer noOfExperts) {
		this.noOfExperts = noOfExperts;
	}

}
