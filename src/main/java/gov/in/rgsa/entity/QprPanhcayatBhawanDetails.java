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
import javax.persistence.NamedNativeQueries;
import javax.persistence.NamedNativeQuery;
import javax.persistence.OneToOne;
import javax.persistence.Table;
import javax.persistence.Transient;

import org.springframework.web.multipart.MultipartFile;

import com.fasterxml.jackson.annotation.JsonBackReference;

@Entity
@Table(name="qpr_panhcayat_bhawan_details",schema="rgsa")

@NamedNativeQueries({
	@NamedNativeQuery(name="SUB_TOTAL_OTHER_PANCHAYAT_BHAWAN",query="select coalesce(sum(expenditure_incurred),0) from rgsa.qpr_panhcayat_bhawan qac left join rgsa.panhcayat_bhawan_activity ac on qac.panhcayat_bhawan_activity_id=ac.panhcayat_bhawan_activity_id "
			+ " left join rgsa.qpr_panhcayat_bhawan_details qacd on qac.qpr_panhcayat_bhawan_id=qacd.qpr_panhcayat_bhawan_id where ac.state_code=:stateCode and ac.year_id=:yearId and ac.user_type='C'"),
	@NamedNativeQuery(name="SUB_TOTAL_OTHER_PANCHAYAT_BHAWAN_YEAR_WISE",query="select coalesce(sum(expenditure_incurred),0) from rgsa.qpr_panhcayat_bhawan qac inner join "
			+ " rgsa.panhcayat_bhawan_activity ac on qac.panhcayat_bhawan_activity_id=ac.panhcayat_bhawan_activity_id  inner join rgsa.qpr_panhcayat_bhawan_details qacd on "
			+ " qac.qpr_panhcayat_bhawan_id=qacd.qpr_panhcayat_bhawan_id inner join rgsa.panhcayat_bhawan_activity_gps pgp on qacd.panhcayat_bhawan_activity_details_id=pgp.panhcayat_bhawan_activity_details_id "
			+ " and pgp.isactive and pgp.local_body_code=qacd.local_body_code where ac.state_code=:stateCode and ac.year_id=:yearId and ac.user_type='C' and qac.qtr_id=0 and qac.activity_id=:activityId" ),

})

public class QprPanhcayatBhawanDetails implements Serializable{
	
	
	
	/**
	 * 
	 */
	private static final long serialVersionUID = -7622741600882402808L;

	@Id
	@Column(name="qpr_panhcayat_bhawan_details_id")
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private Long qprPanhcayatBhawanDetailsId;
	
	@JsonBackReference
	@ManyToOne
	@JoinColumn(name="qpr_panhcayat_bhawan_id")
	private QprPanchayatBhawan qprPanchayatBhawan;
	
	@Column(name="local_body_code")
	private Integer localBodyCode;
	
	@Column(name="gp_bhawan_status_id")
	private Integer gpBhawanStatusId;
	
	@Column(name="expenditure_incurred")
	private Integer expenditureIncurred;
	
	@Column(name="district_code")
	private Integer districtCode;
	
	 
	
	@OneToOne(fetch=FetchType.EAGER,cascade=CascadeType.ALL)
	@JoinColumn(name="file_node_id")
	private FileNode fileNode;
	
	
	@Column(name="panhcayat_bhawan_activity_details_id")
	private Integer panhcayatBhawanActivityDetailsId;
	
	
	@Transient
	private MultipartFile file;

	public Long getQprPanhcayatBhawanDetailsId() {
		return qprPanhcayatBhawanDetailsId;
	}

	public void setQprPanhcayatBhawanDetailsId(Long qprPanhcayatBhawanDetailsId) {
		this.qprPanhcayatBhawanDetailsId = qprPanhcayatBhawanDetailsId;
	}

	public QprPanchayatBhawan getQprPanchayatBhawan() {
		return qprPanchayatBhawan;
	}

	public void setQprPanchayatBhawan(QprPanchayatBhawan qprPanchayatBhawan) {
		this.qprPanchayatBhawan = qprPanchayatBhawan;
	}

	public Integer getLocalBodyCode() {
		return localBodyCode;
	}

	public void setLocalBodyCode(Integer localBodyCode) {
		this.localBodyCode = localBodyCode;
	}

	public Integer getGpBhawanStatusId() {
		return gpBhawanStatusId;
	}

	public void setGpBhawanStatusId(Integer gpBhawanStatusId) {
		this.gpBhawanStatusId = gpBhawanStatusId;
	}

	public Integer getExpenditureIncurred() {
		return expenditureIncurred;
	}

	public void setExpenditureIncurred(Integer expenditureIncurred) {
		this.expenditureIncurred = expenditureIncurred;
	}

	public Integer getDistrictCode() {
		return districtCode;
	}

	public Integer getPanhcayatBhawanActivityDetailsId() {
		return panhcayatBhawanActivityDetailsId;
	}

	public void setPanhcayatBhawanActivityDetailsId(Integer panhcayatBhawanActivityDetailsId) {
		this.panhcayatBhawanActivityDetailsId = panhcayatBhawanActivityDetailsId;
	}

	public void setDistrictCode(Integer districtCode) {
		this.districtCode = districtCode;
	}

	public FileNode getFileNode() {
		return fileNode;
	}

	public void setFileNode(FileNode fileNode) {
		this.fileNode = fileNode;
	}

	public MultipartFile getFile() {
		return file;
	}

	public void setFile(MultipartFile file) {
		this.file = file;
	}

}
