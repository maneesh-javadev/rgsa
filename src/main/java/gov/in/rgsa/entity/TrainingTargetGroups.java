package gov.in.rgsa.entity;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;

/**
 * @author Mohammad Ayaz 06/09/2018
 *
 */

@Entity
@Table(name="training_target_groups" , schema="rgsa")
@NamedQueries({
@NamedQuery(name="DELETE_TARGETGRP_TRAINING_ID" , query="delete from TrainingTargetGroups where targetTrainingActivityDetails.trainingActivityDetailsId=:trngId"),
@NamedQuery(name="FETCH_TARGETGRP_TRAINING_ID" , query="from TrainingTargetGroups where targetTrainingActivityDetails.trainingActivityDetailsId=:trngId")
})
public class TrainingTargetGroups implements Serializable {
	
	/**
	 * 
	 */
	private static final long serialVersionUID = -1453079474078934874L;

	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	@Column(name="training_wise_target_group_id",nullable=false)
	private Integer trainingWiseTargetGroupId;
	
	@ManyToOne
	@JoinColumn(name="training_id" ,referencedColumnName="training_id")
	private TrainingActivityDetails targetTrainingActivityDetails;
	
	@ManyToOne
	@JoinColumn(name="target_group_master_id",referencedColumnName="target_group_master_id")
	private TargetGroupMaster targetGroupMasterId;

	public Integer getTrainingWiseTargetGroupId() {
		return trainingWiseTargetGroupId;
	}

	public void setTrainingWiseTargetGroupId(Integer trainingWiseTargetGroupId) {
		this.trainingWiseTargetGroupId = trainingWiseTargetGroupId;
	}

	public TrainingActivityDetails getTargetTrainingActivityDetails() {
		return targetTrainingActivityDetails;
	}

	public void setTargetTrainingActivityDetails(TrainingActivityDetails targetTrainingActivityDetails) {
		this.targetTrainingActivityDetails = targetTrainingActivityDetails;
	}

	public TargetGroupMaster getTargetGroupMasterId() {
		return targetGroupMasterId;
	}

	public void setTargetGroupMasterId(TargetGroupMaster targetGroupMasterId) {
		this.targetGroupMasterId = targetGroupMasterId;
	}

}
