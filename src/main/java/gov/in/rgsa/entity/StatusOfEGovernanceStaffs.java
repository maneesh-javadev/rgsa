package gov.in.rgsa.entity;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

@Entity
@Table(name="status_of_e_governance_staffs",schema="rgsa")
public class StatusOfEGovernanceStaffs implements Serializable {

	/**
	 * Monty Garg
	 */
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "status_of_e_governance_staffs_id",updatable = false, nullable = false)
	private Integer StatusOfEGovernanceStaffsId;
	
	@ManyToOne
	@JoinColumn(name = "post_id",referencedColumnName="post_id")
	private PostType master;
	
	@ManyToOne
	@JoinColumn(name = "status_of_e_governance_id",referencedColumnName="status_of_e_governance_id")
	private StatusOfEGovernance statusOfEGovernance;
	
	@Column(name="no_of_staff")
	private String noOfStaff;

	public Integer getStatusOfEGovernanceStaffsId() {
		return StatusOfEGovernanceStaffsId;
	}

	public void setStatusOfEGovernanceStaffsId(Integer statusOfEGovernanceStaffsId) {
		StatusOfEGovernanceStaffsId = statusOfEGovernanceStaffsId;
	}

	

	public PostType getMaster() {
		return master;
	}

	public void setMaster(PostType master) {
		this.master = master;
	}

	public StatusOfEGovernance getStatusOfEGovernance() {
		return statusOfEGovernance;
	}

	public void setStatusOfEGovernance(StatusOfEGovernance statusOfEGovernance) {
		this.statusOfEGovernance = statusOfEGovernance;
	}

	public String getNoOfStaff() {
		return noOfStaff;
	}

	public void setNoOfStaff(String noOfStaff) {
		this.noOfStaff = noOfStaff;
	}
	
	
}
