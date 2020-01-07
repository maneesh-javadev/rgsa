package gov.in.rgsa.entity;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.NamedQuery;
import javax.persistence.Table;

@Entity
@Table(name="satcom_level",schema="rgsa")
@NamedQuery(name="SATCOM_LEVEL",query="from SatcomLevel")
public class SatcomLevel implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = -8512752416170932875L;

	@Id
	@Column(name="satcom_level_id")
	private Integer satcomLevelId;
	
	@Column(name="satcom_level_name")
	private String satcomLevelName;
	
	@Column(name="ceiling_value")
	private Integer ceilingValue;

	public Integer getSatcomLevelId() {
		return satcomLevelId;
	}

	public void setSatcomLevelId(Integer satcomLevelId) {
		this.satcomLevelId = satcomLevelId;
	}

	public String getSatcomLevelName() {
		return satcomLevelName;
	}

	public void setSatcomLevelName(String satcomLevelName) {
		this.satcomLevelName = satcomLevelName;
	}

	public Integer getCeilingValue() {
		return ceilingValue;
	}

	public void setCeilingValue(Integer ceilingValue) {
		this.ceilingValue = ceilingValue;
	}
	
	
}
