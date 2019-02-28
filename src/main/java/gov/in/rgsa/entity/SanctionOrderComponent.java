package gov.in.rgsa.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;

@Entity
@NamedQueries({
	@NamedQuery(name="FIND_ALL_SANCTION_ORDER_COMPONENT",query="from SanctionOrderComponent"),
	})
@Table(name="sanction_order_component",schema="rgsa")
public class SanctionOrderComponent {
	
	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	@Column(name="so_component_id")
	private Integer soComponentId;
	
	
	@Column(name="so_component_name")
	private String soComponentName;


	public Integer getSoComponentId() {
		return soComponentId;
	}


	public void setSoComponentId(Integer soComponentId) {
		this.soComponentId = soComponentId;
	}


	public String getSoComponentName() {
		return soComponentName;
	}


	public void setSoComponentName(String soComponentName) {
		this.soComponentName = soComponentName;
	}
	
	
	
}
