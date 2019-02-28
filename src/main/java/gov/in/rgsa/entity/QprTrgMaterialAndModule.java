package gov.in.rgsa.entity;
/**
 * @author Mohammad Ayaz 01/01/2019
 *
 */

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToOne;
import javax.persistence.Table;

@Entity
@Table(name="qpr_trg_material_and_module" , schema="rgsa")
public class QprTrgMaterialAndModule {
	
	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	@Column(name="qpr_trg_material_and_module_id",nullable=false,updatable=false)
	private Integer qprTrgMaterialAndModuleId;
	
	@ManyToOne
	@JoinColumn(name="qpr_cb_activity_details_id")
	private QprCbActivityDetails cbActivityDetails;
	
	@Column(name="material_used")
	private Boolean materialUsed;
	
	@Column(name="institute_involved")
	private String instituteInvolved;

	public Integer getQprTrgMaterialAndModuleId() {
		return qprTrgMaterialAndModuleId;
	}

	public void setQprTrgMaterialAndModuleId(Integer qprTrgMaterialAndModuleId) {
		this.qprTrgMaterialAndModuleId = qprTrgMaterialAndModuleId;
	}

	public QprCbActivityDetails getCbActivityDetails() {
		return cbActivityDetails;
	}

	public void setCbActivityDetails(QprCbActivityDetails cbActivityDetails) {
		this.cbActivityDetails = cbActivityDetails;
	}

	public Boolean getMaterialUsed() {
		return materialUsed;
	}

	public void setMaterialUsed(Boolean materialUsed) {
		this.materialUsed = materialUsed;
	}

	public String getInstituteInvolved() {
		return instituteInvolved;
	}

	public void setInstituteInvolved(String instituteInvolved) {
		this.instituteInvolved = instituteInvolved;
	}
}
