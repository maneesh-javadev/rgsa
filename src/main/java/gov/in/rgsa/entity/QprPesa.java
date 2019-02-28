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
import javax.persistence.NamedNativeQueries;
import javax.persistence.NamedNativeQuery;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.OneToMany;
import javax.persistence.Table;

import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;

import gov.in.rgsa.outbound.QprQuartProgress;

@Entity
@Table(name = "qpr_pesa", schema = "rgsa")
//@NamedQueries({
//	//@NamedQuery(name="FETCH_QPR_PESA",query="SELECT QP FROM QprPesa QP where qprQuarterDetail.qtrId=:qid AND createdBy=:createdBy"),
//	@NamedQuery(name= "FETCH_QPR_PESA", query="SELECT pp, ppd, post, qp, qpd from PesaPlan pp " + 
//			"JOIN PesaPlanDetails ppd ON ppd.pesaPlanId = pp.pesaPlanId " + 
//			"JOIN ppd.pesaPost post ON post.pesaPostId = ppd.designationId " + 
//			"LEFT JOIN QprPesa qp ON qp.pesaPlan.pesaPlanId = pp.pesaPlanId AND qp.qprQuarterDetail.qtrId=:quarterId " + 
//			"LEFT JOIN QprPesaDetails qpd ON qpd.qprPesa.qprPesaId = qp.qprPesaId AND post.pesaPostId = qpd.pesaPost.pesaPostId " + 
//			"where pp.stateCode=:stateCode and yearId=:yearId and pp.userType=:userType ")
//})

@NamedNativeQueries({
	@NamedNativeQuery(name="FETCH_QPR_PESA", query="SELECT ppd.id \"pesaPlanDetailsId\" , pp.pesa_plan_id \"pesaPlanId\", ppd.designation_id \"designationId\", post.pesa_post_name \"pesaPostName\", " + 
			"COALESCE(post.ceiling_value, 0) \"ceilingValue\", COALESCE(ppd.no_of_units, 0) \"noOfUnits\",  " + 
			"COALESCE(ppd.unit_cost_per_month, 0) \"unitCostPerMonth\",  COALESCE(qp.qpr_pesa_id, -1) \"qprPesaId\", COALESCE(qpd.qpr_pesa_details_id, -1) \"qprPesaDetailsId\", " + 
			"COALESCE(qpd.no_of_units_filled, 0) \"noOfUnitsFilled\", COALESCE(qpd.expenditure_incurred, 0) \"expenditureIncurred\",  " + 
			"COALESCE(qp.additional_requirement, 0) \"additionalRequirement\" , COALESCE(qp.is_freez, FALSE) \"isFreeze\" " +
			"from rgsa.pesa_plan pp " + 
			"JOIN rgsa.pesa_plan_details ppd ON ppd.pesa_plan_id = pp.pesa_plan_id " + 
			"JOIN rgsa.pesa_post post ON post.pesa_post_id = ppd.designation_id " + 
			"LEFT JOIN rgsa.qpr_pesa qp ON qp.pesa_plan_id = pp.pesa_plan_id AND qp.qtr_id=:quarterId " + 
			"LEFT JOIN rgsa.qpr_pesa_details qpd ON qpd.qpr_pesa_id = qp.qpr_pesa_id AND post.pesa_post_id = qpd.designation_id " + 
			"where pp.state_code=:stateCode and year_id=:yearId and pp.user_type=:userType "
			+ " ORDER BY   \"pesaPostName\" ",
			resultClass = QprQuartProgress.class
			)
})
public class QprPesa {


	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	@Column(name="qpr_pesa_id", updatable=false, nullable=false)
	private Integer qprPesaId;
	
	@ManyToOne(fetch=FetchType.LAZY)
	@JoinColumn(name="pesa_plan_id", nullable=false)
	private PesaPlan pesaPlan;
	
	@ManyToOne(fetch=FetchType.EAGER)
	@JoinColumn(name="qtr_id", nullable=false)
	private QprQuarterDetail qprQuarterDetail;
	
	@Column(name="additional_requirement")
	private Double additionalRequirement;
	
	@Column(name="is_freez")
	private Boolean isFreeze;
	
	@Column(name="created_by")
	private Integer createdBy;
	
	@CreationTimestamp
	@Column(name="created_on",updatable=false)
	private Timestamp createdOn;
	
	@Column(name="last_updated_by")
	private Integer lastUpdatedBy;
	
	@UpdateTimestamp
	@Column(name="last_updated_on")
	private Timestamp lastUpdatedOn;	
	
	@Column(name="menu_id")
	private Integer menuId;
	
	@OneToMany(mappedBy = "qprPesa", cascade = CascadeType.ALL, orphanRemoval = true, fetch=FetchType.LAZY)
	private List<QprPesaDetails> qprPesaDetails;
	
	public static class QprResult{
		Integer ppid; 
		Integer did;
		String ppn;
		Integer cv;
		Integer nou;
		Integer ucpm; 
		Integer qid;
		Integer nouf; 
		Integer ei;
		Integer ar;
	}

	public Integer getQprPesaId() {
		return qprPesaId;
	}

	public void setQprPesaId(Integer qprPesaId) {
		this.qprPesaId = qprPesaId;
	}

	public PesaPlan getPesaPlan() {
		return pesaPlan;
	}

	public void setPesaPlan(PesaPlan pesaPlan) {
		this.pesaPlan = pesaPlan;
	}

	public QprQuarterDetail getQprQuarterDetail() {
		return qprQuarterDetail;
	}

	public void setQprQuarterDetail(QprQuarterDetail qprQuarterDetail) {
		this.qprQuarterDetail = qprQuarterDetail;
	}

	public Double getAdditionalRequirement() {
		return additionalRequirement;
	}

	public void setAdditionalRequirement(Double additionalRequirement) {
		this.additionalRequirement = additionalRequirement;
	}

	public Boolean getIsFreeze() {
		return isFreeze;
	}

	public void setIsFreeze(Boolean isFreeze) {
		this.isFreeze = isFreeze;
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

	public Integer getMenuId() {
		return menuId;
	}

	public void setMenuId(Integer menuId) {
		this.menuId = menuId;
	}

	public List<QprPesaDetails> getQprPesaDetails() {
		return qprPesaDetails;
	}

	public void setQprPesaDetails(List<QprPesaDetails> qprPesaDetails) {
		this.qprPesaDetails = qprPesaDetails;
	}

}
