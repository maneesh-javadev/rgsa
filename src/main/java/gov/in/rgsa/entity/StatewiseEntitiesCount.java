package gov.in.rgsa.entity;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.NamedNativeQueries;
import javax.persistence.NamedNativeQuery;

@Entity
@NamedNativeQueries({
@NamedNativeQuery(query="select st.state_code,s.state_name_english,cast(0 as integer)as no_of_states,st.no_of_districts,"
+ "st.no_of_subdistricts,st.no_of_blocks,st.no_of_villages,st.no_of_zps,st.no_of_bps,st.no_of_vps,st.no_of_tlbs,"
+ "st.no_of_ulbs from statewise_totals st inner join state s on s.state_code=st.state_code where s.isactive",                 
name="getStateWiseEntityCount",resultClass=StatewiseEntitiesCount.class),
@NamedNativeQuery(query="select * from rgsa.fetch_rgsa_entities_count_fn()", 
name="getIndiaLevelEnitiesCount",resultClass=StatewiseEntitiesCount.class),
@NamedNativeQuery(query="select st.state_code,cast('' as character varying)state_name_english,cast(0 as integer)as "
+ "no_of_states,st.no_of_districts,st.no_of_subdistricts,st.no_of_blocks,st.no_of_villages,st.no_of_zps,st.no_of_bps,"
+ "st.no_of_vps,st.no_of_tlbs,st.no_of_ulbs  from statewise_totals_list_fn_new() st"
,name="updateStatewiseTotals",resultClass=StatewiseEntitiesCount.class)
		

})


  
public class StatewiseEntitiesCount implements Serializable {
	/**
	 * 
	 */
	private static final long serialVersionUID = 2205466478917358080L;

	@Id
	@Column(name="state_code")
	private Integer state_code;
	
	@Column(name="state_name_english")
	private String state_name_english;
	
	@Column(name="no_of_stack_holder")
	private Integer no_of_stack_holder;
	
	@Column(name="no_of_convergence")
	private Integer no_of_convergence;
	
	@Column(name="no_of_basic_orientation")
	private Integer no_of_basic_orientation;
	
	@Column(name="no_of_tech_support")
	private Integer no_of_tech_support;
	
	@Column(name="no_of_refersh_training")
	private Integer no_of_refersh_training;
	
	
	@Column(name="no_of_exposure_vws")
	private Integer no_of_exposure_vws;
	
	@Column(name="no_of_exposure_vos")
	private Integer no_of_exposure_vos;
	
	@Column(name="no_of_bhawan_constructed")
	private Integer no_of_bhawan_constructed;
	
	@Column(name="no_of_bhawan_repair")
	private Integer no_of_bahwan_repair;
	
	@Column(name="no_of_bhawan_located")
	private Integer no_of_bhawan_located;
	
	@Column(name="no_of_e_spmu")
	private Integer no_of_e_spmu;
	
	@Column(name="no_of_e_dpmu")
	private Integer no_of_e_dpmu;
	
	@Column(name="no_of_computerization")
	private Integer no_of_computerization;

	public Integer getState_code() {
		return state_code;
	}

	public void setState_code(Integer state_code) {
		this.state_code = state_code;
	}

	public String getState_name_english() {
		return state_name_english;
	}

	public void setState_name_english(String state_name_english) {
		this.state_name_english = state_name_english;
	}

	public Integer getNo_of_stack_holder() {
		return no_of_stack_holder;
	}

	public void setNo_of_stack_holder(Integer no_of_stack_holder) {
		this.no_of_stack_holder = no_of_stack_holder;
	}

	public Integer getNo_of_convergence() {
		return no_of_convergence;
	}

	public void setNo_of_convergence(Integer no_of_convergence) {
		this.no_of_convergence = no_of_convergence;
	}

	public Integer getNo_of_basic_orientation() {
		return no_of_basic_orientation;
	}

	public void setNo_of_basic_orientation(Integer no_of_basic_orientation) {
		this.no_of_basic_orientation = no_of_basic_orientation;
	}

	public Integer getNo_of_tech_support() {
		return no_of_tech_support;
	}

	public void setNo_of_tech_support(Integer no_of_tech_support) {
		this.no_of_tech_support = no_of_tech_support;
	}

	public Integer getNo_of_refersh_training() {
		return no_of_refersh_training;
	}

	public void setNo_of_refersh_training(Integer no_of_refersh_training) {
		this.no_of_refersh_training = no_of_refersh_training;
	}

	public Integer getNo_of_exposure_vws() {
		return no_of_exposure_vws;
	}

	public void setNo_of_exposure_vws(Integer no_of_exposure_vws) {
		this.no_of_exposure_vws = no_of_exposure_vws;
	}

	public Integer getNo_of_exposure_vos() {
		return no_of_exposure_vos;
	}

	public void setNo_of_exposure_vos(Integer no_of_exposure_vos) {
		this.no_of_exposure_vos = no_of_exposure_vos;
	}

	public Integer getNo_of_bhawan_constructed() {
		return no_of_bhawan_constructed;
	}

	public void setNo_of_bhawan_constructed(Integer no_of_bhawan_constructed) {
		this.no_of_bhawan_constructed = no_of_bhawan_constructed;
	}

	public Integer getNo_of_bahwan_repair() {
		return no_of_bahwan_repair;
	}

	public void setNo_of_bahwan_repair(Integer no_of_bahwan_repair) {
		this.no_of_bahwan_repair = no_of_bahwan_repair;
	}

	public Integer getNo_of_e_spmu() {
		return no_of_e_spmu;
	}

	public void setNo_of_e_spmu(Integer no_of_e_spmu) {
		this.no_of_e_spmu = no_of_e_spmu;
	}

	public Integer getNo_of_e_dpmu() {
		return no_of_e_dpmu;
	}

	public void setNo_of_e_dpmu(Integer no_of_e_dpmu) {
		this.no_of_e_dpmu = no_of_e_dpmu;
	}

	public Integer getNo_of_computerization() {
		return no_of_computerization;
	}

	public void setNo_of_computerization(Integer no_of_computerization) {
		this.no_of_computerization = no_of_computerization;
	}

	public Integer getNo_of_bhawan_located() {
		return no_of_bhawan_located;
	}

	public void setNo_of_bhawan_located(Integer no_of_bhawan_located) {
		this.no_of_bhawan_located = no_of_bhawan_located;
	}
	
	
}
