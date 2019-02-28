package gov.in.rgsa.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name="pmu_type",schema="rgsa")
public class PmuType {

	@Id
	@Column(name="pmu_type_id")
	private Integer pmuTypeId;
	
	@Column(name="pmu_type_name")
	private String pmuTypeName;
	
	@Column(name="pmu_level_id")
	private Integer pmuLevelId;

	public Integer getPmuTypeId() {
		return pmuTypeId;
	}

	public void setPmuTypeId(Integer pmuTypeId) {
		this.pmuTypeId = pmuTypeId;
	}

	public String getPmuTypeName() {
		return pmuTypeName;
	}

	public void setPmuTypeName(String pmuTypeName) {
		this.pmuTypeName = pmuTypeName;
	}

	public Integer getPmuLevelId() {
		return pmuLevelId;
	}

	public void setPmuLevelId(Integer pmuLevelId) {
		this.pmuLevelId = pmuLevelId;
	}
}
