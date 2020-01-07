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
import javax.persistence.OneToOne;
import javax.persistence.Table;

/**
 * @author Mohammad Ayaz 31/12/2018
 *
 */
@Entity
@Table(name="qpr_cb_activity_details" , schema="rgsa")
public class QprCbActivityDetails implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = -2353155362067465703L;

	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	@Column(name="qpr_cb_activity_details_id",nullable=false,updatable=false)
	private Integer qprCbActivityDetailsId;
	
	@ManyToOne
	@JoinColumn(name="qpr_cb_activity_id")
	private QprCbActivity qprCbActivity;
	
	@ManyToOne
	@JoinColumn(name="cb_activity_detail_id")
	private CapacityBuildingActivityDetails capacityBuildingActivityDetails;
	
	@Column(name="no_of_days_completed")
	private Integer noOfDaysCompleted;
	
	@Column(name="no_of_units_completed")
	private Integer noOfUnitsCompleted;
	
	@Column(name="expenditure_incurred")
	private Integer expenditureIncurred;
	
	@OneToOne(mappedBy="cbActivityDetails",cascade=CascadeType.ALL)
	private QprTnaTrgEvaluation qprTnaTrgEvaluation;
	
	@OneToOne(mappedBy="cbActivityDetails",cascade=CascadeType.ALL)
	private QprTrgMaterialAndModule qprTrgMaterialAndModule;
	
	@OneToOne(mappedBy="cbActivityDetails",cascade=CascadeType.ALL)
	private QprHandholdingGpdp qprHandholdingGpdp;
	
	@OneToOne(mappedBy="cbActivityDetails",cascade=CascadeType.ALL)
	private QprPanchayatLearningCenter qprPanchayatLearningCenter;

	public Integer getQprCbActivityDetailsId() {
		return qprCbActivityDetailsId;
	}

	public void setQprCbActivityDetailsId(Integer qprCbActivityDetailsId) {
		this.qprCbActivityDetailsId = qprCbActivityDetailsId;
	}

	public QprCbActivity getQprCbActivity() {
		return qprCbActivity;
	}

	public void setQprCbActivity(QprCbActivity qprCbActivity) {
		this.qprCbActivity = qprCbActivity;
	}

	public CapacityBuildingActivityDetails getCapacityBuildingActivityDetails() {
		return capacityBuildingActivityDetails;
	}

	public void setCapacityBuildingActivityDetails(CapacityBuildingActivityDetails capacityBuildingActivityDetails) {
		this.capacityBuildingActivityDetails = capacityBuildingActivityDetails;
	}

	public Integer getNoOfDaysCompleted() {
		return noOfDaysCompleted;
	}

	public void setNoOfDaysCompleted(Integer noOfDaysCompleted) {
		this.noOfDaysCompleted = noOfDaysCompleted;
	}

	public Integer getNoOfUnitsCompleted() {
		return noOfUnitsCompleted;
	}

	public void setNoOfUnitsCompleted(Integer noOfUnitsCompleted) {
		this.noOfUnitsCompleted = noOfUnitsCompleted;
	}

	public Integer getExpenditureIncurred() {
		return expenditureIncurred;
	}

	public void setExpenditureIncurred(Integer expenditureIncurred) {
		this.expenditureIncurred = expenditureIncurred;
	}

	public QprTnaTrgEvaluation getQprTnaTrgEvaluation() {
		return qprTnaTrgEvaluation;
	}

	public void setQprTnaTrgEvaluation(QprTnaTrgEvaluation qprTnaTrgEvaluation) {
		this.qprTnaTrgEvaluation = qprTnaTrgEvaluation;
	}

	public QprTrgMaterialAndModule getQprTrgMaterialAndModule() {
		return qprTrgMaterialAndModule;
	}

	public void setQprTrgMaterialAndModule(QprTrgMaterialAndModule qprTrgMaterialAndModule) {
		this.qprTrgMaterialAndModule = qprTrgMaterialAndModule;
	}

	public QprHandholdingGpdp getQprHandholdingGpdp() {
		return qprHandholdingGpdp;
	}

	public void setQprHandholdingGpdp(QprHandholdingGpdp qprHandholdingGpdp) {
		this.qprHandholdingGpdp = qprHandholdingGpdp;
	}

	public QprPanchayatLearningCenter getQprPanchayatLearningCenter() {
		return qprPanchayatLearningCenter;
	}

	public void setQprPanchayatLearningCenter(QprPanchayatLearningCenter qprPanchayatLearningCenter) {
		this.qprPanchayatLearningCenter = qprPanchayatLearningCenter;
	}
}
