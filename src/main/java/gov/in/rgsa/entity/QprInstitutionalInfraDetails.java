package gov.in.rgsa.entity;

import java.io.Serializable;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQuery;
import javax.persistence.OneToOne;
import javax.persistence.Table;
import javax.persistence.Transient;

import org.springframework.web.multipart.MultipartFile;

import com.fasterxml.jackson.annotation.JsonBackReference;

@Entity
@Table(name="qpr_inst_infra_details",schema="rgsa")
@NamedQuery(name="FETCH_QPR_INST_ACTIVITY_DETAILS_DEPEND_ON_QUATOR",query="SELECt D FROM QprInstitutionalInfraDetails D WHERE D.qprInstitutionalInfrastructure.qprInstInfraId=:qprInstInfraId AND D.trainingInstitueTypeId=:trainingInstituteTypeId")
public class QprInstitutionalInfraDetails implements Serializable {


	
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 10860907875766767L;

	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	@Column(name="qpr_inst_infra_details_id")
	private Long qprInstInfraDetailsId;
	
	@JsonBackReference
	@ManyToOne
	@JoinColumn(name="qpr_inst_infra_id")
	private QprInstitutionalInfrastructure qprInstitutionalInfrastructure;
	
	@Column(name="institutional_infra_activity_details_id")
	private Long instituteInfrsaHrActivityDetailsId;
	
	@Column(name="inst_infra_status_id")
	private Integer instInfraStatusId;
	
	@Column(name="expenditure_incurred")
	private Long expenditureIncurred;
	
	@Column(name="file_path")
	private String file_path;
	
	@OneToOne(fetch=FetchType.EAGER,cascade=CascadeType.ALL)
	@JoinColumn(name="file_node_id")
	private FileNode fileNode;

	
	
	
	@Column(name="institutional_activity_type_id")
	private Integer trainingInstitueTypeId;


	@Transient
	private MultipartFile file;

	
	@Transient
	private Integer fileNodeId;

	public MultipartFile getFile() {
		return file;
	}

	public void setFile(MultipartFile file) {
		this.file = file;
	}

	public Long getQprInstInfraDetailsId() {
		return qprInstInfraDetailsId;
	}

	public void setQprInstInfraDetailsId(Long qprInstInfraDetailsId) {
		this.qprInstInfraDetailsId = qprInstInfraDetailsId;
	}

	public QprInstitutionalInfrastructure getQprInstitutionalInfrastructure() {
		return qprInstitutionalInfrastructure;
	}

	public void setQprInstitutionalInfrastructure(QprInstitutionalInfrastructure qprInstitutionalInfrastructure) {
		this.qprInstitutionalInfrastructure = qprInstitutionalInfrastructure;
	}

	public Long getInstituteInfrsaHrActivityDetailsId() {
		return instituteInfrsaHrActivityDetailsId;
	}

	public void setInstituteInfrsaHrActivityDetailsId(Long instituteInfrsaHrActivityDetailsId) {
		this.instituteInfrsaHrActivityDetailsId = instituteInfrsaHrActivityDetailsId;
	}

	public Integer getInstInfraStatusId() {
		return instInfraStatusId;
	}

	public void setInstInfraStatusId(Integer instInfraStatusId) {
		this.instInfraStatusId = instInfraStatusId;
	}

	public Long getExpenditureIncurred() {
		return expenditureIncurred;
	}

	public void setExpenditureIncurred(Long expenditureIncurred) {
		this.expenditureIncurred = expenditureIncurred;
	}

	
	
	public Integer getTrainingInstitueTypeId() {
		return trainingInstitueTypeId;
	}

	public void setTrainingInstitueTypeId(Integer trainingInstitueTypeId) {
		this.trainingInstitueTypeId = trainingInstitueTypeId;
	}

	public String getFile_path() {
		return file_path;
	}

	public void setFile_path(String file_path) {
		this.file_path = file_path;
	}

	public FileNode getFileNode() {
		return fileNode;
	}

	public void setFileNode(FileNode fileNode) {
		this.fileNode = fileNode;
	}

	public Integer getFileNodeId() {
		return fileNodeId;
	}

	public void setFileNodeId(Integer fileNodeId) {
		this.fileNodeId = fileNodeId;
	}

	

	
	
}
