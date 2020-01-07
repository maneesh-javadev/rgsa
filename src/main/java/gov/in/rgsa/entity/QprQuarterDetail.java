package gov.in.rgsa.entity;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name="qpr_quarter_detail", schema = "rgsa")
public class QprQuarterDetail implements Serializable {
	/**
	 * 
	 */
	private static final long serialVersionUID = -5857699621239636432L;

	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	@Column(name="qtr_id", updatable=false, nullable=false)
	private Integer qtrId;
	
	@Column(name="qtr_duration", nullable=false)
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
