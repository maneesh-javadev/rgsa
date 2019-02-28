package gov.in.rgsa.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;


@Entity
@NamedQueries({
	@NamedQuery(name="FIND_CB_ACTIVITY_GP",query="from CapacityBuildingActivityGPs where cbMaster=:cbMasterId and capacityBuildingActivityDetailsId=:capacityBuildingActivityDetailsId and isactive=true"),
	@NamedQuery(name="RESET_CB_ACTIVITY_GP",query="from CapacityBuildingActivityGPs where capacityBuildingActivityDetailsId in(:activityDetailIdList)"),

	
})
@Table(name="cb_activity_gps", schema = "rgsa")
public class CapacityBuildingActivityGPs {
	
	
	
	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	@Column(name="cb_activity_gps_id",updatable=false,nullable=false)
	private Integer capacityBuildingActivityGPsId;
	
	
	@Column(name="cb_activity_detail_id",updatable=false,nullable=false)
	private Integer capacityBuildingActivityDetailsId;
	
	@Column(name="cb_master_id")
	private Integer cbMaster;
	
	@Column(name="local_body_code")
	private Integer localbodyCode;
	
	@Column(name="isactive")
	private boolean isactive;

	public Integer getCapacityBuildingActivityGPsId() {
		return capacityBuildingActivityGPsId;
	}

	public void setCapacityBuildingActivityGPsId(Integer capacityBuildingActivityGPsId) {
		this.capacityBuildingActivityGPsId = capacityBuildingActivityGPsId;
	}

	public Integer getCapacityBuildingActivityDetailsId() {
		return capacityBuildingActivityDetailsId;
	}

	public void setCapacityBuildingActivityDetailsId(Integer capacityBuildingActivityDetailsId) {
		this.capacityBuildingActivityDetailsId = capacityBuildingActivityDetailsId;
	}

	public Integer getCbMaster() {
		return cbMaster;
	}

	public void setCbMaster(Integer cbMaster) {
		this.cbMaster = cbMaster;
	}

	public Integer getLocalbodyCode() {
		return localbodyCode;
	}

	public void setLocalbodyCode(Integer localbodyCode) {
		this.localbodyCode = localbodyCode;
	}

	public boolean isIsactive() {
		return isactive;
	}

	public void setIsactive(boolean isactive) {
		this.isactive = isactive;
	}
	
	
	

}
