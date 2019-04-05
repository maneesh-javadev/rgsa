package gov.in.rgsa.entity;

import java.util.Date;

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
import javax.persistence.Table;
import javax.persistence.Transient;
/**
 * @author Mohammad Ayaz 06/09/2018
 *
 */

@Entity
@Table(name="target_group_master" , schema="rgsa")
@NamedQueries({
@NamedQuery(name="FETCH_TARGET_GROUP_LIST" , query="From TargetGroupMaster where isActive=true and finYear=:finYear ORDER BY targetGroupMasterName"),
@NamedQuery(name="FETCH_TARGET_GROUP_LIST_BY_ID" , query="From TargetGroupMaster where isActive=true and targetGroupMasterId=:targetGroupMasterId ORDER BY targetGroupMasterName")
})
public class TargetGroupMaster {

	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	@Column(name="target_group_master_id",nullable=false)
	private Integer targetGroupMasterId;
	
	@Column(name="target_group_master_name")
	private String targetGroupMasterName;
	
	@Column(name="state_code")
	private int stateCode;
	
	@Column(name="is_active")
	private Boolean isActive;
	
	
	@Column(name = "fin_year")
	private Integer finYear;
	
	@Column(name="created_on")
	private Date createdOn;
	
	@Column(name="created_by")
	private int createdBy;
	
	@Column(name="user_type")
	private String userType;
	
	@Transient
	private Boolean selectItem;

	public Integer getTargetGroupMasterId() {
		return targetGroupMasterId;
	}

	public void setTargetGroupMasterId(Integer targetGroupMasterId) {
		this.targetGroupMasterId = targetGroupMasterId;
	}

	public String getTargetGroupMasterName() {
		return targetGroupMasterName;
	}

	public void setTargetGroupMasterName(String targetGroupMasterName) {
		this.targetGroupMasterName = targetGroupMasterName;
	}

	public int getStateCode() {
		return stateCode;
	}

	public void setStateCode(int stateCode) {
		this.stateCode = stateCode;
	}

	public Boolean getIsActive() {
		return isActive;
	}

	public void setIsActive(Boolean isActive) {
		this.isActive = isActive;
	}

	public Integer getFinYear() {
		return finYear;
	}

	public void setFinYear(Integer finYear) {
		this.finYear = finYear;
	}

	public Date getCreatedOn() {
		return createdOn;
	}

	public void setCreatedOn(Date createdOn) {
		this.createdOn = createdOn;
	}

	public int getCreatedBy() {
		return createdBy;
	}

	public void setCreatedBy(int createdBy) {
		this.createdBy = createdBy;
	}

	public String getUserType() {
		return userType;
	}

	public void setUserType(String userType) {
		this.userType = userType;
	}

	public Boolean getSelectItem() {
		return selectItem;
	}

	public void setSelectItem(Boolean selectItem) {
		this.selectItem = selectItem;
	}
	
	
	
}
