package gov.in.rgsa.entity;

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
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Transient;

import com.fasterxml.jackson.annotation.JsonBackReference;

/**
 * 
 * @author sourabh
 *
 */

@Entity
@Table(name="satcom_cs_details", schema = "rgsa")
public class SatcomCurrentStatusDetails {
	
	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	@Column(name="satcom_cs_details_id")
	private Integer satcomCurrentStatusDetailsId;
	
	@JsonBackReference
	@ManyToOne(fetch=FetchType.LAZY)
	@JoinColumn(name="satcom_cs_id")
	private SatcomCurrentStatus satcomCurrentStatus;
	
	@Column(name="satcom_master_id")
	private Integer satcomMasterId;
	
	@Column(name="is_dedicated")
	private Boolean isDedicated=Boolean.FALSE;
	
	@Column(name="host_institute")
	private String hostInstitute;
	
	@Column(name="usage_level_zp")
	private Boolean usageLevelzp=Boolean.FALSE;
	
	@Column(name="usage_level_bp")
	private Boolean usageLevelbp=Boolean.FALSE;
	
	@Column(name="usage_level_gp")
	private Boolean usageLevelgp=Boolean.FALSE;
	
	@Column(name="no_of_zps_with_receiving_terminals")
	private Integer noOfZps;
	
	@Column(name="no_of_bps_with_receiving_terminals")
	private Integer noOfBps;
	
	@Column(name="no_of_gps_with_receiving_terminals")
	private Integer noOfGps;

	@Column(name="no_of_trainings_conducted")
	private Integer noOfTrainings;

	@Column(name="no_of_participants_trained")
	private Integer noOfparticipants;

	@OneToMany(mappedBy="satcomCurrentStatusDetails",cascade=CascadeType.ALL)
	private List<SatcomCurrentStatusFundSource> satcomCurrentStatusFundSource;
	
	@Transient
	private String[] scheme;
	
	public Integer getSatcomCurrentStatusDetailsId() {
		return satcomCurrentStatusDetailsId;
	}

	public void setSatcomCurrentStatusDetailsId(Integer satcomCurrentStatusDetailsId) {
		this.satcomCurrentStatusDetailsId = satcomCurrentStatusDetailsId;
	}

	public Integer getSatcomMasterId() {
		return satcomMasterId;
	}

	public void setSatcomMasterId(Integer satcomMasterId) {
		this.satcomMasterId = satcomMasterId;
	}

	public Boolean getIsDedicated() {
		return isDedicated;
	}

	public void setIsDedicated(Boolean isDedicated) {
		this.isDedicated = isDedicated;
	}

	public String getHostInstitute() {
		return hostInstitute;
	}

	public void setHostInstitute(String hostInstitute) {
		this.hostInstitute = hostInstitute;
	}

	public Boolean getUsageLevelzp() {
		return usageLevelzp;
	}

	public void setUsageLevelzp(Boolean usageLevelzp) {
		this.usageLevelzp = usageLevelzp;
	}

	public Boolean getUsageLevelbp() {
		return usageLevelbp;
	}

	public void setUsageLevelbp(Boolean usageLevelbp) {
		this.usageLevelbp = usageLevelbp;
	}

	public Boolean getUsageLevelgp() {
		return usageLevelgp;
	}

	public void setUsageLevelgp(Boolean usageLevelgp) {
		this.usageLevelgp = usageLevelgp;
	}

	public Integer getNoOfZps() {
		return noOfZps;
	}

	public void setNoOfZps(Integer noOfZps) {
		this.noOfZps = noOfZps;
	}

	public Integer getNoOfBps() {
		return noOfBps;
	}

	public void setNoOfBps(Integer noOfBps) {
		this.noOfBps = noOfBps;
	}

	public Integer getNoOfGps() {
		return noOfGps;
	}

	public void setNoOfGps(Integer noOfGps) {
		this.noOfGps = noOfGps;
	}

	public Integer getNoOfTrainings() {
		return noOfTrainings;
	}

	public void setNoOfTrainings(Integer noOfTrainings) {
		this.noOfTrainings = noOfTrainings;
	}

	public Integer getNoOfparticipants() {
		return noOfparticipants;
	}

	public void setNoOfparticipants(Integer noOfparticipants) {
		this.noOfparticipants = noOfparticipants;
	}

	public SatcomCurrentStatus getSatcomCurrentStatus() {
		return satcomCurrentStatus;
	}

	public void setSatcomCurrentStatus(SatcomCurrentStatus satcomCurrentStatus) {
		this.satcomCurrentStatus = satcomCurrentStatus;
	}

	public List<SatcomCurrentStatusFundSource> getSatcomCurrentStatusFundSource() {
		return satcomCurrentStatusFundSource;
	}

	public void setSatcomCurrentStatusFundSource(List<SatcomCurrentStatusFundSource> satcomCurrentStatusFundSource) {
		this.satcomCurrentStatusFundSource = satcomCurrentStatusFundSource;
	}

	public String[] getScheme() {
		return scheme;
	}

	public void setScheme(String[] scheme) {
		this.scheme = scheme;
	}
	
	
}