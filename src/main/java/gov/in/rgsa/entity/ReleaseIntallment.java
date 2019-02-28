package gov.in.rgsa.entity;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;

@Entity
@Table(name="release_intallment",schema="rgsa")
@NamedQueries({
	@NamedQuery(name="FETCH_ReleaseIntallment_DATA",query="from ReleaseIntallment where planCode=:planCode and installmentNo=:installmentNo"),
	})
public class ReleaseIntallment {
	
	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	@Column(name="release_installment_sr_no")
	private Integer releaseIntallmentSno;
	
	@Column(name="plan_code")
	private Integer planCode;
	
	@Column(name="installment_no")
	private Integer installmentNo;
	
	@Column(name="release_status_central_share")
	private Double statusCentralShare;
	
	@Column(name="release_status_state_share")
	private Double statusStateShare;
	
	@Column(name="release_date")
	private Date releaseDate;
	
	@Column(name="status")
	private Boolean status;

	public Integer getReleaseIntallmentSno() {
		return releaseIntallmentSno;
	}

	public void setReleaseIntallmentSno(Integer releaseIntallmentSno) {
		this.releaseIntallmentSno = releaseIntallmentSno;
	}

	public Integer getPlanCode() {
		return planCode;
	}

	public void setPlanCode(Integer planCode) {
		this.planCode = planCode;
	}

	public Integer getInstallmentNo() {
		return installmentNo;
	}

	public void setInstallmentNo(Integer installmentNo) {
		this.installmentNo = installmentNo;
	}

	public Double getStatusCentralShare() {
		return statusCentralShare;
	}

	public void setStatusCentralShare(Double statusCentralShare) {
		this.statusCentralShare = statusCentralShare;
	}

	public Double getStatusStateShare() {
		return statusStateShare;
	}

	public void setStatusStateShare(Double statusStateShare) {
		this.statusStateShare = statusStateShare;
	}

	public Date getReleaseDate() {
		return releaseDate;
	}

	public void setReleaseDate(Date releaseDate) {
		this.releaseDate = releaseDate;
	}

	public Boolean getStatus() {
		return status;
	}

	public void setStatus(Boolean status) {
		this.status = status;
	}
	
	 

}
