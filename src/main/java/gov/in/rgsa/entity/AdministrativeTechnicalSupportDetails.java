package gov.in.rgsa.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

@Entity
@Table(name="administrative_technical_support_details",schema="rgsa")
public class AdministrativeTechnicalSupportDetails{
	
	/**
	 * Monty Garg
	 */
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "id")
	private Integer id;
	
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name="administrative_technical_support_id")
	private AdministrativeTechnicalSupport administrativeTechnicalSupport;
	
	@ManyToOne
	@JoinColumn(name="post_id",referencedColumnName="post_id")
	private PostType postType;
	
	@ManyToOne
	@JoinColumn(name="level_id",referencedColumnName="post_level_id")
	private PostLevel postLevel;
	
	@Column(name="no_of_units")
	private Integer noOfUnits;
	
	@Column(name="unit_cost")
	private Integer unitCost;
	
	@Column(name="no_of_months")
	private Integer noOfMonths;
	
	@Column(name="funds")
	private Integer funds;
	
	@Column(name="remarks")
	private String remarks;
	
	@Column(name="is_approved")
	private Boolean isApproved;
	
	@Column(name="is_active")
	private Boolean isActive;
	
	@Column(name="aspirational_gps")
	private Integer aspirationalGps;

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public AdministrativeTechnicalSupport getAdministrativeTechnicalSupport() {
		return administrativeTechnicalSupport;
	}

	public void setAdministrativeTechnicalSupport(AdministrativeTechnicalSupport administrativeTechnicalSupport) {
		this.administrativeTechnicalSupport = administrativeTechnicalSupport;
	}

	public PostType getPostType() {
		return postType;
	}

	public void setPostType(PostType postType) {
		this.postType = postType;
	}

	public Integer getNoOfUnits() {
		return noOfUnits;
	}

	public void setNoOfUnits(Integer noOfUnits) {
		this.noOfUnits = noOfUnits;
	}

	public Integer getUnitCost() {
		return unitCost;
	}

	public void setUnitCost(Integer unitCost) {
		this.unitCost = unitCost;
	}

	public Integer getNoOfMonths() {
		return noOfMonths;
	}

	public void setNoOfMonths(Integer noOfMonths) {
		this.noOfMonths = noOfMonths;
	}

	public Integer getFunds() {
		return funds;
	}

	public void setFunds(Integer funds) {
		this.funds = funds;
	}

	public String getRemarks() {
		return remarks;
	}

	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}

	public Integer getAspirationalGps() {
		return aspirationalGps;
	}

	public void setAspirationalGps(Integer aspirationalGps) {
		this.aspirationalGps = aspirationalGps;
	}

	public PostLevel getPostLevel() {
		return postLevel;
	}

	public void setPostLevel(PostLevel postLevel) {
		this.postLevel = postLevel;
	}

	public Boolean getIsApproved() {
		return isApproved;
	}

	public void setIsApproved(Boolean isApproved) {
		this.isApproved = isApproved;
	}

	public Boolean getIsActive() {
		return isActive;
	}

	public void setIsActive(Boolean isActive) {
		this.isActive = isActive;
	}
	
}
