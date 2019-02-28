package gov.in.rgsa.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.NamedQuery;
import javax.persistence.Table;

/**
 * 
 * @author sourabh
 *
 */

@Entity
@Table(name="service_master", schema = "rgsa")
@NamedQuery(query="from ServiceMaster",name="FETCH_SERVICE_MASTER")
public class ServiceMaster {
	
	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	@Column(name="service_master_id")
	private Integer serviceMasterId;
	
	@Column(name="service_master_name")
	private String serviceMasterName;

	public Integer getServiceMasterId() {
		return serviceMasterId;
	}

	public void setServiceMasterId(Integer serviceMasterId) {
		this.serviceMasterId = serviceMasterId;
	}

	public String getServiceMasterName() {
		return serviceMasterName;
	}

	public void setServiceMasterName(String serviceMasterName) {
		this.serviceMasterName = serviceMasterName;
	}

	
	
}