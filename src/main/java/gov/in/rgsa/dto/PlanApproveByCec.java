package gov.in.rgsa.dto;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.NamedNativeQuery;

@Entity
/*
 * @NamedNativeQuery(name="APPROVED_CEC_PLAN",
 * query=" select * from rgsa.approve_plan(:stateCode,:yearId)"
 * ,resultClass=PlanApproveByCec.class)
 */
public class PlanApproveByCec implements Serializable {

	private static final long serialVersionUID = 1L;
	
	@Id
	@Column(name="boolean")
	private Boolean message;

	public Boolean getMessage() {
		return message;
	}

	public void setMessage(Boolean message) {
		this.message = message;
	}
	
	
	
	
	
	
}
