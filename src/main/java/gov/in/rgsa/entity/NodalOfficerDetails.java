package gov.in.rgsa.entity;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.NamedQuery;
import javax.persistence.Table;

@Entity
@Table(name="nodal_officer_details",schema="rgsa")
@NamedQuery(name="FETCH_NODAL_DETAILS",query="from NodalOfficerDetails where stateCode=:stateCode")
public class NodalOfficerDetails implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = -4859412475203136314L;

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name="nodal_officer_id")
	private Integer nodalOfficerId;
	
	@Column(name = "state_code")
	private Integer stateCode;
	
	@Column(name="nodal_officer_designation")
	private String nodalOfficerDesignation;
	
	@Column(name="nodal_officer_name")
	private String nodalOfficerName;
	
	@Column(name="nodal_officer_email_id")
	private String nodalOfficerEmailId;
	
	@Column(name="pmu_designation")
	private String pmuDesignation;
	
	@Column(name="pmu_email_id")
	private String pmuEmailId;
	
	@Column(name="dac_designation")
	private String dacDesignation;
	
	@Column(name = "dac_mobile_number")
	private String dacMobileNumber;
	
	@Column(name = "pmu_mobile_number")
	private String pmuMobileNumber;
	
	@Column(name = "nodal_officer_mobile_number")
	private String nodalOfficerMobileNumber;
	
	@Column(name="dac_email_id")
	private String dacEmailId;

	public Integer getNodalOfficerId() {
		return nodalOfficerId;
	}

	public void setNodalOfficerId(Integer nodalOfficerId) {
		this.nodalOfficerId = nodalOfficerId;
	}

	public Integer getStateCode() {
		return stateCode;
	}

	public void setStateCode(Integer stateCode) {
		this.stateCode = stateCode;
	}

	public String getNodalOfficerMobileNumber() {
		return nodalOfficerMobileNumber;
	}

	public void setNodalOfficerMobileNumber(String nodalOfficerMobileNumber) {
		this.nodalOfficerMobileNumber = nodalOfficerMobileNumber;
	}

	public String getNodalOfficerDesignation() {
		return nodalOfficerDesignation;
	}

	public void setNodalOfficerDesignation(String nodalOfficerDesignation) {
		this.nodalOfficerDesignation = nodalOfficerDesignation;
	}

	public String getNodalOfficerName() {
		return nodalOfficerName;
	}

	public void setNodalOfficerName(String nodalOfficerName) {
		this.nodalOfficerName = nodalOfficerName;
	}

	public String getNodalOfficerEmailId() {
		return nodalOfficerEmailId;
	}

	public void setNodalOfficerEmailId(String nodalOfficerEmailId) {
		this.nodalOfficerEmailId = nodalOfficerEmailId;
	}

	public String getPmuDesignation() {
		return pmuDesignation;
	}

	public void setPmuDesignation(String pmuDesignation) {
		this.pmuDesignation = pmuDesignation;
	}

	public String getPmuMobileNumber() {
		return pmuMobileNumber;
	}

	public void setPmuMobileNumber(String pmuMobileNumber) {
		this.pmuMobileNumber = pmuMobileNumber;
	}

	public String getPmuEmailId() {
		return pmuEmailId;
	}

	public void setPmuEmailId(String pmuEmailId) {
		this.pmuEmailId = pmuEmailId;
	}

	public String getDacDesignation() {
		return dacDesignation;
	}

	public void setDacDesignation(String dacDesignation) {
		this.dacDesignation = dacDesignation;
	}

	public String getDacMobileNumber() {
		return dacMobileNumber;
	}

	public void setDacMobileNumber(String dacMobileNumber) {
		this.dacMobileNumber = dacMobileNumber;
	}

	public String getDacEmailId() {
		return dacEmailId;
	}

	public void setDacEmailId(String dacEmailId) {
		this.dacEmailId = dacEmailId;
	}
	
}
