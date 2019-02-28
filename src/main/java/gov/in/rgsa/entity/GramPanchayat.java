package gov.in.rgsa.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.NamedNativeQueries;
import javax.persistence.NamedNativeQuery;
import javax.persistence.Table;

@Entity
@Table(schema = "lgd")

@NamedNativeQueries({
	@NamedNativeQuery(name="GRAM_PANCHAYAT_LGD",query="select entity_code,entity_name,entity_local_name from lgd.get_districtwise_assigned_unit(:districtCode) where entity_type='G' and entity_subtype=3 order by entity_name"),
	@NamedNativeQuery(name="GRAM_PANCHAYAT_BASED_ON_BLOCK",query="select entity_code,entity_name,entity_local_name from lgd.get_blockwise_grampanchayats(:blockCode) order by entity_name")
})

public class GramPanchayat {
	
	@Id
	@Column(name="entity_code")
	private Integer entityCode;
	
	@Column(name = "entity_name")
	String entityName;
	
	@Column(name = "entity_local_name")
	String entityLocalName;

	public Integer getEntityCode() {
		return entityCode;
	}

	public void setEntityCode(Integer entityCode) {
		this.entityCode = entityCode;
	}

	public String getEntityName() {
		return entityName;
	}

	public void setEntityName(String entityName) {
		this.entityName = entityName;
	}

	public String getEntityLocalName() {
		return entityLocalName;
	}

	public void setEntityLocalName(String entityLocalName) {
		this.entityLocalName = entityLocalName;
	}
	
	
	
	

}
