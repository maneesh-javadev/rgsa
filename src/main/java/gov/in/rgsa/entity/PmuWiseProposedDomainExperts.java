package gov.in.rgsa.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQuery;
import javax.persistence.Table;
/**
 * @author MOhammad Ayaz 04/10/2018
 *
 */
@Entity
@NamedQuery(name="FETCH_DOMAIN_EXPERT_PMU_WISE",query="FROM PmuWiseProposedDomainExperts order by domainId asc")
@Table(name="pmu_wise_proposed_domain_experts",schema="rgsa")
public class PmuWiseProposedDomainExperts {
	
	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	@Column(name="pmu_wise_proposed_domain_experts_id")
	private Integer pmuWiseProposedDomainExpertsId;

	@Column(name="district_Id")
	private Integer districtId ;
	
	@ManyToOne
	@JoinColumn(name="pmu_activity_id")
	private PmuActivity pmuActivityDomain;
	
	@Column(name="domain_id")
	private Integer domainId;
	
	@Column(name="no_of_experts")
	private Integer noOfExperts;

	public Integer getPmuWiseProposedDomainExpertsId() {
		return pmuWiseProposedDomainExpertsId;
	}

	public void setPmuWiseProposedDomainExpertsId(Integer pmuWiseProposedDomainExpertsId) {
		this.pmuWiseProposedDomainExpertsId = pmuWiseProposedDomainExpertsId;
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

	public Integer getNoOfExperts() {
		return noOfExperts;
	}

	public void setNoOfExperts(Integer noOfExperts) {
		this.noOfExperts = noOfExperts;
	}

	public PmuActivity getPmuActivityDomain() {
		return pmuActivityDomain;
	}

	public void setPmuActivityDomain(PmuActivity pmuActivityDomain) {
		this.pmuActivityDomain = pmuActivityDomain;
	}

	
}
