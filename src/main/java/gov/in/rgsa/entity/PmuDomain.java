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
 * @author MOhammad Ayaz 03/10/2018
 *
 */
@Entity
@NamedQuery(name="FIND_DOMAIN_PMU_TYPE",query ="SELECT D FROM PmuDomain D ORDER BY D.pmuDomainId")
@Table(name="pmu_domains",schema="rgsa")
public class PmuDomain {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name="pmu_domain_id")
	private Integer pmuDomainId;
	
	@Column(name="pmu_domain_name")
	private String pmuDomainName;

	@ManyToOne
	@JoinColumn(name="pmu_type_id", referencedColumnName="pmu_type_id")
	private PmuType pmuType;

	public Integer getPmuDomainId() {
		return pmuDomainId;
	}

	public void setPmuDomainId(Integer pmuDomainId) {
		this.pmuDomainId = pmuDomainId;
	}

	public String getPmuDomainName() {
		return pmuDomainName;
	}

	public void setPmuDomainName(String pmuDomainName) {
		this.pmuDomainName = pmuDomainName;
	}

	public PmuType getPmuType() {
		return pmuType;
	}

	public void setPmuType(PmuType pmuType) {
		this.pmuType = pmuType;
	}
		
}
