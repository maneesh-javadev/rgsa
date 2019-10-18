package gov.in.rgsa.entity;

import java.sql.Timestamp;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Transient;

import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;


/**
 * @author Mohammad Ayaz 06/12/2018
 *
 */
@Entity
@Table(name="training_progress_report" , schema="rgsa")
@NamedQueries({
	@NamedQuery(name="TRAINING_REPORT_BASED_ON_QUARTER", query="Select TPR from TrainingProgressReport TPR RIGHT OUTER JOIN FETCH TPR.trainingDetailsProgressReportList TDPR where (TDPR.trainingActivityDetails.trainingActivityDetailsId IN (:acivityDetailsId)) AND TPR.trainingActivity.trainingActivityId=:activityId AND TDPR.quarterDuration.qtrId=:quarterId"),
	@NamedQuery(name="TRAINING_REPORT_BASED_ID", query="Select TPR from TrainingProgressReport TPR  where TPR.trainingActivity.trainingActivityId=:activityId"),
})
		
public class TrainingProgressReport  implements IFreezable{

	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	@Column(name="training_report_id",nullable=false,updatable=false)
	private Integer trainingReportId;
	
	@ManyToOne(fetch=FetchType.LAZY)
	@JoinColumn(name="training_activity_id")
	private TrainingActivity trainingActivity;
	
	@OneToMany(mappedBy="trainingProgressReport",cascade=CascadeType.ALL,fetch=FetchType.EAGER)
	private List<TrainingDetailsProgressReport> trainingDetailsProgressReportList;
	
	@Column(name="created_by",updatable=false)
	private Integer createdBy;
	
	@Column(name="created_on",updatable=false)
	@CreationTimestamp
	private Timestamp createdOn;
	
	@Column(name="last_updated_by")
	private Integer lastUpdatedBy;
	
	@Column(name="last_updated_on")
	@UpdateTimestamp
	private Timestamp lastUpdatedOn;
	
	@Column(name="is_freeze")
	private Boolean isFreeze;
	
	@Column(name="menu_id")
	private Integer menuId;
	
	@Transient
	private Integer qtrIdJsp;

	public Integer getQtrIdJsp() {
		return qtrIdJsp;
	}

	public void setQtrIdJsp(Integer qtrIdJsp) {
		this.qtrIdJsp = qtrIdJsp;
	}

	public Integer getTrainingReportId() {
		return trainingReportId;
	}

	public void setTrainingReportId(Integer trainingReportId) {
		this.trainingReportId = trainingReportId;
	}

	public TrainingActivity getTrainingActivity() {
		return trainingActivity;
	}

	public void setTrainingActivity(TrainingActivity trainingActivity) {
		this.trainingActivity = trainingActivity;
	}

	public List<TrainingDetailsProgressReport> getTrainingDetailsProgressReportList() {
		return trainingDetailsProgressReportList;
	}

	public void setTrainingDetailsProgressReportList(
			List<TrainingDetailsProgressReport> trainingDetailsProgressReportList) {
		this.trainingDetailsProgressReportList = trainingDetailsProgressReportList;
	}

	public Integer getCreatedBy() {
		return createdBy;
	}

	public void setCreatedBy(Integer createdBy) {
		this.createdBy = createdBy;
	}

	public Timestamp getCreatedOn() {
		return createdOn;
	}

	public void setCreatedOn(Timestamp createdOn) {
		this.createdOn = createdOn;
	}

	public Integer getLastUpdatedBy() {
		return lastUpdatedBy;
	}

	public void setLastUpdatedBy(Integer lastUpdatedBy) {
		this.lastUpdatedBy = lastUpdatedBy;
	}

	public Timestamp getLastUpdatedOn() {
		return lastUpdatedOn;
	}

	public void setLastUpdatedOn(Timestamp lastUpdatedOn) {
		this.lastUpdatedOn = lastUpdatedOn;
	}

	public Boolean getIsFreeze() {
		return isFreeze;
	}

	public void setIsFreeze(Boolean isFreeze) {
		this.isFreeze = isFreeze;
	}

	public Integer getMenuId() {
		return menuId;
	}

	public void setMenuId(Integer menuId) {
		this.menuId = menuId;
	}
	
	
	
}
