package gov.in.rgsa.entity;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import com.fasterxml.jackson.annotation.JsonBackReference;

/**
 * 
 * @author sourabh
 *
 */

@Entity
@Table(name="satcom_cs_fund_source", schema = "rgsa")
public class SatcomCurrentStatusFundSource implements Serializable {
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 4634458937422776826L;

	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	@Column(name="satcom_cs_fs_id")
	private Integer satcomCurrentStatusFundSourceId;
	
	@JsonBackReference
	@ManyToOne(fetch=FetchType.LAZY)
	@JoinColumn(name="satcom_cs_details_id")
	private SatcomCurrentStatusDetails satcomCurrentStatusDetails;
	
	@ManyToOne(fetch=FetchType.LAZY)
	@JoinColumn(name="scheme_id")
	private SchemeMaster scheme;

	public Integer getSatcomCurrentStatusFundSourceId() {
		return satcomCurrentStatusFundSourceId;
	}

	public void setSatcomCurrentStatusFundSourceId(Integer satcomCurrentStatusFundSourceId) {
		this.satcomCurrentStatusFundSourceId = satcomCurrentStatusFundSourceId;
	}

	public SatcomCurrentStatusDetails getSatcomCurrentStatusDetails() {
		return satcomCurrentStatusDetails;
	}

	public void setSatcomCurrentStatusDetails(SatcomCurrentStatusDetails satcomCurrentStatusDetails) {
		this.satcomCurrentStatusDetails = satcomCurrentStatusDetails;
	}

	public SchemeMaster getScheme() {
		return scheme;
	}

	public void setScheme(SchemeMaster scheme) {
		this.scheme = scheme;
	}
	
}