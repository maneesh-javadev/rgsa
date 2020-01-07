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

@Entity
@Table(name="qpr_ats_details" , schema="rgsa")
public class AdministrativeTechnicalDetailProgress implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = -2146067397941270659L;


	@Id
	@Column(name="qpr_ats_details_id")
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Integer atsDetailsProgressId;
	
	
	@ManyToOne
	@JoinColumn(name="qpr_ats_id")
	private AdministrativeTechnicalProgress administrativeTechnicalSupportProgress;
				
	@Column(name="no_of_units_filled")
	private Integer noOfUnitCompleted; 
	
	
	@Column(name="expenditure_incurred")
	private Integer expenditureIncurred;
	
	@ManyToOne
	@JoinColumn(name="post_id",referencedColumnName="post_id")
	private PostType postType;

	public Integer getAtsDetailsProgressId() {
		return atsDetailsProgressId;
	}

	public void setAtsDetailsProgressId(Integer atsDetailsProgressId) {
		this.atsDetailsProgressId = atsDetailsProgressId;
	}

	public AdministrativeTechnicalProgress getAdministrativeTechnicalSupportProgress() {
		return administrativeTechnicalSupportProgress;
	}

	public void setAdministrativeTechnicalSupportProgress(
			AdministrativeTechnicalProgress administrativeTechnicalSupportProgress) {
		this.administrativeTechnicalSupportProgress = administrativeTechnicalSupportProgress;
	}

	public Integer getNoOfUnitCompleted() {
		return noOfUnitCompleted;
	}

	public void setNoOfUnitCompleted(Integer noOfUnitCompleted) {
		this.noOfUnitCompleted = noOfUnitCompleted;
	}

	public Integer getExpenditureIncurred() {
		return expenditureIncurred;
	}

	public void setExpenditureIncurred(Integer expenditureIncurred) {
		this.expenditureIncurred = expenditureIncurred;
	}

	public PostType getPostType() {
		return postType;
	}

	public void setPostType(PostType postType) {
		this.postType = postType;
	}
	
	


}
