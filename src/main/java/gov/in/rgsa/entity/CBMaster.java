package gov.in.rgsa.entity;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.NamedQuery;
import javax.persistence.Table;

/**
 * Sourabh Rai
 */

@Entity
@Table(name = "cb_master", schema = "rgsa")

@NamedQuery(name = "FETCH_CB_MASTERS", query = "SELECT cbm FROM CBMaster cbm")
public class CBMaster implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 3792918839490621528L;

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "cb_master_id",nullable = false)
	private Integer cbMasterId;
	
	@Column(name="cb_name")
	private String cbName;
	
	@Column(name="ceiling_value")
	private Double ceilingValue;

	public Integer getCbMasterId() {
		return cbMasterId;
	}

	public void setCbMasterId(Integer cbMasterId) {
		this.cbMasterId = cbMasterId;
	}

	public String getCbName() {
		return cbName;
	}

	public void setCbName(String cbName) {
		this.cbName = cbName;
	}

	public Double getCeilingValue() {
		return ceilingValue;
	}

	public void setCeilingValue(Double ceilingValue) {
		this.ceilingValue = ceilingValue;
	}
	
}
