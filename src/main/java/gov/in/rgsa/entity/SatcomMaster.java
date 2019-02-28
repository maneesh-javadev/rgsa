package gov.in.rgsa.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.NamedQuery;
import javax.persistence.Table;

@Entity
@Table(name="satcom_master",schema="rgsa")
@NamedQuery(name="SATCOM_ACTIVTY_NAME",query="from SatcomMaster order by satcomMasterId asc")
public class SatcomMaster {

	@Id
	@Column(name="satcom_master_id")
	private Integer satcomMasterId;
	
	@Column(name="satcom_master_name")
	private String satcomMasterName;

	public Integer getSatcomMasterId() {
		return satcomMasterId;
	}

	public void setSatcomMasterId(Integer satcomMasterId) {
		this.satcomMasterId = satcomMasterId;
	}

	public String getSatcomMasterName() {
		return satcomMasterName;
	}

	public void setSatcomMasterName(String satcomMasterName) {
		this.satcomMasterName = satcomMasterName;
	}
	
	
}
