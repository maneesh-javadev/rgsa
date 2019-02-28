package gov.in.rgsa.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name="qpr_training_breakup",schema="rgsa")
public class QprTrainingBreakup {
	
	@Id
	@Column(name="qpr_training_breakup_id")
	private Integer qprTrainingBreakupId;
	
	@Column(name="training_id")
	private Integer trainingId;
	
	@Column(name="target_group_id")
	private Integer targetGroupId;
	
	@Column(name="sc")
	private Integer SC;
	
	@Column(name="st")
	private Integer ST;
	
	@Column(name="other")
	private Integer other;

	public Integer getQprTrainingBreakupId() {
		return qprTrainingBreakupId;
	}

	public void setQprTrainingBreakupId(Integer qprTrainingBreakupId) {
		this.qprTrainingBreakupId = qprTrainingBreakupId;
	}

	public Integer getTrainingId() {
		return trainingId;
	}

	public void setTrainingId(Integer trainingId) {
		this.trainingId = trainingId;
	}

	public Integer getTargetGroupId() {
		return targetGroupId;
	}

	public void setTargetGroupId(Integer targetGroupId) {
		this.targetGroupId = targetGroupId;
	}

	public Integer getSC() {
		return SC;
	}

	public void setSC(Integer sC) {
		SC = sC;
	}

	public Integer getST() {
		return ST;
	}

	public void setST(Integer sT) {
		ST = sT;
	}

	public Integer getOther() {
		return other;
	}

	public void setOther(Integer other) {
		this.other = other;
	}
	
	

}
