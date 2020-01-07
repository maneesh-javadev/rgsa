package gov.in.rgsa.entity;

import java.io.Serializable;

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
	@NamedQuery(name="FIND_Enablement_GP",query="from EEnablementGPs where eEnablementDetailsId=:eEnablementDetailsId and isactive=true"),
	@NamedQuery(name="RESET_Enablement_GP",query="from EEnablementGPs where eEnablementDetailsId in(:eEnablementDetailId)"),

	
})
@Table(name="e_enablement_gps", schema="rgsa")
public class EEnablementGPs implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 6562070091738533596L;

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name="e_enablement_gps_id")
	private Integer eEnablementGpsId;
	
	@Column(name="local_body_code")
	private Integer localBodyCode;
	
	@Column(name="district_code")
	private Integer districtCode;
	
	@Column(name="isactive")
	private boolean isactive;
	
	@Column(name="e_enablement_details_id")
	private Integer eEnablementDetailsId;
	
	@Column(name="is_aspirational_gps")
	private boolean aspirationalGps;

	public Integer geteEnablementGpsId() {
		return eEnablementGpsId;
	}

	public void seteEnablementGpsId(Integer eEnablementGpsId) {
		this.eEnablementGpsId = eEnablementGpsId;
	}

	public Integer getLocalBodyCode() {
		return localBodyCode;
	}

	public void setLocalBodyCode(Integer localBodyCode) {
		this.localBodyCode = localBodyCode;
	}

	public Integer getDistrictCode() {
		return districtCode;
	}

	public void setDistrictCode(Integer districtCode) {
		this.districtCode = districtCode;
	}

	public boolean isIsactive() {
		return isactive;
	}

	public void setIsactive(boolean isactive) {
		this.isactive = isactive;
	}

	public Integer geteEnablementDetailsId() {
		return eEnablementDetailsId;
	}

	public void seteEnablementDetailsId(Integer eEnablementDetailsId) {
		this.eEnablementDetailsId = eEnablementDetailsId;
	}

	public boolean isAspirationalGps() {
		return aspirationalGps;
	}

	public void setAspirationalGps(boolean aspirationalGps) {
		this.aspirationalGps = aspirationalGps;
	}

	
	
	
	
	
}
