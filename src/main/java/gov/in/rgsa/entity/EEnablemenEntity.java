package gov.in.rgsa.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.NamedNativeQueries;
import javax.persistence.NamedNativeQuery;

@Entity	
@NamedNativeQueries({
	@NamedNativeQuery(query="select ed.e_enablement_details_id,em.ee__master_id,em.ee_name,ed.no_of_units,ed.aspirational_gps " + 
			"from rgsa.e_enablement e inner join rgsa.e_enablement_details ed " + 
			"on e.e_enablement_id=ed.e_enablement_id inner join rgsa.e_enablement_master em " + 
			"on ed.ee_master_id=em.ee__master_id " + 
			"where e.is_active and e.state_code=:stateCode and e.year_id=:yearId and user_type=:userType"
			, name = "FETCH_ENABLEMENT_DETAILS_GPs", resultClass = EEnablemenEntity.class),
	
})
public class EEnablemenEntity {
	
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name="e_enablement_details_id")
	private Integer eEnablementDetailId;
	
	@Column(name="ee__master_id")
	private Integer eMasterId;
	
	@Column(name="ee_name")
	private String eName;
	
	@Column(name="no_of_units")
	private Integer noofGPs;
	
	@Column(name="aspirational_gps")
	private Integer aspirationalGPs;

	public Integer geteEnablementDetailId() {
		return eEnablementDetailId;
	}

	public void seteEnablementDetailId(Integer eEnablementDetailId) {
		this.eEnablementDetailId = eEnablementDetailId;
	}

	public String geteName() {
		return eName;
	}

	public void seteName(String eName) {
		this.eName = eName;
	}

	public Integer getNoofGPs() {
		return noofGPs;
	}

	public void setNoofGPs(Integer noofGPs) {
		this.noofGPs = noofGPs;
	}

	public Integer getAspirationalGPs() {
		return aspirationalGPs;
	}

	public void setAspirationalGPs(Integer aspirationalGPs) {
		this.aspirationalGPs = aspirationalGPs;
	}

	public Integer geteMasterId() {
		return eMasterId;
	}

	public void seteMasterId(Integer eMasterId) {
		this.eMasterId = eMasterId;
	}
	
	

}
