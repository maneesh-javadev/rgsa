package gov.in.rgsa.entity;
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
import javax.persistence.Table;
import java.sql.Timestamp;


import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;

import gov.in.rgsa.outbound.QprEGovResponse;

@NamedNativeQueries({
	@NamedNativeQuery(name="FETCH_QPR_EGOV_SUPPORT", query="SELECT epl.egov_post_level_id \"egovPostLevelId\", "
			+ "epl.egov_post_level_name \"egovPostLevelName\", "
			+ "esa.egov_support_activity_id \"egovSupportActivityId\", esa.state_code \"stateCode\", esa.year_id \"yearId\", "
			+ "esa.version_no \"versionNo\", COALESCE(qe.additional_requirement, 0) \"additionalRequirement\", "
			+ "esad.egov_post_id \"egovPostID\", esad.egov_support_activity_details_id \"egovSupportActivityDetailsId\", "
			+ "COALESCE(esad.no_of_units, 0) \"postApproved\", COALESCE(esad.unit_cost, 0) \"costApproved\", esad.is_approved \"isApproved\", "
			+ "ep.egov_post_name \"egovPostName\", ep.egov_post_id \"egovPostId\", COALESCE(qe.is_freeze, FALSE) \"isFreez\", "
			+ "COALESCE(qe.qpr_egov_id, -1) \"qprEGovId\", COALESCE(qed.qpr_egov_details_id, -1) \"qprEGovDetailsId\","
			+ "COALESCE(qed.no_of_units_filled, 0) \"postFilled\", COALESCE(qed.expenditure_incurred, 0) \"incurred\" "
			+ "FROM rgsa.egov_support_activity esa \n" + 
			"JOIN rgsa.egov_support_activity_details esad ON esad.egov_support_activity_id = esa.egov_support_activity_id \n" + 
			"JOIN rgsa.egov_post ep ON ep.egov_post_id = esad.egov_post_id \n" + 
			"JOIN rgsa.egov_post_level epl ON ep.egov_post_level_id = epl.egov_post_level_id \n" + 
			"LEFT JOIN rgsa.qpr_egov qe ON esa.egov_support_activity_id = qe.egov_support_activity_id AND qe.qtr_id=:quarterId \n" + 
			"LEFT JOIN rgsa.qpr_egov_details qed ON qe.qpr_egov_id = qed.qpr_egov_id AND qed.egov_post_id = esad.egov_post_id \n" + 
			"WHERE esa.user_type = :userType AND esa.state_code=:stateCode and esa.year_id=:yearId \n" + 
			"ORDER BY \"egovPostLevelId\"", resultClass=QprEGovResponse.class)
})
@Entity
@Table(name="qpr_egov", schema="rgsa")
public class QprEGov
{
	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	@Column(name="qpr_egov_id")
	private Integer qprEgovId;

	@ManyToOne(fetch=FetchType.LAZY)
	@JoinColumn(name="egov_support_activity_id", nullable=false)
	private EGovSupportActivity egovSupportActivity;

	@ManyToOne(fetch=FetchType.EAGER)
	@JoinColumn(name="qtr_id", nullable=false)
	private QprQuarterDetail qprQuarterDetail;

	@Column(name="additional_requirement")
	private Double additionalRequirement;

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

	@Column(name="is_freeze")
	private Boolean isFreeze;

	@Column(name="menu_id")
	private Integer menuId;

	public Integer getQprEgovId() {
		return qprEgovId;
	}

	public void setQprEgovId(Integer qprEgovId) {
		this.qprEgovId = qprEgovId;
	}

	public EGovSupportActivity getEgovSupportActivity() {
		return egovSupportActivity;
	}

	public void setEgovSupportActivity(EGovSupportActivity egovSupportActivity) {
		this.egovSupportActivity = egovSupportActivity;
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

	public void setIsFreeze(Boolean b) {
		this.isFreeze = b;
	}

	public Integer getMenuId() {
		return menuId;
	}

	public void setMenuId(Integer menuId) {
		this.menuId = menuId;
	}
	
	

}