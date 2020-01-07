package gov.in.rgsa.entity;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.NamedQuery;
import javax.persistence.Table;

@Entity
@Table(name="gp_bhawan_status",schema="rgsa")
@NamedQuery(name="FETCH_GP_BHAWAN_STATUS",query="SELECT gp FROM GPBhawanStatus gp WHERE activityId=:activityId")
public class GPBhawanStatus implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 7885713292593438561L;

	@Id
	@Column(name="gp_bhawan_status_id")
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private Integer gpBhawanStatusId;
	
	@Column(name="activity_id")
	private Integer activityId;
	
	@Column(name="gp_bhawan_status_name")
	private String gpBhawanStatusName;

	public Integer getGpBhawanStatusId() {
		return gpBhawanStatusId;
	}

	public void setGpBhawanStatusId(Integer gpBhawanStatusId) {
		this.gpBhawanStatusId = gpBhawanStatusId;
	}

	public Integer getActivityId() {
		return activityId;
	}

	public void setActivityId(Integer activityId) {
		this.activityId = activityId;
	}

	public String getGpBhawanStatusName() {
		return gpBhawanStatusName;
	}

	public void setGpBhawanStatusName(String gpBhawanStatusName) {
		this.gpBhawanStatusName = gpBhawanStatusName;
	}
	
	
}
