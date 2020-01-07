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
@Table(name="trg_extend_coverage_details",schema="rgsa")
@NamedQuery(name="FIND_Extent_Of_Coverage_Details",query="FROM ExtentOfCoverageDetails where coverageId=:coverageId order by trainingCategoryId asc") 
public class ExtentOfCoverageDetails implements Serializable{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = -8405630003018921559L;

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name="trg_extend_coverage_details_id")
	private Integer coverageDetailsId;
	
	@Column(name="trg_extend_coverage_id")
	private Integer coverageId;
	
	@Column(name="training_category_id")
	private  Integer trainingCategoryId;
	
	@Column(name="no_of_ers_trained")
	private Integer noOfErsTrained;
	
	@Column(name="no_of_ers_tobetrained")
	private Integer noOfErsToBeTrained;
	
	@Column(name="no_of_ps_trained")
	private Integer noOfPsTrained;
	
	@Column(name="no_of_ps_tobetrained")
	private Integer noOfPsToBeTrained;

	public Integer getCoverageDetailsId() {
		return coverageDetailsId;
	}

	public void setCoverageDetailsId(Integer coverageDetailsId) {
		this.coverageDetailsId = coverageDetailsId;
	}

	public Integer getCoverageId() {
		return coverageId;
	}

	public void setCoverageId(Integer coverageId) {
		this.coverageId = coverageId;
	}

	public Integer getTrainingCategoryId() {
		return trainingCategoryId;
	}

	public void setTrainingCategoryId(Integer trainingCategoryId) {
		this.trainingCategoryId = trainingCategoryId;
	}

	public Integer getNoOfErsTrained() {
		return noOfErsTrained;
	}

	public void setNoOfErsTrained(Integer noOfErsTrained) {
		this.noOfErsTrained = noOfErsTrained;
	}

	public Integer getNoOfErsToBeTrained() {
		return noOfErsToBeTrained;
	}

	public void setNoOfErsToBeTrained(Integer noOfErsToBeTrained) {
		this.noOfErsToBeTrained = noOfErsToBeTrained;
	}

	public Integer getNoOfPsTrained() {
		return noOfPsTrained;
	}

	public void setNoOfPsTrained(Integer noOfPsTrained) {
		this.noOfPsTrained = noOfPsTrained;
	}

	public Integer getNoOfPsToBeTrained() {
		return noOfPsToBeTrained;
	}

	public void setNoOfPsToBeTrained(Integer noOfPsToBeTrained) {
		this.noOfPsToBeTrained = noOfPsToBeTrained;
	}
	
}