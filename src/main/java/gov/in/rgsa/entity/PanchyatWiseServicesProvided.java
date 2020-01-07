package gov.in.rgsa.entity;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import com.fasterxml.jackson.annotation.JsonBackReference;

/**
 * 
 * @author sourabh
 *
 */

@Entity
@Table(name="panchyat_wise_services_provided", schema = "rgsa")
public class PanchyatWiseServicesProvided implements Serializable{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = -8764020522507584476L;

	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	@Column(name="panchyat_wise_services_provided_id")
	private Integer panchyatWiseServicesProvidedId;
	
	@JsonBackReference
	@ManyToOne(fetch=FetchType.LAZY)
	@JoinColumn(name="panchayat_bhawan_cs_details_id")
	private PanchyatBhawanCurrentStatusDetails panchyatBhawanCurrentStatusDetails;
	
	@ManyToOne(fetch=FetchType.LAZY)
	@JoinColumn(name="service_master_id")
	private ServiceMaster serviceMasterId;

	public Integer getPanchyatWiseServicesProvidedId() {
		return panchyatWiseServicesProvidedId;
	}

	public void setPanchyatWiseServicesProvidedId(Integer panchyatWiseServicesProvidedId) {
		this.panchyatWiseServicesProvidedId = panchyatWiseServicesProvidedId;
	}

	public PanchyatBhawanCurrentStatusDetails getPanchyatBhawanCurrentStatusDetails() {
		return panchyatBhawanCurrentStatusDetails;
	}

	public void setPanchyatBhawanCurrentStatusDetails(
			PanchyatBhawanCurrentStatusDetails panchyatBhawanCurrentStatusDetails) {
		this.panchyatBhawanCurrentStatusDetails = panchyatBhawanCurrentStatusDetails;
	}

	public ServiceMaster getServiceMasterId() {
		return serviceMasterId;
	}

	public void setServiceMasterId(ServiceMaster serviceMasterId) {
		this.serviceMasterId = serviceMasterId;
	}

}