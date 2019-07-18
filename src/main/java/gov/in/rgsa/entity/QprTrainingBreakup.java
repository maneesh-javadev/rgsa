package gov.in.rgsa.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQuery;
import javax.persistence.Table;

@Entity
@Table(name="qpr_training_breakup",schema="rgsa")
@NamedQuery(name="FETCH_BREAK_UP_BY_QPR_TRAINING_DETAIL_ID",query="from QprTrainingBreakup where quarterTrainingsDetails.qprTrainingsDetailsId=:qprTrainingsDetailsId order by qprTrainingBreakupId")
public class QprTrainingBreakup {
	
	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	@Column(name="qpr_training_breakup_id")
	private Integer qprTrainingBreakupId;
	
	@ManyToOne
	@JoinColumn(name="qpr_trainings_details_id")
	private QuarterTrainingsDetails quarterTrainingsDetails;
	
	@Column(name="target_group_master_id")
	private Integer targetGroupMasterId;
	
	@Column(name="sc_males")
	private Integer scMales;
	
	@Column(name="sc_females")
	private Integer scFemales;
	
	@Column(name="st_males")
	private Integer stMales;
	
	@Column(name="st_females")
	private Integer stFemales;
	
	@Column(name="others_males")
	private Integer othersMales;
	
	@Column(name="others_females")
	private Integer othersFemales;

	public Integer getQprTrainingBreakupId() {
		return qprTrainingBreakupId;
	}

	public void setQprTrainingBreakupId(Integer qprTrainingBreakupId) {
		this.qprTrainingBreakupId = qprTrainingBreakupId;
	}

	public Integer getTargetGroupMasterId() {
		return targetGroupMasterId;
	}

	public void setTargetGroupMasterId(Integer targetGroupMasterId) {
		this.targetGroupMasterId = targetGroupMasterId;
	}

	public Integer getScMales() {
		return scMales;
	}

	public void setScMales(Integer scMales) {
		this.scMales = scMales;
	}

	public Integer getScFemales() {
		return scFemales;
	}

	public void setScFemales(Integer scFemales) {
		this.scFemales = scFemales;
	}

	public Integer getStMales() {
		return stMales;
	}

	public void setStMales(Integer stMales) {
		this.stMales = stMales;
	}

	public Integer getStFemales() {
		return stFemales;
	}

	public void setStFemales(Integer stFemales) {
		this.stFemales = stFemales;
	}

	public Integer getOthersMales() {
		return othersMales;
	}

	public void setOthersMales(Integer othersMales) {
		this.othersMales = othersMales;
	}

	public Integer getOthersFemales() {
		return othersFemales;
	}

	public void setOthersFemales(Integer othersFemales) {
		this.othersFemales = othersFemales;
	}

	public QuarterTrainingsDetails getQuarterTrainingsDetails() {
		return quarterTrainingsDetails;
	}

	public void setQuarterTrainingsDetails(QuarterTrainingsDetails quarterTrainingsDetails) {
		this.quarterTrainingsDetails = quarterTrainingsDetails;
	}

}
