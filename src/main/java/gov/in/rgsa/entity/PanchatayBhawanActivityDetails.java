package gov.in.rgsa.entity;

import java.io.Serializable;
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
import javax.persistence.NamedQuery;
import javax.persistence.OneToMany;
import javax.persistence.Table;

import com.fasterxml.jackson.annotation.JsonBackReference;

@Entity
@Table(name="panhcayat_bhawan_activity_details", schema="rgsa")
@NamedQuery(name="FETCH_ALL_PANCH_DETAILS_EXCEPT_CURRENT_VERSION",query="from PanchatayBhawanActivityDetails where panchatayBhawanActivity.stateCode=:stateCode and panchatayBhawanActivity.versionNo !=:versionNo and panchatayBhawanActivity.userType in('S','M') order by id")
public class PanchatayBhawanActivityDetails implements Serializable{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@Id
	@Column(name="id")
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private Integer id;
	
	@JsonBackReference
	@ManyToOne(fetch=FetchType.LAZY)
	@JoinColumn(name="panhcayat_bhawan_activity_id")
	private PanchatayBhawanActivity panchatayBhawanActivity;
	
	@ManyToOne(fetch=FetchType.LAZY)
	@JoinColumn(name="activity_id",referencedColumnName="activity_id")
	private GramPanchayatActivity activity;
	
	@OneToMany(mappedBy="activityDetails",cascade=CascadeType.ALL)
	private List<PanchayatBhawanProposedInfo> proposedInfo;
	
	
	@Column(name="unit_cost")
	private Integer unitCost;
	
	@Column(name="work_type")
	private Character workType;
	
	
	@Column(name="funds")
	private Integer funds;
	
	
	@Column(name="aspirational_gps")
	private Integer aspirationalGps;
	
	@Column(name="no_of_gps")
	private Integer noOfGPs;
	
	@Column(name="is_approved")
	private Boolean isApproved;
	
	@Column(name="remarks")
	private String remarks;


	public Integer getId() {
		return id;
	}


	public void setId(Integer id) {
		this.id = id;
	}


	public PanchatayBhawanActivity getPanchatayBhawanActivity() {
		return panchatayBhawanActivity;
	}


	public void setPanchatayBhawanActivity(PanchatayBhawanActivity panchatayBhawanActivity) {
		this.panchatayBhawanActivity = panchatayBhawanActivity;
	}


	public GramPanchayatActivity getActivity() {
		return activity;
	}


	public void setActivity(GramPanchayatActivity activity) {
		this.activity = activity;
	}


	public Integer getUnitCost() {
		return unitCost;
	}


	public void setUnitCost(Integer unitCost) {
		this.unitCost = unitCost;
	}


	public Integer getFunds() {
		return funds;
	}


	public void setFunds(Integer funds) {
		this.funds = funds;
	}


	public Integer getAspirationalGps() {
		return aspirationalGps;
	}


	public void setAspirationalGps(Integer aspirationalGps) {
		this.aspirationalGps = aspirationalGps;
	}

	public Integer getNoOfGPs() {
		return noOfGPs;
	}


	public void setNoOfGPs(Integer noOfGPs) {
		this.noOfGPs = noOfGPs;
	}


	public Boolean getIsApproved() {
		return isApproved;
	}


	public void setIsApproved(Boolean isApproved) {
		this.isApproved = isApproved;
	}


	public List<PanchayatBhawanProposedInfo> getProposedInfo() {
		return proposedInfo;
	}


	public void setProposedInfo(List<PanchayatBhawanProposedInfo> proposedInfo) {
		this.proposedInfo = proposedInfo;
	}


	public Character getWorkType() {
		return workType;
	}


	public void setWorkType(Character workType) {
		this.workType = workType;
	}


	public String getRemarks() {
		return remarks;
	}


	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}
	
	
	
}
