package gov.in.rgsa.entity;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.NamedQuery;
import javax.persistence.Table;

@Entity
@Table(name = "e_enablement_master" , schema = "rgsa")
@NamedQuery(name = "FIND_ALL_INFRA_RESOURCES", query = "SELECT R FROM EEnablementMaster R ORDER BY R.eMasterId ")
public class EEnablementMaster implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 4372473463006430955L;

	@Id
	@Column(name = "ee__master_id")
	private Integer eMasterId;

	@Column(name = "ee_name")
	private String eaName;

	@Column(name = "ceiling_value")
	private Integer ceilingValue;

	public Integer geteMasterId() {
		return eMasterId;
	}

	public void seteMasterId(Integer eMasterId) {
		this.eMasterId = eMasterId;
	}

	public String getEaName() {
		return eaName;
	}

	public void setEaName(String eaName) {
		this.eaName = eaName;
	}

	public Integer getCeilingValue() {
		return ceilingValue;
	}

	public void setCeilingValue(Integer ceilingValue) {
		this.ceilingValue = ceilingValue;
	}
}
