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

@Entity
@Table(name="ti_wise_proposed_domain_experts",schema="rgsa")
@NamedQuery(name="FETCH_DOMAIN_EXPERT_TI_WISE",query="FROM TIWiseProposedDomainExperts order by domainId asc")
public class TIWiseProposedDomainExperts {
	
	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	@Column(name="ti_wise_proposed_domain_experts_id")
	private Integer tiWiseProposedDomainExpertsId;

	@Column(name="district_code")
	private Integer districtCode ;
	
	@ManyToOne
	@JoinColumn(name="institue_infra_hr_activity_id")
	private InstitueInfraHrActivity institueInfraHrActivity;
	
	
	@Column(name="domain_id")
	private Integer domainId;
	
	@Column(name="no_of_experts")
	private Integer noOfExperts;

	public Integer getTiWiseProposedDomainExpertsId() {
		return tiWiseProposedDomainExpertsId;
	}

	public void setTiWiseProposedDomainExpertsId(Integer tiWiseProposedDomainExpertsId) {
		this.tiWiseProposedDomainExpertsId = tiWiseProposedDomainExpertsId;
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

	public InstitueInfraHrActivity getInstitueInfraHrActivity() {
		return institueInfraHrActivity;
	}

	public void setInstitueInfraHrActivity(InstitueInfraHrActivity institueInfraHrActivity) {
		this.institueInfraHrActivity = institueInfraHrActivity;
	}

	public Integer getDistrictCode() {
		return districtCode;
	}

	public void setDistrictCode(Integer districtCode) {
		this.districtCode = districtCode;
	} 
	
	
}