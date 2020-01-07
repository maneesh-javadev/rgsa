package gov.in.rgsa.entity;

import java.io.Serializable;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

/**
 * @author Mohammad Ayaz 06/12/2018
 *
 */

@Entity
@Table(name="categories_of_participant", schema="rgsa")
public class CategoriesOfParticipant implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1757941648518176232L;

	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	@Column(name="categories_of_participant_id",nullable=false,updatable=false)
	private Integer categoriesOfParticipantId;
	
	@ManyToOne
	@JoinColumn(name="training_details_report_id", referencedColumnName="training_details_report_id")
	private TrainingDetailsProgressReport trainingDetailsProgressReport;
	
	@ManyToOne
	@JoinColumn(name="target_group_id",referencedColumnName="target_group_master_id")
	private TargetGroupMaster targetGrpMaster;

	@Column(name="sc")
	private Integer sc;
	
	@Column(name="st")
	private Integer st;
	
	@Column(name="other")
	private Integer other;

	public Integer getCategoriesOfParticipantId() {
		return categoriesOfParticipantId;
	}

	public void setCategoriesOfParticipantId(Integer categoriesOfParticipantId) {
		this.categoriesOfParticipantId = categoriesOfParticipantId;
	}

	public TrainingDetailsProgressReport getTrainingDetailsProgressReport() {
		return trainingDetailsProgressReport;
	}

	public void setTrainingDetailsProgressReport(TrainingDetailsProgressReport trainingDetailsProgressReport) {
		this.trainingDetailsProgressReport = trainingDetailsProgressReport;
	}
	
	public TargetGroupMaster getTargetGrpMaster() {
		return targetGrpMaster;
	}

	public void setTargetGrpMaster(TargetGroupMaster targetGrpMaster) {
		this.targetGrpMaster = targetGrpMaster;
	}

	public Integer getSc() {
		return sc;
	}

	public void setSc(Integer sc) {
		this.sc = sc;
	}

	public Integer getSt() {
		return st;
	}

	public void setSt(Integer st) {
		this.st = st;
	}

	public Integer getOther() {
		return other;
	}

	public void setOther(Integer other) {
		this.other = other;
	}
	  
}
