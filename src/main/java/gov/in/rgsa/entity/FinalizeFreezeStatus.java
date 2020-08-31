package gov.in.rgsa.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.NamedQuery;
import javax.persistence.Table;

@Entity
@Table(name = "finalize_freeze_status", schema = "rgsa")
@NamedQuery(name="FETCH_FINALIZE_FREEZE_STATUS", query="FROM FinalizeFreezeStatus where activityId=:activityId and finalizeType=:finalizeType and isActive=true")
public class FinalizeFreezeStatus {
	
	@Id
	@Column(name="id")
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private Integer id;
	
	@Column(name="activity_id")
	private Integer activityId ;
	
	
	@Column(name="finalize_type")
	private Character finalizeType ;
		
	@Column(name="is_active")
	private Boolean isActive;
		
	@Column(name="is_freeze")
	private Boolean isFreeze;

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Integer getActivityId() {
		return activityId;
	}

	public void setActivityId(Integer activityId) {
		this.activityId = activityId;
	}

	public Character getFinalizeType() {
		return finalizeType;
	}

	public void setFinalizeType(Character finalizeType) {
		this.finalizeType = finalizeType;
	}

	public Boolean getIsActive() {
		return isActive;
	}

	public void setIsActive(Boolean isActive) {
		this.isActive = isActive;
	}

	public Boolean getIsFreeze() {
		return isFreeze;
	}

	public void setIsFreeze(Boolean isFreeze) {
		this.isFreeze = isFreeze;
	}
	
	
		
		

}
