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
import javax.persistence.NamedQuery;
import javax.persistence.Table;

import com.fasterxml.jackson.annotation.JsonBackReference;

/**
 * 
 * @author sourabh
 *
 */

@Entity
@Table(name="training_institute_cs_fund_source", schema = "rgsa")
@NamedQuery(query="delete from TrainingInstituteCurrentStatusFundSource where trainingInstituteCurrentStatusDetails.trainingInstituteCsDetailsId=:detailId",name="DELETE_FUND_SOURCE")
public class TrainingInstituteCurrentStatusFundSource implements Serializable {
	
	/**
	 * 
	 */
	private static final long serialVersionUID = -3022818898631745517L;

	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	@Column(name="training_institute_cs_fs_id")
	private Integer trainingInstituteCurrentStatusFundSourceId;
	
	@JsonBackReference
	@ManyToOne(fetch=FetchType.LAZY)
	@JoinColumn(name="training_institute_cs_details_id")
	private TrainingInstituteCurrentStatusDetails trainingInstituteCurrentStatusDetails;
	
	@ManyToOne
	@JoinColumn(name="scheme_id")
	private SchemeMaster scheme;

	public Integer getTrainingInstituteCurrentStatusFundSourceId() {
		return trainingInstituteCurrentStatusFundSourceId;
	}

	public void setTrainingInstituteCurrentStatusFundSourceId(Integer trainingInstituteCurrentStatusFundSourceId) {
		this.trainingInstituteCurrentStatusFundSourceId = trainingInstituteCurrentStatusFundSourceId;
	}

	public TrainingInstituteCurrentStatusDetails getTrainingInstituteCurrentStatusDetails() {
		return trainingInstituteCurrentStatusDetails;
	}

	public void setTrainingInstituteCurrentStatusDetails(
			TrainingInstituteCurrentStatusDetails trainingInstituteCurrentStatusDetails) {
		this.trainingInstituteCurrentStatusDetails = trainingInstituteCurrentStatusDetails;
	}

	public SchemeMaster getScheme() {
		return scheme;
	}

	public void setScheme(SchemeMaster scheme) {
		this.scheme = scheme;
	}
}