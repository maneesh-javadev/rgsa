package gov.in.rgsa.entity;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.NamedQuery;
import javax.persistence.Table;

@Entity
@Table(name="gps_activity",schema="rgsa")
@NamedQuery(name="FETCH_PANCHAYAT_BHAWAN_ACTIVITY",query="from GramPanchayatActivity")
public class GramPanchayatActivity implements Serializable{

	/**
	 * Monty Shiv
	 */
	private static final long serialVersionUID = 1L;

	@Id
	@Column(name="activity_id")
	private Integer activityId;
	
	@Column(name="activity_name")
	private String activityName;
	
	@Column(name="ceiling_value")
	private Integer ceilingValue;

	public Integer getActivityId() {
		return activityId;
	}

	public void setActivityId(Integer activityId) {
		this.activityId = activityId;
	}

	public String getActivityName() {
		return activityName;
	}

	public void setActivityName(String activityName) {
		this.activityName = activityName;
	}

	public Integer getCeilingValue() {
		return ceilingValue;
	}

	public void setCeilingValue(Integer ceilingValue) {
		this.ceilingValue = ceilingValue;
	}
	
	
}
