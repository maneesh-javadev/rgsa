package gov.in.rgsa.entity;

import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.OneToOne;
import javax.persistence.Table;

import org.hibernate.annotations.LazyCollection;
import org.hibernate.annotations.LazyCollectionOption;

/**
 * @author Mohammad Ayaz 31/12/2018
 *
 */
@Entity
@Table(name="qpr_cb_activity_details" , schema="rgsa")
public class QprCbActivityDetails {

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
	
	@OneToMany(mappedBy="cbActivityDetails",cascade=CascadeType.ALL)
	@LazyCollection(LazyCollectionOption.FALSE)
	private List<QprTnaTrgEvaluation> qprTnaTrgEvaluation;
	
	@OneToMany(mappedBy="cbActivityDetails",cascade=CascadeType.ALL)
	@LazyCollection(LazyCollectionOption.FALSE)
	private List<QprTrgMaterialAndModule> qprTrgMaterialAndModule;
	
	@OneToOne(mappedBy="cbActivityDetails",cascade=CascadeType.ALL)
	@LazyCollection(LazyCollectionOption.FALSE)
	private QprHandholdingGpdp qprHandholdingGpdp;
	
	@OneToOne(mappedBy="cbActivityDetails",cascade=CascadeType.ALL)
	@LazyCollection(LazyCollectionOption.FALSE)
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

	public List<QprTnaTrgEvaluation> getQprTnaTrgEvaluation() {
		return qprTnaTrgEvaluation;
	}

	public void setQprTnaTrgEvaluation(List<QprTnaTrgEvaluation> qprTnaTrgEvaluation) {
		this.qprTnaTrgEvaluation = qprTnaTrgEvaluation;
	}

	public List<QprTrgMaterialAndModule> getQprTrgMaterialAndModule() {
		return qprTrgMaterialAndModule;
	}

	public void setQprTrgMaterialAndModule(List<QprTrgMaterialAndModule> qprTrgMaterialAndModule) {
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