package gov.in.rgsa.entity;


import java.io.Serializable;
import java.sql.Timestamp;

import javax.persistence.*;

import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;

@Entity
@Table(name = "util_cert", schema = "rgsa")
@NamedNativeQueries({
		@NamedNativeQuery(name = "INSTALLMENT_SANCTION_AMOUNT", query =
				"SELECT \n" +
				"  COALESCE(SUM(sanction_order.amount_under_component), 0) + 0.0 \"sanction_amount\" \n" +
				"FROM \n" +
				"  rgsa.sanction_order, \n" +
				"  rgsa.plan, \n" +
				"  rgsa.release_intallment \n" +
				"WHERE \n" +
				"  sanction_order.plan_code = plan.plan_code \n" +
				"  AND release_intallment.release_installment_sr_no = sanction_order.release_installment_sr_no \n" +
				"  AND plan.isactive = true \n" +
				"  AND plan.state_code = :stateCode \n" +
				"  AND plan.plan_status_id = 5 \n" +
				"  AND release_intallment.installment_no = :installmentNumber \n" +
				"  AND plan.year_id = :yearId \n" +
				"GROUP BY plan.plan_code \n" +
				"LIMIT 1"),
		@NamedNativeQuery(name = "INSTALLMENT_UNSPENT_AMOUNT", query =
				"SELECT  \n" +
				"  COALESCE(MAX(fund_released_details.unspent_balance), 0) + 0.0 \"unspent_balance\" \n" +
				"FROM \n" +
				"  rgsa.fund_released, \n" +
				"  rgsa.fund_released_details, \n" +
				"  rgsa.plan \n" +
				"WHERE \n" +
				"  fund_released.fund_released_id = fund_released_details.fund_released_id AND \n" +
				"  plan.plan_code = fund_released.plan_code \n" +
				"  AND plan.isactive = true \n" +
				"  AND plan.state_code = :stateCode \n" +
				"  AND plan.plan_status_id = 5 \n" +
				"  AND fund_released_details.installment_id = :installmentNumber \n" +
				"  AND plan.year_id = :yearId \n" +
				"GROUP BY plan.plan_code \n" +
				"LIMIT 1")
})
public class UtilCert implements Serializable {
	/**
	 * 
	 */
	private static final long serialVersionUID = 8181296361301049149L;

	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	@Column(name="util_cert_id")
	private Integer utilCertId;

	@Column(name="state_code")
	private Integer stateCode;

	@ManyToOne(fetch=FetchType.LAZY)
	@JoinColumn(name="year_id", nullable=false)
	private FinYear finYear;

	@ManyToOne(fetch=FetchType.LAZY)
	@JoinColumn(name="release_installment_sr_no", nullable=false)
	private ReleaseIntallment releaseInstallment;

	@OneToOne(fetch=FetchType.EAGER)
	@JoinColumn(name="generated_file_id", nullable=false)
	private FileNode generatedFile;
	
	@OneToOne(fetch=FetchType.EAGER)
	@JoinColumn(name="upload_file_id", nullable=true)
	private FileNode uploadFile;
	
	@Column(name="upload_allowed")
	private  Boolean uploadAllowed = true;

	@Column(name="created_by")
	private  Integer createdBy;
	
	@CreationTimestamp
	@Column(name="created_on")
	private Timestamp createdOn;

	@Column(name="last_updated_by")
	private  Integer lastUpdatedBy;

	@UpdateTimestamp
	@Column(name="last_updated_on")
	private Timestamp lastUpdatedOn;

	public Integer getUtilCertId() {
		return utilCertId;
	}

	public void setUtilCertId(Integer utilCertId) {
		this.utilCertId = utilCertId;
	}

	public Integer getStateCode() {
		return stateCode;
	}

	public void setStateCode(Integer stateCode) {
		this.stateCode = stateCode;
	}

	public FinYear getFinYear() {
		return finYear;
	}

	public void setFinYear(FinYear finYear) {
		this.finYear = finYear;
	}

	public ReleaseIntallment getReleaseInstallment() {
		return releaseInstallment;
	}

	public void setReleaseInstallment(ReleaseIntallment releaseInstallment) {
		this.releaseInstallment = releaseInstallment;
	}

	public FileNode getGeneratedFile() {
		return generatedFile;
	}

	public void setGeneratedFile(FileNode generatedFile) {
		this.generatedFile = generatedFile;
	}

	public FileNode getUploadFile() {
		return uploadFile;
	}

	public void setUploadFile(FileNode uploadFile) {
		this.uploadFile = uploadFile;
	}
	
	

	public Boolean getUploadAllowed() {
		return uploadAllowed;
	}

	public void setUploadAllowed(Boolean uploadAllowed) {
		this.uploadAllowed = uploadAllowed;
	}

	public Integer getCreatedBy() {
		return createdBy;
	}

	public void setCreatedBy(Integer createdBy) {
		this.createdBy = createdBy;
	}

	public Timestamp getCreatedOn() {
		return createdOn;
	}

	public void setCreatedOn(Timestamp createdOn) {
		this.createdOn = createdOn;
	}

	public Integer getLastUpdatedBy() {
		return lastUpdatedBy;
	}

	public void setLastUpdatedBy(Integer lastUpdatedBy) {
		this.lastUpdatedBy = lastUpdatedBy;
	}

	public Timestamp getLastUpdatedOn() {
		return lastUpdatedOn;
	}

	public void setLastUpdatedOn(Timestamp lastUpdatedOn) {
		this.lastUpdatedOn = lastUpdatedOn;
	}
	
	// Generated
	

}
