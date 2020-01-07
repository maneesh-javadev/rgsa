package gov.in.rgsa.entity;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.NamedQuery;
import javax.persistence.Table;

@Entity
@Table(name="qpr_quarter_detail",schema="rgsa")
@NamedQuery(name="FETCH_QUARTER_DURATION",query="from QuarterDuration order by qtrId")
public class QuarterDuration implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1604943823896734756L;

	@Id
	@Column(name="qtr_id")
	private Integer qtrId;
	
	@Column(name="qtr_duration")
	private String qtrDuration;

	public Integer getQtrId() {
		return qtrId;
	}

	public void setQtrId(Integer qtrId) {
		this.qtrId = qtrId;
	}

	public String getQtrDuration() {
		return qtrDuration;
	}

	public void setQtrDuration(String qtrDuration) {
		this.qtrDuration = qtrDuration;
	}
	
}
