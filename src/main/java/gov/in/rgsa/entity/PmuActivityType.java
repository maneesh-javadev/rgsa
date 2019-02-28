package gov.in.rgsa.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
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
@NamedQuery(name="FETCH_ALL_ACTIVITY_PMU_TYPE",query="from PmuActivityType order by pmuActivityTypeId")
@Table(name="pmu_activity_type",schema="rgsa")
public class PmuActivityType {
	
	@Id
	@Column(name="pmu_activity_type_id")
	private Integer pmuActivityTypeId;
	
	@Column(name="pmu_activity_type_name")
	private String pmuActivityName;
	
	@Column(name="ceiling_value")
	private Integer ceilingValue;

	@ManyToOne
	@JoinColumn(name="pmu_type_id")
	private PmuType pmuType;

	public Integer getPmuActivityTypeId() {
		return pmuActivityTypeId;
	}

	public void setPmuActivityTypeId(Integer pmuActivityTypeId) {
		this.pmuActivityTypeId = pmuActivityTypeId;
	}

	public String getPmuActivityName() {
		return pmuActivityName;
	}

	public void setPmuActivityName(String pmuActivityName) {
		this.pmuActivityName = pmuActivityName;
	}

	public Integer getCeilingValue() {
		return ceilingValue;
	}

	public void setCeilingValue(Integer ceilingValue) {
		this.ceilingValue = ceilingValue;
	}

	public PmuType getPmuType() {
		return pmuType;
	}

	public void setPmuType(PmuType pmuType) {
		this.pmuType = pmuType;
	}
	
	
}
